package laptopshop.controller.client;

import java.util.ArrayList;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import laptopshop.domain.Cart;
import laptopshop.domain.CartDetail;
import laptopshop.domain.Order;
import laptopshop.domain.Product;
import laptopshop.domain.Product_;
import laptopshop.domain.Review;
import laptopshop.domain.User;
import laptopshop.domain.dto.ProductCriteriaDTO;
import laptopshop.service.ProductService;
import laptopshop.service.BlogService;
import laptopshop.service.EmailService;
import laptopshop.service.PaymentService;
import laptopshop.service.VNPayService;
import laptopshop.service.MoMoService;
import laptopshop.service.ZaloPayService;
import laptopshop.domain.Blog;
import laptopshop.domain.Payment;
import laptopshop.service.ReviewService;
import laptopshop.service.UserService;
import laptopshop.service.VoucherService;
import laptopshop.repository.VoucherUsageRepository;

@Controller
public class ItemController {

    private final ProductService productService;
    private final BlogService blogService;
    private final PaymentService paymentService;
    private final VNPayService vnPayService;
    private final MoMoService moMoService;
    private final ZaloPayService zaloPayService;
    private final EmailService emailService;
    private final ReviewService reviewService;
    private final UserService userService;
    private final VoucherService voucherService;
    private final VoucherUsageRepository voucherUsageRepository;

    public ItemController(ProductService productService, BlogService blogService,
            PaymentService paymentService, VNPayService vnPayService,
            MoMoService moMoService, ZaloPayService zaloPayService,
            EmailService emailService, ReviewService reviewService, UserService userService, VoucherService voucherService, VoucherUsageRepository voucherUsageRepository) {
        this.productService = productService;
        this.blogService = blogService;
        this.paymentService = paymentService;
        this.vnPayService = vnPayService;
        this.moMoService = moMoService;
        this.zaloPayService = zaloPayService;
        this.emailService = emailService;
        this.reviewService = reviewService;
        this.userService = userService;
        this.voucherService = voucherService;
        this.voucherUsageRepository = voucherUsageRepository;
    }

