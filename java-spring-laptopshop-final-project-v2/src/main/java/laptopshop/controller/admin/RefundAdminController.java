package laptopshop.controller.admin;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import laptopshop.domain.Order;
import laptopshop.service.OrderService;

@Controller
public class RefundAdminController {

    private final OrderService orderService;

    public RefundAdminController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping("/admin/refund")
    public String getRefundDashboard(Model model,
            @RequestParam(value = "page", defaultValue = "1") String pageOptional) {

        int page = 1;
        try {
            page = Integer.parseInt(pageOptional);
        } catch (Exception e) {
            page = 1;
        }

        if (page < 1) page = 1;

        Pageable pageable = PageRequest.of(page - 1, 10);
        
        // Fetch only orders that are related to refunds
        List<String> refundStatuses = Arrays.asList("REFUND_REQUESTED", "RETURNED", "REFUND_REJECTED");
        Page<Order> ordersPage = this.orderService.fetchOrdersByStatuses(refundStatuses, pageable);
        List<Order> orders = ordersPage.getContent();

        model.addAttribute("orders", orders);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", ordersPage.getTotalPages());
        
        return "admin/refund/show";
    }
}
