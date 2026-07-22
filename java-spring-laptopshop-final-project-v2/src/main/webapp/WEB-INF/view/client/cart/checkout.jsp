<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8">
                    <title> Checkout - Cyber World</title>
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
                        
                        .cyber-checkout-box { background: #fff; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); padding: 30px; margin-bottom: 30px; height: 100%; }
                        .cyber-box-title { font-size: 22px; font-weight: 700; color: #111; border-bottom: 2px solid #eee; padding-bottom: 15px; margin-bottom: 25px; text-transform: uppercase; }
                        
                        .cyber-form-label { font-weight: 600; color: #555; margin-bottom: 8px; display: block; }
                        .cyber-form-control { border: 1px solid #ddd; border-radius: 8px; padding: 12px 15px; transition: 0.3s; width: 100%; box-sizing: border-box; }
                        .cyber-form-control:focus { border-color: #cd1818; outline: none; box-shadow: 0 0 0 3px rgba(205, 24, 24, 0.1); }
                        
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
                                        <li class="breadcrumb-item active" aria-current="page">Checkout Information</li>
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
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${ empty cartDetails}">
                                            <tr>
                                                <td colspan="5" class="text-center py-5">
                                                    Your cart is empty
                                                </td>
                                            </tr>
                                        </c:if>
                                        <c:forEach var="cartDetail" items="${cartDetails}">

                                            <tr>
                                                <td scope="row">
                                                    <div class="d-flex align-items-center">
                                                        <img src="${cartDetail.product.firstImage}"
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
                                                        <fmt:formatNumber type="number" value="${cartDetail.price}" /> VND
                                                    </div>
                                                </td>
                                                <td>
                                                    <div style="font-weight: 600; color: #333;">
                                                        x ${cartDetail.quantity}
                                                    </div>
                                                </td>
                                                <td>
                                                    <div style="font-weight: 700; color: #cd1818;">
                                                        <fmt:formatNumber type="number"
                                                            value="${cartDetail.price * cartDetail.quantity}" /> VND
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>

                                    </tbody>
                                </table>
                            </div>
                            <c:if test="${not empty cartDetails}">
                                <form:form action="/place-order" method="post" modelAttribute="cart">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <div class="mt-4 row g-4">
                                        <div class="col-12 col-md-7">
                                            <div class="cyber-checkout-box">
                                                <div class="cyber-box-title">Delivery Information</div>
                                                <div class="row">
                                                    <div class="col-12 form-group mb-4">
                                                        <label class="cyber-form-label">Full Name</label>
                                                        <input class="cyber-form-control" name="receiverName" placeholder="Enter receiver's full name" required oninvalid="this.setCustomValidity('Please fill out this field.')" oninput="this.setCustomValidity('')" />
                                                    </div>
                                                    <div class="col-12 form-group mb-4">
                                                        <label class="cyber-form-label">Phone Number</label>
                                                        <input class="cyber-form-control" name="receiverPhone" placeholder="Enter contact phone number" required oninvalid="this.setCustomValidity('Please fill out this field.')" oninput="this.setCustomValidity('')" />
                                                    </div>
                                                    <div class="col-12 form-group mb-4">
                                                        <label class="cyber-form-label">Delivery Address</label>
                                                        <input class="cyber-form-control" name="receiverAddress" placeholder="Enter detailed address" required oninvalid="this.setCustomValidity('Please fill out this field.')" oninput="this.setCustomValidity('')" />
                                                    </div>
                                                    <div class="mt-2">
                                                        <a href="/cart" style="color: #cd1818; text-decoration: none; font-weight: 600;"><i class="fa-solid fa-arrow-left me-2"></i> Back to cart</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12 col-md-5">
                                            <div class="cyber-checkout-box">
                                                <div class="cyber-box-title">Payment Information</div>

                                                <div class="cyber-summary-row mt-4">
                                                    <span>Shipping fee:</span>
                                                    <span>0 VND</span>
                                                </div>
                                                
                                                <div class="cyber-summary-total">
                                                    <span>Total:</span>
                                                    <span>
                                                        <fmt:formatNumber type="number" value="${totalPrice}" /> VND
                                                    </span>
                                                </div>

                                                <button type="submit" class="cyber-checkout-btn">
                                                    Confirm Order <i class="fa-solid fa-check ms-2"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </form:form>
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


