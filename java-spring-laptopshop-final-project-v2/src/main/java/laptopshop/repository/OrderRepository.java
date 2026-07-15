package laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import laptopshop.domain.Order;
import laptopshop.domain.User;

import java.util.List;

import org.springframework.data.jpa.repository.Query;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByUser(User user);

    @Query(value = "SELECT DATE_FORMAT(created_at, '%Y-%m') AS period, SUM(total_price) AS total FROM orders WHERE created_at IS NOT NULL GROUP BY DATE_FORMAT(created_at, '%Y-%m') ORDER BY DATE_FORMAT(created_at, '%Y-%m')", nativeQuery = true)
    List<Object[]> findMonthlyRevenue();

    @Query(value = "SELECT DATE_FORMAT(created_at, '%Y-%m-%d') AS period, SUM(total_price) AS total FROM orders WHERE created_at IS NOT NULL GROUP BY DATE_FORMAT(created_at, '%Y-%m-%d') ORDER BY DATE_FORMAT(created_at, '%Y-%m-%d')", nativeQuery = true)
    List<Object[]> findDailyRevenue();

    @Query(value = "SELECT HOUR(created_at) AS period, SUM(total_price) AS total FROM orders WHERE created_at IS NOT NULL GROUP BY HOUR(created_at) ORDER BY HOUR(created_at)", nativeQuery = true)
    List<Object[]> findHourlyRevenue();
}
