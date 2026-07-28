<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600&family=Orbitron:wght@900&display=swap" rel="stylesheet">
        <style>
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
        </style>
        <nav class="sb-topnav navbar navbar-expand navbar-dark" style="background-color: #cd1818;">
            <!-- Navbar Brand-->
            <c:choose>
                <c:when test="${pageContext.request.isUserInRole('ROLE_ADMIN')}">
                    <span class="navbar-brand ps-3 d-flex align-items-center" style="cursor: default;">
                        <img src="/images/logo.png" alt="Logo" style="height: 50px; margin-right: 15px;" />
                        <div class="cyber-logo-text">
                            <span class="cyber-logo-title">CYBER</span>
                            <span class="cyber-logo-title">WORLD</span>
                        </div>
                    </span>
                </c:when>
                <c:otherwise>
                    <a href="/" class="navbar-brand ps-3 d-flex align-items-center" style="text-decoration: none;">
                        <img src="/images/logo.png" alt="Logo" style="height: 50px; margin-right: 15px;" />
                        <div class="cyber-logo-text">
                            <span class="cyber-logo-title">CYBER</span>
                            <span class="cyber-logo-title">WORLD</span>
                        </div>
                    </a>
                </c:otherwise>
            </c:choose>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i
                    class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">
                <span style="color: white;">Welcome,
                    <%=request.getUserPrincipal().getName().toString()%>

                </span>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button"
                        data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <li>
                            <c:choose>
                                <c:when test="${pageContext.request.isUserInRole('ROLE_OWNER')}">
                                    <a class="dropdown-item" href="/admin">Manage Account</a>
                                </c:when>
                                <c:otherwise>
                                    <a class="dropdown-item" href="/account/manage">Manage Account</a>
                                </c:otherwise>
                            </c:choose>
                        </li>

                        <li>
                            <hr class="dropdown-divider" />
                        </li>
                        <li>
                            <form method="post" action="/logout">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <button class="dropdown-item">Logout</button>
                            </form>
                        </li>
                    </ul>
                </li>
            </ul>
        </nav>
