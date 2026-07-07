<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Blog - Cyber World</title>

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

                    <!-- Blog List Start -->
                    <div class="container-fluid py-5 mt-5">
                        <div class="container py-5">
                            <div class="row g-4 mb-5">
                                <div>
                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb">
                                            <li class="breadcrumb-item"><a href="/">Home</a></li>
                                            <li class="breadcrumb-item active" aria-current="page">Blog</li>
                                        </ol>
                                    </nav>
                                </div>

                                <div class="col-lg-12 text-start">
                                    <h1>Our Blog</h1>
                                    <p class="text-muted">Stay updated with the latest tech news, guides, and tips.</p>
                                </div>

                                <c:if test="${empty blogs}">
                                    <div class="col-12 text-center">
                                        <p>No blog posts found.</p>
                                    </div>
                                </c:if>

                                <c:forEach var="blog" items="${blogs}">
                                    <div class="col-md-6 col-lg-4">
                                        <div class="card h-100 shadow-sm border-0">
                                            <img src="/images/blog/${blog.image}" class="card-img-top"
                                                alt="${blog.title}"
                                                style="height: 220px; object-fit: cover;">
                                            <div class="card-body d-flex flex-column">
                                                <h5 class="card-title">
                                                    <a href="/blog/${blog.id}" class="text-decoration-none text-dark">
                                                        ${blog.title}
                                                    </a>
                                                </h5>
                                                <p class="card-text text-muted" style="font-size: 14px;">
                                                    ${fn:substring(blog.content, 0, 150)}...
                                                </p>
                                                <div class="mt-auto">
                                                    <a href="/blog/${blog.id}"
                                                        class="btn btn-primary btn-sm rounded-pill px-3">
                                                        Read More <i class="fas fa-arrow-right ms-1"></i>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>

                                <!-- Pagination -->
                                <c:if test="${totalPages > 0}">
                                    <div class="col-12">
                                        <nav aria-label="Blog pagination">
                                            <ul class="pagination justify-content-center">
                                                <li class="page-item">
                                                    <a class="${1 eq currentPage ? 'disabled page-link' : 'page-link'}"
                                                        href="/blogs?page=${currentPage - 1}" aria-label="Previous">
                                                        <span aria-hidden="true">&laquo;</span>
                                                    </a>
                                                </li>
                                                <c:forEach begin="0" end="${totalPages - 1}" varStatus="loop">
                                                    <li class="page-item">
                                                        <a class="${(loop.index + 1) eq currentPage ? 'active page-link' : 'page-link'}"
                                                            href="/blogs?page=${loop.index + 1}">
                                                            ${loop.index + 1}
                                                        </a>
                                                    </li>
                                                </c:forEach>
                                                <li class="page-item">
                                                    <a class="${totalPages eq currentPage ? 'disabled page-link' : 'page-link'}"
                                                        href="/blogs?page=${currentPage + 1}" aria-label="Next">
                                                        <span aria-hidden="true">&raquo;</span>
                                                    </a>
                                                </li>
                                            </ul>
                                        </nav>
                                    </div>
                                </c:if>

                            </div>
                        </div>
                    </div>
                    <!-- Blog List End -->

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
