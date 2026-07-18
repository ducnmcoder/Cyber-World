package laptopshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

import jakarta.servlet.http.HttpSession;
import laptopshop.domain.Cart;
import laptopshop.domain.CartDetail;
import laptopshop.domain.Order;
import laptopshop.domain.OrderDetail;
import laptopshop.domain.Product;
import laptopshop.domain.User;
import laptopshop.domain.dto.ProductCriteriaDTO;
import laptopshop.repository.CartDetailRepository;
import laptopshop.repository.CartRepository;
import laptopshop.repository.OrderDetailRepository;
import laptopshop.repository.OrderRepository;
import laptopshop.repository.ProductRepository;
import laptopshop.service.specification.ProductSpecs;

@Service
public class ProductService {
    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public ProductService(
            ProductRepository productRepository,
            CartRepository cartRepository,
            CartDetailRepository cartDetailRepository,
            UserService userService,
            OrderRepository orderRepository,
            OrderDetailRepository orderDetailRepository) {
        this.productRepository = productRepository;
        this.cartRepository = cartRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.userService = userService;
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    public Product createProduct(Product pr) {
        return this.productRepository.save(pr);
    }

    public Page<Product> fetchProducts(Pageable page) {
        return this.productRepository.findAll(page);
    }

    public Page<Product> fetchProductsWithSpec(Pageable page, ProductCriteriaDTO productCriteriaDTO) {
        if (productCriteriaDTO.getTarget() == null
                && productCriteriaDTO.getFactory() == null
                && productCriteriaDTO.getPrice() == null
                && productCriteriaDTO.getCpu() == null
                && productCriteriaDTO.getRam() == null
                && productCriteriaDTO.getName() == null) {
            return this.productRepository.findAll(page);
        }

        Specification<Product> combinedSpec = Specification.where(null);

        if (productCriteriaDTO.getTarget() != null && productCriteriaDTO.getTarget().isPresent()) {
            Specification<Product> currentSpecs = ProductSpecs.matchListTarget(productCriteriaDTO.getTarget().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }
        if (productCriteriaDTO.getFactory() != null && productCriteriaDTO.getFactory().isPresent()) {
            Specification<Product> currentSpecs = ProductSpecs.matchListFactory(productCriteriaDTO.getFactory().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }

        if (productCriteriaDTO.getPrice() != null && productCriteriaDTO.getPrice().isPresent()) {
            Specification<Product> currentSpecs = this.buildPriceSpecification(productCriteriaDTO.getPrice().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }

        if (productCriteriaDTO.getMinPrice() != null && productCriteriaDTO.getMinPrice().isPresent() &&
            productCriteriaDTO.getMaxPrice() != null && productCriteriaDTO.getMaxPrice().isPresent()) {
            Specification<Product> currentSpecs = ProductSpecs.matchPrice(productCriteriaDTO.getMinPrice().get(), productCriteriaDTO.getMaxPrice().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }
        
        if (productCriteriaDTO.getCpu() != null && productCriteriaDTO.getCpu().isPresent()) {
            Specification<Product> currentSpecs = ProductSpecs.matchListCpu(productCriteriaDTO.getCpu().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }

        if (productCriteriaDTO.getRam() != null && productCriteriaDTO.getRam().isPresent()) {
            Specification<Product> currentSpecs = ProductSpecs.matchListRam(productCriteriaDTO.getRam().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }

        if (productCriteriaDTO.getStorage() != null && productCriteriaDTO.getStorage().isPresent()) {
            Specification<Product> currentSpecs = ProductSpecs.matchListStorage(productCriteriaDTO.getStorage().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }

        if (productCriteriaDTO.getScreen() != null && productCriteriaDTO.getScreen().isPresent()) {
            Specification<Product> currentSpecs = ProductSpecs.matchListScreen(productCriteriaDTO.getScreen().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }

        if (productCriteriaDTO.getGpu() != null && productCriteriaDTO.getGpu().isPresent()) {
            Specification<Product> currentSpecs = ProductSpecs.matchListGpu(productCriteriaDTO.getGpu().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }

        if (productCriteriaDTO.getHz() != null && productCriteriaDTO.getHz().isPresent()) {
            Specification<Product> currentSpecs = ProductSpecs.matchListHz(productCriteriaDTO.getHz().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }

        if (productCriteriaDTO.getSecurity() != null && productCriteriaDTO.getSecurity().isPresent()) {
            Specification<Product> currentSpecs = ProductSpecs.matchListSecurity(productCriteriaDTO.getSecurity().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }

        if (productCriteriaDTO.getName() != null && productCriteriaDTO.getName().isPresent()) {
            Specification<Product> currentSpecs = ProductSpecs.nameLike(productCriteriaDTO.getName().get());
            combinedSpec = combinedSpec.and(currentSpecs);
        }

        return this.productRepository.findAll(combinedSpec, page);
    }

    // case 6
    public Specification<Product> buildPriceSpecification(List<String> price) {
        Specification<Product> combinedSpec = Specification.where(null); // disconjunction
        for (String p : price) {
            double min = 0;
            double max = 0;

            // Set the appropriate min and max based on the price range string
            switch (p) {
                case "duoi-10-trieu":
                case "under10":
                    min = 1;
                    max = 10000000;
                    break;
                case "10-15-trieu":
                case "10to15":
                    min = 10000000;
                    max = 15000000;
                    break;
                case "15-20-trieu":
                case "15to20":
                    min = 15000000;
                    max = 20000000;
                    break;
                case "20-25-trieu":
                case "20to25":
                    min = 20000000;
                    max = 25000000;
                    break;
                case "25-30-trieu":
                case "25to30":
                    min = 25000000;
                    max = 30000000;
                    break;
                case "tren-30-trieu":
                case "tren-20-trieu":
                case "over30":
                    min = 30000000;
                    max = 200000000;
                    break;
            }

            if (min != 0 && max != 0) {
                Specification<Product> rangeSpec = ProductSpecs.matchMultiplePrice(min, max);
                combinedSpec = combinedSpec.or(rangeSpec);
            }
        }

        return combinedSpec;
    }

    public Optional<Product> fetchProductById(long id) {
        return this.productRepository.findById(id);
    }

    public void deleteProduct(long id) {
        this.productRepository.deleteById(id);
    }

    public void handleAddProductToCart(String email, long productId, HttpSession session, long quantity) {

        User user = email != null ? this.userService.getUserByEmail(email) : null;
        if (user != null) {
            // check user đã có Cart chưa ? nếu chưa -> tạo mới
            Cart cart = this.cartRepository.findByUser(user);

            if (cart == null) {
                // tạo mới cart
                Cart otherCart = new Cart();
                otherCart.setUser(user);
                otherCart.setSum(0);

                cart = this.cartRepository.save(otherCart);
            }

            // save cart_detail
            // tìm product by id

            Optional<Product> productOptional = this.productRepository.findById(productId);
            if (productOptional.isPresent()) {
                Product realProduct = productOptional.get();

                // check sản phẩm đã từng được thêm vào giỏ hàng trước đây chưa ?
                CartDetail oldDetail = this.cartDetailRepository.findByCartAndProduct(cart, realProduct);
                //
                if (oldDetail == null) {
                    CartDetail cd = new CartDetail();
                    cd.setCart(cart);
                    cd.setProduct(realProduct);
                    cd.setPrice(realProduct.getPrice());
                    cd.setQuantity(quantity);
                    this.cartDetailRepository.save(cd);

                    // update cart (sum);
                    int s = cart.getSum() + 1;
                    cart.setSum(s);
                    this.cartRepository.save(cart);
                    session.setAttribute("sum", s);
                } else {
                    oldDetail.setQuantity(oldDetail.getQuantity() + quantity);
                    this.cartDetailRepository.save(oldDetail);
                }

            }
        } else {
            // GUEST CART
            Cart guestCart = (Cart) session.getAttribute("guestCart");
            if (guestCart == null) {
                guestCart = new Cart();
                guestCart.setSum(0);
                guestCart.setCartDetails(new java.util.ArrayList<>());
            }

            Optional<Product> productOptional = this.productRepository.findById(productId);
            if (productOptional.isPresent()) {
                Product realProduct = productOptional.get();

                boolean found = false;
                if (guestCart.getCartDetails() != null) {
                    for (CartDetail cd : guestCart.getCartDetails()) {
                        if (cd.getProduct().getId() == realProduct.getId()) {
                            cd.setQuantity(cd.getQuantity() + quantity);
                            found = true;
                            break;
                        }
                    }
                } else {
                    guestCart.setCartDetails(new java.util.ArrayList<>());
                }

                if (!found) {
                    CartDetail cd = new CartDetail();
                    cd.setProduct(realProduct);
                    cd.setPrice(realProduct.getPrice());
                    cd.setQuantity(quantity);
                    // generate a positive random id for ui handling
                    cd.setId(System.currentTimeMillis() + new java.util.Random().nextInt(1000));
                    guestCart.getCartDetails().add(cd);

                    int s = guestCart.getSum() + 1;
                    guestCart.setSum(s);
                    session.setAttribute("sum", s);
                }
            }
            session.setAttribute("guestCart", guestCart);
        }
    }

    public Cart fetchByUser(User user) {
        return this.cartRepository.findByUser(user);
    }

    public void handleRemoveCartDetail(long cartDetailId, HttpSession session) {
        Optional<CartDetail> cartDetailOptional = this.cartDetailRepository.findById(cartDetailId);
        if (cartDetailOptional.isPresent()) {
            CartDetail cartDetail = cartDetailOptional.get();

            Cart currentCart = cartDetail.getCart();
            // delete cart-detail
            this.cartDetailRepository.deleteById(cartDetailId);

            // update cart
            if (currentCart.getSum() > 1) {
                // update current cart
                int s = currentCart.getSum() - 1;
                currentCart.setSum(s);
                session.setAttribute("sum", s);
                this.cartRepository.save(currentCart);
            } else {
                // delete cart (sum = 1)
                this.cartRepository.deleteById(currentCart.getId());
                session.setAttribute("sum", 0);
            }
        }
    }

    public void handleUpdateCartBeforeCheckout(List<CartDetail> cartDetails) {
        for (CartDetail cartDetail : cartDetails) {
            Optional<CartDetail> cdOptional = this.cartDetailRepository.findById(cartDetail.getId());
            if (cdOptional.isPresent()) {
                CartDetail currentCartDetail = cdOptional.get();
                currentCartDetail.setQuantity(cartDetail.getQuantity());
                this.cartDetailRepository.save(currentCartDetail);
            }
        }
    }

    public void handlePlaceOrder(
            User user, HttpSession session,
            String receiverName, String receiverAddress, String receiverPhone) {

        // step 1: get cart
        Cart cart = null;
        if (user != null && user.getId() != 0) {
            cart = this.cartRepository.findByUser(user);
        } else {
            cart = (Cart) session.getAttribute("guestCart");
        }
        
        if (cart != null) {
            List<CartDetail> cartDetails = cart.getCartDetails();

            if (cartDetails != null && !cartDetails.isEmpty()) {

                // create order
                Order order = new Order();
                order.setUser(user != null && user.getId() != 0 ? user : null);
                order.setReceiverName(receiverName);
                order.setReceiverAddress(receiverAddress);
                order.setReceiverPhone(receiverPhone);
                order.setStatus("PENDING");

                double sum = 0;
                for (CartDetail cd : cartDetails) {
                    sum += cd.getPrice() * cd.getQuantity();
                }
                order.setTotalPrice(sum);
                order.setCreatedAt(LocalDateTime.now());
                order = this.orderRepository.save(order);

                // create orderDetail

                for (CartDetail cd : cartDetails) {
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setOrder(order);
                    orderDetail.setProduct(cd.getProduct());
                    orderDetail.setPrice(cd.getPrice());
                    orderDetail.setQuantity(cd.getQuantity());

                    this.orderDetailRepository.save(orderDetail);
                }

                // step 2: delete cart_detail and cart
                if (user != null && user.getId() != 0) {
                    for (CartDetail cd : cartDetails) {
                        this.cartDetailRepository.deleteById(cd.getId());
                    }
                    this.cartRepository.deleteById(cart.getId());
                } else {
                    session.removeAttribute("guestCart");
                }

                // step 3 : update session
                session.setAttribute("sum", 0);
            }
        }

    }
}
