package laptopshop.controller.admin;

import java.util.List;
import java.util.Optional;

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
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import laptopshop.domain.Product;
import laptopshop.service.ProductService;
import laptopshop.service.UploadService;

@Controller
public class ProductController {

    private final UploadService uploadService;
    private final ProductService productService;

    public ProductController(
            UploadService uploadService,
            ProductService productService) {
        this.uploadService = uploadService;
        this.productService = productService;
    }

    @GetMapping("/admin/product")
    public String getProduct(
            Model model,
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
        Page<Product> prs = this.productService.fetchProducts(pageable);
        List<Product> listProducts = prs.getContent();
        model.addAttribute("products", listProducts);

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", prs.getTotalPages());

        return "admin/product/show";
    }

    @GetMapping("/admin/product/create")
    public String getCreateProductPage(Model model) {
        Product newProduct = new Product();
        newProduct.setSpecification(new laptopshop.domain.ProductSpecification());
        model.addAttribute("newProduct", newProduct);
        return "admin/product/create";
    }

    private void syncProductSpecs(Product pr) {
        if (pr.getSpecification() != null) {
            pr.setCpu(pr.getSpecification().getCpuType());
            pr.setRam(pr.getSpecification().getRamCapacity());
            pr.setScreenSize(pr.getSpecification().getScreenTechnology());
            pr.setStorage(pr.getSpecification().getStorageCapacity());
        }
    }

    @PostMapping("/admin/product/create")
    public String handleCreateProduct(
            @ModelAttribute("newProduct") @Valid Product pr,
            BindingResult newProductBindingResult,
            @RequestParam(value = "imageFiles", required = false) MultipartFile[] files,
            @RequestParam(value = "imageUrl", required = false) String imageUrl) {
        // validate
        if (newProductBindingResult.hasErrors()) {
            return "admin/product/create";
        }

        syncProductSpecs(pr);

        // handle multiple images
        java.util.List<String> savedImages = new java.util.ArrayList<>();
        if (files != null) {
            for (MultipartFile file : files) {
                if (file != null && !file.isEmpty()) {
                    String imgName = this.uploadService.handleSaveUploadFile(file, "product");
                    savedImages.add(imgName);
                }
            }
        }
        if (imageUrl != null && !imageUrl.trim().isEmpty()) {
            String[] urls = imageUrl.split("[,\\n\\r]+");
            for (String url : urls) {
                String trimmedUrl = url.trim();
                if (!trimmedUrl.isEmpty()) {
                    savedImages.add(trimmedUrl);
                }
            }
        }

        if (!savedImages.isEmpty()) {
            pr.setImage(String.join(",", savedImages));
        } else {
            pr.setImage("default.png");
        }

        this.productService.createProduct(pr);

        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/update/{id}")
    public String getUpdateProductPage(Model model, @PathVariable long id) {
        Optional<Product> currentProduct = this.productService.fetchProductById(id);
        Product product = currentProduct.get();
        if (product.getSpecification() == null) {
            product.setSpecification(new laptopshop.domain.ProductSpecification());
        }
        model.addAttribute("newProduct", product);
        return "admin/product/update";
    }

    @PostMapping("/admin/product/update")
    public String handleUpdateProduct(@ModelAttribute("newProduct") @Valid Product pr,
            BindingResult newProductBindingResult,
            @RequestParam(value = "imageFiles", required = false) MultipartFile[] files,
            @RequestParam(value = "imageUrl", required = false) String imageUrl) {

        // validate
        if (newProductBindingResult.hasErrors()) {
            return "admin/product/update";
        }

        Product currentProduct = this.productService.fetchProductById(pr.getId()).get();
        if (currentProduct != null) {
            // handle multiple images
            java.util.List<String> savedImages = new java.util.ArrayList<>();
            if (files != null) {
                for (MultipartFile file : files) {
                    if (file != null && !file.isEmpty()) {
                        String imgName = this.uploadService.handleSaveUploadFile(file, "product");
                        savedImages.add(imgName);
                    }
                }
            }
            if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                String[] urls = imageUrl.split("[,\\n\\r]+");
                for (String url : urls) {
                    String trimmedUrl = url.trim();
                    if (!trimmedUrl.isEmpty()) {
                        savedImages.add(trimmedUrl);
                    }
                }
            }

            if (!savedImages.isEmpty()) {
                currentProduct.setImage(String.join(",", savedImages));
            }

            currentProduct.setName(pr.getName());
            currentProduct.setPrice(pr.getPrice());
            currentProduct.setOriginalPrice(pr.getOriginalPrice());
            currentProduct.setPromoEndDate(pr.getPromoEndDate());
            currentProduct.setQuantity(pr.getQuantity());
            currentProduct.setDetailDesc(pr.getDetailDesc());
            currentProduct.setShortDesc(pr.getShortDesc());
            currentProduct.setFactory(pr.getFactory());
            currentProduct.setTarget(pr.getTarget());
            currentProduct.setColor(pr.getColor());
            
            // Update specification
            if (pr.getSpecification() != null) {
                laptopshop.domain.ProductSpecification newSpec = pr.getSpecification();
                if (currentProduct.getSpecification() == null) {
                    currentProduct.setSpecification(newSpec);
                } else {
                    newSpec.setId(currentProduct.getSpecification().getId());
                    currentProduct.setSpecification(newSpec);
                }
            }

            // Sync base fields from specs
            syncProductSpecs(currentProduct);

            this.productService.createProduct(currentProduct);
        }

        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/delete/{id}")
    public String getDeleteProductPage(Model model, @PathVariable long id) {
        model.addAttribute("id", id);
        model.addAttribute("newProduct", new Product());
        return "admin/product/delete";
    }

    @PostMapping("/admin/product/delete")
    public String postDeleteProduct(Model model, @ModelAttribute("newProduct") Product pr) {
        this.productService.deleteProduct(pr.getId());
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/{id}")
    public String getProductDetailPage(Model model, @PathVariable long id) {
        Product pr = this.productService.fetchProductById(id).get();
        model.addAttribute("product", pr);
        model.addAttribute("id", id);
        return "admin/product/detail";
    }
}
