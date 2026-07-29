package laptopshop.controller.admin;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import laptopshop.domain.Review;
import laptopshop.service.ReviewService;

@Controller
public class AdminReviewController {

    private final ReviewService reviewService;

    public AdminReviewController(ReviewService reviewService) {
        this.reviewService = reviewService;
    }

    @GetMapping("/admin/review")
    public String getReviewPage(Model model, @RequestParam(value = "page", defaultValue = "1") int page) {
        Pageable pageable = PageRequest.of(page - 1, 10, Sort.by("id").descending());
        Page<Review> reviews = this.reviewService.getAllReviews(pageable);
        model.addAttribute("reviews", reviews.getContent());
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", reviews.getTotalPages());
        return "admin/review/show";
    }

    @PostMapping("/admin/review/approve/{id}")
    public String approveReview(@PathVariable long id, org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        Optional<Review> optionalReview = this.reviewService.findById(id);
        if (optionalReview.isPresent()) {
            Review review = optionalReview.get();
            review.setStatus("APPROVED");
            this.reviewService.saveReview(review);
            this.reviewService.updateProductReviewStats(review.getProduct());
            redirectAttributes.addFlashAttribute("success", "Review approved successfully.");
        }
        return "redirect:/admin/review";
    }

    @PostMapping("/admin/review/reject/{id}")
    public String rejectReview(@PathVariable long id, org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        Optional<Review> optionalReview = this.reviewService.findById(id);
        if (optionalReview.isPresent()) {
            Review review = optionalReview.get();
            review.setStatus("REJECTED");
            this.reviewService.saveReview(review);
            this.reviewService.updateProductReviewStats(review.getProduct());
            redirectAttributes.addFlashAttribute("success", "Review rejected.");
        }
        return "redirect:/admin/review";
    }

    @PostMapping("/admin/review/reply/{id}")
    public String replyReview(@PathVariable long id, @RequestParam("reply") String reply, org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        Optional<Review> optionalReview = this.reviewService.findById(id);
        if (optionalReview.isPresent()) {
            Review review = optionalReview.get();
            review.setReply(reply);
            this.reviewService.saveReview(review);
            redirectAttributes.addFlashAttribute("success", "Replied to review.");
        }
        return "redirect:/admin/review";
    }
}
