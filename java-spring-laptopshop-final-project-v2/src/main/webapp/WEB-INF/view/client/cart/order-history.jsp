<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
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
                                        <a href="/products"
                                            class="btn btn-primary mt-3 px-5 py-3 rounded-pill fw-bold shadow-sm">Start
                                            Shopping</a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="order" items="${orders}">
                                        <div class="card mb-5 shadow-sm border-0 rounded-4 overflow-hidden">
                                            <div
                                                class="card-header bg-white d-flex flex-wrap justify-content-between align-items-center py-3 px-4 border-bottom">
                                                <div class="d-flex align-items-center">
                                                    <div class="rounded-circle d-flex justify-content-center align-items-center me-3 shadow-sm"
                                                        style="width: 48px; height: 48px; background-color: #f8f9fa; color: #cd1818; border: 1px solid #eee;">
                                                        <i class="bi bi-box-seam fs-4"></i>
                                                    </div>
                                                    <div>
                                                        <div class="d-flex align-items-center mb-1">
                                                            <h5 class="mb-0 text-dark fw-bold text-uppercase me-2"
                                                                style="letter-spacing: 0.5px;">
                                                                CW-${order.id}
                                                            </h5>
                                                            <c:if test="${order.status != 'PENDING'}">
                                                                <button
                                                                    class="btn btn-sm btn-danger px-2 py-0 fw-bold d-flex align-items-center"
                                                                    style="font-size: 0.7rem; letter-spacing: 0.5px;"
                                                                    data-bs-toggle="modal"
                                                                    data-bs-target="#trackingModal-${order.id}">
                                                                    <i class="bi bi-truck me-1"></i> TRACKING
                                                                </button>
                                                            </c:if>
                                                        </div>
                                                        <small class="text-muted d-block mb-1"><i
                                                                class="bi bi-calendar-check me-1"></i>Date: ${order.getFormattedCreatedAt()}</small>
                                                        <small class="text-muted d-block"><i
                                                                class="bi bi-credit-card me-1"></i>Payment:
                                                            ${order.paymentMethod != null ? order.paymentMethod :
                                                            'COD'}</small>
                                                    </div>
                                                </div>
                                                <div class="mt-2 mt-md-0 d-flex gap-2 align-items-center">
                                                    <c:if test="${order.status == 'COMPLETE'}">
                                                        <button class="btn btn-sm btn-outline-danger rounded-pill fw-bold px-3 py-2 shadow-sm" data-bs-toggle="modal" data-bs-target="#refundModal-${order.id}">
                                                            REFUND
                                                        </button>
                                                    </c:if>
                                                    <c:if test="${order.status == 'PENDING'}">
                                                        <button class="btn btn-sm btn-outline-danger rounded-pill fw-bold px-3 py-2 shadow-sm" data-bs-toggle="modal" data-bs-target="#cancelModal-${order.id}">
                                                            CANCEL ORDER
                                                        </button>
                                                    </c:if>
                                                    <c:choose>
                                                        <c:when
                                                            test="${order.status == 'SUCCESS' || order.status == 'DELIVERED'}">
                                                            <span
                                                                class="badge rounded-pill fs-6 fw-bold px-3 py-2 shadow-sm"
                                                                style="background: #e8f5e9; color: #2e7d32; border: 1px solid #c8e6c9;"><i
                                                                    class="bi bi-check-circle-fill me-1"></i>
                                                                ${order.status}</span>
                                                        </c:when>
                                                        <c:when
                                                            test="${order.status == 'CANCELLED' || order.status == 'FAILED' || order.status == 'REFUND_REJECTED'}">
                                                            <span
                                                                class="badge rounded-pill fs-6 fw-bold px-3 py-2 shadow-sm"
                                                                style="background: #ffebee; color: #c62828; border: 1px solid #ffcdd2;"><i
                                                                    class="bi bi-x-circle-fill me-1"></i>
                                                                ${order.status}</span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'REFUND_REQUESTED'}">
                                                            <span class="badge rounded-pill fs-6 fw-bold px-3 py-2 shadow-sm" style="background: #e3f2fd; color: #1565c0; border: 1px solid #bbdefb;">
                                                                <i class="bi bi-arrow-return-left me-1"></i> REFUND_REQUESTED
                                                            </span>
                                                        </c:when>
                                                        <c:when test="${order.status == 'RETURNED'}">
                                                            <span class="badge rounded-pill fs-6 fw-bold px-3 py-2 shadow-sm" style="background: #e8f5e9; color: #2e7d32; border: 1px solid #c8e6c9;">
                                                                <i class="bi bi-check-circle-fill me-1"></i> RETURNED
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span
                                                                class="badge rounded-pill fs-6 fw-bold px-3 py-2 shadow-sm"
                                                                style="background: #fff8e1; color: #f57f17; border: 1px solid #ffecb3;"><i
                                                                    class="bi bi-clock-fill me-1"></i>
                                                                ${order.status}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                            <div class="card-body p-0">
                                                <div class="table-responsive">
                                                    <table class="table table-hover mb-0 align-middle">
                                                        <thead class="table-light text-muted">
                                                            <tr>
                                                                <th scope="col" class="ps-4 py-3 text-uppercase"
                                                                    style="font-size: 0.85rem;">Product</th>
                                                                <th scope="col" class="py-3 text-center text-uppercase"
                                                                    style="font-size: 0.85rem;">Unit Price</th>
                                                                <th scope="col" class="py-3 text-center text-uppercase"
                                                                    style="font-size: 0.85rem;">Quantity</th>
                                                                <th scope="col"
                                                                    class="text-end pe-4 py-3 text-uppercase"
                                                                    style="font-size: 0.85rem;">Subtotal</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach var="orderDetail" items="${order.orderDetails}">
                                                                <tr style="cursor: pointer;"
                                                                    onclick="if(!event.target.closest('a')) { $('#orderDetailModal-${order.id}').modal('show'); }">
                                                                    <td class="ps-4 py-3">
                                                                        <div class="d-flex align-items-center">
                                                                            <div class="position-relative">
                                                                                <img src="${orderDetail.product.firstImage}"
                                                                                    class="img-fluid rounded shadow-sm border"
                                                                                    style="width: 80px; height: 80px; object-fit: cover;"
                                                                                    alt="${orderDetail.product.name}">
                                                                            </div>
                                                                            <div class="ms-4">
                                                                                <h6 class="mb-1">
                                                                                    <a href="/product/${orderDetail.product.id}"
                                                                                        class="text-dark fw-bold text-decoration-none"
                                                                                        onmouseover="this.style.color='#0d6efd'"
                                                                                        onmouseout="this.style.color='#212529'">
                                                                                        ${orderDetail.product.name}
                                                                                    </a>
                                                                                </h6>

                                                                            </div>
                                                                        </div>
                                                                    </td>
                                                                    <td class="text-center py-3">
                                                                        <span class="text-muted fw-medium">
                                                                            <fmt:formatNumber type="number"
                                                                                value="${orderDetail.price}" /> VND
                                                                        </span>
                                                                    </td>
                                                                    <td class="text-center py-3">
                                                                        <span
                                                                            class="badge bg-light text-dark border px-3 py-2 fs-6 rounded-pill">${orderDetail.quantity}</span>
                                                                    </td>
                                                                    <td class="text-end pe-4 py-3">
                                                                        <span class="text-dark fw-bold">
                                                                            <fmt:formatNumber type="number"
                                                                                value="${orderDetail.price * orderDetail.quantity}" />
                                                                            VND
                                                                        </span>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <div
                                                class="card-footer bg-light border-top d-flex flex-wrap justify-content-between align-items-center py-4 px-4">
                                                <div class="text-muted mb-2 mb-md-0">
                                                    <small><i class="bi bi-shield-check text-success me-1"></i> Order
                                                        placed
                                                        successfully</small>
                                                </div>
                                                <div class="text-end">
                                                    <c:if test="${order.discountAmount != null and order.discountAmount > 0}">
                                                        <div class="mb-1">
                                                            <span class="text-muted me-3" style="font-size: 0.9rem;">Discount (${order.appliedVouchers})</span>
                                                            <span class="text-success fw-bold" style="font-size: 1rem;">
                                                                - <fmt:formatNumber type="number" value="${order.discountAmount}" /> VND
                                                            </span>
                                                        </div>
                                                    </c:if>
                                                    <span class="text-muted me-3 text-uppercase fw-semibold"
                                                        style="letter-spacing: 1px;">Order Total</span>
                                                    <span class="fw-bold" style="font-size: 1.5rem; color: #cd1818;">
                                                        <fmt:formatNumber type="number" value="${order.totalPrice}" />
                                                        VND
                                                    </span>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Tracking Modal -->
                                        <div class="modal fade" id="trackingModal-${order.id}" tabindex="-1"
                                            aria-labelledby="trackingModalLabel-${order.id}" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered" style="max-width: 450px;">
                                                <div class="modal-content border-0 shadow">
                                                    <!-- Header -->
                                                    <div class="modal-header border-bottom-0 pb-0">
                                                        <h5 class="modal-title fw-bold text-dark"
                                                            style="color: #000000 !important;"
                                                            id="trackingModalLabel-${order.id}">Tracking Information
                                                        </h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                            aria-label="Close"></button>
                                                    </div>

                                                    <div class="modal-body pb-4 pt-3">
                                                        <div class="d-flex flex-column align-items-center text-center">
                                                            <i class="bi bi-truck mb-3"
                                                                style="font-size: 3.5rem; color: #de1111;"></i>

                                                            <div class="w-100 bg-light p-3 rounded-3 mb-3 text-start border"
                                                                style="border-color: #f3f4f6 !important;">
                                                                <c:choose>
                                                                    <c:when test="${not empty order.trackingCode}">
                                                                        <div
                                                                            class="d-flex justify-content-between align-items-center mb-2">
                                                                            <span
                                                                                class="text-muted small text-uppercase fw-bold"
                                                                                style="color: #000000 !important;">Shipping
                                                                                Provider</span>
                                                                            <span class="fw-bold fs-6">
                                                                                <c:choose>
                                                                                    <c:when
                                                                                        test="${fn:containsIgnoreCase(order.trackingCode, 'GHN')}">
                                                                                        <span
                                                                                            class="badge px-3 py-1 rounded-pill"
                                                                                            style="background-color: #fb923c;">Giao
                                                                                            HÃƒÂ ng Nhanh (GHN)</span>
                                                                                    </c:when>
                                                                                    <c:when
                                                                                        test="${fn:containsIgnoreCase(order.trackingCode, 'VTP') || fn:containsIgnoreCase(order.trackingCode, 'VIETTEL')}">
                                                                                        <span
                                                                                            class="badge px-3 py-1 rounded-pill"
                                                                                            style="background-color: #ef4444;">Viettel
                                                                                            Post</span>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <span
                                                                                            class="badge px-3 py-1 rounded-pill"
                                                                                            style="background-color: #de1111;">Standard
                                                                                            Express</span>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </span>
                                                                        </div>
                                                                        <hr
                                                                            class="my-2 border-secondary border-opacity-10">
                                                                        <div
                                                                            class="d-flex justify-content-between align-items-center mt-2">
                                                                            <span
                                                                                class="text-muted small text-uppercase fw-bold"
                                                                                style="color: #000000 !important;">Tracking
                                                                                Code</span>
                                                                            <div class="d-flex align-items-center">
                                                                                <h6 class="mb-0 fw-bold text-dark me-2"
                                                                                    style="color: #000000 !important;">
                                                                                    ${order.trackingCode}</h6>
                                                                                <button
                                                                                    class="btn btn-sm p-0 text-decoration-none"
                                                                                    style="color: #000000;"
                                                                                    onclick="navigator.clipboard.writeText('${order.trackingCode}')"
                                                                                    title="Copy tracking code">
                                                                                    <i class="bi bi-clipboard fs-5"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <div class="text-center py-2">
                                                                            <span class="text-muted">Tracking
                                                                                information is updating...</span>
                                                                        </div>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>

                                                            <div class="d-flex flex-column w-100 gap-2 mt-2">
                                                                <c:choose>
                                                                    <c:when test="${order.shippingProvider == 'GHN'}">
                                                                        <a href="https://ghn.vn/" target="_blank"
                                                                            class="btn w-100 fw-bold shadow-sm py-2 mb-2"
                                                                            style="background-color: #fb923c; color: white; border-radius: 8px;">
                                                                            <i
                                                                                class="bi bi-box-arrow-up-right me-2"></i>GHN
                                                                            (Giao Hàng Nhanh)
                                                                        </a>
                                                                    </c:when>
                                                                    <c:when test="${order.shippingProvider == 'VTP'}">
                                                                        <a href="https://en.viettelpost.com.vn/"
                                                                            target="_blank"
                                                                            class="btn btn-danger w-100 fw-bold shadow-sm py-2"
                                                                            style="border-radius: 8px;">
                                                                            <i
                                                                                class="bi bi-box-arrow-up-right me-2"></i>VTP
                                                                            (Viettel Post)
                                                                        </a>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <a href="https://ghn.vn/" target="_blank"
                                                                            class="btn w-100 fw-bold shadow-sm py-2 mb-2"
                                                                            style="background-color: #fb923c; color: white; border-radius: 8px;">
                                                                            <i
                                                                                class="bi bi-box-arrow-up-right me-2"></i>GHN
                                                                            (Giao Hàng Nhanh)
                                                                        </a>
                                                                        <a href="https://en.viettelpost.com.vn/"
                                                                            target="_blank"
                                                                            class="btn btn-danger w-100 fw-bold shadow-sm py-2"
                                                                            style="border-radius: 8px;">
                                                                            <i
                                                                                class="bi bi-box-arrow-up-right me-2"></i>VTP
                                                                            (Viettel Post)
                                                                        </a>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Order Detail Modal -->
                                        <div class="modal fade" id="orderDetailModal-${order.id}" tabindex="-1"
                                            aria-labelledby="orderDetailModalLabel-${order.id}" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered modal-lg">
                                                <div class="modal-content border-0 rounded-4 shadow"
                                                    style="background-color: #f8f9fa;">

                                                    <div class="modal-header d-flex justify-content-between align-items-center border-bottom-0 pb-0"
                                                        style="padding: 15px 20px;">
                                                        <div class="d-flex align-items-center text-danger"
                                                            style="cursor: pointer;" data-bs-dismiss="modal">
                                                            <i class="bi bi-arrow-left fs-4 me-2"></i>
                                                            <h5 class="mb-0 fw-bold text-dark">Order Information</h5>
                                                        </div>
                                                    </div>

                                                    <div class="modal-body" style="padding: 15px 20px;">
                                                        <!-- Header Status -->
                                                        <div class="rounded-3 p-3 mb-3 d-flex justify-content-between align-items-center text-white shadow-sm"
                                                            style="background-color: #c4080e;">
                                                            <h5 class="mb-0 fw-bold"
                                                                style="color: rgb(228, 177, 26) !important;"><i
                                                                    class="bi bi-box-seam me-2"></i>${order.status}</h5>
                                                            <span class="small opacity-75">Thank you for shopping with
                                                                Cyber World</span>
                                                        </div>

                                                        <!-- Delivery Information -->
                                                        <div class="bg-white rounded-3 p-3 mb-3 shadow-sm position-relative">
                                                            <div class="d-flex justify-content-between align-items-center mb-3">
                                                                <h6 class="fw-bold mb-0" style="color: #000000;">Delivery Information</h6>
                                                                <c:if test="${order.status == 'PENDING'}">
                                                                    <div class="d-flex flex-column align-items-end">
                                                                        <button type="button" class="btn btn-sm btn-outline-primary edit-delivery-btn mb-1" data-bs-toggle="modal" data-bs-target="#editDeliveryModal-${order.id}">
                                                                            <i class="bi bi-pencil me-1"></i> Edit
                                                                        </button>
                                                                        <span class="text-danger small fw-bold countdown-timer" id="countdown-${order.id}" data-created-at="${order.formattedCreatedAt}"></span>
                                                                    </div>
                                                                </c:if>
                                                            </div>
                                                            <div class="d-flex">
                                                                <i class="bi bi-geo-alt fs-4 text-muted me-3 mt-1"></i>
                                                                <div>
                                                                    <p class="mb-1"><span
                                                                            class="text-muted me-2">Name:</span> <strong
                                                                            style="color: #2d3748;">${order.receiverName}</strong>
                                                                    </p>
                                                                    <p class="mb-1"><span
                                                                            class="text-muted me-2">Phone:</span>
                                                                        <strong
                                                                            style="color: #2d3748;">${order.receiverPhone}</strong>
                                                                    </p>
                                                                    <p class="mb-0"><span
                                                                            class="text-muted me-2">Address:</span>
                                                                        <strong
                                                                            style="color: #2d3748;">${order.receiverAddress}</strong>
                                                                    </p>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <!-- Products -->
                                                        <div class="bg-white rounded-3 p-3 mb-3 shadow-sm">
                                                            <h6 class="fw-bold mb-3 border-bottom pb-2"
                                                                style="color: black !important;"><i
                                                                    class="bi bi-shop me-2"></i>Cyber World Official
                                                            </h6>
                                                            <c:forEach var="detail" items="${order.orderDetails}">
                                                                <div class="d-flex mb-3">
                                                                    <img src="${detail.product.firstImage}"
                                                                        class="rounded border"
                                                                        style="width: 70px; height: 70px; object-fit: cover;">
                                                                    <div class="ms-3 w-100">
                                                                        <h6 class="mb-1 text-truncate"
                                                                            style="max-width: 300px; color: black !important;">
                                                                            ${detail.product.name}</h6>
                                                                        <div
                                                                            class="d-flex justify-content-between align-items-center mt-2">
                                                                            <span
                                                                                class="text-muted small">x${detail.quantity}</span>
                                                                            <span class="fw-bold">
                                                                                <fmt:formatNumber type="number"
                                                                                    value="${detail.price}" /> VND
                                                                            </span>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </c:forEach>
                                                            <div
                                                                class="d-flex justify-content-between align-items-center border-top pt-3 mt-2">
                                                                <span class="text-muted">Total amount:</span>
                                                                <span class="fw-bold fs-5" style="color: #cd1818;">
                                                                    <fmt:formatNumber type="number"
                                                                        value="${order.totalPrice}" /> VND
                                                                </span>
                                                            </div>
                                                        </div>

                                                        <!-- Support Links -->
                                                        <div
                                                            class="bg-white rounded-3 p-0 mb-3 shadow-sm list-group list-group-flush">
                                                            <div class="p-3 border-bottom">
                                                                <h6 class="fw-bold mb-0"
                                                                    style="color: black !important;">Need help?</h6>
                                                            </div>
                                                            <a href="/contact"
                                                                class="list-group-item list-group-item-action d-flex justify-content-between align-items-center p-3 text-muted">
                                                                <span><i class="bi bi-chat-dots me-2"></i>Contact
                                                                    Shop</span>
                                                                <i class="bi bi-chevron-right"></i>
                                                            </a>

                                                        </div>

                                                        <!-- Order Info -->
                                                        <div
                                                            class="bg-white rounded-3 p-3 mb-3 shadow-sm text-muted small">
                                                            <div class="d-flex justify-content-between mb-2">
                                                                <span>Order ID</span>
                                                                <span class="text-dark fw-bold">CW-${order.id}</span>
                                                            </div>
                                                            <div class="d-flex justify-content-between mb-2">
                                                                <span>Date</span>
                                                                <span class="text-dark">${order.getFormattedCreatedAt()}</span>
                                                            </div>
                                                            <div class="d-flex justify-content-between">
                                                                <span>Payment Method</span>
                                                                <span class="text-dark">${order.paymentMethod != null ?
                                                                    order.paymentMethod : 'COD'}</span>
                                                            </div>
                                                        </div>

                                                        <!-- Action Buttons -->
                                                        <div class="d-flex justify-content-between">
                                                            <c:choose>
                                                                <c:when
                                                                    test="${order.status == 'COMPLETE' || order.status == 'DELIVERED' || order.status == 'SUCCESS'}">
                                                                    <a href="/product/${order.orderDetails[0].product.id}#reviews-section"
                                                                        class="btn btn-outline-dark rounded-pill w-100 me-2 py-2 fw-bold"
                                                                        style="color: rgb(8, 7, 6) !important; border-color: black !important;"
                                                                        onclick="$('#orderDetailModal-${order.id}').modal('hide');">Reviews</a>
                                                                </c:when>
                                                                <c:when test="${order.status == 'PENDING'}">
                                                                    <button
                                                                        class="btn btn-outline-danger rounded-pill w-100 me-2 py-2 fw-bold"
                                                                        style="color: #cd1818 !important; border-color: #cd1818 !important;"
                                                                        data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#cancelModal-${order.id}">Cancel Order</button>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <button
                                                                        class="btn btn-outline-dark rounded-pill w-100 me-2 py-2 fw-bold"
                                                                        style="color: black !important; border-color: black !important;"
                                                                        data-bs-dismiss="modal">Close</button>
                                                                </c:otherwise>
                                                            </c:choose>
                                                            <a href="/product/${order.orderDetails[0].product.id}"
                                                                class="btn btn-danger rounded-pill w-100 ms-2 py-2 fw-bold"
                                                                style="background-color: #cd1818;"
                                                                onclick="$('#orderDetailModal-${order.id}').modal('hide');">Buy Again</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Edit Delivery Modal -->
                                        <div class="modal fade" id="editDeliveryModal-${order.id}" tabindex="-1" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content border-0 shadow">
                                                    <div class="modal-header border-bottom-0 pb-0">
                                                        <h5 class="modal-title fw-bold text-dark">Edit Delivery Information</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <form action="/update-delivery-info" method="POST">
                                                        <div class="modal-body pb-4 pt-3">
                                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                            <input type="hidden" name="orderId" value="${order.id}" />
                                                            
                                                            <div class="mb-3">
                                                                <label class="form-label fw-bold">Receiver Name</label>
                                                                <input type="text" class="form-control" name="receiverName" value="${order.receiverName}" required>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label class="form-label fw-bold">Receiver Phone</label>
                                                                <input type="text" class="form-control" name="receiverPhone" value="${order.receiverPhone}" required>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label class="form-label fw-bold">Receiver Address</label>
                                                                <textarea class="form-control" name="receiverAddress" rows="3" required>${order.receiverAddress}</textarea>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer border-top-0 pt-0">
                                                            <button type="button" class="btn btn-light rounded-pill px-4 fw-bold" data-bs-dismiss="modal">Cancel</button>
                                                            <button type="submit" class="btn btn-primary rounded-pill px-4 fw-bold">Save Changes</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Refund Modal -->
                                        <div class="modal fade" id="refundModal-${order.id}" tabindex="-1" aria-labelledby="refundModalLabel-${order.id}" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content border-0 shadow">
                                                    <div class="modal-header border-bottom-0 pb-0">
                                                        <h5 class="modal-title fw-bold text-dark" id="refundModalLabel-${order.id}">Refund Request</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body pb-4 pt-3">
                                                        <form action="/order/refund" method="POST" enctype="multipart/form-data" id="refundForm-${order.id}">
                                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                            <input type="hidden" name="orderId" value="${order.id}">
                                                            <div class="mb-3">
                                                                <label class="form-label fw-bold">Order Code</label>
                                                                <input type="text" class="form-control bg-light" value="CW-${order.id}" readonly>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label class="form-label fw-bold">Waybill Code</label>
                                                                <input type="text" class="form-control bg-light" name="trackingCode" value="${order.trackingCode}" readonly>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label class="form-label fw-bold">Name</label>
                                                                <input type="text" class="form-control" name="name" required placeholder="Enter your name">
                                                            </div>
                                                            <div class="mb-3">
                                                                <label class="form-label fw-bold">Phone Number</label>
                                                                <input type="text" class="form-control" name="phone" required placeholder="Enter your phone number">
                                                            </div>
                                                            <div class="mb-3">
                                                                <label class="form-label fw-bold">Bank Name</label>
                                                                <input type="text" class="form-control" name="bankName" required placeholder="Enter your bank name (e.g. Vietcombank)">
                                                            </div>
                                                            <div class="mb-3">
                                                                <label class="form-label fw-bold">Bank Account Number (to receive refund)</label>
                                                                <input type="text" class="form-control" name="bankAccount" required placeholder="Enter your bank account number">
                                                            </div>
                                                            <div class="mb-3">
                                                                <label class="form-label fw-bold">Reason for Refund</label>
                                                                <textarea class="form-control" name="reason" rows="3" required placeholder="Please provide the reason for your refund request"></textarea>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label class="form-label fw-bold">Proof (Images/Videos, max 5, up to 200MB)</label>
                                                                <div class="input-group">
                                                                    <label class="input-group-text btn btn-outline-secondary" for="proofsInput-${order.id}" style="cursor: pointer;">Choose Files</label>
                                                                    <input type="file" class="form-control d-none" id="proofsInput-${order.id}" name="proofs" accept="image/*,video/*" multiple onchange="updateFileLabel(this, '${order.id}'); validateFiles(this);">
                                                                    <input type="text" class="form-control bg-white" id="proofsText-${order.id}" placeholder="No file chosen" readonly onclick="document.getElementById('proofsInput-${order.id}').click();" style="cursor: pointer;">
                                                                </div>
                                                                <div class="form-text text-danger" id="fileError-${order.id}" style="display: none;"></div>
                                                            </div>
                                                            <div class="d-grid mt-4">
                                                                <button type="submit" class="btn btn-danger py-2 fw-bold" style="background-color: #cd1818;">Send Request</button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Cancel Modal -->
                                        <div class="modal fade" id="cancelModal-${order.id}" tabindex="-1" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content border-0 shadow">
                                                    <div class="modal-header border-bottom-0 pb-0">
                                                        <h5 class="modal-title fw-bold text-dark">Cancel Order</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <form action="/order/cancel" method="POST">
                                                        <div class="modal-body pb-4 pt-3">
                                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                            <input type="hidden" name="orderId" value="${order.id}" />
                                                            
                                                            <div class="alert alert-warning rounded-3 mb-4">
                                                                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                                                <strong>Warning:</strong> Are you sure you want to cancel this order? This action cannot be undone.
                                                            </div>

                                                            <div class="mb-3">
                                                                <label class="form-label fw-bold">Cancellation Reason <span class="text-danger">*</span></label>
                                                                <textarea class="form-control" name="reason" rows="3" required placeholder="Please let us know why you are cancelling..."></textarea>
                                                            </div>
                                                            
                                                            <c:if test="${order.paymentMethod != 'COD'}">
                                                                <div class="alert alert-info rounded-3 mt-3">
                                                                    <i class="bi bi-info-circle-fill me-2"></i>
                                                                    Since you paid online via <strong>${order.paymentMethod}</strong>, please provide your bank details below for the refund process.
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label class="form-label fw-bold">Bank Name <span class="text-danger">*</span></label>
                                                                    <input type="text" class="form-control" name="refundBankName" required placeholder="e.g. Vietcombank, Techcombank...">
                                                                </div>
                                                                <div class="mb-3">
                                                                    <label class="form-label fw-bold">Bank Account Number <span class="text-danger">*</span></label>
                                                                    <input type="text" class="form-control" name="refundBankAccount" required placeholder="Enter your account number">
                                                                </div>
                                                                <div class="row">
                                                                    <div class="col-md-6 mb-3">
                                                                        <label class="form-label fw-bold">Account Holder Name <span class="text-danger">*</span></label>
                                                                        <input type="text" class="form-control" name="refundName" required value="${order.receiverName}">
                                                                    </div>
                                                                    <div class="col-md-6 mb-3">
                                                                        <label class="form-label fw-bold">Phone Number <span class="text-danger">*</span></label>
                                                                        <input type="text" class="form-control" name="refundPhone" required value="${order.receiverPhone}">
                                                                    </div>
                                                                </div>
                                                            </c:if>
                                                        </div>
                                                        <div class="modal-footer border-top-0 pt-0">
                                                            <button type="button" class="btn btn-light rounded-pill px-4 fw-bold" data-bs-dismiss="modal">Keep Order</button>
                                                            <button type="submit" class="btn btn-danger rounded-pill px-4 fw-bold">Confirm Cancel</button>
                                                        </div>
                                                    </form>
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
                    
                    <script>
                        // Fix for modal staying open when navigating back (bfcache)
                        window.addEventListener('pageshow', function () {
                            // Unconditionally close any open modal on page show
                            var openModals = document.querySelectorAll('.modal.show');
                            openModals.forEach(function(modal) {
                                modal.classList.remove('show');
                                modal.style.display = 'none';
                            });
                            
                            var backdrops = document.querySelectorAll('.modal-backdrop');
                            backdrops.forEach(function(backdrop) {
                                backdrop.remove();
                            });
                            
                            document.body.classList.remove('modal-open');
                            document.body.style.paddingRight = '';
                            document.body.style.overflow = '';
                        });

                        function validateFiles(input) {
                            var errorDiv = input.nextElementSibling;
                            if (input.files.length > 5) {
                                errorDiv.textContent = 'You can only upload a maximum of 5 files.';
                                errorDiv.style.display = 'block';
                                input.value = ''; // clear
                                updateFileLabel(input, input.id.split('-')[1]);
                                return;
                            }
                            
                            var maxSize = 200 * 1024 * 1024; // 200MB
                            for (var i = 0; i < input.files.length; i++) {
                                if (input.files[i].size > maxSize) {
                                    errorDiv.textContent = 'Each file must not exceed 200MB.';
                                    errorDiv.style.display = 'block';
                                    input.value = ''; // clear
                                    updateFileLabel(input, input.id.split('-')[1]);
                                    return;
                                }
                            }
                            errorDiv.style.display = 'none';
                        }
                        function updateFileLabel(input, orderId) {
                            var textInput = document.getElementById('proofsText-' + orderId);
                            if (input.files && input.files.length > 0) {
                                textInput.value = input.files.length + " file(s) selected";
                            } else {
                                textInput.value = "";
                            }
                        }

                        // Countdown logic for Delivery Info Edit
                        const timers = document.querySelectorAll('.countdown-timer');
                        timers.forEach(timer => {
                            const createdAtStr = timer.getAttribute('data-created-at');
                            if (!createdAtStr) return;
                            
                            // Parse 'dd-MM-yyyy HH:mm'
                            const parts = createdAtStr.split(/[\s-:]+/);
                            if (parts.length < 5) return;
                            
                            const day = parseInt(parts[0], 10);
                            const month = parseInt(parts[1], 10) - 1;
                            const year = parseInt(parts[2], 10);
                            const hour = parseInt(parts[3], 10);
                            const minute = parseInt(parts[4], 10);
                            
                            const createdAt = new Date(year, month, day, hour, minute);
                            const deadline = new Date(createdAt.getTime() + 6 * 60 * 60 * 1000); // + 6 hours

                            function updateCountdown() {
                                const now = new Date();
                                const diff = deadline - now;
                                
                                if (diff <= 0 || isNaN(diff)) {
                                    timer.innerHTML = "Expired";
                                    // Disable the edit button
                                    const btn = timer.previousElementSibling;
                                    if(btn && btn.classList.contains('edit-delivery-btn')) {
                                        btn.disabled = true;
                                        btn.classList.add('disabled');
                                    }
                                    return;
                                }

                                const hours = Math.floor(diff / (1000 * 60 * 60));
                                const mins = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
                                const secs = Math.floor((diff % (1000 * 60)) / 1000);

                                timer.innerHTML = '<i class="bi bi-clock me-1"></i>' + hours + 'h ' + mins + 'm ' + secs + 's';
                            }
                            
                            updateCountdown();
                            setInterval(updateCountdown, 1000);
                        });
                    </script>

                    <!-- Success Popup -->
                    <c:if test="${not empty successMessage}">
                        <div class="modal fade" id="successModal" tabindex="-1" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered modal-sm">
                                <div class="modal-content text-center py-4 rounded-3 border-0 shadow">
                                    <div class="modal-body">
                                        <div class="mb-3">
                                            <i class="fa fa-check-circle text-danger" style="font-size: 4rem;"></i>
                                        </div>
                                        <h5 class="mb-3 fw-bold">${successMessage}</h5>
                                        <button type="button" class="btn btn-danger px-4" data-bs-dismiss="modal">OK</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <script>
                            document.addEventListener("DOMContentLoaded", function() {
                                var successModal = new bootstrap.Modal(document.getElementById('successModal'));
                                successModal.show();
                            });
                        </script>
                    </c:if>
                </body>

                </html>