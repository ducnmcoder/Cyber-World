package laptopshop.controller.client;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import laptopshop.domain.Contact;
import laptopshop.domain.Feedback;
import laptopshop.domain.User;
import laptopshop.service.ContactService;
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
public class PageController {

    private final ContactService contactService;
    
    @Autowired
    private FeedbackService feedbackService;

    @Autowired
    private EmailService emailService;

    public PageController(ContactService contactService) {
        this.contactService = contactService;
    }

    // --- ABOUT ---
    @GetMapping("/about")
    public String getAboutPage(Model model) {
        return "client/about/show";
    }

    // --- CONTACT ---
    @GetMapping("/contact")
    public String getContactPage(Model model) {
        model.addAttribute("newContact", new Contact());
        return "client/contact/show";
    }

    @PostMapping("/contact")
    public String handleSubmitContact(
            @ModelAttribute("newContact") @Valid Contact contact,
            BindingResult bindingResult,
            Model model) {

        if (bindingResult.hasErrors()) {
            return "client/contact/show";
        }

        this.contactService.handleSaveContact(contact);
        model.addAttribute("success", true);
        model.addAttribute("newContact", new Contact());
        return "client/contact/show";
    }

    @PostMapping("/api/contact/footer")
    @org.springframework.web.bind.annotation.ResponseBody
    public org.springframework.http.ResponseEntity<String> handleFooterContact(
            @org.springframework.web.bind.annotation.RequestBody Contact contact) {
        if (contact.getSubject() == null || contact.getSubject().trim().isEmpty()) {
            contact.setSubject("Contact from Footer");
        }
        this.contactService.handleSaveContact(contact);
        return org.springframework.http.ResponseEntity.ok("{\"status\":\"success\"}");
    }

    // --- FEEDBACK ---
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
