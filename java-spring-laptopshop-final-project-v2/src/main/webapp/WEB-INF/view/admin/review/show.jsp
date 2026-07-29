<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <title>Manage Reviews - Cyber World Admin</title>
    <link href="/css/styles.css" rel="stylesheet"/>
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
<jsp:include page="../layout/header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="../layout/sidebar.jsp"/>
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Manage Reviews</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active">Reviews</li>
                </ol>

                <c:if test="${not empty success}">
                    <div class="alert alert-success">${success}</div>
                </c:if>

                <div class="card mb-4">
                    <div class="card-header">
                        <i class="fas fa-table me-1"></i>
                        List of Reviews
                    </div>
                    <div class="card-body">
                        <table class="table table-bordered table-striped table-hover">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Product</th>
                                <th>User</th>
                                <th>Rating</th>
                                <th>Content</th>
                                <th>Status</th>
                                <th>Reply</th>
                                <th>Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="review" items="${reviews}">
                                <tr>
                                    <td>${review.id}</td>
                                    <td><a href="/product/${review.product.id}" target="_blank">${review.product.name}</a></td>
                                    <td>${review.user.fullName} (${review.user.email})</td>
                                    <td>
                                        <span class="text-warning">
                                            <c:forEach begin="1" end="5" var="i">
                                                <i class="fa-${review.rating >= i ? 'solid' : 'regular'} fa-star"></i>
                                            </c:forEach>
                                        </span>
                                    </td>
                                    <td>${review.content}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${review.status == 'PENDING'}">
                                                <span class="badge bg-warning text-dark">PENDING</span>
                                            </c:when>
                                            <c:when test="${review.status == 'APPROVED'}">
                                                <span class="badge bg-success">APPROVED</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger">REJECTED</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${review.reply}</td>
                                    <td>
                                        <div class="d-flex gap-2">
                                            <c:if test="${review.status != 'APPROVED'}">
                                                <form action="/admin/review/approve/${review.id}" method="post">
                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                    <button type="submit" class="btn btn-sm btn-success" title="Approve"><i class="fas fa-check"></i></button>
                                                </form>
                                            </c:if>
                                            <c:if test="${review.status != 'REJECTED'}">
                                                <form action="/admin/review/reject/${review.id}" method="post">
                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                    <button type="submit" class="btn btn-sm btn-danger" title="Reject"><i class="fas fa-times"></i></button>
                                                </form>
                                            </c:if>
                                            <button type="button" class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#replyModal${review.id}" title="Reply">
                                                <i class="fas fa-reply"></i>
                                            </button>
                                        </div>

                                        <!-- Reply Modal -->
                                        <div class="modal fade" id="replyModal${review.id}" tabindex="-1" aria-labelledby="replyModalLabel${review.id}" aria-hidden="true">
                                            <div class="modal-dialog">
                                                <div class="modal-content">
                                                    <form action="/admin/review/reply/${review.id}" method="post">
                                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                        <div class="modal-header">
                                                            <h5 class="modal-title" id="replyModalLabel${review.id}">Reply to Review #${review.id}</h5>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="mb-3">
                                                                <label class="form-label fw-bold">Review Content:</label>
                                                                <p class="text-muted">${review.content}</p>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label class="form-label fw-bold">Your Reply:</label>
                                                                <textarea name="reply" class="form-control" rows="3" required>${review.reply}</textarea>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                            <button type="submit" class="btn btn-primary">Save Reply</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        
                        <!-- Pagination -->
                        <c:if test="${totalPages > 1}">
                            <nav aria-label="Page navigation">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                        <a class="page-link" href="?page=${currentPage - 1}">Previous</a>
                                    </li>
                                    <c:forEach begin="1" end="${totalPages}" var="i">
                                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                                            <a class="page-link" href="?page=${i}">${i}</a>
                                        </li>
                                    </c:forEach>
                                    <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                        <a class="page-link" href="?page=${currentPage + 1}">Next</a>
                                    </li>
                                </ul>
                            </nav>
                        </c:if>
                    </div>
                </div>
            </div>
        </main>
        <jsp:include page="../layout/footer.jsp"/>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
</body>
</html>
