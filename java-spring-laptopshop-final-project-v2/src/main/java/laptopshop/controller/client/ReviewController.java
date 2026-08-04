package laptopshop.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import laptopshop.domain.Product;
import laptopshop.domain.Review;
import laptopshop.domain.User;
import laptopshop.service.ProductService;
import laptopshop.service.ReviewService;
import laptopshop.service.UserService;

@Controller
public class ReviewController {

    private final ReviewService reviewService;
    private final ProductService productService;
    private final UserService userService;

    public ReviewController(ReviewService reviewService, ProductService productService, UserService userService) {
        this.reviewService = reviewService;
        this.productService = productService;
        this.userService = userService;
    }

    @PostMapping("/product/review")
    public String submitReview(
            @RequestParam("productId") long productId,
            @RequestParam("rating") int rating,
            @RequestParam("content") String content,
            HttpServletRequest request,
            org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            return "redirect:/login";
        }

        long userId = (long) session.getAttribute("id");
        User user = this.userService.getUserById(userId);
        Product product = this.productService.fetchProductById(productId).orElse(null);

        if (user == null || product == null) {
            return "redirect:/products";
        }

        if (!this.reviewService.canUserReview(user, product)) {
            redirectAttributes.addFlashAttribute("error", "You can only review products you have purchased and completed the order.");
            return "redirect:/product/" + productId;
        }

        // Check if user already reviewed
        Review existingReview = this.reviewService.getUserReviewForProduct(user, product);
        if (existingReview != null) {
            existingReview.setRating(rating);
            existingReview.setContent(content);
            existingReview.setStatus("PENDING"); // require re-approval after edit
            this.reviewService.saveReview(existingReview);
            redirectAttributes.addFlashAttribute("success", "Your review has been updated and is pending approval.");
        } else {
            Review newReview = new Review();
            newReview.setUser(user);
            newReview.setProduct(product);
            newReview.setRating(rating);
            newReview.setContent(content);
            newReview.setStatus("PENDING");
            this.reviewService.saveReview(newReview);
            redirectAttributes.addFlashAttribute("success", "Your review has been submitted and is pending approval.");
        }

        return "redirect:/product/" + productId;
    }
}
