package laptopshop.repository;

import laptopshop.domain.Voucher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VoucherRepository extends JpaRepository<Voucher, Long> {
    java.util.List<Voucher> findByStatus(String status);
}
