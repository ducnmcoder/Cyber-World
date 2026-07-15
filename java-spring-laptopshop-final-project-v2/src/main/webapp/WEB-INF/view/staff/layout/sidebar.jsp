<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                <div class="sb-sidenav-menu">
                    <div class="nav">
                        <div class="sb-sidenav-menu-heading">Features</div>
                        <a class="nav-link" href="/staff/order">
                            <div class="sb-nav-link-icon"><i class="fas fa-shopping-cart"></i></div>
                            Orders
                        </a>

                        <a class="nav-link" href="/staff/blog">
                            <div class="sb-nav-link-icon"><i class="fas fa-blog"></i></div>
                            Blog
                        </a>

                        <a class="nav-link" href="/staff/contact">
                            <div class="sb-nav-link-icon"><i class="fas fa-envelope"></i></div>
                            Contact
                        </a>
                    </div>
                </div>
                <div class="sb-sidenav-footer">
                    <div class="small">Logged in as:</div>
                    Staff
                </div>
            </nav>
        </div>
