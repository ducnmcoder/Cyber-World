package laptopshop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.core.io.ClassPathResource;

import jakarta.mail.internet.MimeMessage;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender javaMailSender;

    @org.springframework.beans.factory.annotation.Value("${spring.mail.username}")
    private String senderEmail;

    public void sendFeedbackConfirmationEmail(String toEmail, String subject, String content) {
        try {
            MimeMessage message = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom(senderEmail, "Cyber World");
            helper.setTo(toEmail);
            helper.setSubject("Feedback Received: " + subject);
            
            String htmlContent = "<div style=\"font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; background-color: #f4f7f6; padding: 40px 0; margin: 0;\">" +
                "  <div style=\"max-width: 600px; margin: 0 auto; background-color: #ffffff; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.05);\">" +
                "    <table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"background-color: #cd1818;\">" +
                "      <tr><td align=\"center\" style=\"padding: 25px 30px;\">" +
                "        <table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr>" +
                "          <td valign=\"middle\"><img src=\"cid:logoImage\" alt=\"Cyber World Logo\" style=\"height: 70px; display: block; border: 0;\"></td>" +
                "          <td valign=\"middle\" style=\"padding-left: 0;\"><h1 style=\"margin: 0; margin-left: -35px; position: relative; z-index: 10; color: #ffffff; font-size: 32px; font-weight: 800; letter-spacing: 2px; font-family: 'Arial Black', Impact, sans-serif;\">CYBER WORLD</h1></td>" +
                "        </tr></table>" +
                "      </td></tr>" +
                "    </table>" +
                "    <div style=\"padding: 30px; color: #333333; line-height: 1.6; font-size: 16px;\">" +
                "      <p style=\"margin-top: 0; font-size: 18px; font-weight: 600;\">Hello there,</p>" +
                "      <p>Thank you for getting in touch with us! We have successfully received your feedback and our team is already reviewing it.</p>" +
                "      <p>Here is a copy of what you submitted:</p>" +
                "      <div style=\"background-color: #f9f9f9; border-left: 4px solid #cd1818; padding: 15px 20px; margin: 25px 0; border-radius: 0 8px 8px 0;\">" +
                "        <strong style=\"color: #cd1818; display: block; margin-bottom: 8px; font-size: 15px;\">Subject: " + subject + "</strong>" +
                "        <div style=\"color: #555555; font-size: 14px; line-height: 1.5;\">" + (content != null ? content.replace("\n", "<br>") : "") + "</div>" +
                "      </div>" +
                "      <p>We highly appreciate your input, as it helps us continuously improve our services and product quality. If your feedback requires a response, one of our support agents will get back to you shortly.</p>" +
                "      <p style=\"margin-bottom: 0; margin-top: 30px;\">Best regards,<br><strong style=\"color: #111111;\">The Cyber World Team</strong></p>" +
                "    </div>" +
                "    <div style=\"background-color: #fcfcfc; padding: 20px; text-align: center; border-top: 1px solid #eeeeee; color: #888888; font-size: 13px;\">" +
                "      &copy; 2026 Cyber World. All rights reserved.<br>" +
                "      This is an automated message, please do not reply directly to this email." +
                "    </div>" +
                "  </div>" +
                "</div>";

            helper.setText(htmlContent, true);
            
            // Add inline logo image
            ClassPathResource logo = new ClassPathResource("static/images/logo.png");
            helper.addInline("logoImage", logo);

            javaMailSender.send(message);
        } catch (Exception e) {
            System.err.println("Failed to send email: " + e.getMessage());
        }
    }

    public void sendOrderConfirmationEmail(String toEmail, laptopshop.domain.Order order) {
        try {
            MimeMessage message = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom(senderEmail, "Cyber World");
            helper.setTo(toEmail);
            helper.setSubject("Order Confirmation #" + order.getId() + " - Cyber World");

            String paymentMethodLabel;
            switch (order.getPaymentMethod()) {
                case "VNPAY": paymentMethodLabel = "VNPay"; break;
                case "MOMO": paymentMethodLabel = "MoMo"; break;
                case "ZALOPAY": paymentMethodLabel = "ZaloPay"; break;
                default: paymentMethodLabel = "Cash on Delivery (COD)"; break;
            }

            String paymentStatusLabel;
            switch (order.getPaymentStatus()) {
                case "PAID": paymentStatusLabel = "<span style=\"color: #28a745; font-weight: 700;\">&#10003; Paid</span>"; break;
                case "FAILED": paymentStatusLabel = "<span style=\"color: #dc3545; font-weight: 700;\">&#10007; Failed</span>"; break;
                default: paymentStatusLabel = "<span style=\"color: #ffc107; font-weight: 700;\">&#9679; Pending</span>"; break;
            }

            java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance(new java.util.Locale("vi", "VN"));
            String formattedTotal = nf.format(order.getTotalPrice());

            // Build order items table
            StringBuilder itemsHtml = new StringBuilder();
            StringBuilder productNames = new StringBuilder();
            if (order.getOrderDetails() != null) {
                for (laptopshop.domain.OrderDetail od : order.getOrderDetails()) {
                    String productName = od.getProduct() != null ? od.getProduct().getName() : "Product";
                    
                    if (productNames.length() > 0) {
                        productNames.append(", ");
                    }
                    productNames.append(productName);

                    String formattedPrice = nf.format(od.getPrice());
                    String formattedSubtotal = nf.format(od.getPrice() * od.getQuantity());
                    itemsHtml.append("<tr>")
                        .append("<td style=\"padding: 12px 15px; border-bottom: 1px solid #eee; font-size: 14px;\">").append(productName).append("</td>")
                        .append("<td style=\"padding: 12px 15px; border-bottom: 1px solid #eee; text-align: center; font-size: 14px;\">").append(od.getQuantity()).append("</td>")
                        .append("<td style=\"padding: 12px 15px; border-bottom: 1px solid #eee; text-align: right; font-size: 14px;\">").append(formattedPrice).append(" VND</td>")
                        .append("<td style=\"padding: 12px 15px; border-bottom: 1px solid #eee; text-align: right; font-size: 14px; font-weight: 600;\">").append(formattedSubtotal).append(" VND</td>")
                        .append("</tr>");
                }
            }

            String htmlContent = "<div style=\"font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; background-color: #f4f7f6; padding: 40px 0; margin: 0;\">" +
                "<div style=\"max-width: 600px; margin: 0 auto; background-color: #ffffff; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.05);\">" +
                "<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"background-color: #cd1818;\">" +
                "<tr><td align=\"center\" style=\"padding: 25px 30px;\">" +
                "<table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr>" +
                "<td valign=\"middle\"><img src=\"cid:logoImage\" alt=\"Cyber World Logo\" style=\"height: 70px; display: block; border: 0;\"></td>" +
                "<td valign=\"middle\" style=\"padding-left: 0;\"><h1 style=\"margin: 0; margin-left: -35px; position: relative; z-index: 10; color: #ffffff; font-size: 32px; font-weight: 800; letter-spacing: 2px; font-family: 'Arial Black', Impact, sans-serif;\">CYBER WORLD</h1></td>" +
                "</tr></table>" +
                "</td></tr></table>" +
                "<div style=\"padding: 30px; color: #333333; line-height: 1.6; font-size: 16px;\">" +
                "<p style=\"margin-top: 0; font-size: 18px; font-weight: 600;\">Order Confirmed!</p>" +
                "<p>Thank you for your purchase at <strong>Cyber World</strong>. Your order has been successfully placed.</p>" +
                "<div style=\"background-color: #f9f9f9; border-radius: 8px; padding: 20px; margin: 25px 0;\">" +
                "<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"font-size: 15px;\">" +
                "<tr><td style=\"padding: 8px 0; color: #888;\">Product Name:</td><td style=\"padding: 8px 0; text-align: right; font-weight: 700; color: #cd1818;\">" + productNames.toString() + "</td></tr>" +
                "<tr><td style=\"padding: 8px 0; color: #888;\">Receiver:</td><td style=\"padding: 8px 0; text-align: right; font-weight: 600;\">" + order.getReceiverName() + "</td></tr>" +
                "<tr><td style=\"padding: 8px 0; color: #888;\">Phone:</td><td style=\"padding: 8px 0; text-align: right;\">" + order.getReceiverPhone() + "</td></tr>" +
                "<tr><td style=\"padding: 8px 0; color: #888;\">Address:</td><td style=\"padding: 8px 0; text-align: right;\">" + order.getReceiverAddress() + "</td></tr>" +
                "<tr><td style=\"padding: 8px 0; color: #888;\">Payment:</td><td style=\"padding: 8px 0; text-align: right; font-weight: 600;\">" + paymentMethodLabel + "</td></tr>" +
                "<tr><td style=\"padding: 8px 0; color: #888;\">Status:</td><td style=\"padding: 8px 0; text-align: right;\">" + paymentStatusLabel + "</td></tr>" +
                "</table></div>" +
                "<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"margin: 20px 0;\">" +
                "<thead><tr style=\"background-color: #cd1818; color: white;\">" +
                "<th style=\"padding: 12px 15px; text-align: left; font-size: 13px; text-transform: uppercase;\">Product</th>" +
                "<th style=\"padding: 12px 15px; text-align: center; font-size: 13px; text-transform: uppercase;\">Qty</th>" +
                "<th style=\"padding: 12px 15px; text-align: right; font-size: 13px; text-transform: uppercase;\">Price</th>" +
                "<th style=\"padding: 12px 15px; text-align: right; font-size: 13px; text-transform: uppercase;\">Subtotal</th>" +
                "</tr></thead><tbody>" + itemsHtml.toString() + "</tbody>" +
                "<tfoot><tr><td colspan=\"3\" style=\"padding: 15px; text-align: right; font-size: 16px; font-weight: 700; border-top: 2px solid #cd1818;\">Total:</td>" +
                "<td style=\"padding: 15px; text-align: right; font-size: 18px; font-weight: 800; color: #cd1818; border-top: 2px solid #cd1818;\">" + formattedTotal + " VND</td></tr></tfoot>" +
                "</table>" +
                "<p style=\"margin-bottom: 0; margin-top: 30px;\">Best regards,<br><strong style=\"color: #111111;\">The Cyber World Team</strong></p>" +
                "</div>" +
                "<div style=\"background-color: #fcfcfc; padding: 20px; text-align: center; border-top: 1px solid #eeeeee; color: #888888; font-size: 13px;\">" +
                "&copy; 2026 Cyber World. All rights reserved.<br>" +
                "This is an automated message, please do not reply directly to this email." +
                "</div></div></div>";

            helper.setText(htmlContent, true);

            ClassPathResource logo = new ClassPathResource("static/images/logo.png");
            helper.addInline("logoImage", logo);

            javaMailSender.send(message);
        } catch (Exception e) {
            System.err.println("Failed to send order confirmation email: " + e.getMessage());
        }
    }

    public void sendRefundRejectionEmail(String toEmail, laptopshop.domain.Order order, String rejectReason) {
        try {
            MimeMessage message = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom(senderEmail, "Cyber World");
            helper.setTo(toEmail);
            helper.setSubject("Refund Request Rejected - Order CW-" + order.getId() + " - Cyber World");

            String productName = "Products from Order CW-" + order.getId();
            if (order.getOrderDetails() != null && !order.getOrderDetails().isEmpty()) {
                productName = order.getOrderDetails().get(0).getProduct().getName();
                if (order.getOrderDetails().size() > 1) {
                    productName += " and " + (order.getOrderDetails().size() - 1) + " other item(s)";
                }
            }

            String customerName = order.getRefundName() != null ? order.getRefundName() : order.getReceiverName();

            String htmlContent = "<div style=\"font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; background-color: #f4f7f6; padding: 40px 0; margin: 0;\">" +
                "<div style=\"max-width: 600px; margin: 0 auto; background-color: #ffffff; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.05);\">" +
                "    <table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"background-color: #cd1818;\">" +
                "      <tr><td align=\"center\" style=\"padding: 25px 30px;\">" +
                "        <table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr>" +
                "          <td valign=\"middle\"><img src=\"cid:logoImage\" alt=\"Cyber World Logo\" style=\"height: 70px; display: block; border: 0;\"></td>" +
                "          <td valign=\"middle\" style=\"padding-left: 0;\"><h1 style=\"margin: 0; margin-left: -35px; position: relative; z-index: 10; color: #ffffff; font-size: 32px; font-weight: 800; letter-spacing: 2px; font-family: 'Arial Black', Impact, sans-serif;\">CYBER WORLD</h1></td>" +
                "        </tr></table>" +
                "      </td></tr>" +
                "    </table>" +
                "<div style=\"padding: 30px; color: #333333; line-height: 1.6; font-size: 16px;\">" +
                "<p>Dear <strong>" + customerName + "</strong>,</p>" +
                "<p>Thank you for shopping at <strong>CYBER WORLD</strong> and for submitting your return/refund request.</p>" +
                "<p>After reviewing your request, we would like to inform you of the outcome:</p>" +
                "<h3>Order Information</h3>" +
                "<ul>" +
                "<li><strong>Customer:</strong> " + customerName + "</li>" +
                "<li><strong>Order ID:</strong> CW-" + order.getId() + "</li>" +
                "<li><strong>Product:</strong> " + productName + "</li>" +
                "</ul>" +
                "<p>We regret to inform you that <strong>your return/refund request has not been approved</strong>.</p>" +
                "<h3>Reason for rejection may include one of the following:</h3>" +
                "<ul>" +
                "<li>The product is not in its original condition or shows signs of use.</li>" +
                "<li>The product is missing accessories, gifts, or the original packaging.</li>" +
                "<li>The request was submitted after the permitted return period.</li>" +
                "<li>The product does not qualify for a return/refund under the store's policy.</li>" +
                "</ul>" +
                "<p>If you have additional information, photos, or evidence to support your request, please reply to this email or contact our Customer Care department within <strong>07 days</strong> of receiving this notification so we can re-evaluate your case.</p>" +
                "<p>We sincerely apologize for any inconvenience this may cause and look forward to serving you again in the future.</p>" +
                "<p>Best regards,<br><strong>CYBER WORLD</strong><br>Customer Care Department<br>Email: <a href=\"mailto:support@cyberworld.com\">support@cyberworld.com</a><br>Hotline: 1900-XXXX</p>" +
                "</div>" +
                "</div>" +
                "</div>";

            helper.setText(htmlContent, true);
            
            // Add inline logo image
            ClassPathResource logo = new ClassPathResource("static/images/logo.png");
            helper.addInline("logoImage", logo);

            javaMailSender.send(message);
        } catch (Exception e) {
            System.err.println("Failed to send refund rejection email: " + e.getMessage());
        }
    }

    public void sendRefundApprovalEmail(String toEmail, laptopshop.domain.Order order) {
        try {
            MimeMessage message = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom(senderEmail, "Cyber World");
            helper.setTo(toEmail);
            helper.setSubject("Refund Request Approved - Order CW-" + order.getId() + " - Cyber World");

            String productName = "Products from Order CW-" + order.getId();
            if (order.getOrderDetails() != null && !order.getOrderDetails().isEmpty()) {
                productName = order.getOrderDetails().get(0).getProduct().getName();
                if (order.getOrderDetails().size() > 1) {
                    productName += " and " + (order.getOrderDetails().size() - 1) + " other item(s)";
                }
            }

            String customerName = order.getRefundName() != null ? order.getRefundName() : order.getReceiverName();

            String htmlContent = "<div style=\"font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; background-color: #f4f7f6; padding: 40px 0; margin: 0;\">" +
                "<div style=\"max-width: 600px; margin: 0 auto; background-color: #ffffff; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.05);\">" +
                "    <table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"background-color: #cd1818;\">" +
                "      <tr><td align=\"center\" style=\"padding: 25px 30px;\">" +
                "        <table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr>" +
                "          <td valign=\"middle\"><img src=\"cid:logoImage\" alt=\"Cyber World Logo\" style=\"height: 70px; display: block; border: 0;\"></td>" +
                "          <td valign=\"middle\" style=\"padding-left: 0;\"><h1 style=\"margin: 0; margin-left: -35px; position: relative; z-index: 10; color: #ffffff; font-size: 32px; font-weight: 800; letter-spacing: 2px; font-family: 'Arial Black', Impact, sans-serif;\">CYBER WORLD</h1></td>" +
                "        </tr></table>" +
                "      </td></tr>" +
                "    </table>" +
                "<div style=\"padding: 30px; color: #333333; line-height: 1.6; font-size: 16px;\">" +
                "<p>Dear <strong>" + customerName + "</strong>,</p>" +
                "<p>Thank you for shopping at <strong>CYBER WORLD</strong> and for your patience during the return/refund process.</p>" +
                "<p>We are pleased to inform you that <strong>your return/refund request has been successfully approved</strong>.</p>" +
                "<h3>Order Information</h3>" +
                "<ul>" +
                "<li><strong>Customer:</strong> " + customerName + "</li>" +
                "<li><strong>Order ID:</strong> CW-" + order.getId() + "</li>" +
                "<li><strong>Product:</strong> " + productName + "</li>" +
                "</ul>" +
                "<h3>Refund Details</h3>" +
                "<p>Your refund is currently being processed. The amount will be credited to your provided bank account (<strong>" + (order.getRefundBankName() != null ? order.getRefundBankName() : "N/A") + "</strong>) within <strong>3-7 business days</strong>, depending on your bank's processing time.</p>" +
                "<p>If you do not receive your refund after 7 business days, please reply to this email or contact our Customer Care department for further assistance.</p>" +
                "<p>We appreciate your understanding and look forward to serving you again soon.</p>" +
                "<p>Best regards,<br><strong>CYBER WORLD</strong><br>Customer Care Department<br>Email: <a href=\"mailto:support@cyberworld.com\">support@cyberworld.com</a><br>Hotline: 1900-XXXX</p>" +
                "</div>" +
                "</div>" +
                "</div>";

            helper.setText(htmlContent, true);

            // Add inline logo image
            ClassPathResource logo = new ClassPathResource("static/images/logo.png");
            helper.addInline("logoImage", logo);

            javaMailSender.send(message);
        } catch (Exception e) {
            System.err.println("Failed to send refund approval email: " + e.getMessage());
        }
    }

    public void sendOrderCancellationEmail(String toEmail, laptopshop.domain.Order order, String reason) {
        try {
            MimeMessage message = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom(senderEmail, "Cyber World");
            helper.setTo(toEmail);
            helper.setSubject("Order Cancelled - Order CW-" + order.getId() + " - Cyber World");

            String productName = "Products from Order CW-" + order.getId();
            if (order.getOrderDetails() != null && !order.getOrderDetails().isEmpty()) {
                productName = order.getOrderDetails().get(0).getProduct().getName();
                if (order.getOrderDetails().size() > 1) {
                    productName += " and " + (order.getOrderDetails().size() - 1) + " other item(s)";
                }
            }

            String customerName = order.getReceiverName() != null ? order.getReceiverName() : "Customer";
            String trackingCode = order.getTrackingCode() != null && !order.getTrackingCode().isEmpty() ? order.getTrackingCode() : "N/A";
            
            java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
            String cancelDate = java.time.LocalDateTime.now().format(formatter);

            // Handle guest user reason
            if (order.getUser() == null && (reason == null || reason.isEmpty())) {
                reason = "Refused to receive goods"; // "Từ chối nhận hàng"
            } else if (reason == null || reason.isEmpty()) {
                reason = "Requested by customer";
            }

            String htmlContent = "<div style=\"font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; background-color: #f4f7f6; padding: 40px 0; margin: 0;\">" +
                "<div style=\"max-width: 600px; margin: 0 auto; background-color: #ffffff; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.05);\">" +
                "    <table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"background-color: #cd1818;\">" +
                "      <tr><td align=\"center\" style=\"padding: 25px 30px;\">" +
                "        <table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr>" +
                "          <td valign=\"middle\"><img src=\"cid:logoImage\" alt=\"Cyber World Logo\" style=\"height: 70px; display: block; border: 0;\"></td>" +
                "          <td valign=\"middle\" style=\"padding-left: 0;\"><h1 style=\"margin: 0; margin-left: -35px; position: relative; z-index: 10; color: #ffffff; font-size: 32px; font-weight: 800; letter-spacing: 2px; font-family: 'Arial Black', Impact, sans-serif;\">CYBER WORLD</h1></td>" +
                "        </tr></table>" +
                "      </td></tr>" +
                "    </table>" +
                "<div style=\"padding: 30px; color: #333333; line-height: 1.6; font-size: 16px;\">" +
                "<p><strong>CYBER WORLD</strong> would like to inform you that your order has been <strong>cancelled</strong>.</p>" +
                "<h3>Order Information</h3>" +
                "<ul>" +
                "<li><strong>Customer:</strong> " + customerName + "</li>" +
                "<li><strong>Product:</strong> " + productName + "</li>" +
                "<li><strong>Tracking Code:</strong> " + trackingCode + "</li>" +
                "<li><strong>Order Status:</strong> Cancelled</li>" +
                "<li><strong>Cancellation Time:</strong> " + cancelDate + "</li>" +
                "</ul>" +
                "<h3>Cancellation Reason:</h3>" +
                "<p>" + reason + "</p>" +
                "<p>If the order has been paid in advance, <strong>CYBER WORLD</strong> will process a refund according to the store's refund policy.</p>" +
                "<p>If you need support or have questions regarding the order cancellation, please contact Customer Service.</p>" +
                "<p>We apologize for this inconvenience and look forward to serving you in future purchases.</p>" +
                "<p>Best regards,<br><strong>CYBER WORLD</strong><br>Customer Service Department</p>" +
                "</div>" +
                "</div>" +
                "</div>";

            helper.setText(htmlContent, true);

            // Add inline logo image
            org.springframework.core.io.ClassPathResource logo = new org.springframework.core.io.ClassPathResource("static/images/logo.png");
            helper.addInline("logoImage", logo);

            javaMailSender.send(message);
        } catch (Exception e) {
            System.err.println("Failed to send order cancellation email: " + e.getMessage());
        }
    }

    public void sendShippingEmail(String toEmail, laptopshop.domain.Order order) {
        try {
            MimeMessage message = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom(senderEmail, "Cyber World");
            helper.setTo(toEmail);
            helper.setSubject("Your Order is Shipping - CW-" + order.getId() + " - Cyber World");

            String productName = "Products from Order CW-" + order.getId();
            if (order.getOrderDetails() != null && !order.getOrderDetails().isEmpty()) {
                productName = order.getOrderDetails().get(0).getProduct().getName();
                if (order.getOrderDetails().size() > 1) {
                    productName += " and " + (order.getOrderDetails().size() - 1) + " other item(s)";
                }
            }

            String customerName = order.getReceiverName() != null ? order.getReceiverName() : "Customer";
            String shippingProvider = order.getShippingProvider() != null && !order.getShippingProvider().isEmpty() ? order.getShippingProvider() : "Standard Shipping";
            String trackingCode = order.getTrackingCode() != null && !order.getTrackingCode().isEmpty() ? order.getTrackingCode() : "N/A";
            String orderTrackingUrl = "http://localhost:8080/order-history"; // Default
            
            if (order.getShippingProvider() != null) {
                switch (order.getShippingProvider()) {
                    case "GHN": orderTrackingUrl = "https://ghn.vn/"; break;
                    case "GHTK": orderTrackingUrl = "https://giaohangtietkiem.vn/"; break;
                    case "VIETTEL": orderTrackingUrl = "https://viettelpost.com.vn/"; break;
                    case "VNPOST": orderTrackingUrl = "http://www.vnpost.vn/"; break;
                    case "JNT": orderTrackingUrl = "https://jtexpress.vn/"; break;
                    case "NINJAVAN": orderTrackingUrl = "https://www.ninjavan.co/"; break;
                    case "SHOPEXPRESS": orderTrackingUrl = "https://spx.vn/"; break;
                }
            }

            String htmlContent = "<div style=\"font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; background-color: #f4f7f6; padding: 40px 0; margin: 0;\">" +
                "<div style=\"max-width: 600px; margin: 0 auto; background-color: #ffffff; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.05);\">" +
                "    <table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"background-color: #cd1818;\">" +
                "      <tr><td align=\"center\" style=\"padding: 25px 30px;\">" +
                "        <table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr>" +
                "          <td valign=\"middle\"><img src=\"cid:logoImage\" alt=\"Cyber World Logo\" style=\"height: 70px; display: block; border: 0;\"></td>" +
                "          <td valign=\"middle\" style=\"padding-left: 0;\"><h1 style=\"margin: 0; margin-left: -35px; position: relative; z-index: 10; color: #ffffff; font-size: 32px; font-weight: 800; letter-spacing: 2px; font-family: 'Arial Black', Impact, sans-serif;\">CYBER WORLD</h1></td>" +
                "        </tr></table>" +
                "      </td></tr>" +
                "    </table>" +
                "<div style=\"padding: 30px; color: #333333; line-height: 1.6; font-size: 16px;\">" +
                "<p>Dear <strong>" + customerName + "</strong>,</p>" +
                "<p>Thank you for shopping at <strong>CYBER WORLD</strong>.</p>" +
                "<p>We would like to inform you that your order has been changed to <strong>Shipping</strong> status.</p>" +
                "<h3>Order Information</h3>" +
                "<ul>" +
                "<li><strong>Customer:</strong> " + customerName + "</li>" +
                "<li><strong>Product:</strong> " + productName + "</li>" +
                "<li><strong>Order Status:</strong> Shipping</li>" +
                "<li><strong>Shipping Provider:</strong> " + shippingProvider + "</li>" +
                "<li><strong>Tracking Code:</strong> " + trackingCode + "</li>" +
                "</ul>" +
                "<p>Your order is currently being shipped to your registered address. Please keep your phone available so the delivery staff can contact you upon delivery.</p>" +
                "<p>You can track your order status at:<br><a href=\"" + orderTrackingUrl + "\" style=\"color: #cd1818; text-decoration: none; font-weight: bold;\">Track Order Here</a></p>" +
                "<p>Thank you for trusting and choosing <strong>CYBER WORLD</strong>.</p>" +
                "<p>Best regards,<br><strong>CYBER WORLD</strong><br>Customer Service Department</p>" +
                "</div>" +
                "</div>" +
                "</div>";

            helper.setText(htmlContent, true);
            
            // Add inline logo image
            ClassPathResource logo = new ClassPathResource("static/images/logo.png");
            helper.addInline("logoImage", logo);

            javaMailSender.send(message);
        } catch (Exception e) {
            System.err.println("Failed to send shipping email: " + e.getMessage());
        }
    }

    public void sendCompleteEmail(String toEmail, laptopshop.domain.Order order) {
        try {
            MimeMessage message = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom(senderEmail, "Cyber World");
            helper.setTo(toEmail);
            helper.setSubject("Your Order is Complete - CW-" + order.getId() + " - Cyber World");

            String productName = "Products from Order CW-" + order.getId();
            if (order.getOrderDetails() != null && !order.getOrderDetails().isEmpty()) {
                productName = order.getOrderDetails().get(0).getProduct().getName();
                if (order.getOrderDetails().size() > 1) {
                    productName += " and " + (order.getOrderDetails().size() - 1) + " other item(s)";
                }
            }

            String customerName = order.getReceiverName() != null ? order.getReceiverName() : "Customer";
            String trackingCode = order.getTrackingCode() != null && !order.getTrackingCode().isEmpty() ? order.getTrackingCode() : "N/A";
            
            java.time.format.DateTimeFormatter formatter = java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy");
            String completedDate = java.time.LocalDate.now().format(formatter);

            String htmlContent = "<div style=\"font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; background-color: #f4f7f6; padding: 40px 0; margin: 0;\">" +
                "<div style=\"max-width: 600px; margin: 0 auto; background-color: #ffffff; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.05);\">" +
                "    <table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"background-color: #cd1818;\">" +
                "      <tr><td align=\"center\" style=\"padding: 25px 30px;\">" +
                "        <table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr>" +
                "          <td valign=\"middle\"><img src=\"cid:logoImage\" alt=\"Cyber World Logo\" style=\"height: 70px; display: block; border: 0;\"></td>" +
                "          <td valign=\"middle\" style=\"padding-left: 0;\"><h1 style=\"margin: 0; margin-left: -35px; position: relative; z-index: 10; color: #ffffff; font-size: 32px; font-weight: 800; letter-spacing: 2px; font-family: 'Arial Black', Impact, sans-serif;\">CYBER WORLD</h1></td>" +
                "        </tr></table>" +
                "      </td></tr>" +
                "    </table>" +
                "<div style=\"padding: 30px; color: #333333; line-height: 1.6; font-size: 16px;\">" +
                "<p>Dear <strong>" + customerName + "</strong>,</p>" +
                "<p><strong>CYBER WORLD</strong> would like to inform you that your order has been successfully delivered.</p>" +
                "<h3>Order Information</h3>" +
                "<ul>" +
                "<li><strong>Customer:</strong> " + customerName + "</li>" +
                "<li><strong>Product:</strong> " + productName + "</li>" +
                "<li><strong>Tracking Code:</strong> " + trackingCode + "</li>" +
                "<li><strong>Order Status:</strong> Complete</li>" +
                "<li><strong>Completed Date:</strong> " + completedDate + "</li>" +
                "</ul>" +
                "<p>Thank you for choosing <strong>CYBER WORLD</strong>.</p>" +
                "<p>If the product meets your needs, you can leave a review to help other customers with their reference.</p>" +
                "<p>In case the product encounters issues during the warranty period or you need technical support, please contact our customer care department.</p>" +
                "<p>Best regards,<br><strong>CYBER WORLD</strong><br>Customer Care Department</p>" +
                "</div>" +
                "</div>" +
                "</div>";

            helper.setText(htmlContent, true);
            
            // Add inline logo image
            org.springframework.core.io.ClassPathResource logo = new org.springframework.core.io.ClassPathResource("static/images/logo.png");
            helper.addInline("logoImage", logo);

            javaMailSender.send(message);
        } catch (Exception e) {
            System.err.println("Failed to send complete email: " + e.getMessage());
        }
    }

    public void sendPasswordResetEmail(String toEmail, String code) {
        try {
            MimeMessage message = javaMailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom(senderEmail, "Cyber World");
            helper.setTo(toEmail);
            helper.setSubject("Password Reset Verification Code - Cyber World");

            String htmlContent = "<div style=\"font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif; background-color: #f4f7f6; padding: 40px 0; margin: 0;\">" +
                "<div style=\"max-width: 600px; margin: 0 auto; background-color: #ffffff; border-radius: 8px; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.05);\">" +
                "    <table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"background-color: #cd1818;\">" +
                "      <tr><td align=\"center\" style=\"padding: 25px 30px;\">" +
                "        <table cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr>" +
                "          <td valign=\"middle\"><img src=\"cid:logoImage\" alt=\"Cyber World Logo\" style=\"height: 70px; display: block; border: 0;\"></td>" +
                "          <td valign=\"middle\" style=\"padding-left: 0;\"><h1 style=\"margin: 0; margin-left: -35px; position: relative; z-index: 10; color: #ffffff; font-size: 32px; font-weight: 800; letter-spacing: 2px; font-family: 'Arial Black', Impact, sans-serif;\">CYBER WORLD</h1></td>" +
                "        </tr></table>" +
                "      </td></tr>" +
                "    </table>" +
                "<div style=\"padding: 30px; color: #333333; line-height: 1.6; font-size: 16px;\">" +
                "<p>Hello,</p>" +
                "<p>We received a request to reset the password for your Cyber World account associated with this email address.</p>" +
                "<p>Your password reset verification code is:</p>" +
                "<div style=\"text-align: center; margin: 30px 0;\">" +
                "<span style=\"font-size: 32px; font-weight: bold; letter-spacing: 5px; color: #cd1818; padding: 10px 20px; border: 2px dashed #cd1818; border-radius: 8px;\">" + code + "</span>" +
                "</div>" +
                "<p>This code will expire in 5 minutes.</p>" +
                "<p>If you did not request a password reset, you can safely ignore this email.</p>" +
                "<p>Best regards,<br><strong>CYBER WORLD</strong><br>Customer Care Department</p>" +
                "</div>" +
                "</div>" +
                "</div>";

            helper.setText(htmlContent, true);

            // Add inline logo image
            org.springframework.core.io.ClassPathResource logo = new org.springframework.core.io.ClassPathResource("static/images/logo.png");
            helper.addInline("logoImage", logo);

            javaMailSender.send(message);
        } catch (Exception e) {
            System.err.println("Failed to send password reset email: " + e.getMessage());
        }
    }
}
