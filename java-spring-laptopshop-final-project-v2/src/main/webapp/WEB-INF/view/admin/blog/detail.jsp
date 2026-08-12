<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <title>Blog Detail - Cyber World</title>
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Blog Detail</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item"><a href="/admin/blog">Blog</a></li>
                                    <li class="breadcrumb-item active">View Detail</li>
                                </ol>
                                <div class="mt-5">
                                    <div class="row">
                                        <div class="col-12 mx-auto">
                                            <div class="card">
                                                <div class="card-header">
                                                    <h3>Blog ID: ${id}</h3>
                                                </div>
                                                <div class="card-body">
                                                    <div class="row">
                                                        <div class="col-md-12 mb-4">
                                                            <c:if test="${not empty blog.image}">
                                                                <img src="${blog.displayImage}"
                                                                    class="img-fluid rounded mb-3" alt="${blog.title}" onerror="this.style.display='none'" style="max-height: 400px; object-fit: cover;" />
                                                            </c:if>
                                                            <c:if test="${blog.type == 'VIDEO' and not empty blog.videoUrl}">
                                                                <div class="mb-4">
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
                                                                            <iframe width="100%" height="450" src="https://www.youtube.com/embed/${videoId}" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            <video width="100%" height="450" controls>
                                                                                <source src="${blog.videoUrl}" type="video/mp4">
                                                                                Your browser does not support the video tag.
                                                                            </video>
                                                                        </c:otherwise>
                                                                    </c:choose>
                                                                </div>
                                                            </c:if>
                                                        </div>
                                                        <div class="col-md-12">
                                                            <h4>${blog.title}</h4>
                                                            <hr />
                                                            <p>${blog.content}</p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <a href="/admin/blog" class="btn btn-success mt-3">Back</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </main>
                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>
            </body>

            </html>
