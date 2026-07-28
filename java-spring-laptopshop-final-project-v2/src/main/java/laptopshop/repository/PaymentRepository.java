package laptopshop.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import laptopshop.domain.Order;
import laptopshop.domain.Payment;

public interface PaymentRepository extends JpaRepository<Payment, Long> {
    List<Payment> findByOrder(Order order);
    Payment findByTransactionRef(String transactionRef);
}
