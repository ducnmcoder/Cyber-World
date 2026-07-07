<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>${blog.title} - Cyber World</title>

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
            </head>

            <body>

                <!-- Spinner Start -->
                <div id="spinner"
                    class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                    <div class="spinner-grow text-primary" role="status"></div>
                </div>
                <!-- Spinner End -->

                <jsp:include page="../layout/header.jsp" />

                <!-- Blog Detail Start -->
                <div class="container-fluid py-5 mt-5">
                    <div class="container py-5">
                        <div class="row g-4">
                            <div>
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/">Home</a></li>
                                        <li class="breadcrumb-item"><a href="/blogs">Blog</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">${blog.title}</li>
                                    </ol>
                                </nav>
                            </div>

                            <div class="col-lg-8 mx-auto">
                                <h1 class="mb-4">${blog.title}</h1>
                                <div class="text-muted mb-4">
                                    <i class="fas fa-calendar-alt me-2"></i>
                                    <fmt:parseDate value="${blog.createdAt}" pattern="yyyy-MM-dd'T'HH:mm"
                                        var="parsedDate" type="both" />
                                    <fmt:formatDate value="${parsedDate}" pattern="MMMM dd, yyyy" />
                                </div>
                                <img src="/images/blog/${blog.image}" class="img-fluid rounded mb-4 w-100"
                                    alt="${blog.title}" style="max-height: 450px; object-fit: cover;">
                                <div class="blog-content" style="font-size: 16px; line-height: 1.8;">
                                    <p>${blog.content}</p>
                                </div>
                                <hr class="my-4">
                                <a href="/blogs" class="btn btn-outline-primary rounded-pill px-4">
                                    <i class="fas fa-arrow-left me-2"></i> Back to Blog
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Blog Detail End -->

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