    @GetMapping("/product/{id}")
    public String getProductPage(Model model, @PathVariable long id, HttpServletRequest request) {
        Product pr = this.productService.fetchProductById(id).orElse(null);
        if (pr == null) {
            return "redirect:/products";
        }
        model.addAttribute("product", pr);
        model.addAttribute("id", id);
        java.util.List<laptopshop.domain.Voucher> activeVouchers = this.voucherService.getActiveVouchers();
        HttpSession currentSession = request.getSession(false);
        User sessionUser = null;
        if (currentSession != null) {
            String email = (String) currentSession.getAttribute("email");
            if (email != null) {
                sessionUser = this.userService.getUserByEmail(email);
            }
        }
        final User currentUser = sessionUser;
        
        java.util.List<laptopshop.domain.Voucher> applicableVouchers = activeVouchers.stream().filter(v -> {
            boolean matches = false;
            if (v.getAppliesTo() == null || v.getAppliesTo().equals("ALL")) matches = true;
            else if (v.getAppliesTo().equals("FACTORY") && pr.getFactory() != null && v.getApplyValue() != null && pr.getFactory().equalsIgnoreCase(v.getApplyValue())) matches = true;
            else if (v.getAppliesTo().equals("TARGET") && pr.getTarget() != null && v.getApplyValue() != null && pr.getTarget().equalsIgnoreCase(v.getApplyValue())) matches = true;
            
            if (matches && currentUser != null) {
                if (this.voucherUsageRepository.existsValidUsage(currentUser, v, pr)) {
                    matches = false;
                }
            }
            return matches;
        }).collect(java.util.stream.Collectors.toList());
        java.util.List<laptopshop.domain.Voucher> discountVouchers = new java.util.ArrayList<>();
        java.util.List<laptopshop.domain.Voucher> freeshipVouchers = new java.util.ArrayList<>();
        
        laptopshop.domain.Voucher bestDiscountVoucher = null;
        double maxDiscountAmount = -1;

        laptopshop.domain.Voucher bestFreeshipVoucher = null;
        double maxFreeshipAmount = -1;

        for (laptopshop.domain.Voucher v : applicableVouchers) {
            if ("FREESHIP".equals(v.getDiscountType())) {
                freeshipVouchers.add(v);
                if (v.getDiscountAmount() > maxFreeshipAmount) {
                    maxFreeshipAmount = v.getDiscountAmount();
                    bestFreeshipVoucher = v;
                }
            } else {
                discountVouchers.add(v);
                double currentDiscount = 0;
                if ("FIXED".equals(v.getDiscountType())) {
                    currentDiscount = v.getDiscountAmount();
                } else if ("PERCENT".equals(v.getDiscountType())) {
                    currentDiscount = pr.getPrice() * v.getDiscountAmount() / 100.0;
                }
                if (currentDiscount > maxDiscountAmount) {
                    maxDiscountAmount = currentDiscount;
                    bestDiscountVoucher = v;
                }
            }
        }
        
        java.util.List<Long> autoSelected = new java.util.ArrayList<>();
        if (bestDiscountVoucher != null) autoSelected.add(bestDiscountVoucher.getId());
        if (bestFreeshipVoucher != null) autoSelected.add(bestFreeshipVoucher.getId());
        
        // Create a sorted list where preselected are at the top
        java.util.List<laptopshop.domain.Voucher> sortedVouchers = new java.util.ArrayList<>();
        if (bestDiscountVoucher != null) sortedVouchers.add(bestDiscountVoucher);
        if (bestFreeshipVoucher != null) sortedVouchers.add(bestFreeshipVoucher);
        
        for (laptopshop.domain.Voucher v : applicableVouchers) {
            if (!autoSelected.contains(v.getId())) {
                sortedVouchers.add(v);
            }
        }
        
        model.addAttribute("discountVouchers", discountVouchers);
        model.addAttribute("freeshipVouchers", freeshipVouchers);
        model.addAttribute("preselectedVouchers", autoSelected);
        model.addAttribute("vouchers", sortedVouchers);
        // Reviews pagination
        Pageable pageable = PageRequest.of(0, 50, Sort.by("createdAt").descending());
        Page<Review> reviews = this.reviewService.getApprovedReviewsByProduct(pr, pageable);
        model.addAttribute("reviews", reviews.getContent());
        
        // Latest Videos & Articles
        Pageable newsPageable = PageRequest.of(0, 10, Sort.by("createdAt").descending());
        model.addAttribute("latestVideos", this.blogService.fetchBlogsByCategoryAndHasVideo("NEWS", newsPageable).getContent());
        model.addAttribute("latestArticles", this.blogService.fetchBlogsByCategoryAndNoVideo("NEWS", newsPageable).getContent());

        // Check if user is logged in and can review
        HttpSession session = request.getSession(false);
        boolean canReview = false;
        Review userReview = null;

        if (session != null && session.getAttribute("email") != null) {
            long userId = (long) session.getAttribute("id");
            User user = this.userService.getUserById(userId);
            if (user != null) {
                canReview = this.reviewService.canUserReview(user, pr);
                if (canReview) {
                    userReview = this.reviewService.getUserReviewForProduct(user, pr);
                }
            }
        }

        model.addAttribute("canReview", canReview);
        model.addAttribute("userReview", userReview);

        return "thymeleaf/client/product/detail";
    }

