package laptopshop.controller.admin;

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

import laptopshop.domain.Order;
import laptopshop.domain.Payment;
import laptopshop.service.OrderService;
import laptopshop.service.PaymentService;
import laptopshop.service.EmailService;

@Controller
public class OrderController {

    private final OrderService orderService;
    private final PaymentService paymentService;
    private final EmailService emailService;

    public OrderController(OrderService orderService, PaymentService paymentService, EmailService emailService) {
        this.orderService = orderService;
        this.paymentService = paymentService;
        this.emailService = emailService;
    }

    @GetMapping("/admin/order")
    public String getDashboard(Model model,
            @RequestParam("page") Optional<String> pageOptional) {

        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                // convert from String to int
                page = Integer.parseInt(pageOptional.get());
            } else {
                // page = 1
            }
        } catch (Exception e) {
            // page = 1
            // TODO: handle exception
        }

        if (page < 1) page = 1;

        Pageable pageable = PageRequest.of(page - 1, 10);
        Page<Order> ordersPage = this.orderService.fetchAllOrders(pageable);
        List<Order> orders = ordersPage.getContent();

        model.addAttribute("orders", orders);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", ordersPage.getTotalPages());
        return "admin/order/show";
    }

    @GetMapping("/admin/order/{id}")
    public String getOrderDetailPage(Model model, @PathVariable long id, @RequestParam(value = "page", defaultValue = "1") String page, @RequestParam(value = "source", required = false) String source) {
        Order order = this.orderService.fetchOrderById(id).get();
        model.addAttribute("order", order);
        model.addAttribute("id", id);
        model.addAttribute("page", page);
        model.addAttribute("source", source);
        model.addAttribute("orderDetails", order.getOrderDetails());
        model.addAttribute("payments", this.paymentService.getPaymentsByOrder(order));
        return "admin/order/detail";
    }

    @GetMapping("/admin/order/delete/{id}")
    public String getDeleteOrderPage(Model model, @PathVariable long id, @RequestParam(value = "page", defaultValue = "1") String page) {
        model.addAttribute("id", id);
        model.addAttribute("newOrder", new Order());
        model.addAttribute("page", page);
        return "admin/order/delete";
    }

    @PostMapping("/admin/order/delete")
    public String postDeleteOrder(@ModelAttribute("newOrder") Order order, @RequestParam(value = "page", defaultValue = "1") String page) {
        this.orderService.deleteOrderById(order.getId());
        return "redirect:/admin/order?page=" + page;
    }

    @GetMapping("/admin/order/update/{id}")
    public String getUpdateOrderPage(Model model, @PathVariable long id, @RequestParam(value = "page", defaultValue = "1") String page) {
        Optional<Order> currentOrder = this.orderService.fetchOrderById(id);
        model.addAttribute("newOrder", currentOrder.get());
        model.addAttribute("page", page);
        return "admin/order/update";
    }

    @PostMapping("/admin/order/update")
    public String handleUpdateOrder(@ModelAttribute("newOrder") Order order, @RequestParam(value = "page", defaultValue = "1") String page) {
        Optional<Order> currentOrderOpt = this.orderService.fetchOrderById(order.getId());
        if(currentOrderOpt.isPresent()) {
            Order currentOrder = currentOrderOpt.get();
            boolean statusChangedToShipping = !"SHIPPING".equals(currentOrder.getStatus()) && "SHIPPING".equals(order.getStatus());
            boolean statusChangedToComplete = !"COMPLETE".equals(currentOrder.getStatus()) && "COMPLETE".equals(order.getStatus());
            
            this.orderService.updateOrder(order);
            
            if (statusChangedToShipping || statusChangedToComplete) {
                String email = currentOrder.getReceiverEmail() != null && !currentOrder.getReceiverEmail().isEmpty() 
                                    ? currentOrder.getReceiverEmail() 
                                    : (currentOrder.getUser() != null ? currentOrder.getUser().getEmail() : null);
                if (email != null && !email.isEmpty()) {
                    // Fetch full updated order
                    Order updatedOrder = this.orderService.fetchOrderById(order.getId()).get();
                    if (statusChangedToShipping) {
                        this.emailService.sendShippingEmail(email, updatedOrder);
                    } else if (statusChangedToComplete) {
                        this.emailService.sendCompleteEmail(email, updatedOrder);
                    }
                }
            }
        } else {
            this.orderService.updateOrder(order);
        }
        return "redirect:/admin/order?page=" + page;
    }

    @PostMapping("/admin/order/refund/approve")
    public String handleApproveRefund(@RequestParam("orderId") long orderId, @RequestParam(value = "page", defaultValue = "1") String page, @RequestParam(value = "source", required = false) String source) {
        Optional<Order> currentOrder = this.orderService.fetchOrderById(orderId);
        if (currentOrder.isPresent()) {
            Order order = currentOrder.get();
            order.setStatus("RETURNED"); // Mark as returned/approved
            this.orderService.updateOrder(order);
            
            // Send email
            String email = order.getReceiverEmail() != null && !order.getReceiverEmail().isEmpty() 
                                    ? order.getReceiverEmail() 
                                    : (order.getUser() != null ? order.getUser().getEmail() : null);
            if (email != null && !email.isEmpty()) {
                this.emailService.sendRefundApprovalEmail(email, order);
            }
        }
        String redirectUrl = "/admin/order/" + orderId + "?page=" + page;
        if (source != null && !source.isEmpty()) {
            redirectUrl += "&source=" + source;
        }
        return "redirect:" + redirectUrl;
    }

    @PostMapping("/admin/order/refund/reject")
    public String handleRejectRefund(@RequestParam("orderId") long orderId, @RequestParam(value = "page", defaultValue = "1") String page, @RequestParam(value = "source", required = false) String source) {
        Optional<Order> currentOrder = this.orderService.fetchOrderById(orderId);
        if (currentOrder.isPresent()) {
            Order order = currentOrder.get();
            order.setStatus("REFUND_REJECTED"); // Mark as rejected so it stays in refund history
            this.orderService.updateOrder(order);
            
            // Send email
            String email = order.getReceiverEmail() != null && !order.getReceiverEmail().isEmpty() 
                                    ? order.getReceiverEmail() 
                                    : (order.getUser() != null ? order.getUser().getEmail() : null);
            if (email != null && !email.isEmpty()) {
                this.emailService.sendRefundRejectionEmail(email, order, null);
            }
        }
        String redirectUrl = "/admin/order/" + orderId + "?page=" + page;
        if (source != null && !source.isEmpty()) {
            redirectUrl += "&source=" + source;
        }
        return "redirect:" + redirectUrl;
    }
}
