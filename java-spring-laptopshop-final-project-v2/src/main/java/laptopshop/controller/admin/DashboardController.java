package laptopshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import laptopshop.service.OrderService;
import laptopshop.service.UserService;

@Controller
public class DashboardController {

    private final UserService userService;
    private final OrderService orderService;

    public DashboardController(UserService userService, OrderService orderService) {
        this.userService = userService;
        this.orderService = orderService;
    }

    @GetMapping(value = {"/admin", "/owner"})
    public String getDashboard(Model model) {
        return "admin/dashboard/show";
    }

}
