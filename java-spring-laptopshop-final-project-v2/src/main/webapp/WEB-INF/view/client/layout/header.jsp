<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
        font-size: 24px;
        font-weight: bold;
        color: white;
        text-decoration: none;
        display: flex;
        align-items: center;
        gap: 10px;
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
        font-size: 14px;
        gap: 5px;
        background: #000000;
        padding: 8px 15px;
        border-radius: 5px;
        transition: background 0.2s;
    }
    .cyber-action-btn:hover {
        background: #333333;
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
            <img src="/images/logo.png" alt="Cyber World Logo" style="height: 40px; margin-right: 10px;">
            Cyber World
        </a>
        
        <form class="cyber-search" action="/products" method="get">
            <input type="text" name="name" placeholder="Search laptops, accessories...">
            <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
        </form>

        <div class="cyber-header-actions">
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
                    <span class="badge bg-warning text-dark rounded-pill" style="margin-left: 5px;">${sessionScope.sum != null ? sessionScope.sum : 0}</span>
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
                    <button type="submit" class="cyber-action-btn" title="Logout" style="border: none; cursor: pointer; font-family: inherit;">
                        <i class="fa-solid fa-user-shield"></i>
                        <span style="margin: 0 5px;">${sessionScope.user.role.name}</span>
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
                    <button type="submit" class="cyber-action-btn" title="Logout" style="border: none; cursor: pointer; font-family: inherit;">
                        <i class="fa-solid fa-sign-out-alt"></i>
                    </button>
                </form>
            </c:if>
        </div>
    </div>
</header>
