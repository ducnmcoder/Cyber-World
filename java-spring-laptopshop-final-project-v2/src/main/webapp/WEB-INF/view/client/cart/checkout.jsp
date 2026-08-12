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
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                        rel="stylesheet">

                    <!-- Libraries Stylesheet -->
                    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
                    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
                    
                    <!-- Select2 CSS -->
                    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />


                    <!-- Customized Bootstrap Stylesheet -->
                    <link href="/client/css/bootstrap.min.css" rel="stylesheet">

                    <!-- Template Stylesheet -->
                    <link href="/client/css/style.css" rel="stylesheet">

                    <!-- Premium Cart Styles -->
                    <style>
                        body {
                            background-color: #f8f9fa;
                            font-family: 'Inter', sans-serif;
                        }

                        .cyber-cart-container {
                            background: #fff;
                            border-radius: 12px;
                            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
                            overflow: hidden;
                            margin-bottom: 30px;
                        }

                        .cyber-cart-table thead {
                            background: #cd1818;
                            color: #fff;
                        }

                        .cyber-cart-table th {
                            font-weight: 600;
                            padding: 15px;
                            border: none;
                            text-transform: uppercase;
                            font-size: 14px;
                        }

                        .cyber-cart-table td {
                            vertical-align: middle;
                            padding: 20px 15px;
                            border-bottom: 1px solid #eee;
                        }

                        .cyber-product-name {
                            color: #333;
                            font-weight: 600;
                            font-size: 16px;
                            text-decoration: none;
                            transition: 0.2s;
                        }

                        .cyber-product-name:hover {
                            color: #cd1818;
                        }

                        .cyber-checkout-box {
                            background: #fff;
                            border-radius: 12px;
                            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
                            padding: 30px;
                            margin-bottom: 30px;
                            height: 100%;
                        }

                        .cyber-box-title {
                            font-size: 22px;
                            font-weight: 700;
                            color: #111;
                            border-bottom: 2px solid #eee;
                            padding-bottom: 15px;
                            margin-bottom: 25px;
                            text-transform: uppercase;
                        }

                        .cyber-form-label {
                            font-weight: 600;
                            color: #555;
                            margin-bottom: 8px;
                            display: block;
                        }

                        .cyber-form-control {
                            border: 1px solid #ddd;
                            border-radius: 8px;
                            padding: 12px 15px;
                            transition: 0.3s;
                            width: 100%;
                            box-sizing: border-box;
                        }

                        .cyber-form-control:focus {
                            border-color: #cd1818;
                            outline: none;
                            box-shadow: 0 0 0 3px rgba(205, 24, 24, 0.1);
                        }
                        
                        /* Select2 custom styles to match cyber-form-control */
                        .select2-container--default .select2-selection--single {
                            border: 1px solid #ddd;
                            border-radius: 8px;
                            height: auto;
                            padding: 10px 15px;
                            transition: 0.3s;
                        }
                        .select2-container--default .select2-selection--single .select2-selection__arrow {
                            height: 100%;
                            right: 10px;
                        }
                        .select2-container--default.select2-container--focus .select2-selection--single {
                            border-color: #cd1818;
                            box-shadow: 0 0 0 3px rgba(205, 24, 24, 0.1);
                        }

                        .cyber-summary-row {
                            display: flex;
                            justify-content: space-between;
                            margin-bottom: 15px;
                            font-size: 16px;
                            color: #555;
                        }

                        .cyber-summary-total {
                            display: flex;
                            justify-content: space-between;
                            margin-top: 20px;
                            padding-top: 20px;
                            border-top: 2px solid #eee;
                            font-size: 20px;
                            font-weight: 700;
                            color: #cd1818;
                        }

                        .cyber-checkout-btn {
                            background: #cd1818;
                            color: #fff;
                            border: none;
                            padding: 15px 30px;
                            font-size: 18px;
                            font-weight: 600;
                            border-radius: 8px;
                            width: 100%;
                            margin-top: 25px;
                            transition: 0.3s;
                            text-transform: uppercase;
                            letter-spacing: 1px;
                        }

                        .cyber-checkout-btn:hover {
                            background: #a81010;
                            color: #fff;
                            transform: translateY(-2px);
                            box-shadow: 0 4px 10px rgba(205, 24, 24, 0.3);
                        }

                        .breadcrumb-item a {
                            color: #cd1818;
                            text-decoration: none;
                            font-weight: 600;
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

                    <!-- Error Notification Toast -->
                    <c:if test="${not empty errorMessage}">
                        <div id="errorToast"
                            style="position: fixed; top: 80px; right: 20px; background-color: #cd1818; color: white; padding: 15px 25px; border-radius: 5px; box-shadow: 0 4px 6px rgba(0,0,0,0.1); z-index: 100000; display: flex; align-items: center; gap: 10px; animation: slideIn 0.5s;">
                            <i class="fa-solid fa-circle-exclamation" style="font-size: 20px;"></i>
                            <span>${errorMessage}</span>
                        </div>
                        <style>
                            @keyframes slideIn {
                                from {
                                    right: -300px;
                                    opacity: 0;
                                }

                                to {
                                    right: 20px;
                                    opacity: 1;
                                }
                            }
                        </style>
                        <script>
                            setTimeout(function () {
                                var toast = document.getElementById('errorToast');
                                if (toast) { toast.style.display = 'none'; }
                            }, 5000);
                        </script>
                    </c:if>

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
                                                            style="width: 80px; height: 80px; object-fit: cover; border: 1px solid #eee;"
                                                            alt="">
                                                    </div>
                                                </td>
                                                <td>
                                                    <a href="/product/${cartDetail.product.id}" target="_blank"
                                                        class="cyber-product-name">
                                                        ${cartDetail.product.name}
                                                    </a>
                                                </td>
                                                <td>
                                                    <div style="font-weight: 600; color: #555;">
                                                        <fmt:formatNumber type="number" value="${cartDetail.price}" />
                                                        VND
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

                                    <c:if test="${not empty discountVouchers}">
                                        <div class="cyber-checkout-box mt-4 mb-0" style="padding: 20px 30px;">
                                            <div class="cyber-box-title"
                                                style="font-size: 18px; margin-bottom: 15px; padding-bottom: 0; border: none;">
                                                <i class="fa-solid fa-ticket"
                                                    style="color: #cd1818; margin-right: 8px;"></i> Discount Vouchers
                                            </div>
                                            
                                            <c:choose>
                                                <c:when test="${empty sessionScope.email}">
                                                    <div style="font-size: 14px; color: #666; font-style: italic; background: #f9f9f9; padding: 10px; border-radius: 8px;">
                                                        Please login to use more vouchers
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="d-flex flex-wrap" style="gap: 15px;">
                                                        <c:forEach var="v" items="${discountVouchers}">
                                                            <c:set var="isChecked" value="false" />
                                                            <c:if test="${preselectedVouchers != null}">
                                                                <c:forEach var="pid" items="${preselectedVouchers}">
                                                                    <c:if test="${pid == v.id}">
                                                                        <c:set var="isChecked" value="true" />
                                                                    </c:if>
                                                                </c:forEach>
                                                            </c:if>

                                                            <label
                                                                style="background: ${isChecked ? '#fff5f5' : '#fff'}; border: 1px solid ${isChecked ? '#cd1818' : '#ddd'}; border-radius: 8px; padding: 12px; cursor: pointer; flex: 1 1 250px; max-width: 320px; display: flex; align-items: flex-start; gap: 10px; transition: 0.3s;"
                                                                onmouseover="if(!this.querySelector('input').checked) this.style.borderColor='#cd1818';"
                                                                onmouseout="if(!this.querySelector('input').checked) this.style.borderColor='#ddd';">
                                                                <input type="checkbox" name="selectedVouchers" value="${v.id}"
                                                                    class="voucher-checkbox discount-voucher"
                                                                    style="accent-color: #cd1818; margin-top: 4px; width: 16px; height: 16px;"
                                                                    data-discount-type="${v.discountType}"
                                                                    data-discount-amount="${v.discountAmount}" <c:if
                                                                    test="${isChecked}">checked
                                                                </c:if>
                                                                onchange="handleVoucherSelection(this, 'discount-voucher')">
                                                                <div>
                                                                    <div
                                                                        style="font-weight: bold; color: #cd1818; font-size: 14px; margin-bottom: 5px; line-height: 1.2; display: flex; align-items: center; flex-wrap: wrap; gap: 5px;">
                                                                        ${v.title}
                                                                        <c:choose>
                                                                            <c:when test="${v.discountType == 'PERCENT'}">
                                                                                <span
                                                                                    style="background: #cd1818; color: white; padding: 2px 6px; border-radius: 4px; font-size: 11px;">
                                                                                    -
                                                                                    <fmt:formatNumber type="number" value="${v.discountAmount}" />%
                                                                                </span>
                                                                            </c:when>
                                                                            <c:when test="${v.discountType == 'FIXED'}">
                                                                                <span
                                                                                    style="background: #cd1818; color: white; padding: 2px 6px; border-radius: 4px; font-size: 11px;">
                                                                                    -
                                                                                    <fmt:formatNumber type="number" value="${v.discountAmount}" />
                                                                                    VND
                                                                                </span>
                                                                            </c:when>
                                                                        </c:choose>
                                                                    </div>
                                                                    <div style="font-size: 12px; color: #666; line-height: 1.4;">${v.description}
                                                                    </div>
                                                                </div>
                                                            </label>
                                                        </c:forEach>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </c:if>

                    <c:if test="${not empty freeshipVouchers}">
                        <div class="cyber-checkout-box mt-4 mb-0" style="padding: 20px 30px;">
                            <div class="cyber-box-title"
                                style="font-size: 18px; margin-bottom: 15px; padding-bottom: 0; border: none;"><i
                                    class="fa-solid fa-truck" style="color: #28a745; margin-right: 8px;"></i> Freeship
                                Vouchers</div>
                            <div class="d-flex flex-wrap" style="gap: 15px;">
                                <c:forEach var="v" items="${freeshipVouchers}">
                                    <c:set var="isChecked" value="false" />
                                    <c:if test="${preselectedVouchers != null}">
                                        <c:forEach var="pid" items="${preselectedVouchers}">
                                            <c:if test="${pid == v.id}">
                                                <c:set var="isChecked" value="true" />
                                            </c:if>
                                        </c:forEach>
                                    </c:if>

                                    <label
                                        style="background: ${isChecked ? '#f0fdf4' : '#fff'}; border: 1px solid ${isChecked ? '#28a745' : '#ddd'}; border-radius: 8px; padding: 12px; cursor: pointer; flex: 1 1 250px; max-width: 320px; display: flex; align-items: flex-start; gap: 10px; transition: 0.3s;"
                                        onmouseover="if(!this.querySelector('input').checked) this.style.borderColor='#28a745';"
                                        onmouseout="if(!this.querySelector('input').checked) this.style.borderColor='#ddd';">
                                        <input type="checkbox" name="selectedVouchers" value="${v.id}"
                                            class="voucher-checkbox freeship-voucher"
                                            style="accent-color: #28a745; margin-top: 4px; width: 16px; height: 16px;"
                                            data-discount-type="${v.discountType}"
                                            data-discount-amount="${v.discountAmount}" <c:if test="${isChecked}">checked
                    </c:if>
                    onchange="handleVoucherSelection(this, 'freeship-voucher')">
                    <div>
                        <div
                            style="font-weight: bold; color: #28a745; font-size: 14px; margin-bottom: 5px; line-height: 1.2; display: flex; align-items: center; flex-wrap: wrap; gap: 5px;">
                            ${v.title}
                            <span
                                style="background: #28a745; color: white; padding: 2px 6px; border-radius: 4px; font-size: 11px;">
                                -
                                <fmt:formatNumber type="number" value="${v.discountAmount}" /> VND (Ship)
                            </span>
                        </div>
                        <div style="font-size: 12px; color: #666; line-height: 1.4;">${v.description}</div>
                    </div>
                    </label>
                    </c:forEach>
                    </div>
                    </div>
                    </c:if>

                    <div class="mt-4 row g-4">
                        <div class="col-12 col-md-7">
                            <div class="cyber-checkout-box">
                                <div class="cyber-box-title">Delivery Information</div>
                                <div class="row">
                                    <div class="col-12 form-group mb-4">
                                        <label class="cyber-form-label">Email</label>
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.email}">
                                                <input type="email" class="cyber-form-control" name="receiverEmail"
                                                    value="${sessionScope.email}" readonly
                                                    style="background-color: #f8f9fa;" />
                                            </c:when>
                                            <c:otherwise>
                                                <input type="email" class="cyber-form-control" name="receiverEmail"
                                                    placeholder="Enter your email" required
                                                    oninvalid="this.setCustomValidity('Please fill out this field.')"
                                                    oninput="this.setCustomValidity('')" />
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="col-12 form-group mb-4">
                                        <label class="cyber-form-label">Full Name</label>
                                        <input class="cyber-form-control" name="receiverName"
                                            placeholder="Enter receiver's full name" required
                                            oninvalid="this.setCustomValidity('Please fill out this field.')"
                                            oninput="this.setCustomValidity('')" />
                                    </div>
                                    <div class="col-12 form-group mb-4">
                                        <label class="cyber-form-label">Phone Number</label>
                                        <input class="cyber-form-control" name="receiverPhone"
                                            placeholder="Enter contact phone number" required
                                            oninvalid="this.setCustomValidity('Please fill out this field.')"
                                            oninput="this.setCustomValidity('')" />
                                    </div>
                                    <div class="col-12 form-group mb-4">
                                        <label class="cyber-form-label">Province/City</label>
                                        <select class="cyber-form-control mb-2" id="provinceSelect" name="receiverProvince" required onchange="updateShippingFee()">
                                            <option value="" disabled selected>Select Province/City</option>
                                        </select>
                                        <label class="cyber-form-label mt-2">District</label>
                                        <select class="cyber-form-control mb-2" id="districtSelect" required>
                                            <option value="" disabled selected>Select District</option>
                                        </select>
                                        <label class="cyber-form-label mt-2">Ward/Commune</label>
                                        <select class="cyber-form-control mb-2" id="wardSelect" required>
                                            <option value="" disabled selected>Select Ward/Commune</option>
                                        </select>
                                        <label class="cyber-form-label mt-2">Detailed Address</label>
                                        <input class="cyber-form-control" id="detailedAddress"
                                            placeholder="House number, street name" required
                                            oninvalid="this.setCustomValidity('Please fill out this field.')"
                                            oninput="this.setCustomValidity(''); combineAddress();" />
                                        <input type="hidden" name="receiverAddress" id="receiverAddress" />
                                    </div>
                                    <div class="mt-2">
                                        <a href="/cart"
                                            style="color: #cd1818; text-decoration: none; font-weight: 600;"><i
                                                class="fa-solid fa-arrow-left me-2"></i> Back to cart</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-5">
                            <div class="cyber-checkout-box">
                                <div class="cyber-box-title">Payment Information</div>

                                <div class="mb-4">
                                    <label class="cyber-form-label">Payment Method</label>

                                    <div class="payment-method-option"
                                        style="border: 2px solid #cd1818; border-radius: 8px; padding: 12px 15px; margin-bottom: 10px; cursor: pointer; transition: 0.3s; background: #fff5f5;">
                                        <label
                                            style="cursor: pointer; display: flex; align-items: center; margin: 0; width: 100%;">
                                            <input type="radio" name="paymentMethod" value="COD" checked
                                                style="accent-color: #cd1818; width: 18px; height: 18px; margin-right: 12px;" />
                                            <span style="font-size: 20px; margin-right: 10px;">&#128181;</span>
                                            <div>
                                                <div style="font-weight: 600; color: #333;">Cash on Delivery (COD)</div>
                                                <div style="font-size: 12px; color: #888;">Pay when you receive your
                                                    order</div>
                                            </div>
                                        </label>
                                    </div>

                                    <div class="payment-method-option"
                                        style="border: 2px solid #ddd; border-radius: 8px; padding: 12px 15px; margin-bottom: 10px; cursor: pointer; transition: 0.3s;">
                                        <label
                                            style="cursor: pointer; display: flex; align-items: center; margin: 0; width: 100%;">
                                            <input type="radio" name="paymentMethod" value="VNPAY"
                                                style="accent-color: #cd1818; width: 18px; height: 18px; margin-right: 12px;" />
                                            <span style="font-size: 20px; margin-right: 10px;">&#127974;</span>
                                            <div>
                                                <div style="font-weight: 600; color: #333;">VNPay</div>
                                                <div style="font-size: 12px; color: #888;">ATM / Visa / MasterCard / QR
                                                    Pay</div>
                                            </div>
                                        </label>
                                    </div>

                                    <div class="payment-method-option"
                                        style="border: 2px solid #ddd; border-radius: 8px; padding: 12px 15px; margin-bottom: 10px; cursor: pointer; transition: 0.3s;">
                                        <label
                                            style="cursor: pointer; display: flex; align-items: center; margin: 0; width: 100%;">
                                            <input type="radio" name="paymentMethod" value="MOMO"
                                                style="accent-color: #cd1818; width: 18px; height: 18px; margin-right: 12px;" />
                                            <span style="font-size: 20px; margin-right: 10px;">&#128241;</span>
                                            <div>
                                                <div style="font-weight: 600; color: #333;">MoMo</div>
                                                <div style="font-size: 12px; color: #888;">Pay via MoMo e-wallet</div>
                                            </div>
                                        </label>
                                    </div>

                                    <div class="payment-method-option"
                                        style="border: 2px solid #ddd; border-radius: 8px; padding: 12px 15px; margin-bottom: 0; cursor: pointer; transition: 0.3s;">
                                        <label
                                            style="cursor: pointer; display: flex; align-items: center; margin: 0; width: 100%;">
                                            <input type="radio" name="paymentMethod" value="ZALOPAY"
                                                style="accent-color: #cd1818; width: 18px; height: 18px; margin-right: 12px;" />
                                            <span style="font-size: 20px; margin-right: 10px;">&#128179;</span>
                                            <div>
                                                <div style="font-weight: 600; color: #333;">ZaloPay</div>
                                                <div style="font-size: 12px; color: #888;">Pay via ZaloPay e-wallet
                                                </div>
                                            </div>
                                        </label>
                                    </div>
                                </div>

                                <div class="cyber-summary-row mt-4">
                                    <span>Shipping fee:</span>
                                    <span id="display-shipping-fee">100.000 VND</span>
                                </div>

                                <div class="cyber-summary-total">
                                    <span>Total:</span>
                                    <span id="display-total-price">
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

                    <!-- Select2 JS -->
                    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

                    <!-- Template Javascript -->
                    <script src="/client/js/main.js"></script>

                    <script>
                        const baseTotal = ${ totalPrice };
                        const totalQuantity = ${ totalQuantity != null ? totalQuantity : 0 };
                        let currentShippingFee = 100000;
                        let provincesData = [];
                        
                        function toEnglish(name) {
                            if (!name) return "";
                            let enName = name;
                            if (name.startsWith("Thành phố ")) enName = name.replace("Thành phố ", "") + " City";
                            else if (name.startsWith("Tỉnh ")) enName = name.replace("Tỉnh ", "") + " Province";
                            else if (name.startsWith("Quận ")) enName = name.replace("Quận ", "") + " District";
                            else if (name.startsWith("Huyện ")) enName = name.replace("Huyện ", "") + " District";
                            else if (name.startsWith("Thị xã ")) enName = name.replace("Thị xã ", "") + " Town";
                            else if (name.startsWith("Phường ")) enName = name.replace("Phường ", "") + " Ward";
                            else if (name.startsWith("Xã ")) enName = name.replace("Xã ", "") + " Commune";
                            else if (name.startsWith("Thị trấn ")) enName = name.replace("Thị trấn ", "") + " Town";
                            
                            // Remove accents
                            return enName.normalize("NFD").replace(/[\u0300-\u036f]/g, "").replace(/đ/g, "d").replace(/Đ/g, "D");
                        }
                        
                        document.addEventListener("DOMContentLoaded", function() {
                            fetch('https://provinces.open-api.vn/api/?depth=3')
                                .then(response => response.json())
                                .then(data => {
                                    provincesData = data;
                                    const provinceSelect = document.getElementById('provinceSelect');
                                    data.forEach(p => {
                                        const option = document.createElement('option');
                                        option.value = toEnglish(p.name);
                                        option.textContent = toEnglish(p.name);
                                        option.dataset.code = p.code;
                                        provinceSelect.appendChild(option);
                                    });
                                    
                                    // Initialize Select2
                                    $('#provinceSelect').select2({ width: '100%' });
                                    $('#districtSelect').select2({ width: '100%' });
                                    $('#wardSelect').select2({ width: '100%' });
                                });
                                
                            $('#provinceSelect').on('change', function() {
                                updateShippingFee();
                                const districtSelect = document.getElementById('districtSelect');
                                const wardSelect = document.getElementById('wardSelect');
                                districtSelect.innerHTML = '<option value="" disabled selected>Select District</option>';
                                wardSelect.innerHTML = '<option value="" disabled selected>Select Ward/Commune</option>';
                                
                                const selectedProvinceCode = this.options[this.selectedIndex].dataset.code;
                                const province = provincesData.find(p => p.code == selectedProvinceCode);
                                if (province && province.districts) {
                                    province.districts.forEach(d => {
                                        const option = document.createElement('option');
                                        option.value = toEnglish(d.name);
                                        option.textContent = toEnglish(d.name);
                                        option.dataset.code = d.code;
                                        districtSelect.appendChild(option);
                                    });
                                }
                                $('#districtSelect').trigger('change.select2');
                                $('#wardSelect').trigger('change.select2');
                                combineAddress();
                            });
                            
                            $('#districtSelect').on('change', function() {
                                const wardSelect = document.getElementById('wardSelect');
                                wardSelect.innerHTML = '<option value="" disabled selected>Select Ward/Commune</option>';
                                
                                const provinceCode = document.getElementById('provinceSelect').options[document.getElementById('provinceSelect').selectedIndex].dataset.code;
                                const districtCode = this.options[this.selectedIndex].dataset.code;
                                
                                const province = provincesData.find(p => p.code == provinceCode);
                                if (province) {
                                    const district = province.districts.find(d => d.code == districtCode);
                                    if (district && district.wards) {
                                        district.wards.forEach(w => {
                                            const option = document.createElement('option');
                                            option.value = toEnglish(w.name);
                                            option.textContent = toEnglish(w.name);
                                            wardSelect.appendChild(option);
                                        });
                                    }
                                }
                                $('#wardSelect').trigger('change.select2');
                                combineAddress();
                            });
                            
                            $('#wardSelect').on('change', combineAddress);
                        });

                        function updateShippingFee() {
                            const p = document.getElementById('provinceSelect').value;
                            if (p.includes('Ho Chi Minh') || p.includes('Ha Noi')) {
                                currentShippingFee = 50000;
                            } else if (p) {
                                currentShippingFee = 100000;
                            }
                            document.getElementById('display-shipping-fee').innerText = currentShippingFee.toLocaleString('de-DE') + ' VND';
                            calculateTotal();
                        }

                        function combineAddress() {
                            const p = document.getElementById('provinceSelect').value;
                            const d = document.getElementById('districtSelect').value;
                            const w = document.getElementById('wardSelect').value;
                            const addr = document.getElementById('detailedAddress').value;
                            
                            let parts = [];
                            if (addr) parts.push(addr);
                            if (w && w !== '') parts.push(w);
                            if (d && d !== '') parts.push(d);
                            if (p && p !== '') parts.push(p);
                            
                            document.getElementById('receiverAddress').value = parts.join(', ');
                        }

                        function handleVoucherSelection(checkbox, groupClass) {
                            if (checkbox.checked) {
                                document.querySelectorAll('.' + groupClass).forEach(function (cb) {
                                    if (cb !== checkbox) {
                                        cb.checked = false;
                                        cb.parentElement.style.borderColor = '#ddd';
                                        cb.parentElement.style.backgroundColor = '#fff';
                                    }
                                });
                                checkbox.parentElement.style.borderColor = (groupClass === 'discount-voucher') ? '#cd1818' : '#28a745';
                                checkbox.parentElement.style.backgroundColor = (groupClass === 'discount-voucher') ? '#fff5f5' : '#f0fdf4';
                            } else {
                                checkbox.parentElement.style.borderColor = '#ddd';
                                checkbox.parentElement.style.backgroundColor = '#fff';
                            }
                            calculateTotal();
                        }

                        function calculateTotal() {
                            let discountAmount = 0;
                            let percentDiscount = 0;
                            let shippingDiscount = 0;

                            document.querySelectorAll('.voucher-checkbox:checked').forEach(function (cb) {
                                const type = cb.getAttribute('data-discount-type');
                                const amount = parseFloat(cb.getAttribute('data-discount-amount'));

                                if (type === 'FREESHIP') {
                                    shippingDiscount += amount;
                                } else if (type === 'FIXED') {
                                    discountAmount += amount * totalQuantity;
                                } else if (type === 'PERCENT') {
                                    percentDiscount += amount;
                                }
                            });

                            let actualShippingDiscount = shippingDiscount > currentShippingFee ? currentShippingFee : shippingDiscount;

                            let newTotal = baseTotal;
                            if (percentDiscount > 0) {
                                newTotal = newTotal - (newTotal * percentDiscount / 100);
                            }
                            if (discountAmount > 0) {
                                newTotal = newTotal - discountAmount;
                            }

                            newTotal = newTotal + currentShippingFee - actualShippingDiscount;

                            if (newTotal < 0) newTotal = 0;

                            // Format to locale string mimicking JSTL formatNumber (e.g., 35.290.000)
                            const formatted = newTotal.toLocaleString('de-DE', { maximumFractionDigits: 0 }) + ' VND';
                            document.getElementById('display-total-price').innerText = formatted;
                        }

                        document.addEventListener("DOMContentLoaded", function () {
                            calculateTotal();
                        });

                        // Payment method radio button interaction
                        document.querySelectorAll('input[name="paymentMethod"]').forEach(function (radio) {
                            radio.addEventListener('change', function () {
                                // Reset all options
                                document.querySelectorAll('.payment-method-option').forEach(function (opt) {
                                    opt.style.borderColor = '#ddd';
                                    opt.style.background = '#fff';
                                });
                                // Highlight selected
                                if (this.checked) {
                                    var parent = this.closest('.payment-method-option');
                                    parent.style.borderColor = '#cd1818';
                                    parent.style.background = '#fff5f5';
                                }
                            });
                        });
                    </script>
                </body>

                </html>