    private boolean isManager(HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user != null && user.getRole() != null) {
            String roleName = user.getRole().getName();
            return "ADMIN".equals(roleName) || "STAFF".equals(roleName) || "OWNER".equals(roleName);
        }
        return false;
    }

    @PostMapping("/add-product-to-cart/{id}")
    public String addProductToCart(@PathVariable long id, HttpServletRequest request,
            org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession(true);
        if (isManager(session)) {
            return "redirect:/";
        }

        long productId = id;
        String email = (String) session.getAttribute("email");

        try {
            this.productService.handleAddProductToCart(email, productId, session, 1);
            redirectAttributes.addFlashAttribute("cartMessage", "Item successfully added to your cart!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/";
    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        if (isManager(session)) {
            return "redirect:/";
        }

        String email = (String) session.getAttribute("email");
        Cart cart = null;
        if (email != null) {
            User currentUser = new User();
            long id = (long) session.getAttribute("id");
            currentUser.setId(id);
            cart = this.productService.fetchByUser(currentUser);
        } else {
            cart = (Cart) session.getAttribute("guestCart");
        }

        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();
        if (cartDetails == null) {
            cartDetails = new ArrayList<>();
        }

        boolean cartChanged = false;
        List<CartDetail> validDetails = new ArrayList<>();
        List<CartDetail> invalidDetails = new ArrayList<>();
        for (CartDetail cd : cartDetails) {
            if (cd.getProduct() != null && this.productService.fetchProductById(cd.getProduct().getId()).isPresent()) {
                validDetails.add(cd);
            } else {
                cartChanged = true;
                invalidDetails.add(cd);
            }
        }

        // Clean up invalid CartDetails from DB and update cart sum
        if (cartChanged && email != null && cart != null) {
            for (CartDetail cd : invalidDetails) {
                this.productService.handleRemoveCartDetail(cd.getId(), session);
            }
            // Refresh session sum to match valid items
            session.setAttribute("sum", validDetails.size());
        } else if (cartChanged && email == null && cart != null) {
            cart.setCartDetails(validDetails);
            cart.setSum(validDetails.size());
            session.setAttribute("guestCart", cart);
            session.setAttribute("sum", validDetails.size());
        }

        cartDetails = validDetails;

        if (cartChanged) {
            model.addAttribute("errorMessage",
                    "Some items in your cart are no longer available and have been automatically removed.");
        }

        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getPrice() * cd.getQuantity();
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);

        model.addAttribute("cart", cart != null ? cart : new Cart());

        return "client/cart/show";
    }

    @PostMapping("/delete-cart-product/{id}")
    public String deleteCartDetail(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        if (isManager(session)) {
            return "redirect:/";
        }

        String email = (String) session.getAttribute("email");
        if (email != null) {
            this.productService.handleRemoveCartDetail(id, session);
        } else {
            Cart guestCart = (Cart) session.getAttribute("guestCart");
            if (guestCart != null && guestCart.getCartDetails() != null) {
                guestCart.getCartDetails().removeIf(cd -> cd.getId() == id);
                int s = guestCart.getCartDetails().size();
                guestCart.setSum(s);
                session.setAttribute("sum", s);
                session.setAttribute("guestCart", guestCart);
            }
        }
        return "redirect:/cart";
    }

    @GetMapping("/checkout")
    public String getCheckOutPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        if (isManager(session)) {
            return "redirect:/";
        }

        String email = (String) session.getAttribute("email");
        Cart cart = null;
        if (email != null) {
            User currentUser = new User();
            long id = (long) session.getAttribute("id");
            currentUser.setId(id);
            cart = this.productService.fetchByUser(currentUser);
        } else {
            cart = (Cart) session.getAttribute("guestCart");
        }

        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();
        if (cartDetails == null) {
            cartDetails = new ArrayList<>();
        }

        boolean cartChanged = false;
        List<CartDetail> validDetails = new ArrayList<>();
        List<CartDetail> invalidDetails = new ArrayList<>();
        for (CartDetail cd : cartDetails) {
            if (cd.getProduct() != null && this.productService.fetchProductById(cd.getProduct().getId()).isPresent()) {
                validDetails.add(cd);
            } else {
                cartChanged = true;
                invalidDetails.add(cd);
            }
        }

        // Clean up invalid CartDetails from DB and update cart sum
        if (cartChanged && email != null && cart != null) {
            for (CartDetail cd : invalidDetails) {
                this.productService.handleRemoveCartDetail(cd.getId(), session);
            }
            session.setAttribute("sum", validDetails.size());
        } else if (cartChanged && email == null && cart != null) {
            cart.setCartDetails(validDetails);
            cart.setSum(validDetails.size());
            session.setAttribute("guestCart", cart);
            session.setAttribute("sum", validDetails.size());
        }

        cartDetails = validDetails;

        if (cartChanged) {
            model.addAttribute("errorMessage",
                    "Some items in your cart are no longer available and have been automatically removed.");
        }

        double totalPrice = 0;
        int totalQuantity = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getPrice() * cd.getQuantity();
            totalQuantity += (int) cd.getQuantity();
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("totalQuantity", totalQuantity);
        model.addAttribute("cart", cart != null ? cart : new Cart());

        java.util.List<laptopshop.domain.Voucher> activeVouchers = this.voucherService.getActiveVouchers();
        java.util.List<laptopshop.domain.Voucher> applicableVouchers = new java.util.ArrayList<>();
        User finalUser = null;
        if (email != null) {
            finalUser = this.userService.getUserByEmail(email);
        }

        for (laptopshop.domain.Voucher v : activeVouchers) {
            boolean matches = false;
            if (v.getAppliesTo() == null || v.getAppliesTo().equals("ALL")) {
                matches = true;
            } else {
                for (laptopshop.domain.CartDetail cd : cartDetails) {
                    laptopshop.domain.Product p = cd.getProduct();
                    if (p != null) {
                        if (v.getAppliesTo().equals("FACTORY") && p.getFactory() != null && v.getApplyValue() != null && p.getFactory().equalsIgnoreCase(v.getApplyValue())) {
                            matches = true;
                            break;
                        }
                        if (v.getAppliesTo().equals("TARGET") && p.getTarget() != null && v.getApplyValue() != null && p.getTarget().equalsIgnoreCase(v.getApplyValue())) {
                            matches = true;
                            break;
                        }
                    }
                }
            }
            
            if (matches && finalUser != null) {
                boolean allApplicableUsed = true;
                boolean foundApplicable = false;
                for (laptopshop.domain.CartDetail cd : cartDetails) {
                    laptopshop.domain.Product p = cd.getProduct();
                    if (p == null) continue;
                    boolean pMatches = false;
                    if (v.getAppliesTo() == null || v.getAppliesTo().equals("ALL")) {
                        pMatches = true;
                    } else if ("FACTORY".equals(v.getAppliesTo()) && p.getFactory() != null && v.getApplyValue() != null && p.getFactory().equalsIgnoreCase(v.getApplyValue())) {
                        pMatches = true;
                    } else if ("TARGET".equals(v.getAppliesTo()) && p.getTarget() != null && v.getApplyValue() != null && p.getTarget().equalsIgnoreCase(v.getApplyValue())) {
                        pMatches = true;
                    }
                    if (pMatches) {
                        foundApplicable = true;
                        if (!this.voucherUsageRepository.existsValidUsage(finalUser, v, p)) {
                            allApplicableUsed = false;
                            break;
                        }
                    }
                }
                if (foundApplicable && allApplicableUsed) {
                    matches = false;
                }
            }
            
            if (matches) {
                applicableVouchers.add(v);
            }
        }
        java.util.List<laptopshop.domain.Voucher> discountVouchers = new java.util.ArrayList<>();
        java.util.List<laptopshop.domain.Voucher> freeshipVouchers = new java.util.ArrayList<>();
        
        laptopshop.domain.Voucher bestDiscountVoucher = null;
        double maxDiscountAmount = -1;

        laptopshop.domain.Voucher bestFreeshipVoucher = null;
        double maxFreeshipAmount = -1;

        for (laptopshop.domain.Voucher v : applicableVouchers) {
            if ("FREESHIP".equals(v.getDiscountType())) {
                freeshipVouchers.add(v);
                if (v.getDiscountAmount() > maxFreeshipAmount) {
                    maxFreeshipAmount = v.getDiscountAmount();
                    bestFreeshipVoucher = v;
                }
            } else {
                discountVouchers.add(v);
                double currentDiscount = 0;
                if ("FIXED".equals(v.getDiscountType())) {
                    currentDiscount = v.getDiscountAmount() * totalQuantity;
                } else if ("PERCENT".equals(v.getDiscountType())) {
                    currentDiscount = totalPrice * v.getDiscountAmount() / 100.0;
                }
                if (currentDiscount > maxDiscountAmount) {
                    maxDiscountAmount = currentDiscount;
                    bestDiscountVoucher = v;
                }
            }
        }
        
        model.addAttribute("discountVouchers", discountVouchers);
        model.addAttribute("freeshipVouchers", freeshipVouchers);

        java.util.List<Long> preselectedVouchers = (java.util.List<Long>) session.getAttribute("preselectedVouchers");
        if (preselectedVouchers != null) {
            model.addAttribute("preselectedVouchers", preselectedVouchers);
            session.removeAttribute("preselectedVouchers");
        } else {
            java.util.List<Long> autoSelected = new java.util.ArrayList<>();
            if (bestDiscountVoucher != null) autoSelected.add(bestDiscountVoucher.getId());
            if (bestFreeshipVoucher != null) autoSelected.add(bestFreeshipVoucher.getId());
            model.addAttribute("preselectedVouchers", autoSelected);
        }

        return "client/cart/checkout";
    }

    @PostMapping("/confirm-checkout")
    public String getCheckOutPage(@ModelAttribute("cart") Cart cart, HttpServletRequest request,
            org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession(true);
        if (isManager(session)) {
            return "redirect:/";
        }

        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();

        String email = (String) session.getAttribute("email");
        try {
            if (email != null) {
                this.productService.handleUpdateCartBeforeCheckout(cartDetails);
            } else {
                Cart guestCart = (Cart) session.getAttribute("guestCart");
                if (guestCart != null && guestCart.getCartDetails() != null) {
                    for (CartDetail cd : cartDetails) {
                        for (CartDetail gcd : guestCart.getCartDetails()) {
                            if (gcd.getId() == cd.getId()) {
                                long productStock = gcd.getProduct() != null && gcd.getProduct().getQuantity() != null
                                        ? gcd.getProduct().getQuantity()
                                        : 0;
                                if (cd.getQuantity() > productStock) {
                                    throw new RuntimeException("Insufficient quantity of products");
                                }
                                gcd.setQuantity(cd.getQuantity());
                                break;
                            }
                        }
                    }
                    session.setAttribute("guestCart", guestCart);
                }
            }
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/cart";
        }
        return "redirect:/checkout";
    }

    @PostMapping("/place-order")
    public String handlePlaceOrder(
            HttpServletRequest request,
            @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverAddress") String receiverAddress,
            @RequestParam("receiverPhone") String receiverPhone,
            @RequestParam(value = "receiverProvince", required = false) String receiverProvince,
            @RequestParam(value = "receiverEmail", required = false) String receiverEmail,
            @RequestParam(value = "paymentMethod", defaultValue = "COD") String paymentMethod,
            @RequestParam(value = "selectedVouchers", required = false) java.util.List<Long> selectedVouchers,
            org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {

        HttpSession session = request.getSession(true);
        if (isManager(session)) {
            return "redirect:/";
        }

        String email = (String) session.getAttribute("email");
        User currentUser = null;
        if (email != null) {
            currentUser = new User();
            long id = (long) session.getAttribute("id");
            currentUser.setId(id);
        }

        Order order = null;
        try {
            // Create order with payment method
            order = this.productService.handlePlaceOrder(
                    currentUser, session, receiverName, receiverAddress, receiverPhone, receiverEmail, receiverProvince, paymentMethod, selectedVouchers);
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/checkout";
        }

        if (order == null) {
            return "redirect:/cart";
        }

        // Create payment record
        Payment payment = this.paymentService.createPayment(order, paymentMethod);

        switch (paymentMethod) {
            case "VNPAY":
                String vnpayUrl = this.vnPayService.createPaymentUrl(order, payment.getTransactionRef(), request);
                if (vnpayUrl != null) {
                    return "redirect:" + vnpayUrl;
                }
                // If VNPay URL creation fails, mark as failed
                this.paymentService.updatePaymentStatus(payment.getId(), "FAILED", null);
                order.setPaymentStatus("FAILED");
                return "redirect:/payment-failed";

            case "MOMO":
                String momoUrl = this.moMoService.createPaymentUrl(order, payment.getTransactionRef());
                if (momoUrl != null) {
                    return "redirect:" + momoUrl;
                }
                this.paymentService.updatePaymentStatus(payment.getId(), "FAILED", null);
                order.setPaymentStatus("FAILED");
                return "redirect:/payment-failed";

            case "ZALOPAY":
                String zalopayUrl = this.zaloPayService.createPaymentUrl(order, payment.getTransactionRef());
                if (zalopayUrl != null) {
                    return "redirect:" + zalopayUrl;
                }
                this.paymentService.updatePaymentStatus(payment.getId(), "FAILED", null);
                order.setPaymentStatus("FAILED");
                return "redirect:/payment-failed";

            case "COD":
            default:
                // COD: mark payment as pending, send email
                order.setPaymentStatus("PENDING");
                String emailToSend = receiverEmail != null && !receiverEmail.isEmpty() ? receiverEmail : email;
                if (emailToSend != null && !emailToSend.isEmpty()) {
                    this.emailService.sendOrderConfirmationEmail(emailToSend, order);
                }
                return "redirect:/thanks";
        }
    }

    @GetMapping("/thanks")
    public String getThankYouPage(Model model) {

        return "client/cart/thanks";
    }

    @GetMapping("/payment-failed")
    public String getPaymentFailedPage(Model model) {
        return "client/cart/payment-failed";
    }

    @PostMapping("/add-product-from-view-detail")
    public String handleAddProductFromViewDetail(
            @RequestParam("id") long id,
            @RequestParam("quantity") long quantity,
            @RequestParam(value = "selectedVouchers", required = false) java.util.List<Long> selectedVouchers,
            HttpServletRequest request,
            org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession(true);
        if (isManager(session)) {
            return "redirect:/product/" + id;
        }

        if (selectedVouchers != null && !selectedVouchers.isEmpty()) {
            session.setAttribute("preselectedVouchers", selectedVouchers);
        }

        String email = (String) session.getAttribute("email");
        try {
            this.productService.handleAddProductToCart(email, id, session, quantity);
            redirectAttributes.addFlashAttribute("cartMessage", "Item successfully added to your cart!");
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/product/" + id;
    }

    @PostMapping("/buy-now")
    public String handleBuyNow(
            @RequestParam("id") long id,
            @RequestParam("quantity") long quantity,
            @RequestParam(value = "selectedVouchers", required = false) java.util.List<Long> selectedVouchers,
            HttpServletRequest request,
            org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession(true);
        if (isManager(session)) {
            return "redirect:/product/" + id;
        }

        if (selectedVouchers != null && !selectedVouchers.isEmpty()) {
            session.setAttribute("preselectedVouchers", selectedVouchers);
        }

        String email = (String) session.getAttribute("email");
        try {
            this.productService.handleAddProductToCart(email, id, session, quantity);
            return "redirect:/checkout";
        } catch (RuntimeException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/product/" + id;
        }
    }

    @GetMapping("/products")
    public String getProductPage(Model model,
            ProductCriteriaDTO productCriteriaDTO,
            HttpServletRequest request) {
        int page = 1;
        try {
            if (productCriteriaDTO.getPage().isPresent()) {
                // convert from String to int
                page = Integer.parseInt(productCriteriaDTO.getPage().get());
            } else {
                // page = 1
            }
        } catch (Exception e) {
            // page = 1
            // TODO: handle exception
        }

        // check sort price
        Pageable pageable = PageRequest.of(page - 1, 8, Sort.by("id").ascending());

        if (productCriteriaDTO.getSort() != null && productCriteriaDTO.getSort().isPresent()) {
            String sort = productCriteriaDTO.getSort().get();
            if (sort.equals("gia-tang-dan")) {
                pageable = PageRequest.of(page - 1, 8, Sort.by("price").ascending());
            } else if (sort.equals("gia-giam-dan")) {
                pageable = PageRequest.of(page - 1, 8, Sort.by("price").descending());
            } else if (sort.equals("featured")) {
                pageable = PageRequest.of(page - 1, 8, Sort.by("sold").descending());
            }
        }

        Page<Product> prs = this.productService.fetchProductsWithSpec(pageable, productCriteriaDTO);

        List<Product> products = prs.getContent().size() > 0 ? prs.getContent()
                : new ArrayList<Product>();

        String qs = request.getQueryString();
        if (qs != null && !qs.isBlank()) {
            // remove page
            qs = qs.replace("page=" + page, "");
        }

        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", prs.getTotalPages());
        model.addAttribute("totalElements", prs.getTotalElements());
        model.addAttribute("queryString", qs);

        List<Blog> latestNews = this.blogService.fetchLatestNews(PageRequest.of(0, 5, Sort.by("createdAt").descending())).getContent();
        model.addAttribute("latestNews", latestNews);

        List<Blog> latestBlogs = this.blogService.fetchLatestBlogs(PageRequest.of(0, 5, Sort.by("createdAt").descending())).getContent();
        model.addAttribute("blogs", latestBlogs);

        return "thymeleaf/client/homepage/show";
    }

}
