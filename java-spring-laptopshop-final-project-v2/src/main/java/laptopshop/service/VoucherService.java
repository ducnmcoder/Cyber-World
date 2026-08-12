package laptopshop.service;

import java.util.Optional;
import laptopshop.domain.Voucher;
import laptopshop.repository.VoucherRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class VoucherService {

    private final VoucherRepository voucherRepository;

    public VoucherService(VoucherRepository voucherRepository) {
        this.voucherRepository = voucherRepository;
    }

    public Page<Voucher> fetchVouchers(Pageable pageable) {
        return this.voucherRepository.findAll(pageable);
    }

    public Voucher handleSaveVoucher(Voucher voucher) {
        return this.voucherRepository.save(voucher);
    }

    public java.util.List<Voucher> getActiveVouchers() {
        java.util.List<Voucher> activeVouchers = this.voucherRepository.findByStatus("ACTIVE");
        java.time.LocalDate today = java.time.LocalDate.now();
        return activeVouchers.stream().filter(v -> {
            if (v.getValidUntil() == null) return true;
            try {
                java.time.LocalDate validUntil = java.time.LocalDate.parse(v.getValidUntil());
                if (validUntil.isBefore(today)) {
                    return false;
                }
            } catch (Exception e) {
                try {
                    java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy");
                    java.time.LocalDate validUntil = java.time.LocalDate.parse(v.getValidUntil(), formatter);
                    if (validUntil.isBefore(today)) {
                        return false;
                    }
                } catch (Exception ex) {
                    // Ignore parse errors, let it show
                }
            }
            return true;
        }).collect(java.util.stream.Collectors.toList());
    }

    public Optional<Voucher> fetchVoucherById(long id) {
        return this.voucherRepository.findById(id);
    }

    public void deleteVoucher(long id) {
        this.voucherRepository.deleteById(id);
    }
}
