<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Manage Account - Cyber World</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet"> 

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="/client/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="/client/css/style.css" rel="stylesheet">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        $(document).ready(() => {
            const avatarFile = $("#avatarFile");
            avatarFile.change(function (e) {
                if(e.target.files.length > 0) {
                    const imgURL = URL.createObjectURL(e.target.files[0]);
                    $("#avatarPreview").attr("src", imgURL);
                    $("#avatarPreview").css({ "display": "block" });
                }
            });
        });
    </script>
</head>
<body>
    <!-- Spinner Start -->
    <div id="spinner" class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-primary" role="status"></div>
    </div>
    <!-- Spinner End -->

    <jsp:include page="../layout/header.jsp" />

    <!-- Single Page Header start -->
    <div class="container-fluid page-header py-5">
        <h1 class="text-center text-white display-6">Manage Account</h1>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item"><a href="/">Home</a></li>
            <li class="breadcrumb-item active text-white">Manage Account</li>
        </ol>
    </div>
    <!-- Single Page Header End -->

    <!-- Account Management Start -->
    <div class="container-fluid py-5">
        <div class="container py-5">
            <c:if test="${param.success == 'info'}">
                <div class="alert alert-success">Personal information updated successfully.</div>
            </c:if>
            <c:if test="${param.success == 'password'}">
                <div class="alert alert-success">Password updated successfully.</div>
            </c:if>
            <c:if test="${param.error == 'password_mismatch'}">
                <div class="alert alert-danger">Passwords do not match. Please try again.</div>
            </c:if>
            <c:if test="${param.error == 'email_exists'}">
                <div class="alert alert-danger">Email already exists. Please choose another one.</div>
            </c:if>
            
            <div class="row g-5">
                <!-- Personal Info Column -->
                <div class="col-lg-6 col-xl-6">
                    <div class="bg-light rounded p-5 mb-4">
                        <h3 class="mb-4">Personal Information</h3>
                        <form:form method="post" action="/account/manage/info" modelAttribute="currentUser" enctype="multipart/form-data">
                            <div class="row gx-3">
                                <div class="col-12 mb-3">
                                    <label class="form-label">Email</label>
                                    <form:input type="email" class="form-control" path="email" required="required" />
                                </div>
                                <div class="col-12 mb-3">
                                    <label class="form-label">Full Name</label>
                                    <form:input type="text" class="form-control" path="fullName" required="required" />
                                </div>
                                <div class="col-12 mb-3">
                                    <label class="form-label">Phone Number</label>
                                    <form:input type="text" class="form-control" path="phone" />
                                </div>
                                <div class="col-12 mb-3">
                                    <label class="form-label">Address</label>
                                    <form:input type="text" class="form-control" path="address" />
                                </div>
                                <div class="col-12 mb-3">
                                    <label class="form-label">Avatar</label>
                                    <input class="form-control bg-white" type="file" id="avatarFile" accept=".png, .jpg, .jpeg" name="avatarFile" />
                                </div>
                                <div class="col-12 mb-3">
                                    <img class="img-fluid rounded" style="max-height: 200px; ${empty currentUser.avatar ? 'display:none;' : ''}" alt="avatar preview" id="avatarPreview" src="/images/avatar/${currentUser.avatar}" />
                                </div>
                            </div>
                            <button type="submit" class="btn border-secondary rounded-pill px-4 py-3 text-primary w-100">Save Information</button>
                        </form:form>
                    </div>
                </div>
                
                <!-- Password Column -->
                <div class="col-lg-6 col-xl-6">
                    <div class="bg-light rounded p-5">
                        <h3 class="mb-4">Change Password</h3>
                        <form method="post" action="/account/manage/password">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                            <div class="row gx-3">
                                <div class="col-12 mb-3">
                                    <label class="form-label">New Password</label>
                                    <input type="password" class="form-control" name="newPassword" required />
                                </div>
                                <div class="col-12 mb-4">
                                    <label class="form-label">Confirm Password</label>
                                    <input type="password" class="form-control" name="confirmPassword" required />
                                </div>
                            </div>
                            <button type="submit" class="btn border-secondary rounded-pill px-4 py-3 text-primary w-100">Change Password</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Account Management End -->

    <jsp:include page="../layout/footer.jsp" />

    <!-- Back to Top -->
    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>   

    <!-- JavaScript Libraries -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="/client/lib/easing/easing.min.js"></script>
    <script src="/client/lib/waypoints/waypoints.min.js"></script>
    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="/client/js/main.js"></script>
</body>
</html>
