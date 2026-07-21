package laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import laptopshop.domain.OrderDetail;
import laptopshop.domain.Product;

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

    List<OrderDetail> findByProduct(Product product);
}
