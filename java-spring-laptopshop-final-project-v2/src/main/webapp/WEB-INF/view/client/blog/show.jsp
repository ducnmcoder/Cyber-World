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
                    <style>
                        .cyber-blog-card {
                            border: 1px solid transparent;
                            transition: all 0.3s ease;
                            border-radius: 12px;
                            overflow: hidden;
                            background: #fff;
                            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
                        }
                        .cyber-blog-card:hover {
                            transform: translateY(-5px);
                            box-shadow: 0 10px 25px rgba(205, 24, 24, 0.15);
                            border-color: #cd1818;
                        }
                        .cyber-blog-img-wrapper {
                            overflow: hidden;
                            position: relative;
                        }
                        .cyber-blog-img {
                            transition: transform 0.5s ease;
                        }
                        .cyber-blog-card:hover .cyber-blog-img {
                            transform: scale(1.05);
                        }
                        .cyber-blog-title a {
                            color: #212529;
                            transition: color 0.3s ease;
                            font-weight: 700;
                            font-size: 1.1rem;
                        }
                        .cyber-blog-card:hover .cyber-blog-title a {
                            color: #cd1818;
                        }
                        .cyber-btn-readmore {
                            background: transparent;
                            color: #cd1818;
                            border: 2px solid #cd1818;
                            border-radius: 25px;
                            padding: 8px 20px;
                            font-weight: 600;
                            transition: all 0.3s ease;
                            text-decoration: none;
                            display: inline-block;
                        }
                        .cyber-btn-readmore:hover {
                            background: #cd1818;
                            color: #fff;
                        }
                        .cyber-pagination {
                            display: flex;
                            flex-direction: row;
                            justify-content: center;
                            align-items: center;
                            list-style: none;
                            padding: 0;
                            gap: 5px;
                        }
                        .cyber-pagination .page-item {
                            display: inline-block;
                        }
                        ul.cyber-pagination .page-link {
                            color: #cd1818;
                            background-color: #fff;
                            border-radius: 5px;
                            border: 1px solid #dee2e6;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            min-width: 40px;
                            height: 40px;
                            padding: 0 10px;
                            text-decoration: none;
                        }
                        ul.cyber-pagination .page-link.disabled {
                            color: #6c757d;
                            pointer-events: none;
                            background-color: #f8f9fa;
                            border-color: #dee2e6;
                        }
                        ul.cyber-pagination .active .page-link {
                            background-color: #cd1818 !important;
                            border-color: #cd1818 !important;
                            color: white !important;
                        }
                        ul.cyber-pagination .page-link:hover {
                            background-color: #f8f9fa !important;
                            color: #a01010 !important;
                            border-color: #cd1818 !important;
                        }
                        ul.cyber-pagination .active .page-link:hover {
                            background-color: #cd1818 !important;
                            color: white !important;
                        }
                        .cyber-play-icon {
                            transition: transform 0.3s ease;
                        }
                        .cyber-blog-card:hover .cyber-play-icon {
                            transform: translate(-50%, -50%) scale(1.1) !important;
                        }
                    </style>
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
                                            <c:choose>
                                                <c:when test="${isNewsPage}">
                                                    <li class="breadcrumb-item active" aria-current="page">News</li>
                                                </c:when>
                                                <c:otherwise>
                                                    <li class="breadcrumb-item active" aria-current="page">Blog</li>
                                                </c:otherwise>
                                            </c:choose>
                                        </ol>
                                    </nav>
                                </div>

                                <div class="col-lg-12 text-start">
                                            <c:choose>
                                                <c:when test="${isNewsPage}">
                                                    <h1>Latest News</h1>
                                                    <p class="text-muted">Stay updated with the latest news.</p>
                                                </c:when>
                                                <c:otherwise>
                                                    <h1>Our Blog</h1>
                                                    <p class="text-muted">Stay updated with the latest tech news, guides, and tips.</p>
                                                </c:otherwise>
                                            </c:choose>
                                </div>

                                <c:if test="${empty blogs}">
                                    <div class="col-12 text-center">
                                        <p>No blog posts found.</p>
                                    </div>
                                </c:if>

                                <c:forEach var="blog" items="${blogs}">
                                    <div class="col-md-6 col-lg-4">
                                        <div class="card h-100 cyber-blog-card">
                                            <c:choose>
                                                <c:when test="${blog.type == 'VIDEO' and not empty blog.videoUrl}">
                                                    <c:set var="thumbnailUrl" value="/images/logo.png" />
                                                    <c:choose>
                                                        <c:when test="${fn:contains(blog.videoUrl, 'youtube.com') or fn:contains(blog.videoUrl, 'youtu.be')}">
                                                            <c:set var="videoId" value="" />
                                                            <c:if test="${fn:contains(blog.videoUrl, 'v=')}">
                                                                <c:set var="videoId" value="${fn:substringAfter(blog.videoUrl, 'v=')}" />
                                                                <c:if test="${fn:contains(videoId, '&')}">
                                                                    <c:set var="videoId" value="${fn:substringBefore(videoId, '&')}" />
                                                                </c:if>
                                                            </c:if>
                                                            <c:if test="${fn:contains(blog.videoUrl, 'youtu.be/')}">
                                                                <c:set var="videoId" value="${fn:substringAfter(blog.videoUrl, 'youtu.be/')}" />
                                                                <c:if test="${fn:contains(videoId, '?')}">
                                                                    <c:set var="videoId" value="${fn:substringBefore(videoId, '?')}" />
                                                                </c:if>
                                                            </c:if>
                                                            <c:if test="${fn:contains(blog.videoUrl, '/shorts/')}">
                                                                <c:set var="videoId" value="${fn:substringAfter(blog.videoUrl, '/shorts/')}" />
                                                                <c:if test="${fn:contains(videoId, '?')}">
                                                                    <c:set var="videoId" value="${fn:substringBefore(videoId, '?')}" />
                                                                </c:if>
                                                            </c:if>
                                                            <c:set var="thumbnailUrl" value="https://img.youtube.com/vi/${videoId}/hqdefault.jpg" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:set var="thumbnailUrl" value="/images/logo.png" />
                                                        </c:otherwise>
                                                    </c:choose>
                                                    
                                                    <c:if test="${not empty blog.image}">
                                                        <c:set var="thumbnailUrl" value="${blog.displayImage}" />
                                                    </c:if>
                                                    
                                                    <div class="position-relative cyber-blog-img-wrapper">
                                                        <img src="${thumbnailUrl}" class="card-img-top cyber-blog-img" alt="${blog.title}" onerror="this.onerror=null;this.src='/images/logo.png';" style="height: 220px; object-fit: cover;">
                                                        <div class="position-absolute top-50 start-50 translate-middle cyber-play-icon" style="transform: translate(-50%, -50%);">
                                                            <i class="fas fa-play-circle text-white opacity-75" style="font-size: 4rem; text-shadow: 0 0 15px rgba(0,0,0,0.8);"></i>
                                                        </div>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="cyber-blog-img-wrapper">
                                                        <img src="${blog.displayImage}" class="card-img-top cyber-blog-img"
                                                            alt="${blog.title}"
                                                            onerror="this.onerror=null;this.src='/images/logo.png';"
                                                            style="height: 220px; object-fit: cover;">
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                            <div class="card-body d-flex flex-column" style="padding: 1.5rem;">
                                                <h5 class="card-title cyber-blog-title mb-3">
                                                    <a href="/blog/${blog.id}" class="text-decoration-none">
                                                        ${blog.title}
                                                    </a>
                                                </h5>
                                                <div class="card-text text-muted mb-4" style="font-size: 14.5px; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; line-height: 1.6;">
                                                    ${blog.content}
                                                </div>
                                                <div class="mt-auto text-end">
                                                    <a href="/blog/${blog.id}"
                                                        class="cyber-btn-readmore">
                                                        Read More <i class="fas fa-arrow-right ms-1"></i>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>

                                <!-- Pagination -->
                                <c:if test="${totalPages > 1}">
                                    <div class="col-12 mt-5">
                                        <nav aria-label="Blog pagination">
                                            <ul class="pagination justify-content-center cyber-pagination">
                                                <c:forEach begin="0" end="${totalPages - 1}" varStatus="loop">
                                                    <li class="page-item ${((loop.index + 1) eq currentPage) ? 'active' : ''}">
                                                        <a class="page-link"
                                                            href="${isNewsPage ? '/news' : '/blogs'}?page=${loop.index + 1}">
                                                            ${loop.index + 1}
                                                        </a>
                                                    </li>
                                                </c:forEach>
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
