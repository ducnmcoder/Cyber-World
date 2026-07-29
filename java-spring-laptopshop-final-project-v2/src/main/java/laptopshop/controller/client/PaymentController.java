package laptopshop.controller.client;

import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import laptopshop.domain.Order;
import laptopshop.domain.Payment;
import laptopshop.service.EmailService;
import laptopshop.service.MoMoService;
import laptopshop.service.OrderService;
import laptopshop.service.PaymentService;
import laptopshop.service.VNPayService;
import laptopshop.service.ZaloPayService;

@Controller("clientPaymentController")
@RequestMapping("/api/payment")
public class PaymentController {

    private final PaymentService paymentService;
    private final OrderService orderService;
    private final VNPayService vnPayService;
    private final MoMoService moMoService;
    private final ZaloPayService zaloPayService;
    private final EmailService emailService;
    private final laptopshop.service.ProductService productService;

    public PaymentController(PaymentService paymentService, OrderService orderService,
            VNPayService vnPayService, MoMoService moMoService,
            ZaloPayService zaloPayService, EmailService emailService,
            laptopshop.service.ProductService productService) {
        this.paymentService = paymentService;
        this.orderService = orderService;
        this.vnPayService = vnPayService;
        this.moMoService = moMoService;
        this.zaloPayService = zaloPayService;
        this.emailService = emailService;
        this.productService = productService;
    }

    @GetMapping("/vnpay-return")
    public String vnpayReturn(HttpServletRequest request) {
        Map<String, String> params = request.getParameterMap().entrySet().stream()
                .collect(Collectors.toMap(Map.Entry::getKey, e -> e.getValue()[0]));

        String vnpTxnRef = params.get("vnp_TxnRef");
        String vnpTransactionNo = params.get("vnp_TransactionNo");

        Payment payment = this.paymentService.getPaymentByTransactionRef(vnpTxnRef);
        if (payment == null) {
            return "redirect:/payment-failed";
        }

        Order order = payment.getOrder();

        if (this.vnPayService.validateReturn(params) && this.vnPayService.isPaymentSuccess(params)) {
            // Payment successful
            this.paymentService.updatePaymentStatus(payment.getId(), "PAID", vnpTransactionNo);
            order.setPaymentStatus("PAID");
            this.orderService.updateOrderPaymentStatus(order);

            // Clear the cart
            this.productService.handleClearCart(order.getUser(), request.getSession(false));

            // Send confirmation email
            if (order.getUser() != null && order.getUser().getEmail() != null) {
                this.emailService.sendOrderConfirmationEmail(order.getUser().getEmail(), order);
            }

            return "redirect:/thanks";
        } else {
            // Payment failed
            this.paymentService.updatePaymentStatus(payment.getId(), "FAILED", vnpTransactionNo);
            order.setPaymentStatus("FAILED");
            this.orderService.updateOrderPaymentStatus(order);
            return "redirect:/payment-failed";
        }
    }

    @GetMapping("/momo-return")
    public String momoReturn(@RequestParam Map<String, String> params, HttpServletRequest request) {
        String orderId = params.get("orderId");
        String transId = params.get("transId");

        Payment payment = this.paymentService.getPaymentByTransactionRef(orderId);
        if (payment == null) {
            return "redirect:/payment-failed";
        }

        Order order = payment.getOrder();

        if (this.moMoService.isPaymentSuccess(params)) {
            // Payment successful
            this.paymentService.updatePaymentStatus(payment.getId(), "PAID", transId);
            order.setPaymentStatus("PAID");
            this.orderService.updateOrderPaymentStatus(order);

            // Clear the cart
            this.productService.handleClearCart(order.getUser(), request.getSession(false));

            // Send confirmation email
            if (order.getUser() != null && order.getUser().getEmail() != null) {
                this.emailService.sendOrderConfirmationEmail(order.getUser().getEmail(), order);
            }

            return "redirect:/thanks";
        } else {
            // Payment failed
            this.paymentService.updatePaymentStatus(payment.getId(), "FAILED", transId);
            order.setPaymentStatus("FAILED");
            this.orderService.updateOrderPaymentStatus(order);
            return "redirect:/payment-failed";
        }
    }

    @GetMapping("/zalopay-return")
    public String zalopayReturn(@RequestParam Map<String, String> params, HttpServletRequest request) {
        String appTransId = params.get("apptransid");

        // Extract our transactionRef from ZaloPay's app_trans_id format: yyMMdd_transactionRef
        String transactionRef = this.zaloPayService.extractTransactionRef(appTransId);

        Payment payment = this.paymentService.getPaymentByTransactionRef(transactionRef);
        if (payment == null) {
            return "redirect:/payment-failed";
        }

        Order order = payment.getOrder();

        if (this.zaloPayService.isPaymentSuccess(params)) {
            // Payment successful
            this.paymentService.updatePaymentStatus(payment.getId(), "PAID", appTransId);
            order.setPaymentStatus("PAID");
            this.orderService.updateOrderPaymentStatus(order);

            // Clear the cart
            this.productService.handleClearCart(order.getUser(), request.getSession(false));

            // Send confirmation email
            if (order.getUser() != null && order.getUser().getEmail() != null) {
                this.emailService.sendOrderConfirmationEmail(order.getUser().getEmail(), order);
            }

            return "redirect:/thanks";
        } else {
            // Payment failed
            this.paymentService.updatePaymentStatus(payment.getId(), "FAILED", appTransId);
            order.setPaymentStatus("FAILED");
            this.orderService.updateOrderPaymentStatus(order);
            return "redirect:/payment-failed";
        }
    }
}
