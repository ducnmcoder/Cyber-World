package laptopshop.controller.staff;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import laptopshop.service.BlogService;
import laptopshop.service.ContactService;
import laptopshop.service.UserService;

@Controller
public class StaffDashboardController {

    private final UserService userService;
    private final BlogService blogService;
    private final ContactService contactService;

    public StaffDashboardController(UserService userService, BlogService blogService,
            ContactService contactService) {
        this.userService = userService;
        this.blogService = blogService;
        this.contactService = contactService;
    }

    @GetMapping("/staff")
    public String getStaffDashboard(Model model) {
        return "redirect:/staff/order";
    }
}
