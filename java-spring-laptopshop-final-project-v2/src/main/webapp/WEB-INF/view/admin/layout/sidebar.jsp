<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-light" id="sidenavAccordion">
                <div class="sb-sidenav-menu">
                    <div class="nav">
                        <div class="sb-sidenav-menu-heading">Features</div>
                        <c:if test="${pageContext.request.isUserInRole('ROLE_OWNER')}">
                            <a class="nav-link" href="/admin">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                Dashboard
                            </a>
                        </c:if>

                        <c:if test="${pageContext.request.isUserInRole('ROLE_ADMIN')}">
                            <a class="nav-link" href="/admin/user">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                User
                            </a>
                        </c:if>

                        <c:if test="${pageContext.request.isUserInRole('ROLE_OWNER')}">
                            <a class="nav-link" href="/admin/product">
                                <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                                Product
                            </a>

                            <a class="nav-link" href="/admin/order">
                                <div class="sb-nav-link-icon"><i class="fas fa-shopping-cart"></i></div>
                                Order
                            </a>

                            <a class="nav-link" href="/admin/refund">
                                <div class="sb-nav-link-icon"><i class="fas fa-undo"></i></div>
                                Refund
                            </a>

                            <a class="nav-link collapsed" href="#" data-bs-toggle="collapse"
                                data-bs-target="#collapseContent" aria-expanded="false" aria-controls="collapseContent">
                                <div class="sb-nav-link-icon"><i class="fas fa-file-alt"></i></div>
                                Content
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="collapseContent" aria-labelledby="headingOne"
                                data-bs-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="/admin/blog">Manage Blogs</a>
                                    <a class="nav-link" href="/admin/news">Manage News</a>
                                </nav>
                            </div>

                            <a class="nav-link" href="/admin/payment">
                                <div class="sb-nav-link-icon"><i class="fas fa-money-bill"></i></div>
                                Payment
                            </a>

                            <a class="nav-link" href="/admin/contact">
                                <div class="sb-nav-link-icon"><i class="fas fa-envelope"></i></div>
                                Contact
                            </a>

                            <a class="nav-link" href="/admin/review">
                                <div class="sb-nav-link-icon"><i class="fas fa-star"></i></div>
                                Review
                            </a>

                            <a class="nav-link" href="/admin/voucher">
                                <div class="sb-nav-link-icon"><i class="fas fa-ticket-alt"></i></div>
                                Voucher
                            </a>
                        </c:if>
                    </div>
                </div>
                <div class="sb-sidenav-footer">
                    <div class="small">Logged in as:</div>
                    <c:choose>
                        <c:when test="${pageContext.request.isUserInRole('ROLE_ADMIN')}">
                            Admin
                        </c:when>
                        <c:when test="${pageContext.request.isUserInRole('ROLE_OWNER')}">
                            Owner
                        </c:when>
                        <c:when test="${pageContext.request.isUserInRole('ROLE_STAFF')}">
                            Staff
                        </c:when>
                        <c:otherwise>
                            User
                        </c:otherwise>
                    </c:choose>
                </div>
            </nav>
        </div>
