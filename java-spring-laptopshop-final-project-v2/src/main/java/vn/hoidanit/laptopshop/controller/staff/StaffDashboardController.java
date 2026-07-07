package vn.hoidanit.laptopshop.controller.staff;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import vn.hoidanit.laptopshop.service.BlogService;
import vn.hoidanit.laptopshop.service.ContactService;
import vn.hoidanit.laptopshop.service.UserService;

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
        model.addAttribute("countOrders", this.userService.countOrders());
        model.addAttribute("countBlogs", this.blogService.countBlogs());
        model.addAttribute("countContacts", this.contactService.countContacts());
        return "staff/dashboard/show";
    }
}
