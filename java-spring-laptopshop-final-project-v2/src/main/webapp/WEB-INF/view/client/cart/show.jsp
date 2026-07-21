<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8">
                    <title> Cart - Cyber World</title>
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
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                        rel="stylesheet">

                    <!-- Libraries Stylesheet -->
                    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
                    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


                    <!-- Customized Bootstrap Stylesheet -->
                    <link href="/client/css/bootstrap.min.css" rel="stylesheet">

                    <!-- Template Stylesheet -->
                    <link href="/client/css/style.css" rel="stylesheet">

                    <!-- Premium Cart Styles -->
                    <style>
                        body { background-color: #f8f9fa; font-family: 'Inter', sans-serif; }
                        .cyber-cart-container { background: #fff; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); overflow: hidden; margin-bottom: 30px; }
                        .cyber-cart-table thead { background: #cd1818; color: #fff; }
                        .cyber-cart-table th { font-weight: 600; padding: 15px; border: none; text-transform: uppercase; font-size: 14px; }
                        .cyber-cart-table td { vertical-align: middle; padding: 20px 15px; border-bottom: 1px solid #eee; }
                        .cyber-product-name { color: #333; font-weight: 600; font-size: 16px; text-decoration: none; transition: 0.2s; }
                        .cyber-product-name:hover { color: #cd1818; }
                        .cyber-qty-btn { background: #f1f1f1; color: #333; border: none; width: 35px; height: 35px; border-radius: 5px; font-weight: bold; transition: 0.2s; }
                        .cyber-qty-btn:hover { background: #e2e2e2; }
                        .cyber-qty-input { width: 50px; text-align: center; border: 1px solid #ddd; border-radius: 5px; font-weight: 600; }
                        .cyber-delete-btn { background: #ff4d4f; color: #fff; border: none; width: 35px; height: 35px; border-radius: 5px; transition: 0.2s; }
                        .cyber-delete-btn:hover { background: #ff2528; }
                        .cyber-summary-box { background: #fff; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); padding: 30px; }
                        .cyber-summary-title { font-size: 22px; font-weight: 700; color: #111; border-bottom: 2px solid #eee; padding-bottom: 15px; margin-bottom: 20px; }
                        .cyber-summary-row { display: flex; justify-content: space-between; margin-bottom: 15px; font-size: 16px; color: #555; }
                        .cyber-summary-total { display: flex; justify-content: space-between; margin-top: 20px; padding-top: 20px; border-top: 2px solid #eee; font-size: 20px; font-weight: 700; color: #cd1818; }
                        .cyber-checkout-btn { background: #cd1818; color: #fff; border: none; padding: 15px 30px; font-size: 18px; font-weight: 600; border-radius: 8px; width: 100%; margin-top: 25px; transition: 0.3s; text-transform: uppercase; letter-spacing: 1px; }
                        .cyber-checkout-btn:hover { background: #a81010; color: #fff; transform: translateY(-2px); box-shadow: 0 4px 10px rgba(205, 24, 24, 0.3); }
                        .breadcrumb-item a { color: #cd1818; text-decoration: none; font-weight: 600; }
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

                    <!-- Cart Page Start -->
                    <div class="container-fluid py-5">
                        <div class="container py-5">
                            <div class="mb-3">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Cart Details</li>
                                    </ol>
                                </nav>
                            </div>
                            <div class="cyber-cart-container table-responsive">
                                <table class="table cyber-cart-table mb-0">
                                    <thead>
                                        <tr>
                                            <th scope="col">Product</th>
                                            <th scope="col">Product Name</th>
                                            <th scope="col">Unit Price</th>
                                            <th scope="col">Quantity</th>
                                            <th scope="col">Total Price</th>
                                            <th scope="col">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${ empty cartDetails}">
                                            <tr>
                                                <td colspan="6" class="text-center py-5">
                                                    <div style="font-size: 50px; color: #ddd; margin-bottom: 15px;"><i class="fa-solid fa-cart-shopping"></i></div>
                                                    <h5 style="color: #666;">Your cart is empty</h5>
                                                    <a href="/" class="btn" style="background: #cd1818; color: white; margin-top: 15px; padding: 10px 25px; border-radius: 5px;">Continue Shopping</a>
                                                </td>
                                            </tr>
                                        </c:if>
                                        <c:forEach var="cartDetail" items="${cartDetails}" varStatus="status">

                                            <tr>
                                                <td scope="row">
                                                    <div class="d-flex align-items-center">
                                                        <img src="/images/product/${cartDetail.product.image}"
                                                            class="img-fluid rounded"
                                                            style="width: 80px; height: 80px; object-fit: cover; border: 1px solid #eee;" alt="">
                                                    </div>
                                                </td>
                                                <td>
                                                    <a href="/product/${cartDetail.product.id}" target="_blank" class="cyber-product-name">
                                                        ${cartDetail.product.name}
                                                    </a>
                                                </td>
                                                <td>
                                                    <div style="font-weight: 600; color: #555;">
                                                        <fmt:formatNumber type="number" value="${cartDetail.price}" /> đ
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="input-group quantity" style="width: 120px;">
                                                        <div class="input-group-btn">
                                                            <button class="btn-minus cyber-qty-btn">
                                                                <i class="fa fa-minus"></i>
                                                            </button>
                                                        </div>
                                                        <input type="text"
                                                            class="form-control cyber-qty-input"
                                                            value="${cartDetail.quantity}"
                                                            data-cart-detail-id="${cartDetail.id}"
                                                            data-cart-detail-price="${cartDetail.price}"
                                                            data-cart-detail-index="${status.index}">
                                                        <div class="input-group-btn">
                                                            <button class="btn-plus cyber-qty-btn">
                                                                <i class="fa fa-plus"></i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div style="font-weight: 700; color: #cd1818;" data-cart-detail-id="${cartDetail.id}">
                                                        <fmt:formatNumber type="number"
                                                            value="${cartDetail.price * cartDetail.quantity}" /> đ
                                                    </div>
                                                </td>
                                                <td>
                                                    <form method="post" action="/delete-cart-product/${cartDetail.id}" style="margin: 0;">
                                                        <input type="hidden" name="${_csrf.parameterName}"
                                                            value="${_csrf.token}" />
                                                        <button class="cyber-delete-btn" title="Delete">
                                                            <i class="fa fa-trash"></i>
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>

                                    </tbody>
                                </table>
                            </div>
                            <c:if test="${not empty cartDetails}">
                                <div class="mt-4 row justify-content-end">
                                    <div class="col-12 col-md-6 col-lg-5">
                                        <div class="cyber-summary-box">
                                            <div class="cyber-summary-title">Payment Information</div>
                                            <div class="cyber-summary-row">
                                                <span>Subtotal:</span>
                                                <span data-cart-total-price="${totalPrice}">
                                                    <fmt:formatNumber type="number" value="${totalPrice}" /> đ
                                                </span>
                                            </div>
                                            <div class="cyber-summary-row">
                                                <span>Shipping fee:</span>
                                                <span>0 đ</span>
                                            </div>
                                            
                                            <div class="cyber-summary-total">
                                                <span>Total:</span>
                                                <span data-cart-total-price="${totalPrice}">
                                                    <fmt:formatNumber type="number" value="${totalPrice}" /> đ
                                                </span>
                                            </div>

                                            <form:form action="/confirm-checkout" method="post" modelAttribute="cart">
                                                <input type="hidden" name="${_csrf.parameterName}"
                                                    value="${_csrf.token}" />
                                                <div style="display: none;">
                                                    <c:forEach var="cartDetail" items="${cart.cartDetails}"
                                                        varStatus="status">
                                                        <div class="mb-3">
                                                            <div class="form-group">
                                                                <form:input class="form-control" type="hidden"
                                                                    value="${cartDetail.id}"
                                                                    path="cartDetails[${status.index}].id" />
                                                            </div>
                                                            <div class="form-group">
                                                                <form:input class="form-control" type="hidden"
                                                                    value="${cartDetail.quantity}"
                                                                    path="cartDetails[${status.index}].quantity" />
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                                <button class="cyber-checkout-btn">
                                                    Proceed to Checkout <i class="fa-solid fa-arrow-right ms-2"></i>
                                                </button>
                                            </form:form>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
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
