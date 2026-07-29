package laptopshop.service;

import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;

import laptopshop.domain.Order;

@Service
public class MoMoService {

    @Value("${momo.partner-code}")
    private String partnerCode;

    @Value("${momo.access-key}")
    private String accessKey;

    @Value("${momo.secret-key}")
    private String secretKey;

    @Value("${momo.endpoint}")
    private String endpoint;

    @Value("${momo.return-url}")
    private String returnUrl;

    @Value("${momo.notify-url}")
    private String notifyUrl;

    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();

    public String createPaymentUrl(Order order, String transactionRef) {
        try {
            String requestId = UUID.randomUUID().toString();
            String orderId = transactionRef;
            long amount = (long) order.getTotalPrice();
            String orderInfo = "Thanh toan don hang Cyber World #" + order.getId();
            String requestType = "payWithMethod";
            String extraData = "";

            // Build raw signature
            String rawSignature = "accessKey=" + accessKey
                    + "&amount=" + amount
                    + "&extraData=" + extraData
                    + "&ipnUrl=" + notifyUrl
                    + "&orderId=" + orderId
                    + "&orderInfo=" + orderInfo
                    + "&partnerCode=" + partnerCode
                    + "&redirectUrl=" + returnUrl
                    + "&requestId=" + requestId
                    + "&requestType=" + requestType;

            String signature = hmacSHA256(secretKey, rawSignature);

            // Build request body
            Map<String, Object> requestBody = new HashMap<>();
            requestBody.put("partnerCode", partnerCode);
            requestBody.put("partnerName", "Cyber World");
            requestBody.put("storeId", "CyberWorldStore");
            requestBody.put("requestId", requestId);
            requestBody.put("amount", amount);
            requestBody.put("orderId", orderId);
            requestBody.put("orderInfo", orderInfo);
            requestBody.put("redirectUrl", returnUrl);
            requestBody.put("ipnUrl", notifyUrl);
            requestBody.put("lang", "vi");
            requestBody.put("requestType", requestType);
            requestBody.put("autoCapture", true);
            requestBody.put("extraData", extraData);
            requestBody.put("signature", signature);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);

            String jsonBody = objectMapper.writeValueAsString(requestBody);
            HttpEntity<String> entity = new HttpEntity<>(jsonBody, headers);

            ResponseEntity<String> response = restTemplate.exchange(endpoint, HttpMethod.POST, entity, String.class);

            if (response.getStatusCode() == HttpStatus.OK) {
                @SuppressWarnings("unchecked")
                Map<String, Object> responseBody = objectMapper.readValue(response.getBody(), Map.class);
                int resultCode = (int) responseBody.get("resultCode");
                if (resultCode == 0) {
                    return (String) responseBody.get("payUrl");
                }
            }
        } catch (Exception e) {
            System.err.println("MoMo payment creation failed: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public boolean validateCallback(Map<String, String> params) {
        try {
            String receivedSignature = params.get("signature");
            if (receivedSignature == null) return false;

            String rawSignature = "accessKey=" + accessKey
                    + "&amount=" + params.get("amount")
                    + "&extraData=" + params.getOrDefault("extraData", "")
                    + "&message=" + params.get("message")
                    + "&orderId=" + params.get("orderId")
                    + "&orderInfo=" + params.get("orderInfo")
                    + "&orderType=" + params.get("orderType")
                    + "&partnerCode=" + params.get("partnerCode")
                    + "&payType=" + params.get("payType")
                    + "&requestId=" + params.get("requestId")
                    + "&responseTime=" + params.get("responseTime")
                    + "&resultCode=" + params.get("resultCode")
                    + "&transId=" + params.get("transId");

            String checkSignature = hmacSHA256(secretKey, rawSignature);
            return checkSignature.equals(receivedSignature);
        } catch (Exception e) {
            return false;
        }
    }

    public boolean isPaymentSuccess(Map<String, String> params) {
        String resultCode = params.get("resultCode");
        return "0".equals(resultCode);
    }

    private String hmacSHA256(String key, String data) {
        try {
            Mac hmac256 = Mac.getInstance("HmacSHA256");
            SecretKeySpec secretKeySpec = new SecretKeySpec(key.getBytes(StandardCharsets.UTF_8), "HmacSHA256");
            hmac256.init(secretKeySpec);
            byte[] bytes = hmac256.doFinal(data.getBytes(StandardCharsets.UTF_8));
            StringBuilder hash = new StringBuilder();
            for (byte b : bytes) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hash.append('0');
                hash.append(hex);
            }
            return hash.toString();
        } catch (Exception e) {
            throw new RuntimeException("Failed to generate HMAC SHA256", e);
        }
    }
}
