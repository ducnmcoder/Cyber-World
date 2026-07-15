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

    @GetMapping("/admin")
    public String getDashboard(Model model) {
        model.addAttribute("monthlyRevenue", this.orderService.fetchMonthlyRevenue());
        model.addAttribute("dailyRevenue", this.orderService.fetchDailyRevenue());
        model.addAttribute("hourlyRevenue", this.orderService.fetchHourlyRevenue());
        model.addAttribute("topProducts", this.orderService.fetchTopProductsByRevenue(10));
        return "admin/dashboard/show";
    }
}
