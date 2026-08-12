package laptopshop.controller.client;

import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import laptopshop.service.ProductService;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

class CartRequest {
    private long quantity;
    private long productId;
    private java.util.List<Long> selectedVouchers;

    public java.util.List<Long> getSelectedVouchers() {
        return selectedVouchers;
    }

    public void setSelectedVouchers(java.util.List<Long> selectedVouchers) {
        this.selectedVouchers = selectedVouchers;
    }

    public long getQuantity() {
        return quantity;
    }

    public void setQuantity(long quantity) {
        this.quantity = quantity;
    }

    public long getProductId() {
        return productId;
    }

    public void setProductId(long productId) {
        this.productId = productId;
    }
}

@RestController
public class CartAPI {

    private final ProductService productService;

    public CartAPI(ProductService productService) {
        this.productService = productService;
    }

    @PostMapping("/api/add-product-to-cart")
    public ResponseEntity<Integer> addProductToCart(
            @RequestBody() CartRequest cartRequest,
            HttpServletRequest request) {

        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        this.productService.handleAddProductToCart(email, cartRequest.getProductId(), session,
                cartRequest.getQuantity());

        if (cartRequest.getSelectedVouchers() != null && !cartRequest.getSelectedVouchers().isEmpty()) {
            session.setAttribute("preselectedVouchers", cartRequest.getSelectedVouchers());
        }

        int sum = (int) session.getAttribute("sum");

        return ResponseEntity.ok().body(sum);
    }

}
