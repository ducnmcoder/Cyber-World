<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="Cyber World - Dự án cyberworld" />
    <meta name="author" content="Cyber World" />
    <title>Manage Vouchers - Cyber World</title>
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
                    <h1 class="mt-4">Manage Vouchers</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                        <li class="breadcrumb-item active">Voucher</li>
                    </ol>
                    <div class="mt-5">
                        <div class="row">
                            <div class="col-12 mx-auto">
                                <div class="d-flex justify-content-between">
                                    <h3>Table Vouchers</h3>
                                    <a href="/admin/voucher/create" class="btn btn-primary">Create a voucher</a>
                                </div>
                                <hr />
                                <table class=" table table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Title</th>
                                            <th>Discount</th>
                                            <th>Applies To</th>
                                            <th>Valid Until</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="voucher" items="${vouchers}" varStatus="loop">
                                            <tr>
                                                <th>${(currentPage - 1) * 5 + loop.count}</th>
                                                <td>${voucher.title}</td>
                                                <td>
                                                    <fmt:formatNumber type="number" value="${voucher.discountAmount}" />
                                                    <c:if test="${voucher.discountType == 'PERCENT'}">%</c:if>
                                                    <c:if test="${voucher.discountType == 'FIXED'}">VND</c:if>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${empty voucher.appliesTo or voucher.appliesTo == 'ALL'}">All Products</c:when>
                                                        <c:otherwise>${voucher.appliesTo}: ${voucher.applyValue}</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>${voucher.validUntil}</td>
                                                <td>
                                                    <span class="badge ${voucher.status == 'ACTIVE' ? 'bg-success' : 'bg-secondary'}">${voucher.status}</span>
                                                </td>
                                                <td>
                                                    <a href="/admin/voucher/update/${voucher.id}" class="btn btn-warning mx-2">Update</a>
                                                    <a href="/admin/voucher/delete/${voucher.id}" class="btn btn-danger">Delete</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <nav aria-label="Page navigation example">
                                    <ul class="pagination justify-content-center">
                                        <li class="page-item">
                                            <a class="${1 eq currentPage ? 'disabled page-link' : 'page-link'}" href="/admin/voucher?page=${currentPage - 1}" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </li>
                                        <c:if test="${totalPages > 0}">
                                            <c:forEach begin="0" end="${totalPages - 1}" varStatus="loop">
                                                <li class="page-item">
                                                    <a class="${(loop.index + 1) eq currentPage ? 'active page-link' : 'page-link'}" href="/admin/voucher?page=${loop.index + 1}">
                                                        ${loop.index + 1}
                                                    </a>
                                                </li>
                                            </c:forEach>
                                        </c:if>
                                        <li class="page-item">
                                            <a class="${(totalPages == 0) or (totalPages eq currentPage) ? 'disabled page-link' : 'page-link'}" href="/admin/voucher?page=${currentPage + 1}" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </li>
                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <jsp:include page="../layout/footer.jsp" />
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <script src="/js/scripts.js"></script>
</body>

</html>
