<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Footer Start -->
<footer style="margin-top: var(--spacing-2xl); border-top: 1px solid var(--border-color); padding-top: var(--spacing-2xl);">
    <div class="container">
        
        <!-- Trusted Brands -->
        <div class="text-center" style="margin-bottom: var(--spacing-2xl);">
            <p class="text-secondary" style="font-size: 0.75rem; letter-spacing: 1px; text-transform: uppercase; margin-bottom: var(--spacing-md);">Trusted Brands We Carry</p>
            <div class="d-flex justify-center align-center flex-wrap gap-md" style="opacity: 0.6;">
                <span style="font-weight: 600; font-size: 0.9rem;">Apple</span>
                <span style="font-weight: 600; font-size: 0.9rem;">ASUS ROG</span>
                <span style="font-weight: 600; font-size: 0.9rem;">NVIDIA</span>
                <span style="font-weight: 600; font-size: 0.9rem;">AMD</span>
                <span style="font-weight: 600; font-size: 0.9rem;">Intel</span>
                <span style="font-weight: 600; font-size: 0.9rem;">Samsung</span>
                <span style="font-weight: 600; font-size: 0.9rem;">Logitech</span>
                <span style="font-weight: 600; font-size: 0.9rem;">Razer</span>
                <span style="font-weight: 600; font-size: 0.9rem;">MSI</span>
                <span style="font-weight: 600; font-size: 0.9rem;">Corsair</span>
            </div>
        </div>

        <!-- Newsletter -->
        <div class="card d-flex align-center justify-between flex-wrap gap-lg" style="padding: var(--spacing-xl); margin-bottom: var(--spacing-2xl); background: rgba(255,255,255,0.02);">
            <div>
                <h3 class="text-primary" style="font-size: 1.5rem; margin-bottom: 0.5rem;">Get drops before anyone else.</h3>
                <p class="text-secondary" style="font-size: 0.875rem;">Newsletter. No spam. Just the best gear straight to your inbox.</p>
            </div>
            <div class="d-flex gap-sm" style="flex: 1; max-width: 400px;">
                <input type="email" placeholder="email@domain.com" style="flex: 1; padding: 0.75rem 1rem; border-radius: var(--radius-md); background: rgba(0,0,0,0.2); border: 1px solid var(--border-color); color: var(--text-primary); font-size: 0.875rem;">
                <button class="btn btn-primary" style="border-radius: var(--radius-md);">Subscribe</button>
            </div>
        </div>

        <!-- Links Grid -->
        <div class="grid grid-cols-5 gap-xl" style="margin-bottom: var(--spacing-2xl);">
            <div style="grid-column: span 2;">
                <a href="/" class="d-flex align-center gap-sm" style="margin-bottom: var(--spacing-md);">
                    <img src="/images/logo.png" alt="CyberWorld" style="height: 32px;" onerror="this.src='https://via.placeholder.com/32?text=CW'" />
                    <span class="text-primary" style="font-weight: 700; font-size: 1.25rem;">CyberWorld</span>
                </a>
                <p class="text-secondary" style="font-size: 0.875rem; max-width: 250px;">Premium tech for builders, gamers and creators.</p>
            </div>
            
            <div>
                <h4 class="text-primary" style="font-size: 0.875rem; margin-bottom: var(--spacing-md);">Shop</h4>
                <ul class="d-flex flex-col gap-sm">
                    <li><a href="/products" class="text-secondary" style="font-size: 0.875rem;">Laptops</a></li>
                    <li><a href="/products?category=phones" class="text-secondary" style="font-size: 0.875rem;">Phones</a></li>
                    <li><a href="/products?category=components" class="text-secondary" style="font-size: 0.875rem;">PC Components</a></li>
                    <li><a href="/products?category=gaming" class="text-secondary" style="font-size: 0.875rem;">Gaming</a></li>
                    <li><a href="/products?category=monitors" class="text-secondary" style="font-size: 0.875rem;">Monitors</a></li>
                    <li><a href="/products?category=accessories" class="text-secondary" style="font-size: 0.875rem;">Accessories</a></li>
                </ul>
            </div>

            <div>
                <h4 class="text-primary" style="font-size: 0.875rem; margin-bottom: var(--spacing-md);">Support</h4>
                <ul class="d-flex flex-col gap-sm">
                    <li><a href="/contact" class="text-secondary" style="font-size: 0.875rem;">Help Center</a></li>
                    <li><a href="/order-history" class="text-secondary" style="font-size: 0.875rem;">Order Status</a></li>
                    <li><a href="#" class="text-secondary" style="font-size: 0.875rem;">Shipping</a></li>
                    <li><a href="#" class="text-secondary" style="font-size: 0.875rem;">Returns</a></li>
                    <li><a href="#" class="text-secondary" style="font-size: 0.875rem;">Warranty</a></li>
                </ul>
            </div>

            <div>
                <h4 class="text-primary" style="font-size: 0.875rem; margin-bottom: var(--spacing-md);">Company</h4>
                <ul class="d-flex flex-col gap-sm">
                    <li><a href="/about" class="text-secondary" style="font-size: 0.875rem;">About CyberWorld</a></li>
                    <li><a href="#" class="text-secondary" style="font-size: 0.875rem;">Careers</a></li>
                    <li><a href="/contact" class="text-secondary" style="font-size: 0.875rem;">Contact</a></li>
                </ul>
            </div>
        </div>

        <!-- Copyright Bar -->
        <div class="d-flex justify-between align-center flex-wrap gap-md" style="padding-top: var(--spacing-lg); padding-bottom: var(--spacing-lg); border-top: 1px solid var(--border-color);">
            <p class="text-secondary" style="font-size: 0.75rem;">&copy; 2026 CyberWorld. All rights reserved.</p>
            <p class="text-secondary" style="font-size: 0.75rem;">Prices in USD. Free shipping on orders over $99.</p>
        </div>
    </div>
</footer>
<!-- Footer End -->