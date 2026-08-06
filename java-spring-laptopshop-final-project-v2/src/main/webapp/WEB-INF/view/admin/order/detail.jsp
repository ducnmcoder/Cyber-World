<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="description" content="Cyber World - Dự án cyberworld" />
                    <meta name="author" content="Cyber World" />
                    <title>Detail Order - Cyber World</title>
                    <link href="/css/styles.css" rel="stylesheet" />

                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                </head>

                <body class="sb-nav-fixed">
                    <jsp:include page="../layout/header.jsp" />
                    <div id="layoutSidenav">
                        <jsp:include page="../layout/sidebar.jsp" />
                        <div id="layoutSidenav_content">
                            <main>
                                <div class="container-fluid px-4">
                                    <h1 class="mt-4">Orders</h1>
                                    <ol class="breadcrumb mb-4">
                                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                        <li class="breadcrumb-item"><a href="/admin/order">Order</a></li>
                                        <li class="breadcrumb-item active">View detail</li>
                                    </ol>
                                    <div class="mt-5">
                                        <div class="row">
                                            <div class="col-12 mx-auto">
                                                <div class="d-flex justify-content-between">
                                                    <h3>Order detail with id = ${id}</h3>
                                                </div>

                                                <hr />

                                                <div class="table-responsive">
                                                    <table class="table">
                                                        <thead>
                                                            <tr>
                                                                <th scope="col">Sản phẩm</th>
                                                                <th scope="col">Tên</th>
                                                                <th scope="col">Price cả</th>
                                                                <th scope="col">Quantity</th>
                                                                <th scope="col">Thành tiền</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:if test="${ empty orderDetails}">
                                                                <tr>
                                                                    <td colspan="6">
                                                                        Không có sản phẩm trong giỏ hàng
                                                                    </td>
                                                                </tr>
                                                            </c:if>
                                                            <c:forEach var="orderDetail" items="${orderDetails}">

                                                                <tr>
                                                                    <th scope="row">
                                                                        <div class="d-flex align-items-center">
                                                                            <img src="${orderDetail.product.firstImage}"
                                                                                class="img-fluid me-5 rounded-circle"
                                                                                style="width: 80px; height: 80px;"
                                                                                alt="">
                                                                        </div>
                                                                    </th>
                                                                    <td>
                                                                        <p class="mb-0 mt-4">
                                                                            <a href="/product/${orderDetail.product.id}"
                                                                                target="_blank">
                                                                                ${orderDetail.product.name}
                                                                            </a>
                                                                        </p>
                                                                    </td>
                                                                    <td>
                                                                        <p class="mb-0 mt-4">
                                                                            <fmt:formatNumber type="number"
                                                                                value="${orderDetail.price}" /> VND
                                                                        </p>
                                                                    </td>
                                                                    <td>
                                                                        <div class="input-group quantity mt-4"
                                                                            style="width: 100px;">
                                                                            <input type="text"
                                                                                class="form-control form-control-sm text-center border-0"
                                                                                value="${orderDetail.quantity}">
                                                                        </div>
                                                                    </td>
                                                                    <td>
                                                                        <p class="mb-0 mt-4"
                                                                            data-cart-detail-id="${orderDetail.id}">
                                                                            <fmt:formatNumber type="number"
                                                                                value="${orderDetail.price * orderDetail.quantity}" />
                                                                            VND
                                                                        </p>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>

                                                        </tbody>
                                                    </table>
                                                </div>
                                                
                                                <div class="row mt-3 mb-4">
                                                    <div class="col-md-6 offset-md-6">
                                                        <div class="card bg-light">
                                                            <div class="card-body">
                                                                <h5 class="card-title">Order Summary</h5>
                                                                <hr/>
                                                                <div class="d-flex justify-content-between mb-2">
                                                                    <span>Subtotal (estimated):</span>
                                                                    <strong><fmt:formatNumber type="number" value="${order.totalPrice + (order.discountAmount != null ? order.discountAmount : 0)}" /> VND</strong>
                                                                </div>
                                                                <c:if test="${order.discountAmount != null and order.discountAmount > 0}">
                                                                    <div class="d-flex justify-content-between mb-2 text-success">
                                                                        <span>Discount (${order.appliedVouchers}):</span>
                                                                        <strong>- <fmt:formatNumber type="number" value="${order.discountAmount}" /> VND</strong>
                                                                    </div>
                                                                </c:if>
                                                                <hr/>
                                                                <div class="d-flex justify-content-between">
                                                                    <span class="fw-bold">Total Paid/COD:</span>
                                                                    <strong class="text-danger" style="font-size: 1.25rem;"><fmt:formatNumber type="number" value="${order.totalPrice}" /> VND</strong>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <c:if test="${order.status == 'REFUND_REQUESTED'}">
                                                    <div class="mt-5 card border-warning mb-3">
                                                        <div class="card-header bg-warning text-dark fw-bold">
                                                            Refund Request Information
                                                        </div>
                                                        <div class="card-body">
                                                            <div class="row mb-2">
                                                                <div class="col-md-3 fw-bold">Customer Name:</div>
                                                                <div class="col-md-9">${order.refundName}</div>
                                                            </div>
                                                            <div class="row mb-2">
                                                                <div class="col-md-3 fw-bold">Phone Number:</div>
                                                                <div class="col-md-9">${order.refundPhone}</div>
                                                            </div>
                                                            <div class="row mb-2">
                                                                <div class="col-md-3 fw-bold">Bank Name:</div>
                                                                <div class="col-md-9">${order.refundBankName}</div>
                                                            </div>
                                                            <div class="row mb-2">
                                                                <div class="col-md-3 fw-bold">Bank Account:</div>
                                                                <div class="col-md-9">${order.refundBankAccount}</div>
                                                            </div>
                                                            <div class="row mb-3">
                                                                <div class="col-md-3 fw-bold">Reason for Refund:</div>
                                                                <div class="col-md-9">${order.refundReason}</div>
                                                            </div>
                                                            <c:if test="${not empty order.refundProofs}">
                                                                <div class="row mb-3">
                                                                    <div class="col-md-3 fw-bold">Evidence (Proofs):</div>
                                                                    <div class="col-md-9 d-flex flex-wrap gap-2">
                                                                        <c:set var="proofs" value="${fn:split(order.refundProofs, ',')}"/>
                                                                        <c:forEach var="proof" items="${proofs}">
                                                                            <c:set var="ext" value="${fn:toLowerCase(fn:substringAfter(proof, '.'))}"/>
                                                                            <a href="/images/refunds/${proof}" target="_blank" class="border rounded p-1 d-inline-block text-center text-decoration-none" style="width: 120px; background: #f8f9fa;">
                                                                                <c:choose>
                                                                                    <c:when test="${ext == 'mp4' || ext == 'webm' || ext == 'ogg' || ext == 'mov'}">
                                                                                        <div style="height:80px; display:flex; align-items:center; justify-content:center; background:#000;">
                                                                                            <i class="fa fa-play-circle text-white fa-2x"></i>
                                                                                        </div>
                                                                                        <div class="small text-truncate mt-1 text-dark" title="${proof}">${proof}</div>
                                                                                    </c:when>
                                                                                    <c:otherwise>
                                                                                        <img src="/images/refunds/${proof}" alt="Proof" style="width: 100%; height: 80px; object-fit: cover;">
                                                                                        <div class="small text-truncate mt-1 text-dark" title="${proof}">${proof}</div>
                                                                                    </c:otherwise>
                                                                                </c:choose>
                                                                            </a>
                                                                        </c:forEach>
                                                                    </div>
                                                                </div>
                                                            </c:if>
                                                            <div class="d-flex gap-2">
                                                                <form action="/admin/order/refund/approve" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to approve this refund? Status will be changed to RETURNED.');">
                                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                                    <input type="hidden" name="orderId" value="${order.id}">
                                                                    <input type="hidden" name="page" value="${page}">
                                                                    <input type="hidden" name="source" value="${source}">
                                                                    <button type="submit" class="btn btn-success me-2">Approve Refund</button>
                                                                </form>
                                                                <form action="/admin/order/refund/reject" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to reject this refund? An email will be sent automatically.');">
                                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                                    <input type="hidden" name="orderId" value="${order.id}">
                                                                    <input type="hidden" name="page" value="${page}">
                                                                    <input type="hidden" name="source" value="${source}">
                                                                    <button type="submit" class="btn btn-danger">Reject Refund</button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>

                                                <div class="mt-5">
                                                    <h4>Payment History</h4>
                                                    <hr/>
                                                    <table class="table table-bordered">
                                                        <thead class="table-light">
                                                            <tr>
                                                                <th>Transaction Ref</th>
                                                                <th>Method</th>
                                                                <th>Status</th>
                                                                <th>Amount</th>
                                                                <th>Date</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:if test="${empty payments}">
                                                                <tr>
                                                                    <td colspan="5" class="text-center">No payment history found.</td>
                                                                </tr>
                                                            </c:if>
                                                            <c:forEach var="payment" items="${payments}">
                                                                <tr>
                                                                    <td>
                                                                        <a href="/admin/payment/${payment.id}" class="text-primary text-decoration-underline">
                                                                            ${payment.transactionRef}
                                                                        </a>
                                                                    </td>
                                                                    <td>${payment.paymentMethod}</td>
                                                                    <td>
                                                                        <c:choose>
                                                                            <c:when test="${payment.paymentStatus == 'PAID'}">
                                                                                <span class="badge bg-success">PAID</span>
                                                                            </c:when>
                                                                            <c:when test="${payment.paymentStatus == 'FAILED'}">
                                                                                <span class="badge bg-danger">FAILED</span>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <span class="badge bg-warning text-dark">PENDING</span>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </td>
                                                                    <td><fmt:formatNumber type="number" value="${payment.amount}" /> VND</td>
                                                                    <td>${payment.createdAt}</td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>

                                                <c:choose>
                                                    <c:when test="${source == 'refund'}">
                                                        <a href="/admin/refund?page=${page}" class="btn btn-secondary mt-3">Back</a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <a href="/admin/order?page=${page}" class="btn btn-secondary mt-3">Back</a>
                                                    </c:otherwise>
                                                </c:choose>

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


