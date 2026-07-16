<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- CyberWorld Header -->
<header class="navbar">
    <div class="container d-flex align-center justify-between">
        <!-- Logo -->
        <div class="logo">
            <c:choose>
                <c:when test="${pageContext.request.isUserInRole('ROLE_OWNER')}">
                    <a href="javascript:void(0)" onclick="return false;" class="d-flex align-center gap-sm" style="cursor: default;">
                        <img src="/images/logo.png" alt="CyberWorld" style="height: 32px;" onerror="this.src='https://via.placeholder.com/32?text=CW'" />
                        <span class="text-primary" style="font-weight: 700; font-size: 1.25rem;">CyberWorld</span>
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="/" class="d-flex align-center gap-sm">
                        <img src="/images/logo.png" alt="CyberWorld" style="height: 32px;" onerror="this.src='https://via.placeholder.com/32?text=CW'" />
                        <span class="text-primary" style="font-weight: 700; font-size: 1.25rem;">CyberWorld</span>
                    </a>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Navigation Links -->
        <nav class="nav-links d-flex align-center">
            <a href="/products" class="active">Laptops</a>
            <a href="/products?category=phones">Phones</a>
            <a href="/products?category=components">Components</a>
            <a href="/products?category=gaming">Gaming</a>
            <a href="/products?category=monitors">Monitors</a>
            <a href="/products?category=accessories">Accessories</a>
        </nav>

        <!-- Right Actions -->
        <div class="d-flex align-center gap-md">
            <!-- Search -->
            <div class="search-bar d-flex align-center" style="background: rgba(255,255,255,0.05); border-radius: var(--radius-xl); padding: 0.35rem 1rem; border: 1px solid var(--border-color);">
                <i class="fas fa-search text-secondary" style="font-size: 0.875rem;"></i>
                <input type="text" placeholder="Search products, brands..." style="padding-left: 0.75rem; font-size: 0.875rem; color: var(--text-primary); width: 220px; background: transparent; border: none; outline: none;">
            </div>

            <c:if test="${not empty pageContext.request.userPrincipal}">
                <a href="/cart" style="position: relative; color: var(--text-secondary); margin-inline: 0.5rem; transition: color var(--transition-fast);">
                    <i class="fas fa-shopping-cart" style="font-size: 1.1rem;"></i>
                    <span style="position: absolute; top: -8px; right: -10px; background: var(--accent-blue); color: white; font-size: 0.65rem; padding: 2px 6px; border-radius: 12px; font-weight: 600;">
                        ${sessionScope.sum != null ? sessionScope.sum : '0'}
                    </span>
                </a>
                
                <div class="dropdown" style="position: relative;">
                    <a href="#" style="color: var(--text-secondary); transition: color var(--transition-fast);" id="userDropdownTrigger">
                        <i class="fas fa-user" style="font-size: 1.1rem;"></i>
                    </a>
                    <!-- Custom Dropdown Menu -->
                    <div class="dropdown-menu" style="display: none; position: absolute; right: 0; top: 100%; margin-top: 1rem; background: var(--bg-card); border: 1px solid var(--border-color); border-radius: var(--radius-md); padding: 1.5rem; width: 260px; z-index: 100; box-shadow: var(--shadow-soft);">
                        <div class="d-flex flex-col align-center text-center">
                            <img style="width: 70px; height: 70px; border-radius: 50%; object-fit: cover; margin-bottom: 0.75rem; border: 2px solid var(--border-color);" src="/images/avatar/${sessionScope.avatar}" onerror="this.src='https://ui-avatars.com/api/?name=${sessionScope.fullName}&background=random'" />
                            <span class="text-primary" style="font-weight: 600; font-size: 1rem;"><c:out value="${sessionScope.fullName}" /></span>
                            <span class="text-secondary" style="font-size: 0.8rem; margin-top: 0.25rem;">Member</span>
                        </div>
                        <hr style="border: none; border-top: 1px solid var(--border-color); margin: 1.25rem 0;">
                        <ul class="d-flex flex-col gap-sm" style="padding: 0;">
                            <li>
                                <c:choose>
                                    <c:when test="${pageContext.request.isUserInRole('ROLE_OWNER')}">
                                        <a href="/admin" class="text-secondary" style="display: block; padding: 0.5rem; border-radius: var(--radius-sm); font-size: 0.875rem;">Manage Account</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="/account/manage" class="text-secondary" style="display: block; padding: 0.5rem; border-radius: var(--radius-sm); font-size: 0.875rem;">Manage Account</a>
                                    </c:otherwise>
                                </c:choose>
                            </li>
                            <li><a href="/order-history" class="text-secondary" style="display: block; padding: 0.5rem; border-radius: var(--radius-sm); font-size: 0.875rem;">Order History</a></li>
                            <li>
                                <form method="post" action="/logout" style="margin: 0;">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <button class="text-secondary" style="display: block; padding: 0.5rem; width: 100%; text-align: left; cursor: pointer; border-radius: var(--radius-sm); font-size: 0.875rem; background: none; border: none;">Logout</button>
                                </form>
                            </li>
                        </ul>
                    </div>
                </div>
            </c:if>
            <c:if test="${empty pageContext.request.userPrincipal}">
                <a href="/login" class="btn btn-primary" style="margin-left: 0.5rem;">Sign In</a>
            </c:if>
        </div>
    </div>
</header>
<!-- Simple inline script for dropdown toggle since we removed bootstrap.js -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const userDropdownTrigger = document.getElementById('userDropdownTrigger');
        if (userDropdownTrigger) {
            userDropdownTrigger.addEventListener('click', function(e) {
                e.preventDefault();
                const menu = this.nextElementSibling;
                if (menu.style.display === 'none' || menu.style.display === '') {
                    menu.style.display = 'block';
                    this.style.color = 'var(--text-primary)';
                } else {
                    menu.style.display = 'none';
                    this.style.color = 'var(--text-secondary)';
                }
            });
            // Click outside to close
            document.addEventListener('click', function(e) {
                if (!userDropdownTrigger.contains(e.target) && !userDropdownTrigger.nextElementSibling.contains(e.target)) {
                    userDropdownTrigger.nextElementSibling.style.display = 'none';
                    userDropdownTrigger.style.color = 'var(--text-secondary)';
                }
            });
            
            // Hover effects on dropdown items
            const dropdownLinks = userDropdownTrigger.nextElementSibling.querySelectorAll('a, button');
            dropdownLinks.forEach(link => {
                link.addEventListener('mouseenter', function() {
                    this.style.backgroundColor = 'rgba(255, 255, 255, 0.05)';
                    this.style.color = 'var(--text-primary)';
                });
                link.addEventListener('mouseleave', function() {
                    this.style.backgroundColor = 'transparent';
                    this.style.color = 'var(--text-secondary)';
                });
            });
        }
    });
</script>