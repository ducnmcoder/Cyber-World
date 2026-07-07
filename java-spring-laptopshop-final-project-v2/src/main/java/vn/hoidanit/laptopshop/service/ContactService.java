package vn.hoidanit.laptopshop.service;

import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import vn.hoidanit.laptopshop.domain.Contact;
import vn.hoidanit.laptopshop.repository.ContactRepository;

@Service
public class ContactService {

    private final ContactRepository contactRepository;

    public ContactService(ContactRepository contactRepository) {
        this.contactRepository = contactRepository;
    }

    public Contact handleSaveContact(Contact contact) {
        return this.contactRepository.save(contact);
    }

    public Page<Contact> fetchAllContacts(Pageable pageable) {
        return this.contactRepository.findAll(pageable);
    }

    public Optional<Contact> fetchContactById(long id) {
        return this.contactRepository.findById(id);
    }

    public void deleteContactById(long id) {
        this.contactRepository.deleteById(id);
    }

    public void updateContactStatus(Contact contact) {
        Optional<Contact> contactOptional = this.fetchContactById(contact.getId());
        if (contactOptional.isPresent()) {
            Contact currentContact = contactOptional.get();
            currentContact.setStatus(contact.getStatus());
            this.contactRepository.save(currentContact);
        }
    }

    public long countContacts() {
        return this.contactRepository.count();
    }

}
