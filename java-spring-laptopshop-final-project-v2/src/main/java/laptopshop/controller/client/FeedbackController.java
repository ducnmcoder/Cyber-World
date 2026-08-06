package laptopshop.controller.client;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import laptopshop.domain.Feedback;
import laptopshop.domain.User;
import laptopshop.service.EmailService;
import laptopshop.service.FeedbackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class FeedbackController {

    @Autowired
    private FeedbackService feedbackService;

    @Autowired
    private EmailService emailService;

    @GetMapping("/feedback")
    public String showFeedbackForm(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("feedback", new Feedback());
        return "client/feedback/feedback";
    }

    @PostMapping("/feedback")
    public String submitFeedback(@Valid @ModelAttribute("feedback") Feedback feedback,
                                 BindingResult bindingResult,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {
        
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        if (bindingResult.hasErrors()) {
            return "client/feedback/feedback";
        }

        // Set the user to the feedback
        feedback.setUser(user);
        
        // Save to DB
        feedbackService.saveFeedback(feedback);
        
        // Send email
        emailService.sendFeedbackConfirmationEmail(user.getEmail(), feedback.getSubject(), feedback.getContent());

        // Redirect with success message
        redirectAttributes.addFlashAttribute("successMessage", "Thank you for your feedback! We have sent a confirmation email to your address.");
        
        return "redirect:/feedback";
    }
}
