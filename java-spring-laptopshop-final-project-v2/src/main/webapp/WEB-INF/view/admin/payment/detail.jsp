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
                <title>Detail Payment - Cyber World</title>
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
                                <h1 class="mt-4">Payments</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item"><a href="/admin/payment">Payment</a></li>
                                    <li class="breadcrumb-item active">View detail</li>
                                </ol>
                                <div class="mt-5">
                                    <div class="row">
                                        <div class="col-12 mx-auto">
                                            <div class="d-flex justify-content-between">
                                                <h3>Payment detail with id = ${id}</h3>
                                            </div>

                                            <hr />

                                            <div class="card mb-4">
                                                <div class="card-body">
                                                    <div class="row mb-3">
                                                        <div class="col-md-3 fw-bold">Transaction Ref:</div>
                                                        <div class="col-md-9">${payment.transactionRef}</div>
                                                    </div>
                                                    <div class="row mb-3">
                                                        <div class="col-md-3 fw-bold">Gateway Transaction ID:</div>
                                                        <div class="col-md-9">${payment.gatewayTransactionId != null ? payment.gatewayTransactionId : 'N/A'}</div>
                                                    </div>
                                                    <div class="row mb-3">
                                                        <div class="col-md-3 fw-bold">Method:</div>
                                                        <div class="col-md-9">${payment.paymentMethod}</div>
                                                    </div>
                                                    <div class="row mb-3">
                                                        <div class="col-md-3 fw-bold">Status:</div>
                                                        <div class="col-md-9">
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
                                                        </div>
                                                    </div>
                                                    <div class="row mb-3">
                                                        <div class="col-md-3 fw-bold">Amount:</div>
                                                        <div class="col-md-9">
                                                            <fmt:formatNumber type="number" value="${payment.amount}" /> VND
                                                        </div>
                                                    </div>
                                                    <div class="row mb-3">
                                                        <div class="col-md-3 fw-bold">Created At:</div>
                                                        <div class="col-md-9">${payment.createdAt}</div>
                                                    </div>
                                                    <div class="row mb-3">
                                                        <div class="col-md-3 fw-bold">Payment Date (if success):</div>
                                                        <div class="col-md-9">${payment.paymentDate != null ? payment.paymentDate : 'N/A'}</div>
                                                    </div>
                                                    <div class="row mb-3">
                                                        <div class="col-md-3 fw-bold">Associated Order ID:</div>
                                                        <div class="col-md-9">
                                                            <a href="/admin/order/${payment.order.id}" class="text-primary text-decoration-underline">
                                                                #${payment.order.id}
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <a href="/admin/payment?page=${page}" class="btn btn-success mt-3">Back</a>

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
