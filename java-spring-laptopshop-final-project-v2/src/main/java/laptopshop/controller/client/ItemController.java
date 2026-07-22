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
import laptopshop.domain.Product;
import laptopshop.domain.Product_;
import laptopshop.domain.User;
import laptopshop.domain.dto.ProductCriteriaDTO;
import laptopshop.service.ProductService;

@Controller
public class ItemController {

    private final ProductService productService;

    public ItemController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/product/{id}")
    public String getProductPage(Model model, @PathVariable long id) {
        Product pr = this.productService.fetchProductById(id).orElse(null);
        if (pr == null) {
            return "redirect:/products";
        }
        model.addAttribute("product", pr);
        model.addAttribute("id", id);
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
    public String addProductToCart(@PathVariable long id, HttpServletRequest request, org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession(true);
        if (isManager(session)) {
            return "redirect:/";
        }

        long productId = id;
        String email = (String) session.getAttribute("email");

        this.productService.handleAddProductToCart(email, productId, session, 1);
        redirectAttributes.addFlashAttribute("cartMessage", "Item successfully added to your cart!");
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

        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getPrice() * cd.getQuantity();
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);

        return "client/cart/checkout";
    }

    @PostMapping("/confirm-checkout")
    public String getCheckOutPage(@ModelAttribute("cart") Cart cart, HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        if (isManager(session)) {
            return "redirect:/";
        }

        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();
        
        String email = (String) session.getAttribute("email");
        if (email != null) {
            this.productService.handleUpdateCartBeforeCheckout(cartDetails);
        } else {
            Cart guestCart = (Cart) session.getAttribute("guestCart");
            if (guestCart != null && guestCart.getCartDetails() != null) {
                for (CartDetail cd : cartDetails) {
                    for (CartDetail gcd : guestCart.getCartDetails()) {
                        if (gcd.getId() == cd.getId()) {
                            gcd.setQuantity(cd.getQuantity());
                            break;
                        }
                    }
                }
                session.setAttribute("guestCart", guestCart);
            }
        }
        return "redirect:/checkout";
    }

    @PostMapping("/place-order")
    public String handlePlaceOrder(
            HttpServletRequest request,
            @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverAddress") String receiverAddress,
            @RequestParam("receiverPhone") String receiverPhone) {
        
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

        this.productService.handlePlaceOrder(currentUser, session, receiverName, receiverAddress, receiverPhone);

        return "redirect:/thanks";
    }

    @GetMapping("/thanks")
    public String getThankYouPage(Model model) {

        return "client/cart/thanks";
    }

    @PostMapping("/add-product-from-view-detail")
    public String handleAddProductFromViewDetail(
            @RequestParam("id") long id,
            @RequestParam("quantity") long quantity,
            HttpServletRequest request, org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        HttpSession session = request.getSession(true);
        if (isManager(session)) {
            return "redirect:/product/" + id;
        }

        String email = (String) session.getAttribute("email");
        this.productService.handleAddProductToCart(email, id, session, quantity);
        redirectAttributes.addFlashAttribute("cartMessage", "Item successfully added to your cart!");
        return "redirect:/product/" + id;
    }

    @PostMapping("/buy-now")
    public String handleBuyNow(
            @RequestParam("id") long id,
            @RequestParam("quantity") long quantity,
            HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        if (isManager(session)) {
            return "redirect:/product/" + id;
        }

        String email = (String) session.getAttribute("email");
        this.productService.handleAddProductToCart(email, id, session, quantity);
        return "redirect:/checkout";
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
        

        return "thymeleaf/client/homepage/show";
    }

}
