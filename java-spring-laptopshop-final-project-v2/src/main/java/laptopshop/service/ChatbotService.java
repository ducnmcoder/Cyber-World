package laptopshop.service;

import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import laptopshop.domain.Product;
import laptopshop.repository.ProductRepository;

@Service
public class ChatbotService {

    private final ProductRepository productRepository;
    private final RestTemplate restTemplate;

    @Value("${gemini.api.key}")
    private String apiKey;

    @Value("${gemini.api.url}")
    private String apiUrl;

    public ChatbotService(ProductRepository productRepository) {
        this.productRepository = productRepository;
        this.restTemplate = new RestTemplate();
    }

    public String chat(String userMessage) {
        String productData = "";
        
        // --- BƯỚC 1: Lấy dữ liệu từ Database ---
        try {
            productData = buildProductData();
        } catch (org.springframework.dao.DataAccessException e) {
            System.err.println("[LỖI DATABASE] Không thể lấy dữ liệu sản phẩm: " + e.getMessage());
            return "Sorry, database connection issue. Please try again later.";
        } catch (Exception e) {
            System.err.println("[LỖI HỆ THỐNG] Lỗi không xác định khi truy vấn DB: " + e.getMessage());
            return "Sorry, unable to load product data.";
        }

        // --- BƯỚC 2 & 3: Tạo System Prompt và Gọi Gemini API ---
        try {
            String systemPrompt = buildSystemPrompt(productData);
            return callGeminiAPI(systemPrompt, userMessage);
            
        } catch (org.springframework.web.client.HttpStatusCodeException e) {
            System.err.println("[LỖI GEMINI API] Mã lỗi " + e.getStatusCode() + ": " + e.getResponseBodyAsString());
            return "Sorry, Gemini API error. Please check your API key or quota.";
            
        } catch (org.springframework.web.client.ResourceAccessException e) {
            System.err.println("[LỖI MẠNG] Không thể kết nối tới Gemini: " + e.getMessage());
            return "Sorry, unable to connect to Gemini AI service. Check internet connection.";
            
        } catch (Exception e) {
            System.err.println("[LỖI KHÔNG XÁC ĐỊNH] Lỗi khi gọi API: " + e.getMessage());
            e.printStackTrace();
            return "Sorry, the system is currently experiencing issues. Please try again later.";
        }
    }

    private String buildProductData() {
        List<Product> products = productRepository.findAll();
        StringBuilder sb = new StringBuilder();
        sb.append("DANH SÁCH SẢN PHẨM CỦA CỬA HÀNG CYBER WORLD:\n\n");

        for (Product p : products) {
            sb.append("- Tên: ").append(p.getName());
            sb.append(" | Giá: ").append(formatPrice(p.getPrice()));
            if (p.getOriginalPrice() > 0 && p.getOriginalPrice() > p.getPrice()) {
                sb.append(" (Giá gốc: ").append(formatPrice(p.getOriginalPrice())).append(")");
            }
            sb.append(" | Hãng: ").append(p.getFactory() != null ? p.getFactory() : "N/A");
            sb.append(" | CPU: ").append(p.getCpu() != null ? p.getCpu() : "N/A");
            sb.append(" | RAM: ").append(p.getRam() != null ? p.getRam() : "N/A");
            sb.append(" | Ổ cứng: ").append(p.getStorage() != null ? p.getStorage() : "N/A");
            sb.append(" | Màn hình: ").append(p.getScreenSize() != null ? p.getScreenSize() : "N/A");
            sb.append(" | Màu: ").append(p.getColor() != null ? p.getColor() : "N/A");
            sb.append(" | Mục đích: ").append(p.getTarget() != null ? p.getTarget() : "N/A");
            sb.append(" | Mô tả: ").append(p.getShortDesc() != null ? p.getShortDesc() : "N/A");
            sb.append(" | Còn hàng: ").append(p.getQuantity()).append(" | Đã bán: ").append(p.getSold());
            sb.append(" | Link: /product/").append(p.getId());
            sb.append("\n");
        }

        return sb.toString();
    }

    private String formatPrice(double price) {
        if (price >= 1000000) {
            double million = price / 1000000.0;
            if (million == (long) million) {
                return String.format("%d triệu VNĐ", (long) million);
            }
            return String.format("%.1f triệu VNĐ", million);
        }
        return String.format("%,.0f VNĐ", price);
    }

    private String buildSystemPrompt(String productData) {
        return """
                You are the AI assistant of the Cyber World laptop store. Your responsibilities:

                1. ONLY answer questions related to Cyber World's laptop products.
                2. You can help customers:
                   - Search for laptops by price (e.g., "laptops from 15 to 20 million VND")
                   - Search by brand (e.g., "Dell laptops", "Asus laptops")
                   - Search by specs (CPU, RAM, storage, screen size)
                   - Search by purpose (gaming, office work, graphic design...)
                   - Compare products
                   - Recommend products that match their needs
                   - Provide detailed product information
                3. For questions NOT related to the store's laptop products, respond with:
                   "I'm sorry, I can only assist with questions about Cyber World's laptop products. Would you like to learn about any of our laptops?"
                4. Respond in English, be concise, friendly, and professional.
                5. When presenting products, use this EXACT format:
                   - [Product Name](/product/ID) - Price
                6. ALWAYS suggest exactly 3 products (unless fewer match).
                7. Order products by price from lowest to highest.
                8. DO NOT print the raw URL. ONLY use the markdown format [Name](URL).
                9. Use appropriate emojis.

                """
                + productData;
    }

    @SuppressWarnings("unchecked")
    private String callGeminiAPI(String systemPrompt, String userMessage) {
        String url = apiUrl + "?key=" + apiKey;

        // Build request body
        Map<String, Object> requestBody = new HashMap<>();

        // System instruction
        Map<String, Object> systemInstruction = new HashMap<>();
        Map<String, String> systemPart = new HashMap<>();
        systemPart.put("text", systemPrompt);
        systemInstruction.put("parts", List.of(systemPart));
        requestBody.put("system_instruction", systemInstruction);

        // User message content
        Map<String, Object> content = new HashMap<>();
        content.put("role", "user");
        Map<String, String> part = new HashMap<>();
        part.put("text", userMessage);
        content.put("parts", List.of(part));
        requestBody.put("contents", List.of(content));

        // Generation config
        Map<String, Object> generationConfig = new HashMap<>();
        generationConfig.put("temperature", 0.3);
        // maxOutputTokens is removed so the model can use its maximum capacity
        requestBody.put("generationConfig", generationConfig);

        // Send request
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);
        ResponseEntity<Map> response = restTemplate.postForEntity(url, entity, Map.class);

        // Parse response
        Map<String, Object> body = response.getBody();
        if (body != null && body.containsKey("candidates")) {
            List<Map<String, Object>> candidates = (List<Map<String, Object>>) body.get("candidates");
            if (!candidates.isEmpty()) {
                Map<String, Object> candidate = candidates.get(0);
                Map<String, Object> contentResp = (Map<String, Object>) candidate.get("content");
                if (contentResp != null) {
                    List<Map<String, Object>> parts = (List<Map<String, Object>>) contentResp.get("parts");
                    if (parts != null && !parts.isEmpty()) {
                        return (String) parts.get(0).get("text");
                    }
                }
            }
        }

        return "Sorry, I can't process your request right now. Please try again.";
    }
}
