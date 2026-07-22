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
        try {
            // Build product data from DB
            String productData = buildProductData();

            // Build system prompt
            String systemPrompt = buildSystemPrompt(productData);

            // Call Gemini API
            return callGeminiAPI(systemPrompt, userMessage);
        } catch (Exception e) {
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
                5. When presenting products, clearly show the name, price, and key specs.
                6. If multiple products match, list up to 5 of the best matches.
                7. Use appropriate emojis to keep the conversation friendly.

                """ + productData;
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
        generationConfig.put("maxOutputTokens", 500);
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
