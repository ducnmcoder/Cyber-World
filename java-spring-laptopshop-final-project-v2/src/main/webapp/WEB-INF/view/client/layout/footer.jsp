<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    .cyber-footer {
        background: #111;
        color: #eee;
        padding: 50px 0 20px 0;
        margin-top: 50px;
        font-size: 14px;
        font-family: 'Inter', sans-serif;
    }
    .cyber-footer .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 15px;
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 30px;
    }
    .cyber-footer .footer-col h4 {
        font-size: 16px;
        font-weight: 700;
        color: #fff;
        margin-bottom: 20px;
        text-transform: uppercase;
    }
    .cyber-footer .footer-col ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }
    .cyber-footer .footer-col ul li {
        margin-bottom: 10px;
    }
    .cyber-footer .footer-col ul li a {
        color: #bbb;
        text-decoration: none;
        transition: 0.2s;
    }
    .cyber-footer .footer-col ul li a:hover {
        color: #fff;
    }
    .cyber-footer .footer-hotline {
        font-size: 20px;
        font-weight: 800;
        color: #cd1818;
        display: block;
        margin-bottom: 15px;
    }
    .cyber-footer .footer-bottom {
        text-align: center;
        border-top: 1px solid #333;
        margin-top: 40px;
        padding-top: 20px;
        color: #777;
    }
</style>

<footer class="cyber-footer">
    <div class="container">
        <div class="footer-col">
            <h4>Hotline & Hỗ trợ</h4>
            <a href="tel:18001234" class="footer-hotline">1800 1234</a>
            <ul>
                <li><a href="#">Tổng đài (8:00 - 21:00)</a></li>
                <li><a href="#">Hỗ trợ kỹ thuật</a></li>
                <li><a href="#">Trung tâm bảo hành</a></li>
            </ul>
        </div>
        
        <div class="footer-col">
            <h4>Hệ thống cửa hàng</h4>
            <ul>
                <li><a href="#">Showroom tại Hà Nội</a></li>
                <li><a href="#">Showroom tại TP Hồ Chí Minh</a></li>
                <li><a href="#">Showroom tại Đà Nẵng</a></li>
                <li><a href="#">Tìm cửa hàng gần nhất</a></li>
            </ul>
        </div>
        
        <div class="footer-col">
            <h4>Chính sách</h4>
            <ul>
                <li><a href="#">Chính sách bảo hành</a></li>
                <li><a href="#">Chính sách đổi trả</a></li>
                <li><a href="#">Chính sách vận chuyển</a></li>
                <li><a href="#">Bảo mật thông tin</a></li>
            </ul>
        </div>
        
        <div class="footer-col">
            <h4>Thanh toán & Giao hàng</h4>
            <div style="display: flex; gap: 10px; margin-bottom: 15px; font-size: 24px;">
                <i class="fa-brands fa-cc-visa" style="color: white;"></i>
                <i class="fa-brands fa-cc-mastercard" style="color: white;"></i>
                <i class="fa-brands fa-cc-paypal" style="color: white;"></i>
            </div>
            <div style="display: flex; gap: 10px; font-size: 24px;">
                <i class="fa-solid fa-truck-fast" style="color: white;"></i>
                <i class="fa-solid fa-box" style="color: white;"></i>
            </div>
        </div>
    </div>
    <div class="footer-bottom">
        <p>&copy; 2026 Cyber World. Tất cả các quyền được bảo lưu.</p>
    </div>
</footer>
