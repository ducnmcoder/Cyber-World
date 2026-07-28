<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Manage Account - Cyber World</title>
    <link href="/css/styles.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
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
<body class="sb-nav-fixed">
    <jsp:include page="../layout/header.jsp" />
    <div id="layoutSidenav">
        <jsp:include page="../layout/sidebar.jsp" />
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4">
                    <h1 class="mt-4">Manage Account</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                        <li class="breadcrumb-item active">Account</li>
                    </ol>
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
                    <c:if test="${not empty updateEmailWarning}">
                        <div class="alert alert-warning">${updateEmailWarning}</div>
                    </c:if>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <i class="fas fa-user me-1"></i> Personal Information
                                </div>
                                <div class="card-body">
                                    <form:form method="post" action="/account/manage/info" modelAttribute="currentUser" enctype="multipart/form-data">
                                        <div class="mb-3">
                                            <label class="form-label">Email:</label>
                                            <form:input type="email" class="form-control" path="email" required="required" />
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Full Name:</label>
                                            <form:input type="text" class="form-control" path="fullName" required="required" />
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Phone number:</label>
                                            <form:input type="text" class="form-control" path="phone" />
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Address:</label>
                                            <form:input type="text" class="form-control" path="address" />
                                        </div>
                                        <div class="mb-3">
                                            <label for="avatarFile" class="form-label">Avatar:</label>
                                            <input class="form-control" type="file" id="avatarFile" accept=".png, .jpg, .jpeg" name="avatarFile" />
                                        </div>
                                        <div class="mb-3">
                                            <img style="max-height: 250px; ${empty currentUser.avatar ? 'display:none;' : ''}" alt="avatar preview" id="avatarPreview" src="/images/avatar/${currentUser.avatar}" />
                                        </div>
                                        <button type="submit" class="btn btn-primary">Save Info</button>
                                    </form:form>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card mb-4">
                                <div class="card-header">
                                    <i class="fas fa-lock me-1"></i> Change Password
                                </div>
                                <div class="card-body">
                                    <form method="post" action="/account/manage/password">
                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                        <div class="mb-3">
                                            <label class="form-label">New Password:</label>
                                            <input type="password" class="form-control" name="newPassword" required />
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Confirm Password:</label>
                                            <input type="password" class="form-control" name="confirmPassword" required />
                                        </div>
                                        <button type="submit" class="btn btn-warning">Change Password</button>
                                    </form>
                                </div>
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
</body>
</html>
