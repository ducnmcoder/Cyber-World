package laptopshop.config;

import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

@Component
public class SessionClearConfig {

    private final JdbcTemplate jdbcTemplate;

    SessionClearConfig(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @EventListener(ApplicationReadyEvent.class)
    public void clearSessionsOnStartup() {
        try {
            // Xóa toàn bộ session cũ trong database mỗi khi restart lại server
            jdbcTemplate.execute("DELETE FROM SPRING_SESSION_ATTRIBUTES");
            jdbcTemplate.execute("DELETE FROM SPRING_SESSION");
            System.out.println("====== Đã xóa các session cũ từ database để tránh lỗi lưu phiên đăng nhập cũ ======");
        } catch (Exception e) {
            System.out.println("Không thể xóa session cũ: " + e.getMessage());
        }
    }
}
