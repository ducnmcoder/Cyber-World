package vn.hoidanit.laptopshop.controller.account;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import jakarta.servlet.http.HttpServletRequest;

import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.service.UploadService;
import vn.hoidanit.laptopshop.service.UserService;

@Controller
public class AccountController {

    private final UserService userService;
    private final UploadService uploadService;
    private final PasswordEncoder passwordEncoder;

    public AccountController(UserService userService, UploadService uploadService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.uploadService = uploadService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/account/manage")
    public String getManageAccountPage(HttpServletRequest request, Model model) {
        String email = request.getUserPrincipal().getName();
        User currentUser = this.userService.getUserByEmail(email);
        
        // Use a DTO-like approach to safely bind form inputs
        User dto = new User();
        dto.setId(currentUser.getId());
        dto.setFullName(currentUser.getFullName());
        dto.setPhone(currentUser.getPhone());
        dto.setAddress(currentUser.getAddress());
        dto.setAvatar(currentUser.getAvatar());
        dto.setEmail(currentUser.getEmail());

        model.addAttribute("currentUser", dto);

        String roleName = currentUser.getRole().getName();
        if (roleName != null && ("ROLE_OWNER".equals(roleName) || "OWNER".equals(roleName) || roleName.contains("OWNER"))) {
            return "redirect:/admin";
        } else if (roleName != null && ("ROLE_ADMIN".equals(roleName) || "ADMIN".equals(roleName) || roleName.contains("ADMIN"))) {
            return "admin/account/manage";
        } else if ("STAFF".equals(roleName) || (roleName != null && roleName.contains("STAFF"))) {
            return "staff/account/manage";
        } else {
            return "client/account/manage";
        }
    }

    @PostMapping("/account/manage/info")
    public String updatePersonalInfo(HttpServletRequest request, 
                                     @ModelAttribute("currentUser") User formUser,
                                     @RequestParam("avatarFile") MultipartFile file) {
        String email = request.getUserPrincipal().getName();
        User currentUser = this.userService.getUserByEmail(email);
        
        boolean emailChanged = false;
        if (formUser.getEmail() != null && !formUser.getEmail().equals(currentUser.getEmail())) {
            if (this.userService.checkEmailExist(formUser.getEmail())) {
                return "redirect:/account/manage?error=email_exists";
            }
            currentUser.setEmail(formUser.getEmail());
            emailChanged = true;
        }

        currentUser.setFullName(formUser.getFullName());
        currentUser.setPhone(formUser.getPhone());
        currentUser.setAddress(formUser.getAddress());

        if (!file.isEmpty()) {
            String avatar = this.uploadService.handleSaveUploadFile(file, "avatar");
            currentUser.setAvatar(avatar);
        }

        this.userService.handleSaveUser(currentUser);
        
        if (emailChanged) {
            try {
                request.logout();
            } catch (Exception e) {
                // Ignore
            }
            return "redirect:/login";
        }
        
        // Refresh session avatar and name 
        request.getSession().setAttribute("fullName", currentUser.getFullName());
        request.getSession().setAttribute("avatar", currentUser.getAvatar());

        return "redirect:/account/manage?success=info";
    }

    @PostMapping("/account/manage/password")
    public String updatePassword(HttpServletRequest request,
                                 @RequestParam("newPassword") String newPassword,
                                 @RequestParam("confirmPassword") String confirmPassword) {
        if (!newPassword.equals(confirmPassword)) {
            return "redirect:/account/manage?error=password_mismatch";
        }

        String email = request.getUserPrincipal().getName();
        User currentUser = this.userService.getUserByEmail(email);

        String encodedPassword = this.passwordEncoder.encode(newPassword);
        currentUser.setPassword(encodedPassword);

        this.userService.handleSaveUser(currentUser);

        return "redirect:/account/manage?success=password";
    }
}
