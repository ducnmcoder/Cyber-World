<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Include FontAwesome 6 explicitly for the new icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- Include Google Fonts for Logo -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600&family=Orbitron:wght@900&display=swap" rel="stylesheet">

<style>
    .cyber-header {
        background-color: #cd1818;
        color: white;
        padding: 10px 0;
        box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        position: sticky;
        top: 0;
        z-index: 99999;
    }
    .cyber-header .container {
        max-width: 1200px;
        margin: 0 auto;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }
    .cyber-logo {
        text-decoration: none;
        display: flex;
        align-items: center;
    }
    .cyber-logo-text {
        display: flex;
        flex-direction: column;
        justify-content: center;
    }
    .cyber-logo-title {
        font-family: 'Orbitron', sans-serif;
        font-size: 26px;
        font-weight: 900;
        letter-spacing: 1px;
        line-height: 1.1;
        text-transform: uppercase;
        color: white;
    }
    .cyber-search {
        flex-grow: 1;
        margin: 0 40px;
        position: relative;
        max-width: 500px;
    }
    .cyber-search input {
        width: 100%;
        padding: 10px 40px 10px 15px;
        border-radius: 20px;
        border: none;
        outline: none;
        color: #111;
    }
    .cyber-search button {
        position: absolute;
        right: 15px;
        top: 50%;
        transform: translateY(-50%);
        background: none;
        border: none;
        cursor: pointer;
        color: #666;
    }
    .cyber-header-actions {
        display: flex;
        gap: 15px;
    }
    .cyber-action-btn {
        display: flex;
        align-items: center;
        color: white;
        text-decoration: none;
        font-size: 16px;
        gap: 8px;
        background: #000000;
        padding: 10px 18px;
        border-radius: 8px;
        transition: background 0.2s;
        border: none;
    }
    .cyber-action-btn:hover {
        background: #333333;
        color: white;
    }

    .cyber-menu-btn {
        background: transparent;
        border: none;
        color: white;
        font-size: 24px;
        cursor: pointer;
        padding: 5px 10px;
        transition: 0.2s;
    }
    .cyber-menu-btn:hover {
        opacity: 0.8;
    }

    /* Dropdown Menu */
    .cyber-dropdown {
        position: relative;
        display: inline-block;
    }
    .cyber-dropdown-content {
        display: none;
        position: absolute;
        right: 0;
        top: 100%;
        background-color: #fff;
        min-width: 160px;
        box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
        z-index: 1000;
        border-radius: 8px;
        overflow: hidden;
    }
    .cyber-dropdown-content a {
        color: #333;
        padding: 12px 16px;
        text-decoration: none;
        display: block;
        font-size: 14px;
        font-weight: 500;
        transition: background 0.2s;
        text-align: left;
    }
    .cyber-dropdown-content a i {
        margin-right: 8px;
        width: 16px;
        text-align: center;
    }
    .cyber-dropdown-content a:hover {
        background-color: #f1f2f6;
        color: #cd1818;
    }
    .cyber-dropdown:hover .cyber-dropdown-content {
        display: block;
    }
</style>

<header class="cyber-header">
    <div class="container">
        <c:choose>
            <c:when test="${sessionScope.user != null and sessionScope.user.role.name == 'ADMIN'}">
                <a href="#" class="cyber-logo">
            </c:when>
            <c:otherwise>
                <a href="/" class="cyber-logo">
            </c:otherwise>
        </c:choose>
            <img src="/images/logo.png" alt="Cyber World Logo" style="height: 50px; margin-right: 15px;">
            <div class="cyber-logo-text">
                <span class="cyber-logo-title">CYBER</span>
                <span class="cyber-logo-title">WORLD</span>
            </div>
        </a>
        
        <form class="cyber-search" action="/products" method="get">
            <input type="text" name="name" placeholder="Search laptops, accessories...">
            <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
        </form>

        <div class="cyber-header-actions" style="align-items: center;">
            <!-- Order history for USER only -->
            <c:if test="${sessionScope.user != null and sessionScope.user.role.name == 'USER'}">
                <a href="/order-history" class="cyber-action-btn" title="Order History">
                    <i class="fa-solid fa-clock-rotate-left"></i>
                </a>
            </c:if>
            
            <!-- Cart for USER and Guest -->
            <c:if test="${sessionScope.user == null or sessionScope.user.role.name == 'USER'}">
                <a href="/cart" class="cyber-action-btn" title="Cart">
                    <i class="fa-solid fa-cart-shopping"></i>
                    <span style="margin-left: 5px; font-weight: bold;">${sessionScope.sum != null ? sessionScope.sum : 0}</span>
                </a>
            </c:if>

            <!-- Dashboard for STAFF -->
            <c:if test="${sessionScope.user != null and sessionScope.user.role.name == 'STAFF'}">
                <a href="/staff" class="cyber-action-btn" title="Dashboard">
                    <i class="fa-solid fa-table-columns"></i>
                </a>
            </c:if>

            <!-- Dashboard for OWNER -->
            <c:if test="${sessionScope.user != null and sessionScope.user.role.name == 'OWNER'}">
                <a href="/owner" class="cyber-action-btn" title="Dashboard">
                    <i class="fa-solid fa-table-columns"></i>
                </a>
            </c:if>

            <!-- Role / Logout Button for ADMIN, OWNER, STAFF -->
            <c:if test="${sessionScope.user != null and sessionScope.user.role.name != 'USER'}">
                <form method="post" action="/logout" style="margin: 0;">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <button type="submit" class="cyber-action-btn" title="Logout" style="cursor: pointer; font-family: inherit;">
                        <i class="fa-solid fa-user-shield"></i>
                        <span style="margin: 0 5px; color: white;">${sessionScope.user.role.name}</span>
                        <i class="fa-solid fa-sign-out-alt"></i>
                    </button>
                </form>
            </c:if>

            <!-- Account / Logout Button for USER and Guest -->
            <c:if test="${sessionScope.user == null}">
                <a href="/login" class="cyber-action-btn" title="Account">
                    <i class="fa-solid fa-user"></i>
                </a>
            </c:if>
            <c:if test="${sessionScope.user != null and sessionScope.user.role.name == 'USER'}">
                <form method="post" action="/logout" style="margin: 0;">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <button type="submit" class="cyber-action-btn" title="Logout" style="cursor: pointer; font-family: inherit;">
                        <i class="fa-solid fa-sign-out-alt"></i>
                    </button>
                </form>
            </c:if>

            <!-- Hamburger Menu -->
            <div class="cyber-dropdown" style="margin-left: 10px;">
                <button class="cyber-menu-btn" title="Menu">
                    <i class="fa-solid fa-bars"></i>
                </button>
                <div class="cyber-dropdown-content">
                    <a href="/blog"><i class="fa-solid fa-blog"></i> Blog</a>
                    <a href="#footer" onclick="document.getElementById('footer').scrollIntoView({behavior: 'smooth'})"><i class="fa-solid fa-envelope"></i> Contact</a>
                    <a href="#footer" onclick="document.getElementById('footer').scrollIntoView({behavior: 'smooth'})"><i class="fa-solid fa-circle-info"></i> About Us</a>
                    <c:if test="${sessionScope.user != null and sessionScope.user.role.name == 'USER'}">
                        <a href="/account/manage"><i class="fa-solid fa-user-gear"></i> Manage Account</a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</header>
