package laptopshop.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

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
                "    <div style=\"background-color: #cd1818; padding: 25px 30px; text-align: center;\">" +
                "      <h1 style=\"margin: 0; color: #ffffff; font-size: 26px; font-weight: 700; letter-spacing: 2px;\">CYBER WORLD</h1>" +
                "    </div>" +
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
            
            javaMailSender.send(message);
        } catch (Exception e) {
            System.err.println("Failed to send email: " + e.getMessage());
        }
    }
}
