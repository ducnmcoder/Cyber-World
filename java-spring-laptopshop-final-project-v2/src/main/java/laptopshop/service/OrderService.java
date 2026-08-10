package laptopshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import laptopshop.domain.Order;
import laptopshop.domain.OrderDetail;
import laptopshop.domain.Product;
import laptopshop.domain.Payment;
import laptopshop.domain.User;
import laptopshop.repository.OrderDetailRepository;
import laptopshop.repository.OrderRepository;
import laptopshop.repository.PaymentRepository;

@Service
public class OrderService {
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;
    private final PaymentRepository paymentRepository;

    public OrderService(
            OrderRepository orderRepository,
            OrderDetailRepository orderDetailRepository,
            PaymentRepository paymentRepository) {
        this.orderDetailRepository = orderDetailRepository;
        this.orderRepository = orderRepository;
        this.paymentRepository = paymentRepository;
    }

    public Page<Order> fetchAllOrders(Pageable page) {
        return this.orderRepository.findAll(page);
    }

    public List<Order> fetchAllOrdersList() {
        return this.orderRepository.findAll();
    }

    public List<Order> fetchOrdersByStatus(String status) {
        return this.orderRepository.findByStatus(status);
    }

    public Optional<Order> fetchOrderById(long id) {
        return this.orderRepository.findById(id);
    }

    @Transactional
    public void deleteOrderById(long id) {
        Optional<Order> orderOptional = this.fetchOrderById(id);
        if (orderOptional.isPresent()) {
            Order order = orderOptional.get();
            
            // Delete payments first
            List<Payment> payments = order.getPayments();
            if (payments != null) {
                for (Payment payment : payments) {
                    this.paymentRepository.deleteById(payment.getId());
                }
            }

            // delete order detail
            List<OrderDetail> orderDetails = order.getOrderDetails();
            for (OrderDetail orderDetail : orderDetails) {
                this.orderDetailRepository.deleteById(orderDetail.getId());
            }
        }

        this.orderRepository.deleteById(id);
    }

    @Transactional
    public void updateOrder(Order order) {
        Optional<Order> orderOptional = this.fetchOrderById(order.getId());
        if (orderOptional.isPresent()) {
            Order currentOrder = orderOptional.get();
            currentOrder.setStatus(order.getStatus());
            currentOrder.setPaymentStatus(order.getPaymentStatus());
            this.orderRepository.save(currentOrder);
        }
    }

    @Transactional
    public void updateOrderPaymentStatus(Order order) {
        Optional<Order> orderOptional = this.fetchOrderById(order.getId());
        if (orderOptional.isPresent()) {
            Order currentOrder = orderOptional.get();
            currentOrder.setPaymentStatus(order.getPaymentStatus());
            this.orderRepository.save(currentOrder);
        }
    }

    public List<Order> fetchOrderByUser(User user) {
        return this.orderRepository.findByUser(user);
    }

    @Transactional
    public void updateDeliveryInfo(long orderId, String receiverName, String receiverPhone, String receiverAddress) {
        Optional<Order> opt = this.orderRepository.findById(orderId);
        if (opt.isPresent()) {
            Order order = opt.get();
            order.setReceiverName(receiverName);
            order.setReceiverPhone(receiverPhone);
            order.setReceiverAddress(receiverAddress);
            this.orderRepository.save(order);
        }
    }

    @Transactional
    public void cancelOrder(long orderId, String reason, String refundName, String refundPhone, String bankName, String bankAccount) {
        Optional<Order> opt = this.orderRepository.findById(orderId);
        if (opt.isPresent()) {
            Order order = opt.get();
            if ("PENDING".equals(order.getStatus())) {
                order.setStatus("CANCELLED");
                order.setRefundReason(reason);
                if (!"COD".equals(order.getPaymentMethod())) {
                    order.setRefundName(refundName);
                    order.setRefundPhone(refundPhone);
                    order.setRefundBankName(bankName);
                    order.setRefundBankAccount(bankAccount);
                }
                this.orderRepository.save(order);

                // Restock products
                if (order.getOrderDetails() != null) {
                    for (OrderDetail cd : order.getOrderDetails()) {
                        Product product = cd.getProduct();
                        if (product != null) {
                            long currentQuantity = product.getQuantity() != null ? product.getQuantity() : 0;
                            product.setQuantity(currentQuantity + cd.getQuantity());

                            long currentSold = product.getSold() != null ? product.getSold() : 0;
                            long remainingSold = currentSold - cd.getQuantity();
                            product.setSold(remainingSold < 0 ? 0 : remainingSold);
                        }
                    }
                }
            }
        }
    }

