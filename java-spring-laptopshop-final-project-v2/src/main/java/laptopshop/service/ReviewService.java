package laptopshop.service;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import laptopshop.domain.Product;
import laptopshop.domain.Review;
import laptopshop.domain.User;
import laptopshop.repository.OrderRepository;
import laptopshop.repository.ProductRepository;
import laptopshop.repository.ReviewRepository;

@Service
public class ReviewService {

    private final ReviewRepository reviewRepository;
    private final OrderRepository orderRepository;
    private final ProductRepository productRepository;

    public ReviewService(ReviewRepository reviewRepository, OrderRepository orderRepository, ProductRepository productRepository) {
        this.reviewRepository = reviewRepository;
        this.orderRepository = orderRepository;
        this.productRepository = productRepository;
    }

    public Review saveReview(Review review) {
        return this.reviewRepository.save(review);
    }

    public Optional<Review> findById(long id) {
        return this.reviewRepository.findById(id);
    }

    public Page<Review> getApprovedReviewsByProduct(Product product, Pageable pageable) {
        return this.reviewRepository.findByProductAndStatus(product, "APPROVED", pageable);
    }

    public Page<Review> getAllReviews(Pageable pageable) {
        return this.reviewRepository.findAll(pageable);
    }

    public boolean canUserReview(User user, Product product) {
        if (user == null || product == null) return false;
        return this.orderRepository.existsByUserAndStatusAndProduct(user, "COMPLETE", product);
    }

    public Review getUserReviewForProduct(User user, Product product) {
        if (user == null || product == null) return null;
        return this.reviewRepository.findByUserAndProduct(user, product);
    }

    @Transactional
    public void updateProductReviewStats(Product product) {
        Double avgRating = this.reviewRepository.getAverageRatingForProduct(product);
        Integer reviewCount = this.reviewRepository.getReviewCountForProduct(product);

        product.setAverageRating(avgRating != null ? Math.round(avgRating * 10.0) / 10.0 : 0.0);
        product.setReviewCount(reviewCount != null ? reviewCount : 0);

        this.productRepository.save(product);
    }
}
