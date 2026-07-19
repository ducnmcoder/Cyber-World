package laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import laptopshop.domain.OrderDetail;

import java.util.List;

@Repository
public interface OrderDetailRepository extends JpaRepository<OrderDetail, Long> {

    @Query(value = "SELECT p.id AS product_id, p.name AS product_name, SUM(od.quantity) AS total_quantity, SUM(od.quantity * od.price) AS revenue "
            + "FROM order_detail od "
            + "JOIN products p ON od.product_id = p.id "
            + "GROUP BY p.id, p.name "
            + "ORDER BY revenue DESC "
            + "LIMIT ?1", nativeQuery = true)
    List<Object[]> findTopProductsByRevenue(int limit);

    @Query(value = "SELECT p.id AS product_id, p.name AS product_name, SUM(od.quantity) AS total_quantity, SUM(od.quantity * od.price) AS revenue "
            + "FROM order_detail od "
            + "JOIN products p ON od.product_id = p.id "
            + "JOIN orders o ON od.order_id = o.id "
            + "WHERE YEAR(o.created_at) = :year "
            + "GROUP BY p.id, p.name "
            + "ORDER BY revenue DESC "
            + "LIMIT :limit", nativeQuery = true)
    List<Object[]> findTopProductsByYear(@Param("year") int year, @Param("limit") int limit);

    @Query(value = "SELECT p.id AS product_id, p.name AS product_name, SUM(od.quantity) AS total_quantity, SUM(od.quantity * od.price) AS revenue "
            + "FROM order_detail od "
            + "JOIN products p ON od.product_id = p.id "
            + "JOIN orders o ON od.order_id = o.id "
            + "WHERE YEAR(o.created_at) = :year AND MONTH(o.created_at) = :month "
            + "GROUP BY p.id, p.name "
            + "ORDER BY revenue DESC "
            + "LIMIT :limit", nativeQuery = true)
    List<Object[]> findTopProductsByYearAndMonth(@Param("year") int year, @Param("month") int month, @Param("limit") int limit);

    @Query(value = "SELECT p.id AS product_id, p.name AS product_name, SUM(od.quantity) AS total_quantity, SUM(od.quantity * od.price) AS revenue "
            + "FROM order_detail od "
            + "JOIN products p ON od.product_id = p.id "
            + "JOIN orders o ON od.order_id = o.id "
            + "WHERE YEAR(o.created_at) = :year AND MONTH(o.created_at) = :month AND DAY(o.created_at) = :day "
            + "GROUP BY p.id, p.name "
            + "ORDER BY revenue DESC "
            + "LIMIT :limit", nativeQuery = true)
    List<Object[]> findTopProductsByYearMonthAndDay(@Param("year") int year, @Param("month") int month, @Param("day") int day, @Param("limit") int limit);

    @Query(value = "SELECT p.id AS product_id, p.name AS product_name, SUM(od.quantity) AS total_quantity, SUM(od.quantity * od.price) AS revenue "
            + "FROM order_detail od "
            + "JOIN products p ON od.product_id = p.id "
            + "JOIN orders o ON od.order_id = o.id "
            + "WHERE YEAR(o.created_at) = :year AND MONTH(o.created_at) = :month AND DAY(o.created_at) = :day AND HOUR(o.created_at) = :hour "
            + "GROUP BY p.id, p.name "
            + "ORDER BY revenue DESC "
            + "LIMIT :limit", nativeQuery = true)
    List<Object[]> findTopProductsByYearMonthDayAndHour(@Param("year") int year, @Param("month") int month, @Param("day") int day, @Param("hour") int hour, @Param("limit") int limit);
}
