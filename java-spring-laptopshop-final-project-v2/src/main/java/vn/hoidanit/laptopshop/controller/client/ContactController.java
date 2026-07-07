package vn.hoidanit.laptopshop.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.validation.Valid;
import vn.hoidanit.laptopshop.domain.Contact;
import vn.hoidanit.laptopshop.service.ContactService;

@Controller
public class ContactController {

    private final ContactService contactService;

    public ContactController(ContactService contactService) {
        this.contactService = contactService;
    }

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

}
