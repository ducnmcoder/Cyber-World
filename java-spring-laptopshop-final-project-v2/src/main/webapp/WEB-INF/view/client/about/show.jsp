<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>About Us - Cyber World</title>

            <!-- Google Web Fonts -->
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link
                href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                rel="stylesheet">

            <!-- Icon Font Stylesheet -->
            <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                rel="stylesheet">

            <!-- Libraries Stylesheet -->
            <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
            <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

            <!-- Customized Bootstrap Stylesheet -->
            <link href="/client/css/bootstrap.min.css" rel="stylesheet">

            <!-- Template Stylesheet -->
            <link href="/client/css/style.css" rel="stylesheet">

            <meta name="_csrf" content="${_csrf.token}" />
            <meta name="_csrf_header" content="${_csrf.headerName}" />
        </head>

        <body>

            <!-- Spinner Start -->
            <div id="spinner"
                class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                <div class="spinner-grow text-primary" role="status"></div>
            </div>
            <!-- Spinner End -->

            <jsp:include page="../layout/header.jsp" />

            <!-- Page Header Start -->
            <div class="container-fluid page-header py-5">
                <h1 class="text-center text-white display-6">About Us</h1>
                <ol class="breadcrumb justify-content-center mb-0">
                    <li class="breadcrumb-item"><a href="/">Home</a></li>
                    <li class="breadcrumb-item active text-white">About Us</li>
                </ol>
            </div>
            <!-- Page Header End -->

            <!-- About Start -->
            <div class="container-fluid py-5">
                <div class="container py-5">
                    <div class="row g-5 align-items-center">
                        <div class="col-lg-6">
                            <div class="position-relative">
                                <img src="/client/img/hero-img-1.png"
                                    class="img-fluid w-100 rounded" alt="About Cyber World"
                                    style="object-fit: cover;">
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <h1 class="mb-4 text-primary">Welcome to Cyber World</h1>
                            <p class="mb-4" style="font-size: 16px; line-height: 1.8;">
                                <strong>Cyber World</strong> is a store specializing in providing authentic laptops with the most competitive prices in the market. We are committed to bringing customers high-quality products from top global brands.
                            </p>
                            <p class="mb-4" style="font-size: 16px; line-height: 1.8;">
                                With years of experience in the technology field, our team is always ready to advise and assist customers in choosing the most suitable products for their needs.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- About End -->

            <!-- Mission & Vision Start -->
            <div class="container-fluid bg-light py-5">
                <div class="container py-5">
                    <div class="text-center mb-5">
                        <h2 class="text-primary">Mission & Vision</h2>
                    </div>
                    <div class="row g-4">
                        <div class="col-lg-4">
                            <div class="bg-white rounded p-4 text-center h-100 shadow-sm">
                                <div class="mb-4">
                                    <i class="fas fa-bullseye fa-3x text-primary"></i>
                                </div>
                                <h4 class="mb-3">Mission</h4>
                                <p style="line-height: 1.8;">
                                    To provide customers with high-quality laptops at reasonable prices, along with dedicated and professional customer care services.
                                </p>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="bg-white rounded p-4 text-center h-100 shadow-sm">
                                <div class="mb-4">
                                    <i class="fas fa-eye fa-3x text-primary"></i>
                                </div>
                                <h4 class="mb-3">Vision</h4>
                                <p style="line-height: 1.8;">
                                    To become the leading reputable online laptop store in Vietnam, trusted and chosen by customers.
                                </p>
                            </div>
                        </div>
                        <div class="col-lg-4">
                            <div class="bg-white rounded p-4 text-center h-100 shadow-sm">
                                <div class="mb-4">
                                    <i class="fas fa-heart fa-3x text-primary"></i>
                                </div>
                                <h4 class="mb-3">Core Values</h4>
                                <p style="line-height: 1.8;">
                                    Quality - Prestige - Dedication. We always put the interests of our customers first in all activities.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Mission & Vision End -->

            <!-- Why Choose Us Start -->
            <div class="container-fluid py-5">
                <div class="container py-5">
                    <div class="text-center mb-5">
                        <h2 class="text-primary">Why Choose Us?</h2>
                    </div>
                    <div class="row g-4">
                        <div class="col-md-6 col-lg-3">
                            <div class="text-center p-4">
                                <div class="btn-square rounded-circle bg-secondary mb-4 mx-auto"
                                    style="width: 80px; height: 80px; display: flex; align-items: center; justify-content: center;">
                                    <i class="fas fa-check-circle fa-2x text-white"></i>
                                </div>
                                <h5>100% Authentic</h5>
                                <p>We guarantee authentic products with full documentation and warranty.</p>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-3">
                            <div class="text-center p-4">
                                <div class="btn-square rounded-circle bg-secondary mb-4 mx-auto"
                                    style="width: 80px; height: 80px; display: flex; align-items: center; justify-content: center;">
                                    <i class="fas fa-shipping-fast fa-2x text-white"></i>
                                </div>
                                <h5>Fast Delivery</h5>
                                <p>We support express delivery within 2 hours in the inner city.</p>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-3">
                            <div class="text-center p-4">
                                <div class="btn-square rounded-circle bg-secondary mb-4 mx-auto"
                                    style="width: 80px; height: 80px; display: flex; align-items: center; justify-content: center;">
                                    <i class="fas fa-undo fa-2x text-white"></i>
                                </div>
                                <h5>30-Day Returns</h5>
                                <p>Flexible return policy within 30 days.</p>
                            </div>
                        </div>
                        <div class="col-md-6 col-lg-3">
                            <div class="text-center p-4">
                                <div class="btn-square rounded-circle bg-secondary mb-4 mx-auto"
                                    style="width: 80px; height: 80px; display: flex; align-items: center; justify-content: center;">
                                    <i class="fas fa-headset fa-2x text-white"></i>
                                </div>
                                <h5>24/7 Support</h5>
                                <p>Our consulting team is ready to support you anytime, anywhere.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Why Choose Us End -->

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
        </body>

        </html>
