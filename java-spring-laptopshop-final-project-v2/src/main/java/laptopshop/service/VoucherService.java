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
        return this.voucherRepository.findByStatus("ACTIVE");
    }

    public Optional<Voucher> fetchVoucherById(long id) {
        return this.voucherRepository.findById(id);
    }

    public void deleteVoucher(long id) {
        this.voucherRepository.deleteById(id);
    }
}
