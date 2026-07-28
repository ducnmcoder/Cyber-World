package laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import laptopshop.domain.Order;
import laptopshop.domain.User;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByUser(User user);

    @Query(value = "SELECT MONTH(created_at) AS period, SUM(total_price) AS total FROM orders WHERE created_at IS NOT NULL AND YEAR(created_at) = :year GROUP BY MONTH(created_at) ORDER BY MONTH(created_at)", nativeQuery = true)
    List<Object[]> findMonthlyRevenueByYear(@Param("year") int year);

    @Query(value = "SELECT DAY(created_at) AS period, SUM(total_price) AS total FROM orders WHERE created_at IS NOT NULL AND YEAR(created_at) = :year AND MONTH(created_at) = :month GROUP BY DAY(created_at) ORDER BY DAY(created_at)", nativeQuery = true)
    List<Object[]> findDailyRevenueByYearAndMonth(@Param("year") int year, @Param("month") int month);

    @Query(value = "SELECT HOUR(created_at) AS period, SUM(total_price) AS total FROM orders WHERE created_at IS NOT NULL AND YEAR(created_at) = :year AND MONTH(created_at) = :month AND DAY(created_at) = :day GROUP BY HOUR(created_at) ORDER BY HOUR(created_at)", nativeQuery = true)
    List<Object[]> findHourlyRevenueByYearMonthAndDay(@Param("year") int year, @Param("month") int month, @Param("day") int day);

    @Query(value = "SELECT DATE_FORMAT(created_at, '%Y-%m') AS period, SUM(total_price) AS total FROM orders WHERE created_at IS NOT NULL GROUP BY DATE_FORMAT(created_at, '%Y-%m') ORDER BY DATE_FORMAT(created_at, '%Y-%m')", nativeQuery = true)
    List<Object[]> findMonthlyRevenue();

    @Query(value = "SELECT DATE_FORMAT(created_at, '%Y-%m-%d') AS period, SUM(total_price) AS total FROM orders WHERE created_at IS NOT NULL GROUP BY DATE_FORMAT(created_at, '%Y-%m-%d') ORDER BY DATE_FORMAT(created_at, '%Y-%m-%d')", nativeQuery = true)
    List<Object[]> findDailyRevenue();

    @Query(value = "SELECT HOUR(created_at) AS period, SUM(total_price) AS total FROM orders WHERE created_at IS NOT NULL GROUP BY HOUR(created_at) ORDER BY HOUR(created_at)", nativeQuery = true)
    List<Object[]> findHourlyRevenue();
}
