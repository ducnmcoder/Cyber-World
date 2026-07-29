package laptopshop.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import laptopshop.domain.Product;
import laptopshop.domain.Review;
import laptopshop.domain.User;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {
    
    Page<Review> findByProductAndStatus(Product product, String status, Pageable pageable);
    
    Review findByUserAndProduct(User user, Product product);
    
    boolean existsByUserAndProduct(User user, Product product);
    
    @Query("SELECT AVG(r.rating) FROM Review r WHERE r.product = :product AND r.status = 'APPROVED'")
    Double getAverageRatingForProduct(@Param("product") Product product);
    
    @Query("SELECT COUNT(r) FROM Review r WHERE r.product = :product AND r.status = 'APPROVED'")
    Integer getReviewCountForProduct(@Param("product") Product product);
}
