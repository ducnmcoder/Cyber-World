package laptopshop.repository;

import laptopshop.domain.Product;
import laptopshop.domain.User;
import laptopshop.domain.Voucher;
import laptopshop.domain.VoucherUsage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface VoucherUsageRepository extends JpaRepository<VoucherUsage, Long> {

    @Query("SELECT COUNT(vu) > 0 FROM VoucherUsage vu " +
           "WHERE vu.user = :user AND vu.voucher = :voucher AND vu.product = :product " +
           "AND (" +
           "  (vu.order.paymentMethod = 'COD' AND vu.order.status != 'CANCELLED') " +
           "  OR " +
           "  (vu.order.paymentMethod != 'COD' AND vu.order.paymentStatus = 'PAID') " +
           ")")
    boolean existsValidUsage(@Param("user") User user, 
                             @Param("voucher") Voucher voucher, 
                             @Param("product") Product product);

}
