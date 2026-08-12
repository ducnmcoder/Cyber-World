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
    <title>Update Voucher - Cyber World</title>
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
                        <li class="breadcrumb-item active">Update</li>
                    </ol>
                    <div class="mt-5">
                        <div class="row">
                            <div class="col-md-6 col-12 mx-auto">
                                <h3>Update a voucher</h3>
                                <hr />
                                <form:form method="post" action="/admin/voucher/update" modelAttribute="newVoucher">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <div class="mb-3" style="display: none;">
                                        <label class="form-label">Id:</label>
                                        <form:input type="text" class="form-control" path="id" />
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Code:</label>
                                        <form:input type="text" class="form-control" path="code" />
                                        <form:errors path="code" cssClass="text-danger" />
                                    </div>
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
                                            <form:input type="text" class="form-control" path="validUntil" />
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
                                            <form:input type="text" class="form-control" path="applyValue" placeholder="e.g. MACBOOK, GAMING" />
                                        </div>
                                    </div>
                                    
                                    <button type="submit" class="btn btn-warning">Update</button>
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
        function toggleApplyValue() {
            var appliesTo = document.getElementById("appliesToSelect").value;
            var container = document.getElementById("applyValueContainer");
            if (appliesTo === "ALL" || appliesTo === "" || appliesTo === null) {
                container.style.display = "none";
            } else {
                container.style.display = "block";
            }
        }
        document.addEventListener("DOMContentLoaded", function() {
            toggleApplyValue();
        });
    </script>
</body>

</html>
