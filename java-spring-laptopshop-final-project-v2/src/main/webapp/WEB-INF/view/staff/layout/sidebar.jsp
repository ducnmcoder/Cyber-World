<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <div id="layoutSidenav_nav">
            <nav class="sb-sidenav accordion sb-sidenav-light" id="sidenavAccordion">
                <div class="sb-sidenav-menu">
                    <div class="nav">
                        <div class="sb-sidenav-menu-heading">Features</div>
                        <a class="nav-link" href="/staff/order">
                            <div class="sb-nav-link-icon"><i class="fas fa-shopping-cart"></i></div>
                            Orders
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
                                <a class="nav-link" href="/staff/blog">Manage Blogs</a>
                                <a class="nav-link" href="/staff/news">Manage News</a>
                            </nav>
                        </div>

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
