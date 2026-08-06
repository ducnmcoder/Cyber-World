package laptopshop.controller.client;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import laptopshop.domain.Order;
import laptopshop.service.OrderService;

import java.util.Optional;

import org.springframework.web.multipart.MultipartFile;
import laptopshop.service.UploadService;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class RefundController {

    private final OrderService orderService;
    private final UploadService uploadService;

    public RefundController(OrderService orderService, UploadService uploadService) {
        this.orderService = orderService;
        this.uploadService = uploadService;
    }

    @PostMapping("/order/refund")
    public String requestRefund(
            @RequestParam("orderId") long orderId,
            @RequestParam("name") String name,
            @RequestParam("phone") String phone,
            @RequestParam("bankName") String bankName,
            @RequestParam("bankAccount") String bankAccount,
            @RequestParam("reason") String reason,
            @RequestParam(value = "proofs", required = false) MultipartFile[] proofs,
            RedirectAttributes redirectAttributes) {

        Optional<Order> orderOpt = orderService.fetchOrderById(orderId);
        if (orderOpt.isPresent()) {
            Order order = orderOpt.get();
            order.setRefundName(name);
            order.setRefundPhone(phone);
            order.setRefundBankName(bankName);
            order.setRefundBankAccount(bankAccount);
            order.setRefundReason(reason);
            order.setStatus("REFUND_REQUESTED");
            
            if (proofs != null && proofs.length > 0) {
                List<String> proofPaths = new ArrayList<>();
                for (int i = 0; i < proofs.length && i < 5; i++) {
                    MultipartFile file = proofs[i];
                    if (!file.isEmpty()) {
                        String fileName = uploadService.handleSaveUploadFile(file, "refunds");
                        proofPaths.add(fileName);
                    }
                }
                if (!proofPaths.isEmpty()) {
                    order.setRefundProofs(String.join(",", proofPaths));
                }
            }
            
            orderService.updateOrder(order);
            redirectAttributes.addFlashAttribute("successMessage", "Refund request submitted successfully!");
        }

        return "redirect:/order-history";
    }
}
