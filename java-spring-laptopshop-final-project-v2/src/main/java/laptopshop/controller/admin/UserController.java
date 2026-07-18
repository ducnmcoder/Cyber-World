package laptopshop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import laptopshop.domain.Role;
import laptopshop.domain.User;
import laptopshop.service.UploadService;
import laptopshop.service.UserService;

@Controller
public class UserController {

    private final UserService userService;
    private final UploadService uploadService;
    private final PasswordEncoder passwordEncoder;

    public UserController(
            UploadService uploadService,
            UserService userService,
            PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.uploadService = uploadService;
        this.passwordEncoder = passwordEncoder;
    }

    @RequestMapping("/")
    public String getHomePage(Model model) {
        List<User> arrUsers = this.userService.getAllUsersByEmail("1@gmail.com");
        System.out.println(arrUsers);

        model.addAttribute("eric", "test");
        model.addAttribute("avatar", "from controller with model");
        return "hello";
    }

    @RequestMapping("/admin/user")
    public String getUserPage(Model model,
            @RequestParam("page") Optional<String> pageOptional) {
        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                // convert from String to int
                page = Integer.parseInt(pageOptional.get());
            } else {
                // page = 1
            }
        } catch (Exception e) {
            // page = 1
            // TODO: handle exception
        }

        Pageable pageable = PageRequest.of(page - 1, 5);
        Page<User> usersPage = this.userService.getAllUsers(pageable);
        List<User> users = usersPage.getContent();
        model.addAttribute("users1", users);

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", usersPage.getTotalPages());
        return "admin/user/show";
    }

    @RequestMapping("/admin/user/{id}")
    public String getUserDetailPage(Model model, @PathVariable long id) {
        User user = this.userService.getUserById(id);
        model.addAttribute("user", user);
        model.addAttribute("id", id);
        return "admin/user/detail";
    }

    // User creation has been disabled as per requirements

    @RequestMapping("/admin/user/update/{id}") // GET
    public String getUpdateUserPage(Model model, @PathVariable long id) {
        User currentUser = this.userService.getUserById(id);
        
        // Create a detached DTO-like User to avoid Hibernate flush errors
        // when Spring Form auto-grows the null 'role' property.
        User dto = new User();
        dto.setId(currentUser.getId());
        dto.setEmail(currentUser.getEmail());
        dto.setFullName(currentUser.getFullName());
        dto.setAddress(currentUser.getAddress());
        dto.setPhone(currentUser.getPhone());
        if (currentUser.getRole() != null) {
            Role r = new Role();
            r.setName(currentUser.getRole().getName());
            dto.setRole(r);
        }
        
        model.addAttribute("newUser", dto);
        return "admin/user/update";
    }

    @PostMapping("/admin/user/update")
    public String postUpdateUser(Model model, @ModelAttribute("newUser") User avatar) {
        User currentUser = this.userService.getUserById(avatar.getId());
        if (currentUser != null) {
            // Only update the role, do not allow changing personal info
            currentUser.setRole(this.userService.getRoleByName(avatar.getRole().getName()));

            // bug here
            this.userService.handleSaveUser(currentUser);
        }
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/delete/{id}")
    public String getDeleteUserPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        // User user = new User();
        // user.setId(id);
        model.addAttribute("newUser", new User());
        return "admin/user/delete";
    }

    @PostMapping("/admin/user/delete")
    public String postDeleteUser(Model model, @ModelAttribute("newUser") User eric) {
        User targetUser = this.userService.getUserById(eric.getId());
        org.springframework.security.core.Authentication auth = org.springframework.security.core.context.SecurityContextHolder.getContext().getAuthentication();
        
        if (targetUser != null && targetUser.getRole() != null && "OWNER".equals(targetUser.getRole().getName())) {
            boolean isOwner = auth.getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_OWNER"));
            if (!isOwner) {
                return "redirect:/admin/user?error=CannotDeleteOwner";
            }
        }
        
        this.userService.deleteAUser(eric.getId());
        return "redirect:/admin/user";
    }
}
