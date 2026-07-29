package laptopshop.service;

import laptopshop.domain.Order;
import laptopshop.domain.OrderDetail;
import laptopshop.domain.Product;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xddf.usermodel.chart.*;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.stereotype.Service;

import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ExcelExportService {

    private final OrderService orderService;

    public ExcelExportService(OrderService orderService) {
        this.orderService = orderService;
    }

    public void exportDashboardReport(HttpServletResponse response) throws IOException {
        // Fetch ALL orders
        List<Order> orders = orderService.fetchAllOrdersList();

        try (XSSFWorkbook workbook = new XSSFWorkbook()) {
            // Setup styles
            XSSFCellStyle headerStyle = createHeaderStyle(workbook);
            XSSFCellStyle zebraStyle1 = createZebraStyle(workbook, false);
            XSSFCellStyle zebraStyle2 = createZebraStyle(workbook, true);
            XSSFCellStyle currencyStyle1 = createCurrencyStyle(workbook, false);
            XSSFCellStyle currencyStyle2 = createCurrencyStyle(workbook, true);
            XSSFCellStyle percentStyle1 = createPercentStyle(workbook, false);
            XSSFCellStyle percentStyle2 = createPercentStyle(workbook, true);

            // Tab 1: Dashboard
            XSSFSheet dashboardSheet = workbook.createSheet("Overview Dashboard");
            createDashboardSheet(dashboardSheet, orders, headerStyle, zebraStyle1, zebraStyle2, currencyStyle1, currencyStyle2, percentStyle1, percentStyle2);

            // Tab 2: Chi tiết
            XSSFSheet detailSheet = workbook.createSheet("Order Details");
            createDetailSheet(detailSheet, orders, headerStyle, zebraStyle1, zebraStyle2, currencyStyle1, currencyStyle2);

            ServletOutputStream outputStream = response.getOutputStream();
            workbook.write(outputStream);
            outputStream.close();
        }
    }

    private void createDashboardSheet(XSSFSheet sheet, List<Order> orders, XSSFCellStyle headerStyle, XSSFCellStyle z1, XSSFCellStyle z2, XSSFCellStyle c1, XSSFCellStyle c2, XSSFCellStyle p1, XSSFCellStyle p2) {
        // Calculate KPIs
        double totalRevenue = 0;
        double totalCost = 0;
        int totalOrders = orders.size();

        Map<String, BrandStat> brandStats = new HashMap<>();
        String[] brands = {"Dell", "ASUS", "Apple", "Lenovo", "HP", "MSI"};
        for (String b : brands) brandStats.put(b.toLowerCase(), new BrandStat(b));
        BrandStat otherStat = new BrandStat("Other");

        for (Order o : orders) {
            for (OrderDetail od : o.getOrderDetails()) {
                Product p = od.getProduct();
                long qty = od.getQuantity();
                double price = od.getPrice();
                
                // Gia nhap: Su dung originalPrice. Neu null thi lay price * 0.7
                double cost = (p != null && p.getOriginalPrice() != null) ? p.getOriginalPrice() : (price * 0.7); 

                totalRevenue += price * qty;
                totalCost += cost * qty;

                String factory = (p != null && p.getFactory() != null) ? p.getFactory().toLowerCase() : "other";
                BrandStat stat = brandStats.getOrDefault(factory, otherStat);
                stat.qty += qty;
                stat.revenue += price * qty;
                stat.profit += (price - cost) * qty;
            }
        }
        
        if (otherStat.qty > 0) {
            brandStats.put("other", otherStat);
        }

        // Write KPIs
        XSSFRow row0 = sheet.createRow(0);
        XSSFCell cell0 = row0.createCell(0);
        cell0.setCellValue("BUSINESS OVERVIEW");
        cell0.setCellStyle(headerStyle);
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 2));

        XSSFRow row2 = sheet.createRow(2);
        row2.createCell(0).setCellValue("Total Revenue");
        row2.createCell(1).setCellValue("Total Profit");
        row2.createCell(2).setCellValue("Total Orders");
        for(int i=0; i<=2; i++) row2.getCell(i).setCellStyle(headerStyle);

        XSSFRow row3 = sheet.createRow(3);
        createCell(row3, 0, totalRevenue, c1);
        createCell(row3, 1, totalRevenue - totalCost, c1);
        createCell(row3, 2, (double) totalOrders, z1);

        // Write Brand Performance Table
        XSSFRow row5 = sheet.createRow(5);
        row5.createCell(0).setCellValue("Brand");
        row5.createCell(1).setCellValue("Units Sold");
        row5.createCell(2).setCellValue("Revenue");
        row5.createCell(3).setCellValue("Share (%)");
        row5.createCell(4).setCellValue("Profit");
        for(int i=0; i<=4; i++) row5.getCell(i).setCellStyle(headerStyle);

        int rowIndex = 6;
        for (BrandStat stat : brandStats.values()) {
            if (stat.qty == 0) continue;
            XSSFRow row = sheet.createRow(rowIndex);
            boolean isAlt = (rowIndex % 2 != 0);
            XSSFCellStyle zStyle = isAlt ? z2 : z1;
            XSSFCellStyle cStyle = isAlt ? c2 : c1;
            XSSFCellStyle pStyle = isAlt ? p2 : p1;

            createCell(row, 0, stat.name, zStyle);
            createCell(row, 1, (double) stat.qty, zStyle);
            createCell(row, 2, stat.revenue, cStyle);
            
            double share = totalRevenue > 0 ? (stat.revenue / totalRevenue) : 0;
            createCell(row, 3, share, pStyle);
            createCell(row, 4, stat.profit, cStyle);
            rowIndex++;
        }

        for (int i = 0; i <= 4; i++) sheet.autoSizeColumn(i);

        // Add Charts
        drawCharts(sheet, rowIndex);
    }

    private void drawCharts(XSSFSheet sheet, int lastRowIndex) {
        if (lastRowIndex <= 6) return;

        XSSFDrawing drawing = sheet.createDrawingPatriarch();

        // Bar Chart (Revenue by Brand)
        XSSFClientAnchor anchor1 = drawing.createAnchor(0, 0, 0, 0, 6, 2, 12, 15);
        XSSFChart barChart = drawing.createChart(anchor1);
        barChart.setTitleText("Revenue by Brand");
        barChart.setTitleOverlay(false);
        XDDFCategoryAxis bottomAxis = barChart.createCategoryAxis(AxisPosition.BOTTOM);
        XDDFValueAxis leftAxis = barChart.createValueAxis(AxisPosition.LEFT);
        leftAxis.setCrosses(AxisCrosses.AUTO_ZERO);
        
        XDDFDataSource<String> barCategories = XDDFDataSourcesFactory.fromStringCellRange(sheet, new CellRangeAddress(6, lastRowIndex - 1, 0, 0));
        XDDFNumericalDataSource<Double> barValues = XDDFDataSourcesFactory.fromNumericCellRange(sheet, new CellRangeAddress(6, lastRowIndex - 1, 2, 2));
        
        XDDFChartData barData = barChart.createData(ChartTypes.BAR, bottomAxis, leftAxis);
        XDDFChartData.Series barSeries = barData.addSeries(barCategories, barValues);
        barSeries.setTitle("Revenue", null);
        barChart.plot(barData);
        ((XDDFBarChartData) barData).setBarDirection(BarDirection.COL);

        // Pie Chart (Revenue Share)
        XSSFClientAnchor anchor2 = drawing.createAnchor(0, 0, 0, 0, 13, 2, 18, 15);
        XSSFChart pieChart = drawing.createChart(anchor2);
        pieChart.setTitleText("Revenue Share (%)");
        pieChart.setTitleOverlay(false);
        
        XDDFDataSource<String> pieCategories = XDDFDataSourcesFactory.fromStringCellRange(sheet, new CellRangeAddress(6, lastRowIndex - 1, 0, 0));
        XDDFNumericalDataSource<Double> pieValues = XDDFDataSourcesFactory.fromNumericCellRange(sheet, new CellRangeAddress(6, lastRowIndex - 1, 3, 3));
        
        XDDFChartData pieData = pieChart.createData(ChartTypes.PIE, null, null);
        XDDFChartData.Series pieSeries = pieData.addSeries(pieCategories, pieValues);
        pieSeries.setTitle("Share", null);
        pieChart.plot(pieData);
    }

    private void createDetailSheet(XSSFSheet sheet, List<Order> orders, XSSFCellStyle headerStyle, XSSFCellStyle z1, XSSFCellStyle z2, XSSFCellStyle c1, XSSFCellStyle c2) {
        String[] headers = {
            "Order ID", "Order Date", "Customer Name", "Product Name", 
            "Brand", "Cost Price", "Quantity", "Selling Price", 
            "Total Amount", "Discount", "Profit", "Sales Channel"
        };
        
        XSSFRow headerRow = sheet.createRow(0);
        for (int i = 0; i < headers.length; i++) {
            XSSFCell cell = headerRow.createCell(i);
            cell.setCellValue(headers[i]);
            cell.setCellStyle(headerStyle);
        }

        int rowIdx = 1;
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

        for (Order o : orders) {
            for (OrderDetail od : o.getOrderDetails()) {
                Product p = od.getProduct();
                XSSFRow row = sheet.createRow(rowIdx);
                boolean isAlt = (rowIdx % 2 == 0);
                XSSFCellStyle zStyle = isAlt ? z2 : z1;
                XSSFCellStyle cStyle = isAlt ? c2 : c1;

                long qty = od.getQuantity();
                double sellPrice = od.getPrice();
                double costPrice = (p != null && p.getOriginalPrice() != null) ? p.getOriginalPrice() : (sellPrice * 0.7);
                double total = sellPrice * qty;
                double discount = (p != null && p.getOriginalPrice() != null && p.getOriginalPrice() > sellPrice) 
                                    ? (p.getOriginalPrice() - sellPrice) * qty : 0;
                double profit = total - (costPrice * qty);

                createCell(row, 0, "DH" + o.getId(), zStyle);
                createCell(row, 1, o.getCreatedAt() != null ? o.getCreatedAt().format(dtf) : "", zStyle);
                createCell(row, 2, o.getReceiverName(), zStyle);
                createCell(row, 3, p != null ? p.getName() : "Unknown", zStyle);
                createCell(row, 4, (p != null && p.getFactory() != null) ? p.getFactory() : "Other", zStyle);
                
                createCell(row, 5, costPrice, cStyle);
                createCell(row, 6, (double) qty, zStyle);
                createCell(row, 7, sellPrice, cStyle);
                createCell(row, 8, total, cStyle);
                createCell(row, 9, discount, cStyle);
                createCell(row, 10, profit, cStyle);
                createCell(row, 11, "Website", zStyle);

                rowIdx++;
            }
        }

        for (int i = 0; i < headers.length; i++) sheet.autoSizeColumn(i);
        
        sheet.createFreezePane(0, 1);
        if (rowIdx > 1) {
            sheet.setAutoFilter(new CellRangeAddress(0, rowIdx - 1, 0, headers.length - 1));
        }
    }

    private void createCell(XSSFRow row, int col, String val, XSSFCellStyle style) {
        XSSFCell c = row.createCell(col);
        c.setCellValue(val != null ? val : "");
        c.setCellStyle(style);
    }

    private void createCell(XSSFRow row, int col, double val, XSSFCellStyle style) {
        XSSFCell c = row.createCell(col);
        c.setCellValue(val);
        c.setCellStyle(style);
    }

    private XSSFCellStyle createHeaderStyle(XSSFWorkbook wb) {
        XSSFCellStyle style = wb.createCellStyle();
        // Navy / Slate Blue Theme
        byte[] rgb = new byte[]{(byte) 44, (byte) 62, (byte) 80}; 
        XSSFColor color = new XSSFColor(rgb, null);
        style.setFillForegroundColor(color);
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        
        XSSFFont font = wb.createFont();
        font.setColor(IndexedColors.WHITE.getIndex());
        font.setBold(true);
        style.setFont(font);
        
        style.setAlignment(HorizontalAlignment.CENTER);
        style.setVerticalAlignment(VerticalAlignment.CENTER);
        return style;
    }

    private XSSFCellStyle createZebraStyle(XSSFWorkbook wb, boolean alt) {
        XSSFCellStyle style = wb.createCellStyle();
        if (alt) {
            // Light grey for zebra striping
            byte[] rgb = new byte[]{(byte) 242, (byte) 242, (byte) 242}; 
            XSSFColor color = new XSSFColor(rgb, null);
            style.setFillForegroundColor(color);
            style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        }
        style.setBorderBottom(BorderStyle.THIN);
        style.setBottomBorderColor(IndexedColors.GREY_25_PERCENT.getIndex());
        return style;
    }

    private XSSFCellStyle createCurrencyStyle(XSSFWorkbook wb, boolean alt) {
        XSSFCellStyle style = createZebraStyle(wb, alt);
        XSSFDataFormat format = wb.createDataFormat();
        style.setDataFormat(format.getFormat("#,##0\" VND\""));
        return style;
    }

    private XSSFCellStyle createPercentStyle(XSSFWorkbook wb, boolean alt) {
        XSSFCellStyle style = createZebraStyle(wb, alt);
        XSSFDataFormat format = wb.createDataFormat();
        style.setDataFormat(format.getFormat("0.00%"));
        return style;
    }

    static class BrandStat {
        String name;
        long qty;
        double revenue;
        double profit;
        BrandStat(String n) { name = n; }
    }
}
