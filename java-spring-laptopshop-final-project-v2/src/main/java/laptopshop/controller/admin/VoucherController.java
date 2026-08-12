package laptopshop.controller.admin;

import java.util.List;
import java.util.Optional;
import jakarta.validation.Valid;
import laptopshop.domain.Voucher;
import laptopshop.service.VoucherService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class VoucherController {

    private final VoucherService voucherService;

    public VoucherController(VoucherService voucherService) {
        this.voucherService = voucherService;
    }

    @GetMapping("/admin/voucher")
    public String getVoucher(Model model, @RequestParam("page") Optional<String> pageOptional) {
        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                page = Integer.parseInt(pageOptional.get());
            }
        } catch (Exception e) {
            // default page 1
        }

        Pageable pageable = PageRequest.of(page - 1, 5);
        Page<Voucher> prs = this.voucherService.fetchVouchers(pageable);
        List<Voucher> listVouchers = prs.getContent();
        model.addAttribute("vouchers", listVouchers);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", prs.getTotalPages());

        return "admin/voucher/show";
    }

    @GetMapping("/admin/voucher/create")
    public String getCreateVoucherPage(Model model) {
        model.addAttribute("newVoucher", new Voucher());
        return "admin/voucher/create";
    }

    @PostMapping("/admin/voucher/create")
    public String handleCreateVoucher(
            @ModelAttribute("newVoucher") @Valid Voucher pr,
            BindingResult newVoucherBindingResult,
            Model model) {
        if (newVoucherBindingResult.hasErrors()) {
            return "admin/voucher/create";
        }
        this.voucherService.handleSaveVoucher(pr);
        return "redirect:/admin/voucher";
    }

    @GetMapping("/admin/voucher/update/{id}")
    public String getUpdateVoucherPage(Model model, @PathVariable long id) {
        Optional<Voucher> currentVoucher = this.voucherService.fetchVoucherById(id);
        if (currentVoucher.isPresent()) {
            model.addAttribute("newVoucher", currentVoucher.get());
            return "admin/voucher/update";
        }
        return "redirect:/admin/voucher";
    }

    @PostMapping("/admin/voucher/update")
    public String handleUpdateVoucher(
            @ModelAttribute("newVoucher") @Valid Voucher pr,
            BindingResult newVoucherBindingResult) {
        if (newVoucherBindingResult.hasErrors()) {
            return "admin/voucher/update";
        }

        Optional<Voucher> currentVoucher = this.voucherService.fetchVoucherById(pr.getId());
        if (currentVoucher.isPresent()) {
            Voucher dbVoucher = currentVoucher.get();
            dbVoucher.setCode(pr.getCode());
            dbVoucher.setTitle(pr.getTitle());
            dbVoucher.setDescription(pr.getDescription());
            dbVoucher.setDiscountAmount(pr.getDiscountAmount());
            dbVoucher.setDiscountType(pr.getDiscountType());
            dbVoucher.setValidUntil(pr.getValidUntil());
            dbVoucher.setStatus(pr.getStatus());
            dbVoucher.setAppliesTo(pr.getAppliesTo());
            dbVoucher.setApplyValue(pr.getApplyValue());
            this.voucherService.handleSaveVoucher(dbVoucher);
        }

        return "redirect:/admin/voucher";
    }

    @GetMapping("/admin/voucher/delete/{id}")
    public String getDeleteVoucherPage(Model model, @PathVariable long id) {
        Optional<Voucher> voucher = this.voucherService.fetchVoucherById(id);
        if (voucher.isPresent()) {
            model.addAttribute("id", id);
            model.addAttribute("newVoucher", voucher.get());
            return "admin/voucher/delete";
        }
        return "redirect:/admin/voucher";
    }

    @PostMapping("/admin/voucher/delete")
    public String postDeleteVoucher(Model model, @ModelAttribute("newVoucher") Voucher pr) {
        this.voucherService.deleteVoucher(pr.getId());
        return "redirect:/admin/voucher";
    }
}
