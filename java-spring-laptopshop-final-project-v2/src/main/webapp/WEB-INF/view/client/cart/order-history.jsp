<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8">
                <title> Order History - Cyber World</title>
                <meta content="width=device-width, initial-scale=1.0" name="viewport">
                <meta content="" name="keywords">
                <meta content="" name="description">

                <!-- Google Web Fonts -->
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link
                    href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                    rel="stylesheet">

                <!-- Icon Font Stylesheet -->
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
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

                <!-- Cart Page Start -->
                <div class="container-fluid py-5">
                    <div class="container py-5">
                        <div class="mb-3">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="/">Home</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Order History</li>
                                </ol>
                            </nav>
                        </div>

                        <c:choose>
                            <c:when test="${empty orders}">
                                <div class="text-center py-5">
                                    <i class="bi bi-bag-x text-muted" style="font-size: 5rem;"></i>
                                    <h4 class="mt-4 text-muted">You haven't placed any orders yet.</h4>
                                    <p class="text-muted">Looks like you haven't made your choice yet...</p>
                                    <a href="/products" class="btn btn-primary mt-3 px-5 py-3 rounded-pill fw-bold shadow-sm">Start Shopping</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="order" items="${orders}">
                                    <div class="card mb-5 shadow-sm border-0 rounded-4 overflow-hidden">
                                        <div class="card-header bg-white d-flex flex-wrap justify-content-between align-items-center py-3 px-4 border-bottom">
                                            <div class="d-flex align-items-center">
                                                <div class="rounded-circle d-flex justify-content-center align-items-center me-3 shadow-sm" style="width: 48px; height: 48px; background-color: #f8f9fa; color: #cd1818; border: 1px solid #eee;">
                                                    <i class="bi bi-box-seam fs-4"></i>
                                                </div>
                                                <div>
                                                    <div class="d-flex align-items-center mb-1">
                                                        <h5 class="mb-0 text-dark fw-bold text-uppercase" style="letter-spacing: 0.5px;">
                                                            CW-${order.id}
                                                        </h5>
                                                        <button class="btn btn-sm text-white ms-3 rounded-pill fw-bold shadow-sm" style="background-color: #cd1818; border: none; font-size: 0.75rem; padding: 4px 12px; transition: background 0.2s;" onmouseover="this.style.backgroundColor='#a01212'" onmouseout="this.style.backgroundColor='#cd1818'">
                                                            <i class="bi bi-truck me-1"></i> TRACKING
                                                        </button>
                                                    </div>
                                                    <small class="text-muted d-block"><i class="bi bi-credit-card me-1"></i>Payment: ${order.paymentMethod != null ? order.paymentMethod : 'COD'}</small>
                                                </div>
                                            </div>
                                            <div class="mt-2 mt-md-0">
                                                <c:choose>
                                                    <c:when test="${order.status == 'SUCCESS' || order.status == 'DELIVERED'}">
                                                        <span class="badge rounded-pill fs-6 fw-bold px-3 py-2 shadow-sm" style="background: #e8f5e9; color: #2e7d32; border: 1px solid #c8e6c9;"><i class="bi bi-check-circle-fill me-1"></i> ${order.status}</span>
                                                    </c:when>
                                                    <c:when test="${order.status == 'CANCELLED' || order.status == 'FAILED'}">
                                                        <span class="badge rounded-pill fs-6 fw-bold px-3 py-2 shadow-sm" style="background: #ffebee; color: #c62828; border: 1px solid #ffcdd2;"><i class="bi bi-x-circle-fill me-1"></i> ${order.status}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge rounded-pill fs-6 fw-bold px-3 py-2 shadow-sm" style="background: #fff8e1; color: #f57f17; border: 1px solid #ffecb3;"><i class="bi bi-clock-fill me-1"></i> ${order.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <div class="card-body p-0">
                                            <div class="table-responsive">
                                                <table class="table table-hover mb-0 align-middle">
                                                    <thead class="table-light text-muted">
                                                        <tr>
                                                            <th scope="col" class="ps-4 py-3 text-uppercase" style="font-size: 0.85rem;">Product</th>
                                                            <th scope="col" class="py-3 text-center text-uppercase" style="font-size: 0.85rem;">Unit Price</th>
                                                            <th scope="col" class="py-3 text-center text-uppercase" style="font-size: 0.85rem;">Quantity</th>
                                                            <th scope="col" class="text-end pe-4 py-3 text-uppercase" style="font-size: 0.85rem;">Subtotal</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="orderDetail" items="${order.orderDetails}">
                                                            <tr>
                                                                <td class="ps-4 py-3">
                                                                    <div class="d-flex align-items-center">
                                                                        <div class="position-relative">
                                                                            <img src="${orderDetail.product.firstImage}" class="img-fluid rounded shadow-sm border" style="width: 80px; height: 80px; object-fit: cover;" alt="${orderDetail.product.name}">
                                                                        </div>
                                                                        <div class="ms-4">
                                                                            <h6 class="mb-1">
                                                                                <a href="/product/${orderDetail.product.id}" class="text-dark fw-bold text-decoration-none" onmouseover="this.style.color='#0d6efd'" onmouseout="this.style.color='#212529'">
                                                                                    ${orderDetail.product.name}
                                                                                </a>
                                                                            </h6>
                                                                            <small class="text-muted">Product ID: #${orderDetail.product.id}</small>
                                                                        </div>
                                                                    </div>
                                                                </td>
                                                                <td class="text-center py-3">
                                                                    <span class="text-muted fw-medium"><fmt:formatNumber type="number" value="${orderDetail.price}" /> ₫</span>
                                                                </td>
                                                                <td class="text-center py-3">
                                                                    <span class="badge bg-light text-dark border px-3 py-2 fs-6 rounded-pill">${orderDetail.quantity}</span>
                                                                </td>
                                                                <td class="text-end pe-4 py-3">
                                                                    <span class="text-dark fw-bold"><fmt:formatNumber type="number" value="${orderDetail.price * orderDetail.quantity}" /> ₫</span>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <div class="card-footer bg-light border-top d-flex flex-wrap justify-content-between align-items-center py-4 px-4">
                                            <div class="text-muted mb-2 mb-md-0">
                                                <small><i class="bi bi-shield-check text-success me-1"></i> Order placed successfully</small>
                                            </div>
                                            <div class="text-end">
                                                <span class="text-muted me-3 text-uppercase fw-semibold" style="letter-spacing: 1px;">Order Total</span>
                                                <span class="fw-bold" style="font-size: 1.5rem; color: #cd1818;"><fmt:formatNumber type="number" value="${order.totalPrice}" /> ₫</span>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>

                    </div>
                </div>
                <!-- Cart Page End -->


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


