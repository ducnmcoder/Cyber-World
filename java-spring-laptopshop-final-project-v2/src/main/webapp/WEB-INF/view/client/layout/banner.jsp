<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Hero Section Start -->
<section class="section-padding" style="position: relative; overflow: hidden; padding-top: var(--spacing-2xl); padding-bottom: var(--spacing-2xl);">
    <!-- Background Glow -->
    <div style="position: absolute; top: -10%; right: -10%; width: 50vw; height: 50vw; background: radial-gradient(circle, rgba(59,130,246,0.1) 0%, rgba(10,15,29,0) 70%); z-index: -1;"></div>

    <div class="container">
        <div class="grid grid-cols-2 gap-2xl align-center" style="min-height: 70vh;">
            
            <!-- Left Content -->
            <div class="d-flex flex-col gap-lg">
                <p class="text-accent" style="font-weight: 600; letter-spacing: 1px; font-size: 0.875rem; text-transform: uppercase;">CyberWorld Premium Gear</p>
                <h1 style="font-size: clamp(3rem, 5vw, 4.5rem); font-weight: 800; line-height: 1.1; letter-spacing: -0.02em;">
                    The <span class="text-gradient">tech</span><br/>you actually want.
                </h1>
                <p class="text-secondary" style="font-size: 1.125rem; max-width: 500px; line-height: 1.6;">
                    Laptops, phones, PC components and gaming gear — curated from the brands you trust. Shipped fast, backed by real support.
                </p>
                
                <div class="d-flex align-center gap-md" style="margin-top: var(--spacing-sm);">
                    <a href="/products" class="btn btn-primary" style="padding: 0.75rem 1.5rem; font-size: 1rem;">
                        Shop the collection <i class="fas fa-arrow-right" style="margin-left: 0.5rem;"></i>
                    </a>
                    <a href="/products?sale=true" class="btn btn-outline" style="padding: 0.75rem 1.5rem; font-size: 1rem;">
                        Explore deals
                    </a>
                </div>

                <div class="d-flex align-center gap-xl" style="margin-top: var(--spacing-xl); padding-top: var(--spacing-lg); border-top: 1px solid var(--border-color);">
                    <div>
                        <h4 class="text-primary" style="font-size: 1.5rem; font-weight: 700; margin-bottom: 0.25rem;">100+</h4>
                        <p class="text-secondary" style="font-size: 0.875rem;">Brands</p>
                    </div>
                    <div>
                        <h4 class="text-primary" style="font-size: 1.5rem; font-weight: 700; margin-bottom: 0.25rem;">30+</h4>
                        <p class="text-secondary" style="font-size: 0.875rem;">Stores</p>
                    </div>
                    <div>
                        <h4 class="text-primary" style="font-size: 1.5rem; font-weight: 700; margin-bottom: 0.25rem;">24/7</h4>
                        <p class="text-secondary" style="font-size: 0.875rem;">Support</p>
                    </div>
                </div>
            </div>

            <!-- Right Content (Hero Card) -->
            <div style="position: relative;">
                <div class="card" style="padding: var(--spacing-xl); background: linear-gradient(145deg, #1A243D, #131B2F); border: 1px solid rgba(255,255,255,0.1); position: relative; z-index: 2; transform: perspective(1000px) rotateY(-5deg) rotateX(5deg); box-shadow: -20px 20px 40px rgba(0,0,0,0.5), 0 0 40px rgba(59,130,246,0.2); transition: transform 0.5s ease;">
                    <div class="d-flex justify-between align-center" style="margin-bottom: var(--spacing-xl);">
                        <span style="background: var(--accent-blue); color: white; padding: 0.25rem 0.75rem; border-radius: var(--radius-sm); font-size: 0.75rem; font-weight: 700;">SALE</span>
                        <i class="fas fa-heart text-secondary" style="cursor: pointer;"></i>
                    </div>
                    
                    <div style="height: 250px; display: flex; justify-content: center; align-items: center; margin-bottom: var(--spacing-xl);">
                        <!-- Placeholder for hero image. Mockup shows a sleek screen/laptop -->
                        <div style="width: 80%; height: 70%; background: linear-gradient(to bottom right, #374151, #111827); border-radius: var(--radius-md); box-shadow: 0 10px 20px rgba(0,0,0,0.5); border: 1px solid #4B5563; display: flex; justify-content: center; align-items: center;">
                             <div style="width: 95%; height: 90%; background: linear-gradient(to right, #0ea5e9, #6366f1); opacity: 0.8; border-radius: 4px;"></div>
                        </div>
                    </div>

                    <div class="text-center" style="margin-bottom: var(--spacing-lg);">
                        <h3 class="text-primary" style="font-size: 1.5rem; font-weight: 600;">MacBook Pro 14" M4</h3>
                        <p class="text-secondary" style="font-size: 0.875rem;">14.2" Liquid Retina XDR, M4 Pro, 18GB, 512GB SSD</p>
                    </div>

                    <div class="d-flex justify-between align-center" style="padding-top: var(--spacing-md); border-top: 1px solid var(--border-color);">
                        <div>
                            <span class="text-secondary" style="font-size: 0.75rem; text-decoration: line-through;">$1999</span>
                            <h4 class="text-primary" style="font-size: 1.5rem; font-weight: 700;">$1899</h4>
                        </div>
                        <a href="#" class="btn" style="background: white; color: var(--bg-dark); font-weight: 600; padding: 0.5rem 1rem;">View</a>
                    </div>
                </div>
                
                <!-- Decorative Elements -->
                <div style="position: absolute; top: -20px; right: -20px; width: 100px; height: 100px; background: var(--accent-blue); filter: blur(60px); opacity: 0.3; z-index: 1;"></div>
            </div>

        </div>
    </div>
</section>
<!-- Hero Section End -->