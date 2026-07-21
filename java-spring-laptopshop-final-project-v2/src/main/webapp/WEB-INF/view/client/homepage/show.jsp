<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Home - Cyber World</title>

                <!-- Icon Font Stylesheet -->
                <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />

                <!-- CyberWorld Theme -->
                <link href="/client/css/style.css?v=2" rel="stylesheet">

                <meta name="_csrf" content="${_csrf.token}" />
                <!-- default header name is X-CSRF-TOKEN -->
                <meta name="_csrf_header" content="${_csrf.headerName}" />

                <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.css"
                    rel="stylesheet">

            </head>

            <body>

                <!-- Spinner Start -->
                <div id="spinner"
                    class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                    <div class="spinner-grow text-primary" role="status"></div>
                </div>
                <!-- Spinner End -->

                <jsp:include page="../layout/header.jsp" />


                <jsp:include page="../layout/banner.jsp" />




                <!-- Products Section Start -->
                <section class="section-padding">
                    <div class="container">
                        
                        <!-- Categories Section -->
                        <div style="margin-bottom: var(--spacing-2xl);">
                            <p class="text-accent" style="font-weight: 600; font-size: 0.875rem; text-transform: uppercase; margin-bottom: 0.5rem;">Shop by category</p>
                            <div class="d-flex justify-between align-center flex-wrap gap-md" style="margin-bottom: var(--spacing-xl);">
                                <h2 class="text-primary" style="font-size: 2.5rem; font-weight: 700; m-0">Everything, precisely organised.</h2>
                                <a href="/products" class="text-secondary" style="font-size: 0.875rem; text-decoration: underline;">View all &rarr;</a>
                            </div>
                            
                            <!-- Categories Grid -->
                            <div class="grid grid-cols-4 gap-md">
                                <a href="/products?category=laptops" class="card d-flex justify-between align-center" style="padding: 1.5rem; background: rgba(255,255,255,0.02);">
                                    <div>
                                        <h4 class="text-primary" style="font-size: 1rem; margin-bottom: 0.25rem;">Laptops</h4>
                                        <p class="text-secondary" style="font-size: 0.75rem;">Ultrabooks, gaming rigs, creator machines.</p>
                                    </div>
                                    <i class="fas fa-arrow-right text-secondary" style="opacity: 0.5;"></i>
                                </a>
                                <a href="/products?category=phones" class="card d-flex justify-between align-center" style="padding: 1.5rem; background: rgba(255,255,255,0.02);">
                                    <div>
                                        <h4 class="text-primary" style="font-size: 1rem; margin-bottom: 0.25rem;">Phones</h4>
                                        <p class="text-secondary" style="font-size: 0.75rem;">Flagship smartphones and everyday devices.</p>
                                    </div>
                                    <i class="fas fa-arrow-right text-secondary" style="opacity: 0.5;"></i>
                                </a>
                                <a href="/products?category=components" class="card d-flex justify-between align-center" style="padding: 1.5rem; background: rgba(255,255,255,0.02);">
                                    <div>
                                        <h4 class="text-primary" style="font-size: 1rem; margin-bottom: 0.25rem;">PC Components</h4>
                                        <p class="text-secondary" style="font-size: 0.75rem;">CPUs, GPUs, memory and storage.</p>
                                    </div>
                                    <i class="fas fa-arrow-right text-secondary" style="opacity: 0.5;"></i>
                                </a>
                                <a href="/products?category=gaming" class="card d-flex justify-between align-center" style="padding: 1.5rem; background: rgba(255,255,255,0.02);">
                                    <div>
                                        <h4 class="text-primary" style="font-size: 1rem; margin-bottom: 0.25rem;">Gaming</h4>
                                        <p class="text-secondary" style="font-size: 0.75rem;">Consoles, controllers and gaming gear.</p>
                                    </div>
                                    <i class="fas fa-arrow-right text-secondary" style="opacity: 0.5;"></i>
                                </a>
                            </div>
                        </div>

                        <!-- Featured Products Grid -->
                        <div>
                            <p class="text-accent" style="font-weight: 600; font-size: 0.875rem; text-transform: uppercase; margin-bottom: 0.5rem;">New Drops</p>
                            <h2 class="text-primary" style="font-size: 2.5rem; font-weight: 700; margin-bottom: var(--spacing-xl);">Right now at CyberWorld.</h2>
                            
                            <div class="grid grid-cols-4 gap-lg">
                                <c:forEach var="product" items="${products}">
                                    <div class="card d-flex flex-col" style="position: relative; padding: 1.25rem;">
                                        <!-- Sale Badge & Wishlist -->
                                        <div class="d-flex justify-between align-center" style="margin-bottom: 1rem; z-index: 2;">
                                            <span style="background: var(--accent-blue); color: white; padding: 0.2rem 0.5rem; border-radius: var(--radius-sm); font-size: 0.7rem; font-weight: 700; box-shadow: var(--glow-blue);">SALE</span>
                                            <i class="far fa-heart text-secondary" style="cursor: pointer; transition: color 0.2s;"></i>
                                        </div>
                                        
                                        <!-- Product Image (Centered) -->
                                        <a href="/product/${product.id}" style="display: block; text-align: center; margin-bottom: 1.5rem; height: 180px; display: flex; align-items: center; justify-content: center; position: relative;">
                                            <!-- Subtle glow behind image -->
                                            <div style="position: absolute; width: 60%; height: 60%; background: var(--accent-blue); opacity: 0.1; filter: blur(30px); border-radius: 50%;"></div>
                                            <img src="/images/product/${product.image}" alt="${product.name}" style="max-height: 100%; max-width: 100%; object-fit: contain; position: relative; z-index: 1;" onerror="this.src='https://via.placeholder.com/200?text=Product+Image'">
                                        </a>

                                        <!-- Product Info -->
                                        <div class="d-flex flex-col gap-sm" style="flex: 1;">
                                            <span class="text-secondary" style="font-size: 0.7rem; text-transform: uppercase; font-weight: 600; letter-spacing: 0.5px;">${product.factory}</span>
                                            <a href="/product/${product.id}">
                                                <h4 class="text-primary" style="font-size: 1rem; line-height: 1.4; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; margin-bottom: 0;">${product.name}</h4>
                                            </a>
                                            <p class="text-secondary" style="font-size: 0.75rem; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden; margin-bottom: 0;">${product.shortDesc}</p>
                                            
                                            <!-- Rating placeholder -->
                                            <div class="d-flex align-center gap-xs" style="margin-bottom: 0.5rem;">
                                                <i class="fas fa-star" style="color: #FBBF24; font-size: 0.75rem;"></i>
                                                <span class="text-primary" style="font-size: 0.8rem; font-weight: 600;">4.8</span>
                                                <span class="text-secondary" style="font-size: 0.75rem;">(124 reviews)</span>
                                            </div>
                                        </div>

                                        <!-- Price and Action -->
                                        <div class="d-flex justify-between align-center" style="margin-top: 1rem; padding-top: 1rem; border-top: 1px solid rgba(255,255,255,0.05);">
                                            <div class="d-flex align-center gap-sm">
                                                <h4 class="text-primary" style="font-size: 1.25rem; font-weight: 700; margin-bottom: 0;">
                                                    $<fmt:formatNumber type="number" value="${product.price}" />
                                                </h4>
                                                <span class="text-secondary" style="text-decoration: line-through; font-size: 0.8rem;">$<fmt:formatNumber type="number" value="${product.price + 100}" /></span>
                                            </div>
                                            <button data-product-id="${product.id}" class="btnAddToCartHomepage" style="background: rgba(255,255,255,0.05); color: var(--text-primary); border-radius: 50%; width: 36px; height: 36px; display: flex; align-items: center; justify-content: center; cursor: pointer; transition: all 0.2s;" onmouseover="this.style.background='var(--accent-blue)'; this.style.color='white';" onmouseout="this.style.background='rgba(255,255,255,0.05)'; this.style.color='var(--text-primary)';">
                                                <i class="fas fa-plus"></i>
                                            </button>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>

                    </div>
                </section>
                <!-- Products Section End-->

                <jsp:include page="../layout/feature.jsp" />

                <jsp:include page="../layout/footer.jsp" />


                <!-- Back to Top -->
                <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                        class="fa fa-arrow-up"></i></a>


                <!-- JavaScript Libraries -->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                <script src="/client/lib/easing/easing.min.js"></script>
                <script src="/client/lib/waypoints/waypoints.min.js"></script>
                <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

                <!-- Template Javascript -->
                <script src="/client/js/main.js"></script>
                <script
                    src="https://cdnjs.cloudflare.com/ajax/libs/jquery-toast-plugin/1.3.2/jquery.toast.min.js"></script>
            </body>

            </html>
