package laptopshop.controller.client;

import laptopshop.domain.User;
import laptopshop.service.EmailService;
import laptopshop.service.UserService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDateTime;
import java.util.Random;

@Controller
public class ForgotPasswordController {

    private final UserService userService;
    private final EmailService emailService;
    private final PasswordEncoder passwordEncoder;

    public ForgotPasswordController(UserService userService, EmailService emailService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.emailService = emailService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/forgot-password")
    public String showForgotPasswordForm(Model model, @RequestParam(value = "error", required = false) String error) {
        if ("invalid_code".equals(error)) {
            model.addAttribute("error", "The reset link is invalid or has expired.");
        }
        return "thymeleaf/client/auth/forgot-password";
    }

    @PostMapping("/forgot-password")
    public String processForgotPassword(@RequestParam("email") String email, Model model) {
        User user = userService.getUserByEmail(email);
        if (user == null) {
            model.addAttribute("error", "We could not find an account with that e-mail address.");
            return "thymeleaf/client/auth/forgot-password";
        }

        if (!"LOCAL".equals(user.getProvider())) {
            model.addAttribute("error", "This account was registered using a social provider (Google/Facebook). Please log in with that provider.");
            return "thymeleaf/client/auth/forgot-password";
        }

        // Generate 6-digit code
        String code = String.format("%06d", new Random().nextInt(999999));
        user.setResetPasswordCode(code);
        user.setResetPasswordExpiry(LocalDateTime.now().plusMinutes(5));
        userService.handleSaveUser(user);

        // Send email
        emailService.sendPasswordResetEmail(user.getEmail(), code);

        return "redirect:/verify-code?email=" + email;
    }

    @GetMapping("/verify-code")
    public String showVerifyCodeForm(@RequestParam("email") String email, Model model) {
        model.addAttribute("email", email);
        return "thymeleaf/client/auth/verify-code";
    }

    @PostMapping("/verify-code")
    public String processVerifyCode(@RequestParam("email") String email,
                                    @RequestParam("code") String code,
                                    Model model) {
        User user = userService.getUserByEmail(email);
        if (user == null || user.getResetPasswordCode() == null) {
            model.addAttribute("error", "Invalid request.");
            model.addAttribute("email", email);
            return "thymeleaf/client/auth/verify-code";
        }

        if (user.getResetPasswordExpiry().isBefore(LocalDateTime.now())) {
            model.addAttribute("error", "The verification code has expired. Please request a new one.");
            model.addAttribute("email", email);
            return "thymeleaf/client/auth/verify-code";
        }

        if (!user.getResetPasswordCode().equals(code)) {
            model.addAttribute("error", "Invalid verification code.");
            model.addAttribute("email", email);
            return "thymeleaf/client/auth/verify-code";
        }

        return "redirect:/reset-password?email=" + email + "&code=" + code;
    }

    @GetMapping("/reset-password")
    public String showResetPasswordForm(@RequestParam("email") String email,
                                        @RequestParam("code") String code,
                                        Model model) {
        User user = userService.getUserByEmail(email);
        if (user == null || !code.equals(user.getResetPasswordCode()) || user.getResetPasswordExpiry().isBefore(LocalDateTime.now())) {
            return "redirect:/forgot-password?error=invalid_code";
        }
        
        model.addAttribute("email", email);
        model.addAttribute("code", code);
        return "thymeleaf/client/auth/reset-password";
    }

    @PostMapping("/reset-password")
    public String processResetPassword(@RequestParam("email") String email,
                                       @RequestParam("code") String code,
                                       @RequestParam("password") String password,
                                       @RequestParam("confirmPassword") String confirmPassword,
                                       Model model) {
        if (!password.equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match.");
            model.addAttribute("email", email);
            model.addAttribute("code", code);
            return "thymeleaf/client/auth/reset-password";
        }
        
        if (password.length() < 2) {
            model.addAttribute("error", "Password must be at least 2 characters.");
            model.addAttribute("email", email);
            model.addAttribute("code", code);
            return "thymeleaf/client/auth/reset-password";
        }

        User user = userService.getUserByEmail(email);
        if (user == null || !code.equals(user.getResetPasswordCode()) || user.getResetPasswordExpiry().isBefore(LocalDateTime.now())) {
            return "redirect:/forgot-password?error=invalid_code";
        }

        // Update password
        user.setPassword(passwordEncoder.encode(password));
        user.setResetPasswordCode(null);
        user.setResetPasswordExpiry(null);
        userService.handleSaveUser(user);

        return "redirect:/login?resetSuccess=true";
    }
}
