package laptopshop.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import laptopshop.service.OrderService;
import laptopshop.service.UserService;
import laptopshop.service.ContactService;
import laptopshop.service.ExcelExportService;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
public class DashboardController {

    private final UserService userService;
    private final OrderService orderService;
    private final ContactService contactService;
    private final ExcelExportService excelExportService;

    public DashboardController(UserService userService, OrderService orderService, ContactService contactService, ExcelExportService excelExportService) {
        this.userService = userService;
        this.orderService = orderService;
        this.contactService = contactService;
        this.excelExportService = excelExportService;
    }

    @GetMapping(value = {"/admin", "/owner"})
    public String getDashboard(Model model) {
        model.addAttribute("countUsers", this.userService.countUsers());
        model.addAttribute("countProducts", this.userService.countProducts());
        model.addAttribute("countOrders", this.userService.countOrders());
        model.addAttribute("countContacts", this.contactService.countContacts());
        return "admin/dashboard/show";
    }

    @GetMapping("/owner/dashboard/export")
    public void exportToExcel(HttpServletResponse response) throws IOException {
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        String headerKey = "Content-Disposition";
        String headerValue = "attachment; filename=Dashboard_Report.xlsx";
        response.setHeader(headerKey, headerValue);

        excelExportService.exportDashboardReport(response);
    }
}
