<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Feedback - Cyber World</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
        rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

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

    <!-- Single Page Header start -->
    <div class="container-fluid page-header py-5">
        <h1 class="text-center text-white display-6">Send Feedback</h1>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item"><a href="/">Home</a></li>
            <li class="breadcrumb-item active text-white">Feedback</li>
        </ol>
    </div>
    <!-- Single Page Header End -->

    <!-- Contact Start -->
    <div class="container-fluid contact py-5">
        <div class="container py-5">
            <div class="p-5 bg-light rounded">
                <div class="row g-4">
                    <div class="col-12">
                        <div class="text-center mx-auto" style="max-width: 700px;">
                            <h1 class="text-primary">We'd love to hear from you</h1>
                            <p class="mb-4">All your feedback is valuable to help us improve our services. 
                            Please leave a message below.</p>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        
                        <c:if test="${not empty successMessage}">
                            <div class="alert alert-success" role="alert">
                                ${successMessage}
                            </div>
                        </c:if>

                        <form:form action="/feedback" method="post" modelAttribute="feedback">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            
                            <div class="mb-3">
                                <label for="subjectSelect" class="form-label">Subject <span class="text-danger">*</span></label>
                                <select id="subjectSelect" class="form-select w-100 py-3" onchange="handleSubjectChange()">
                                    <option value="" disabled selected>Select a subject</option>
                                    <option value="Product Inquiry">Product Inquiry</option>
                                    <option value="Order Status & Tracking">Order Status & Tracking</option>
                                    <option value="Technical Support">Technical Support</option>
                                    <option value="Website Bug / Issue">Website Bug / Issue</option>
                                    <option value="Payment & Billing">Payment & Billing</option>
                                    <option value="Other">Other (Please specify)</option>
                                </select>
                                <input type="text" id="customSubject" class="form-control w-100 py-3 mt-2" placeholder="Please specify your subject" style="display: none;" oninput="updateRealSubject()" />
                                <form:input path="subject" type="hidden" id="realSubject" />
                                <form:errors path="subject" cssClass="text-danger" />
                            </div>
                            
                            <div class="mb-3">
                                <label for="content" class="form-label">Content <span class="text-danger">*</span></label>
                                <form:textarea path="content" class="form-control w-100" id="content" rows="6" cols="10" placeholder="Enter your feedback"></form:textarea>
                                <form:errors path="content" cssClass="text-danger" />
                            </div>
                            
                            <button class="btn btn-primary w-100 py-3 mt-2" type="submit">Send Feedback</button>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Contact End -->


    <jsp:include page="../layout/footer.jsp" />

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
        function handleSubjectChange() {
            var select = document.getElementById("subjectSelect");
            var custom = document.getElementById("customSubject");
            var real = document.getElementById("realSubject");
            
            if (select.value === "Other") {
                custom.style.display = "block";
                custom.focus();
                real.value = custom.value;
            } else {
                custom.style.display = "none";
                real.value = select.value;
            }
        }
        
        function updateRealSubject() {
            var real = document.getElementById("realSubject");
            var custom = document.getElementById("customSubject");
            real.value = custom.value;
        }

        document.addEventListener("DOMContentLoaded", function() {
            var real = document.getElementById("realSubject").value;
            var select = document.getElementById("subjectSelect");
            var custom = document.getElementById("customSubject");
            
            if (real) {
                var exists = false;
                for (var i = 0; i < select.options.length; i++) {
                    if (select.options[i].value === real && real !== "Other") {
                        exists = true;
                        break;
                    }
                }
                
                if (exists) {
                    select.value = real;
                } else {
                    select.value = "Other";
                    custom.style.display = "block";
                    custom.value = real;
                }
            }
        });
    </script>
</body>

</html>
