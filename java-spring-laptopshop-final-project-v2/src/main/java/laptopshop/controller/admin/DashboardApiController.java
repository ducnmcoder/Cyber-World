package laptopshop.controller.admin;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import laptopshop.service.OrderService;
import java.util.List;

@RestController
@RequestMapping("/admin/api/dashboard")
public class DashboardApiController {

    private final OrderService orderService;

    public DashboardApiController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping("/revenue/monthly")
    public ResponseEntity<List<Object[]>> getMonthlyRevenue(@RequestParam int year) {
        return ResponseEntity.ok(this.orderService.fetchMonthlyRevenueByYear(year));
    }

    @GetMapping("/revenue/daily")
    public ResponseEntity<List<Object[]>> getDailyRevenue(@RequestParam int year, @RequestParam int month) {
        return ResponseEntity.ok(this.orderService.fetchDailyRevenueByYearAndMonth(year, month));
    }

    @GetMapping("/revenue/hourly")
    public ResponseEntity<List<Object[]>> getHourlyRevenue(@RequestParam int year, @RequestParam int month, @RequestParam int day) {
        return ResponseEntity.ok(this.orderService.fetchHourlyRevenueByYearMonthAndDay(year, month, day));
    }

    @GetMapping("/top-products")
    public ResponseEntity<List<Object[]>> getTopProducts(
            @RequestParam(required = false) Integer year,
            @RequestParam(required = false) Integer month,
            @RequestParam(required = false) Integer day,
            @RequestParam(required = false) Integer hour) {
        
        int limit = 10;
        List<Object[]> topProducts;
        
        if (year != null && month != null && day != null && hour != null) {
            topProducts = this.orderService.fetchTopProductsByYearMonthDayAndHour(year, month, day, hour, limit);
        } else if (year != null && month != null && day != null) {
            topProducts = this.orderService.fetchTopProductsByYearMonthAndDay(year, month, day, limit);
        } else if (year != null && month != null) {
            topProducts = this.orderService.fetchTopProductsByYearAndMonth(year, month, limit);
        } else if (year != null) {
            topProducts = this.orderService.fetchTopProductsByYear(year, limit);
        } else {
            topProducts = this.orderService.fetchTopProductsByRevenue(limit);
        }
        
        return ResponseEntity.ok(topProducts);
    }
}
