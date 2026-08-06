package laptopshop.controller.staff;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import laptopshop.domain.Contact;
import laptopshop.service.ContactService;

@Controller
public class StaffContactController {

    private final ContactService contactService;

    public StaffContactController(ContactService contactService) {
        this.contactService = contactService;
    }

    @GetMapping("/staff/contact")
    public String getContactList(Model model,
            @RequestParam("page") Optional<String> pageOptional) {

        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                page = Integer.parseInt(pageOptional.get());
            }
        } catch (Exception e) {
            // page = 1
        }

        Pageable pageable = PageRequest.of(page - 1, 10);
        Page<Contact> contactsPage = this.contactService.fetchAllContacts(pageable);
        List<Contact> contacts = contactsPage.getContent();

        model.addAttribute("contacts", contacts);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", contactsPage.getTotalPages());
        return "staff/contact/show";
    }

    @GetMapping("/staff/contact/{id}")
    public String getContactDetail(Model model, @PathVariable long id) {
        Optional<Contact> contactOptional = this.contactService.fetchContactById(id);
        if (contactOptional.isPresent()) {
            model.addAttribute("contact", contactOptional.get());
            model.addAttribute("id", id);
        }
        return "staff/contact/detail";
    }

    @GetMapping("/staff/contact/update/{id}")
    public String getUpdateContactPage(Model model, @PathVariable long id) {
        Optional<Contact> currentContact = this.contactService.fetchContactById(id);
        if (currentContact.isPresent()) {
            model.addAttribute("newContact", currentContact.get());
        }
        return "staff/contact/update";
    }

    @PostMapping("/staff/contact/update")
    public String handleUpdateContact(@ModelAttribute("newContact") Contact contact) {
        this.contactService.updateContactStatus(contact);
        return "redirect:/staff/contact";
    }

    // @GetMapping("/staff/contact/delete/{id}")
    // public String getDeleteContactPage(Model model, @PathVariable long id) {
    //     model.addAttribute("id", id);
    //     model.addAttribute("newContact", new Contact());
    //     return "staff/contact/delete";
    // }

    // @PostMapping("/staff/contact/delete")
    // public String postDeleteContact(@ModelAttribute("newContact") Contact contact) {
    //     this.contactService.deleteContactById(contact.getId());
    //     return "redirect:/staff/contact";
    // }

}
