package laptopshop.controller.client;

import java.util.List;
import java.util.Optional;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;
import laptopshop.domain.Order;
import laptopshop.domain.Product;
import laptopshop.domain.User;
import laptopshop.domain.dto.RegisterDTO;
import laptopshop.service.OrderService;
import laptopshop.service.ProductService;
import laptopshop.service.UserService;
import laptopshop.service.BlogService;
import laptopshop.domain.Blog;
import laptopshop.service.EmailService;

@Controller
public class HomePageController {

    private final ProductService productService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final OrderService orderService;
    private final BlogService blogService;
    private final EmailService emailService;

    public HomePageController(
            ProductService productService,
            UserService userService,
            PasswordEncoder passwordEncoder,
            OrderService orderService,
            BlogService blogService,
            EmailService emailService) {
        this.productService = productService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
        this.orderService = orderService;
        this.blogService = blogService;
        this.emailService = emailService;
    }

    @GetMapping("/")
    public String getHomePage(Model model, @RequestParam(value = "page", defaultValue = "1") int page, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            if (user.getRole() != null && "ADMIN".equals(user.getRole().getName())) {
                return "redirect:/admin/user";
            }
        }

        // Ensure page is at least 1
        if (page < 1) page = 1;

        Pageable pageable = PageRequest.of(page - 1, 8, Sort.by("id").ascending());
        Page<Product> prs = this.productService.fetchProducts(pageable);
        List<Product> products = prs.getContent();

        model.addAttribute("products", products);
        model.addAttribute("totalPages", prs.getTotalPages());
        model.addAttribute("totalElements", prs.getTotalElements());
        model.addAttribute("currentPage", page);

        List<Blog> latestNews = this.blogService.fetchLatestNews(PageRequest.of(0, 5, Sort.by("createdAt").descending())).getContent();
        model.addAttribute("latestNews", latestNews);

        List<Blog> latestBlogs = this.blogService.fetchLatestBlogs(PageRequest.of(0, 5, Sort.by("createdAt").descending())).getContent();
        model.addAttribute("blogs", latestBlogs); // keep 'blogs' variable name for backward compatibility on Latest Blogs section

        return "thymeleaf/client/homepage/show";
    }

    @GetMapping("/blog")
    public String getBlogPageRedirect() {
        return "redirect:/blogs";
    }

    @GetMapping("/register")
    public String getRegisterPage(Model model) {
        model.addAttribute("registerUser", new RegisterDTO());
        return "thymeleaf/client/auth/register";
    }

    @PostMapping("/register")
    public String handleRegister(
            @ModelAttribute("registerUser") @Valid RegisterDTO registerDTO,
            BindingResult bindingResult) {

        // validate
        if (bindingResult.hasErrors()) {
            return "thymeleaf/client/auth/register";
        }

        User user = this.userService.registerDTOtoUser(registerDTO);

        String hashPassword = this.passwordEncoder.encode(user.getPassword());

        user.setPassword(hashPassword);
        
        laptopshop.domain.Role userRole = this.userService.getRoleByName("USER");
        if (userRole == null) {
            userRole = new laptopshop.domain.Role();
            userRole.setName("USER");
            userRole.setDescription("User role");
            userRole = this.userService.handleSaveRole(userRole);
        }
        user.setRole(userRole);
        user.setAvatar("avatar.jpg");
        // save
        this.userService.handleSaveUser(user);
        return "redirect:/login?registered";

    }

    @GetMapping("/login")
    public String getLoginPage(Model model) {

        return "thymeleaf/client/auth/login";
    }

    @org.springframework.web.bind.annotation.RequestMapping("/access-deny")
    public String getDenyPage(Model model) {

        return "client/auth/deny";
    }

    @GetMapping("/order-history")
    public String getOrderHistoryPage(Model model, HttpServletRequest request) {
        User currentUser = new User();// null
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);

        List<Order> orders = this.orderService.fetchOrderByUser(currentUser);
        
        // Exclude cancelled orders from the history
        List<Order> activeOrders = orders.stream()
                .filter(order -> !"CANCELLED".equals(order.getStatus()))
                .collect(java.util.stream.Collectors.toList());
                
        model.addAttribute("orders", activeOrders);

        return "client/cart/order-history";
    }

    @PostMapping("/update-delivery-info")
    public String updateDeliveryInfo(@RequestParam("orderId") long orderId,
                                     @RequestParam("receiverName") String receiverName,
                                     @RequestParam("receiverPhone") String receiverPhone,
                                     @RequestParam("receiverAddress") String receiverAddress,
                                     HttpServletRequest request,
                                     org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        Optional<Order> opt = this.orderService.fetchOrderById(orderId);
        if (opt.isPresent()) {
            Order order = opt.get();
            User sessionUser = (User) session.getAttribute("user");
            if (order.getUser() == null || order.getUser().getId() != sessionUser.getId()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Unauthorized access to order.");
                return "redirect:/order-history";
            }
            if ("PENDING".equals(order.getStatus())) {
                long hours = ChronoUnit.HOURS.between(order.getCreatedAt(), LocalDateTime.now());
                if (hours < 6) {
                    this.orderService.updateDeliveryInfo(orderId, receiverName, receiverPhone, receiverAddress);
                    redirectAttributes.addFlashAttribute("successMessage", "Delivery information updated successfully.");
                } else {
                    redirectAttributes.addFlashAttribute("errorMessage", "Cannot edit delivery info after 6 hours.");
                }
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Cannot edit delivery info when order is no longer pending.");
            }
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Order not found.");
        }
        return "redirect:/order-history";
    }

    @PostMapping("/order/cancel")
    public String cancelOrder(HttpServletRequest request, 
                            @RequestParam("orderId") long orderId, 
                            @RequestParam("reason") String reason,
                            @RequestParam(value = "refundName", required = false) String refundName,
                            @RequestParam(value = "refundPhone", required = false) String refundPhone,
                            @RequestParam(value = "refundBankName", required = false) String bankName,
                            @RequestParam(value = "refundBankAccount", required = false) String bankAccount,
                            RedirectAttributes redirectAttributes) {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        
        Optional<Order> opt = this.orderService.fetchOrderById(orderId);
        if (opt.isPresent()) {
            Order order = opt.get();
            User sessionUser = (User) session.getAttribute("user");
            
            // Check authorization
            if (order.getUser() == null || order.getUser().getId() != sessionUser.getId()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Unauthorized access to order.");
                return "redirect:/order-history";
            }
            
            if ("PENDING".equals(order.getStatus())) {
                this.orderService.cancelOrder(orderId, reason, refundName, refundPhone, bankName, bankAccount);
                
                // Send cancellation email
                String userEmail = sessionUser.getEmail();
                if (userEmail != null && !userEmail.isEmpty()) {
                    this.emailService.sendOrderCancellationEmail(userEmail, order, reason);
                }
                
                redirectAttributes.addFlashAttribute("successMessage", "Order cancelled successfully!");
                return "redirect:/order-history";
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Cannot cancel an order that is no longer pending.");
                return "redirect:/order-history";
            }
        }
        
        redirectAttributes.addFlashAttribute("errorMessage", "Order not found.");
        return "redirect:/order-history";
    }
}
