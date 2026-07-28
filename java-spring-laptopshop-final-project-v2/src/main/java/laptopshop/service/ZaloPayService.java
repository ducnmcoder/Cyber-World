package laptopshop.service;

import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;

import laptopshop.domain.Order;

@Service
public class ZaloPayService {

    @Value("${zalopay.app-id}")
    private String appId;

    @Value("${zalopay.key1}")
    private String key1;

    @Value("${zalopay.key2}")
    private String key2;

    @Value("${zalopay.endpoint}")
    private String endpoint;

    @Value("${zalopay.return-url}")
    private String returnUrl;

    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();

    public String createPaymentUrl(Order order, String transactionRef) {
        try {
            String appTransId = getCurrentDateString("yyMMdd") + "_" + transactionRef;
            long appTime = System.currentTimeMillis();
            long amount = (long) order.getTotalPrice();
            String appUser = "CyberWorld";
            String description = "Thanh toan don hang Cyber World #" + order.getId();

            // Items (empty array for simplicity)
            String item = "[]";
            String embedData = "{\"redirecturl\":\"" + returnUrl + "\"}";

            // Build HMAC input: appid|apptransid|appuser|amount|apptime|embeddata|item
            String hmacInput = appId + "|" + appTransId + "|" + appUser + "|" + amount
                    + "|" + appTime + "|" + embedData + "|" + item;

            String mac = hmacSHA256(key1, hmacInput);

            // Build request body
            Map<String, Object> requestBody = new LinkedHashMap<>();
            requestBody.put("app_id", Integer.parseInt(appId));
            requestBody.put("app_trans_id", appTransId);
            requestBody.put("app_user", appUser);
            requestBody.put("app_time", appTime);
            requestBody.put("amount", amount);
            requestBody.put("description", description);
            requestBody.put("item", item);
            requestBody.put("embed_data", embedData);

            requestBody.put("callback_url", returnUrl);
            requestBody.put("mac", mac);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);

            // Build form data
            StringBuilder formData = new StringBuilder();
            for (Map.Entry<String, Object> entry : requestBody.entrySet()) {
                if (formData.length() > 0) formData.append("&");
                formData.append(entry.getKey()).append("=");
                try {
                    formData.append(java.net.URLEncoder.encode(String.valueOf(entry.getValue()), StandardCharsets.UTF_8.toString()));
                } catch (Exception e) {
                    formData.append(entry.getValue());
                }
            }

            HttpEntity<String> entity = new HttpEntity<>(formData.toString(), headers);

            ResponseEntity<String> response = restTemplate.exchange(endpoint, HttpMethod.POST, entity, String.class);

            if (response.getStatusCode() == HttpStatus.OK) {
                @SuppressWarnings("unchecked")
                Map<String, Object> responseBody = objectMapper.readValue(response.getBody(), Map.class);
                int returnCode = (int) responseBody.get("return_code");
                if (returnCode == 1) {
                    return (String) responseBody.get("order_url");
                } else {
                    System.err.println("ZaloPay error: " + responseBody.get("return_message")
                            + " | sub_return_message: " + responseBody.get("sub_return_message"));
                }
            }
        } catch (Exception e) {
            System.err.println("ZaloPay payment creation failed: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    public boolean validateCallback(String data, String reqMac) {
        try {
            String checkMac = hmacSHA256(key2, data);
            return checkMac.equals(reqMac);
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * Validate the return URL parameters from ZaloPay redirect.
     * ZaloPay appends status=1 for success or status=-49 for cancel to the redirecturl.
     */
    public boolean isPaymentSuccess(Map<String, String> params) {
        String status = params.get("status");
        return "1".equals(status);
    }

    /**
     * Extract the app_trans_id from ZaloPay return parameters.
     * The app_trans_id format is: yyMMdd_transactionRef
     */
    public String extractTransactionRef(String appTransId) {
        if (appTransId != null && appTransId.contains("_")) {
            return appTransId.substring(appTransId.indexOf("_") + 1);
        }
        return appTransId;
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

    private String getCurrentDateString(String format) {
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        return sdf.format(new Date());
    }
}
