package vn.hoidanit.laptopshop.controller.admin;

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

import vn.hoidanit.laptopshop.domain.Contact;
import vn.hoidanit.laptopshop.service.ContactService;

@Controller
public class ContactAdminController {

    private final ContactService contactService;

    public ContactAdminController(ContactService contactService) {
        this.contactService = contactService;
    }

    @GetMapping("/admin/contact")
    public String getContactListPage(Model model,
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
        return "admin/contact/show";
    }

    @GetMapping("/admin/contact/{id}")
    public String getContactDetailPage(Model model, @PathVariable long id) {
        Optional<Contact> contactOptional = this.contactService.fetchContactById(id);
        if (contactOptional.isPresent()) {
            model.addAttribute("contact", contactOptional.get());
            model.addAttribute("id", id);
        }
        return "admin/contact/detail";
    }

    @GetMapping("/admin/contact/delete/{id}")
    public String getDeleteContactPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("newContact", new Contact());
        return "admin/contact/delete";
    }

    @PostMapping("/admin/contact/delete")
    public String postDeleteContact(@ModelAttribute("newContact") Contact contact) {
        this.contactService.deleteContactById(contact.getId());
        return "redirect:/admin/contact";
    }

    @GetMapping("/admin/contact/update/{id}")
    public String getUpdateContactPage(Model model, @PathVariable long id) {
        Optional<Contact> currentContact = this.contactService.fetchContactById(id);
        if (currentContact.isPresent()) {
            model.addAttribute("newContact", currentContact.get());
        }
        return "admin/contact/update";
    }

    @PostMapping("/admin/contact/update")
    public String handleUpdateContact(@ModelAttribute("newContact") Contact contact) {
        this.contactService.updateContactStatus(contact);
        return "redirect:/admin/contact";
    }

}
