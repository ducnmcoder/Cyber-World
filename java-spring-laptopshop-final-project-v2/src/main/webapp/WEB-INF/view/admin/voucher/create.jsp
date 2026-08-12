<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="Cyber World - Dự án cyberworld" />
    <meta name="author" content="Cyber World" />
    <title>Create Voucher - Cyber World</title>
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
                        <li class="breadcrumb-item"><a href="/admin/voucher">Voucher</a></li>
                        <li class="breadcrumb-item active">Create</li>
                    </ol>
                    <div class="mt-5">
                        <div class="row">
                            <div class="col-md-6 col-12 mx-auto">
                                <h3>Create a voucher</h3>
                                <hr />
                                <form:form method="post" action="/admin/voucher/create" modelAttribute="newVoucher">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                                    <div class="mb-3">
                                        <label class="form-label">Title:</label>
                                        <form:input type="text" class="form-control" path="title" />
                                        <form:errors path="title" cssClass="text-danger" />
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Description:</label>
                                        <form:input type="text" class="form-control" path="description" />
                                        <form:errors path="description" cssClass="text-danger" />
                                    </div>
                                    <div class="row">
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Discount Amount:</label>
                                            <form:input type="number" class="form-control" path="discountAmount" />
                                            <form:errors path="discountAmount" cssClass="text-danger" />
                                        </div>
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Discount Type:</label>
                                            <form:select class="form-select" path="discountType">
                                                <form:option value="FIXED">FIXED (VND)</form:option>
                                                <form:option value="PERCENT">PERCENT (%)</form:option>
                                                <form:option value="FREESHIP">FREESHIP (Miễn phí vận chuyển)</form:option>
                                            </form:select>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Valid Until:</label>
                                            <form:input type="date" class="form-control" path="validUntil" id="validUntilInput" />
                                            <form:errors path="validUntil" cssClass="text-danger" />
                                        </div>
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Status:</label>
                                            <form:select class="form-select" path="status">
                                                <form:option value="ACTIVE">ACTIVE</form:option>
                                                <form:option value="INACTIVE">INACTIVE</form:option>
                                            </form:select>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="mb-3 col-12 col-md-6">
                                            <label class="form-label">Applies To:</label>
                                            <form:select class="form-select" path="appliesTo" id="appliesToSelect" onchange="toggleApplyValue()">
                                                <form:option value="ALL">All Products</form:option>
                                                <form:option value="FACTORY">Specific Brand (Factory)</form:option>
                                                <form:option value="TARGET">Specific Target</form:option>
                                            </form:select>
                                        </div>
                                        <div class="mb-3 col-12 col-md-6" id="applyValueContainer" style="display: none;">
                                            <label class="form-label">Condition Value:</label>
                                            <form:select class="form-select" path="applyValue" id="applyValueSelect">
                                            </form:select>
                                        </div>
                                    </div>
                                    
                                    <button type="submit" class="btn btn-primary">Create</button>
                                </form:form>
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
    <script>
        const factoryOptions = [
            {value: 'APPLE', text: 'Apple (MacBook)'},
            {value: 'ASUS', text: 'Asus'},
            {value: 'LENOVO', text: 'Lenovo'},
            {value: 'DELL', text: 'Dell'},
            {value: 'LG', text: 'LG'},
            {value: 'ACER', text: 'Acer'}
        ];

        const targetOptions = [
            {value: 'GAMING', text: 'Gaming'},
            {value: 'SINHVIEN-VANPHONG', text: 'Student - Office'},
            {value: 'THIET-KE-DO-HOA', text: 'Graphic Design'},
            {value: 'MONG-NHE', text: 'Thin & Light'},
            {value: 'DOANH-NHAN', text: 'Business'}
        ];

        function toggleApplyValue() {
            var appliesTo = document.getElementById("appliesToSelect").value;
            var container = document.getElementById("applyValueContainer");
            var select = document.getElementById("applyValueSelect");
            
            if (appliesTo === "ALL") {
                container.style.display = "none";
                select.innerHTML = '';
            } else {
                container.style.display = "block";
                select.innerHTML = '';
                var options = appliesTo === "FACTORY" ? factoryOptions : targetOptions;
                options.forEach(function(opt) {
                    var el = document.createElement("option");
                    el.value = opt.value;
                    el.textContent = opt.text;
                    select.appendChild(el);
                });
            }
        }
        document.addEventListener("DOMContentLoaded", function() {
            toggleApplyValue();
            
            var today = new Date().toISOString().split('T')[0];
            document.getElementById("validUntilInput").setAttribute('min', today);
        });
    </script>
</body>

</html>
