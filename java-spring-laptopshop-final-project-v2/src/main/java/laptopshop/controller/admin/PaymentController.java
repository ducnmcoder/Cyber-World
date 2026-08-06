package laptopshop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import laptopshop.domain.Payment;
import laptopshop.service.PaymentService;

@Controller("adminPaymentController")
public class PaymentController {

    private final PaymentService paymentService;

    public PaymentController(PaymentService paymentService) {
        this.paymentService = paymentService;
    }

    @GetMapping("/admin/payment")
    public String getPaymentDashboard(Model model,
            @RequestParam("page") Optional<String> pageOptional) {

        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                page = Integer.parseInt(pageOptional.get());
            }
        } catch (Exception e) {
            // default page = 1
        }

        if (page < 1) page = 1;

        Pageable pageable = PageRequest.of(page - 1, 10, Sort.by("id").descending());
        Page<Payment> paymentsPage = this.paymentService.fetchAllPayments(pageable);
        List<Payment> payments = paymentsPage.getContent();

        model.addAttribute("payments", payments);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", paymentsPage.getTotalPages());
        return "admin/payment/show";
    }

    @GetMapping("/admin/payment/{id}")
    public String getPaymentDetailPage(Model model, @PathVariable long id, @RequestParam(value = "page", defaultValue = "1") String page) {
        Optional<Payment> paymentOpt = this.paymentService.getPaymentById(id);
        if (paymentOpt.isPresent()) {
            model.addAttribute("payment", paymentOpt.get());
            model.addAttribute("id", id);
            model.addAttribute("page", page);
            return "admin/payment/detail";
        }
        return "redirect:/admin/payment?page=" + page;
    }
}
