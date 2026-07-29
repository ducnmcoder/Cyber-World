package laptopshop.service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import laptopshop.domain.Order;
import laptopshop.domain.Payment;
import laptopshop.repository.PaymentRepository;

@Service
public class PaymentService {
    private final PaymentRepository paymentRepository;

    public PaymentService(PaymentRepository paymentRepository) {
        this.paymentRepository = paymentRepository;
    }

    public Payment createPayment(Order order, String paymentMethod) {
        Payment payment = new Payment();
        payment.setOrder(order);
        payment.setPaymentMethod(paymentMethod);
        payment.setAmount(order.getTotalPrice());
        payment.setTransactionRef(generateTransactionRef(order.getId()));
        payment.setCreatedAt(LocalDateTime.now());

        if ("COD".equals(paymentMethod)) {
            payment.setPaymentStatus("PENDING");
        } else {
            payment.setPaymentStatus("PENDING");
        }

        return this.paymentRepository.save(payment);
    }

    public String generateTransactionRef(long orderId) {
        return "CW" + orderId + System.currentTimeMillis();
    }

    public Payment updatePaymentStatus(long paymentId, String status, String gatewayTransactionId) {
        Optional<Payment> paymentOpt = this.paymentRepository.findById(paymentId);
        if (paymentOpt.isPresent()) {
            Payment payment = paymentOpt.get();
            payment.setPaymentStatus(status);
            if (gatewayTransactionId != null) {
                payment.setGatewayTransactionId(gatewayTransactionId);
            }
            if ("PAID".equals(status)) {
                payment.setPaymentDate(LocalDateTime.now());
            }
            return this.paymentRepository.save(payment);
        }
        return null;
    }

    public List<Payment> getPaymentsByOrder(Order order) {
        return this.paymentRepository.findByOrder(order);
    }

    public Page<Payment> fetchAllPayments(Pageable page) {
        return this.paymentRepository.findAll(page);
    }

    public Payment getPaymentByTransactionRef(String transactionRef) {
        return this.paymentRepository.findByTransactionRef(transactionRef);
    }

    public Optional<Payment> getPaymentById(long id) {
        return this.paymentRepository.findById(id);
    }
}