    public List<Object[]> fetchMonthlyRevenue() {
        return this.orderRepository.findMonthlyRevenue();
    }

    public List<Object[]> fetchDailyRevenue() {
        return this.orderRepository.findDailyRevenue();
    }

    public List<Object[]> fetchHourlyRevenue() {
        return this.orderRepository.findHourlyRevenue();
    }

    public List<Object[]> fetchTopProductsByRevenue(int limit) {
        return this.orderDetailRepository.findTopProductsByRevenue(limit);
    }

    public List<Object[]> fetchMonthlyRevenueByYear(int year) {
        List<Object[]> dbData = this.orderRepository.findMonthlyRevenueByYear(year);
        List<Object[]> paddedData = new java.util.ArrayList<>();
        
        for (int i = 1; i <= 12; i++) {
            boolean found = false;
            for (Object[] entry : dbData) {
                if (Integer.parseInt(entry[0].toString()) == i) {
                    paddedData.add(new Object[]{i, entry[1]});
                    found = true;
                    break;
                }
            }
            if (!found) {
                paddedData.add(new Object[]{i, 0});
            }
        }
        return paddedData;
    }

    public List<Object[]> fetchDailyRevenueByYearAndMonth(int year, int month) {
        List<Object[]> dbData = this.orderRepository.findDailyRevenueByYearAndMonth(year, month);
        List<Object[]> paddedData = new java.util.ArrayList<>();
        
        int daysInMonth = java.time.YearMonth.of(year, month).lengthOfMonth();
        
        for (int i = 1; i <= daysInMonth; i++) {
            boolean found = false;
            for (Object[] entry : dbData) {
                if (Integer.parseInt(entry[0].toString()) == i) {
                    paddedData.add(new Object[]{i, entry[1]});
                    found = true;
                    break;
                }
            }
            if (!found) {
                paddedData.add(new Object[]{i, 0});
            }
        }
        return paddedData;
    }

    public List<Object[]> fetchHourlyRevenueByYearMonthAndDay(int year, int month, int day) {
        List<Object[]> dbData = this.orderRepository.findHourlyRevenueByYearMonthAndDay(year, month, day);
        List<Object[]> paddedData = new java.util.ArrayList<>();
        
        for (int i = 0; i <= 23; i++) {
            boolean found = false;
            for (Object[] entry : dbData) {
                if (Integer.parseInt(entry[0].toString()) == i) {
                    paddedData.add(new Object[]{i, entry[1]});
                    found = true;
                    break;
                }
            }
            if (!found) {
                paddedData.add(new Object[]{i, 0});
            }
        }
        return paddedData;
    }

    public List<Object[]> fetchTopProductsByYear(int year, int limit) {
        return this.orderDetailRepository.findTopProductsByYear(year, limit);
    }
    public List<Object[]> fetchTopProductsByYearAndMonth(int year, int month, int limit) {
        return this.orderDetailRepository.findTopProductsByYearAndMonth(year, month, limit);
    }
    public List<Object[]> fetchTopProductsByYearMonthAndDay(int year, int month, int day, int limit) {
        return this.orderDetailRepository.findTopProductsByYearMonthAndDay(year, month, day, limit);
    }
    public List<Object[]> fetchTopProductsByYearMonthDayAndHour(int year, int month, int day, int hour, int limit) {
        return this.orderDetailRepository.findTopProductsByYearMonthDayAndHour(year, month, day, hour, limit);
    }

}
