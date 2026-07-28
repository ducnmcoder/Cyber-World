package laptopshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import laptopshop.service.OrderService;
import laptopshop.service.UserService;
import laptopshop.service.ContactService;

@Controller
public class DashboardController {

    private final UserService userService;
    private final OrderService orderService;
    private final ContactService contactService;

    public DashboardController(UserService userService, OrderService orderService, ContactService contactService) {
        this.userService = userService;
        this.orderService = orderService;
        this.contactService = contactService;
    }

    @GetMapping(value = {"/admin", "/owner"})
    public String getDashboard(Model model) {
        model.addAttribute("countUsers", this.userService.countUsers());
        model.addAttribute("countProducts", this.userService.countProducts());
        model.addAttribute("countOrders", this.userService.countOrders());
        model.addAttribute("countContacts", this.contactService.countContacts());
        return "admin/dashboard/show";
    }

}
