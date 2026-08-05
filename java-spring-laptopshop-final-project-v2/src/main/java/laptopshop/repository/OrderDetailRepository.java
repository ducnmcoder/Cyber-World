package laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import laptopshop.domain.OrderDetail;
import laptopshop.domain.Product;

import java.util.List;

public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {
        List<OrderDetail> findByProduct(Product product);

        @Query(value = "SELECT p.id AS product_id, p.name AS product_name, p.factory AS brand, SUM(od.quantity) AS total_quantity, SUM(od.quantity * od.price) AS revenue "
                        + "FROM order_detail od "
                        + "JOIN products p ON od.product_id = p.id "
                        + "GROUP BY p.id, p.name, p.factory "
                        + "ORDER BY revenue DESC "
                        + "LIMIT ?1", nativeQuery = true)
        List<Object[]> findTopProductsByRevenue(int limit);

        @Query(value = "SELECT p.id AS product_id, p.name AS product_name, p.factory AS brand, SUM(od.quantity) AS total_quantity, SUM(od.quantity * od.price) AS revenue "
                        + "FROM order_detail od "
                        + "JOIN products p ON od.product_id = p.id "
                        + "JOIN orders o ON od.order_id = o.id "
                        + "WHERE YEAR(o.created_at) = ?1 "
                        + "GROUP BY p.id, p.name, p.factory "
                        + "ORDER BY revenue DESC "
                        + "LIMIT ?2", nativeQuery = true)
        List<Object[]> findTopProductsByYear(int year, int limit);

        @Query(value = "SELECT p.id AS product_id, p.name AS product_name, p.factory AS brand, SUM(od.quantity) AS total_quantity, SUM(od.quantity * od.price) AS revenue "
                        + "FROM order_detail od "
                        + "JOIN products p ON od.product_id = p.id "
                        + "JOIN orders o ON od.order_id = o.id "
                        + "WHERE YEAR(o.created_at) = ?1 AND MONTH(o.created_at) = ?2 "
                        + "GROUP BY p.id, p.name, p.factory "
                        + "ORDER BY revenue DESC "
                        + "LIMIT ?3", nativeQuery = true)
        List<Object[]> findTopProductsByYearAndMonth(int year, int month, int limit);

        @Query(value = "SELECT p.id AS product_id, p.name AS product_name, p.factory AS brand, SUM(od.quantity) AS total_quantity, SUM(od.quantity * od.price) AS revenue "
                        + "FROM order_detail od "
                        + "JOIN products p ON od.product_id = p.id "
                        + "JOIN orders o ON od.order_id = o.id "
                        + "WHERE YEAR(o.created_at) = ?1 AND MONTH(o.created_at) = ?2 AND DAY(o.created_at) = ?3 "
                        + "GROUP BY p.id, p.name, p.factory "
                        + "ORDER BY revenue DESC "
                        + "LIMIT ?4", nativeQuery = true)
        List<Object[]> findTopProductsByYearMonthAndDay(int year, int month, int day, int limit);

        @Query(value = "SELECT p.id AS product_id, p.name AS product_name, p.factory AS brand, SUM(od.quantity) AS total_quantity, SUM(od.quantity * od.price) AS revenue "
                        + "FROM order_detail od "
                        + "JOIN products p ON od.product_id = p.id "
                        + "JOIN orders o ON od.order_id = o.id "
                        + "WHERE YEAR(o.created_at) = ?1 AND MONTH(o.created_at) = ?2 AND DAY(o.created_at) = ?3 AND HOUR(o.created_at) = ?4 "
                        + "GROUP BY p.id, p.name, p.factory "
                        + "ORDER BY revenue DESC "
                        + "LIMIT ?5", nativeQuery = true)
        List<Object[]> findTopProductsByYearMonthDayAndHour(int year, int month, int day, int hour, int limit);

        @Query(value = "SELECT COALESCE(LOWER(p.factory), 'other') AS brand, SUM(od.quantity * od.price) AS revenue "
                        + "FROM order_detail od "
                        + "JOIN products p ON od.product_id = p.id "
                        + "JOIN orders o ON od.order_id = o.id "
                        + "WHERE YEAR(o.created_at) = ?1 "
                        + "GROUP BY COALESCE(LOWER(p.factory), 'other') "
                        + "ORDER BY revenue DESC", nativeQuery = true)
        List<Object[]> findRevenueByBrandByYear(int year);

}
