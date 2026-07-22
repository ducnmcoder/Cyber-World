package laptopshop.controller.account;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.authentication.OAuth2AuthenticationToken;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import jakarta.servlet.http.HttpServletRequest;

import laptopshop.domain.User;
import laptopshop.security.CustomOAuth2User;
import laptopshop.service.UploadService;
import laptopshop.service.UserService;

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

    /**
     * Extract email from the current authentication principal.
     * For OAuth2 login (Google), getName() returns the user's name, not email.
     * This helper checks the principal type and extracts email correctly.
     */
    private String getEmailFromPrincipal(HttpServletRequest request) {
        java.security.Principal principal = request.getUserPrincipal();
        if (principal instanceof OAuth2AuthenticationToken) {
            OAuth2AuthenticationToken oauthToken = (OAuth2AuthenticationToken) principal;
            if (oauthToken.getPrincipal() instanceof CustomOAuth2User) {
                return ((CustomOAuth2User) oauthToken.getPrincipal()).getEmail();
            }
        }
        // Form login: getName() returns the email (username)
        return principal.getName();
    }

    @GetMapping("/account/manage")
    public String getManageAccountPage(HttpServletRequest request, Model model) {
        String email = getEmailFromPrincipal(request);
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

        if (currentUser.getEmail() != null && currentUser.getEmail().endsWith("@facebook.local")) {
            model.addAttribute("updateEmailWarning", "Please update your new email address.");
        }

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
        String email = getEmailFromPrincipal(request);
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

        String email = getEmailFromPrincipal(request);
        User currentUser = this.userService.getUserByEmail(email);

        String encodedPassword = this.passwordEncoder.encode(newPassword);
        currentUser.setPassword(encodedPassword);

        this.userService.handleSaveUser(currentUser);

        return "redirect:/account/manage?success=password";
    }
}

