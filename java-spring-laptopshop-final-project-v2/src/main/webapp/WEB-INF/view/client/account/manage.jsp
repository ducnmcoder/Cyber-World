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
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Raleway:wght@600;800&display=swap" rel="stylesheet">

    <!-- Icon Font Stylesheet -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- Libraries Stylesheet -->
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

    <!-- Customized Bootstrap Stylesheet -->
    <link href="/client/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="/client/css/style.css" rel="stylesheet">

    <style>
        /* ===== Account Page Custom Styles ===== */
        .acct-section {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            min-height: calc(100vh - 250px);
            padding: 20px 0 40px;
        }

        /* --- Slim Banner --- */
        .acct-banner {
            padding-top: 25px !important;
            padding-bottom: 25px !important;
            margin-bottom: 0 !important;
            background: linear-gradient(135deg, #cd1818 0%, #b01414 100%) !important;
        }
        .acct-banner h1 {
            font-size: 26px !important;
            font-weight: 700;
            margin-bottom: 4px;
            color: #fff !important;
        }
        .acct-banner .breadcrumb {
            font-size: 13px;
        }
        .acct-banner .breadcrumb-item a,
        .acct-banner .breadcrumb-item,
        .acct-banner .breadcrumb-item.active {
            color: #fff !important;
        }
        .acct-banner .breadcrumb-item + .breadcrumb-item::before {
            color: rgba(255, 255, 255, 0.7) !important;
        }

        /* --- Toast Notifications --- */
        .acct-toast {
            max-width: 100%;
            margin-bottom: 15px;
            border: none;
            border-radius: 10px;
            padding: 10px 18px;
            font-size: 13px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
            animation: slideDown 0.4s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }
        .acct-toast.success { background: #d1fae5; color: #065f46; }
        .acct-toast.danger  { background: #fee2e2; color: #991b1b; }
        .acct-toast.warning { background: #fef3c7; color: #92400e; }
        .acct-toast i { font-size: 16px; }

        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-15px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        /* --- Horizontal Profile Card --- */
        .acct-card {
            width: 100%;
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.06);
            overflow: hidden;
            animation: fadeUp 0.5s ease;
            display: flex;
            flex-direction: row;
        }
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(15px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        /* --- Left Sidebar (Compact Info & Menu) --- */
        .acct-sidebar {
            width: 240px;
            min-width: 240px;
            background: linear-gradient(180deg, #cd1818 0%, #b01414 50%, #8b0c0c 100%);
            padding: 30px 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            border-top-left-radius: 16px;
            border-bottom-left-radius: 16px;
        }
        .acct-avatar-wrap {
            width: 90px;
            height: 90px;
            margin: 0 auto 12px;
            border-radius: 50%;
            border: 3px solid rgba(255, 255, 255, 0.3);
            overflow: hidden;
            background: #fff;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            transition: transform 0.3s ease;
        }
        .acct-avatar-wrap:hover {
            transform: scale(1.05);
        }
        .acct-avatar-wrap img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .acct-user-name {
            color: #fff;
            font-size: 16px;
            font-weight: 700;
            margin-bottom: 2px;
            text-align: center;
        }
        .acct-user-email {
            color: rgba(255, 255, 255, 0.7);
            font-size: 11px;
            font-weight: 400;
            text-align: center;
            word-break: break-all;
            margin-bottom: 25px;
        }

        /* Sidebar Tabs Navigation */
        .acct-sidebar-nav {
            width: 100%;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .acct-tab-btn {
            width: 100%;
            padding: 10px 14px;
            text-align: left;
            background: rgba(255, 255, 255, 0.08);
            border: none;
            border-radius: 8px;
            font-family: 'Inter', sans-serif;
            font-size: 13px;
            font-weight: 600;
            color: rgba(255, 255, 255, 0.75);
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .acct-tab-btn i {
            font-size: 14px;
            width: 16px;
            text-align: center;
        }
        .acct-tab-btn.active {
            background: #ffffff;
            color: #cd1818;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }
        .acct-tab-btn:hover:not(.active) {
            background: rgba(255, 255, 255, 0.15);
            color: #fff;
        }

        /* --- Right Content Form Panel --- */
        .acct-content {
            flex: 1;
            min-width: 0;
            background: #fff;
        }
        .acct-tab-panel {
            display: none;
            padding: 25px 30px;
            animation: fadeIn 0.3s ease;
        }
        .acct-tab-panel.active {
            display: block;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to   { opacity: 1; }
        }

        .acct-tab-panel-title {
            font-size: 18px;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 15px;
            padding-bottom: 8px;
            border-bottom: 1px solid #f1f5f9;
        }

        /* --- Grid Layout for Horizontal Form --- */
        .acct-form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px 20px;
        }
        .acct-form-row .acct-form-group.full-width {
            grid-column: 1 / -1;
        }
        .acct-form-group {
            margin-bottom: 0; /* Managed by grid gap */
        }
        .acct-form-group label {
            display: block;
            font-size: 11px;
            font-weight: 600;
            color: #64748b;
            margin-bottom: 4px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .acct-input-wrap {
            position: relative;
        }
        .acct-input-wrap i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            font-size: 14px;
            pointer-events: none;
            transition: color 0.2s;
        }
        .acct-input-wrap input {
            width: 100%;
            padding: 8px 12px 8px 36px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 13px;
            font-family: 'Inter', sans-serif;
            color: #1e293b;
            background: #f8fafc;
            transition: all 0.2s ease;
            outline: none;
        }
        .acct-input-wrap input:focus {
            border-color: #cd1818;
            background: #fff;
            box-shadow: 0 0 0 3px rgba(205,24,24,0.06);
        }
        .acct-input-wrap input:focus + i {
            color: #cd1818;
        }

        /* Horizontal File Upload Wrap */
        .acct-upload-box {
            display: flex;
            align-items: center;
            gap: 15px;
            background: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            padding: 8px 12px;
        }
        .acct-file-label {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 6px 12px;
            border: 1px dashed #cbd5e1;
            border-radius: 6px;
            cursor: pointer;
            color: #475569;
            font-size: 12px;
            font-weight: 500;
            transition: all 0.2s;
            background: #fff;
            margin: 0;
        }
        .acct-file-label:hover {
            border-color: #cd1818;
            color: #cd1818;
            background: #fef2f2;
        }
        .acct-file-input {
            display: none;
        }
        .acct-avatar-preview-wrap img {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #e2e8f0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        /* Buttons & Switches */
        .acct-submit-btn {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 8px;
            font-family: 'Inter', sans-serif;
            font-size: 14px;
            font-weight: 600;
            color: #fff;
            background: linear-gradient(135deg, #cd1818 0%, #b01414 100%);
            cursor: pointer;
            transition: all 0.2s ease;
            margin-top: 15px;
            box-shadow: 0 4px 12px rgba(205,24,24,0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        .acct-submit-btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 16px rgba(205,24,24,0.3);
        }
        .acct-submit-btn.secondary {
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            box-shadow: 0 4px 12px rgba(245,158,11,0.2);
        }
        .acct-submit-btn.secondary:hover {
            box-shadow: 0 6px 16px rgba(245,158,11,0.3);
        }

        .acct-show-pass {
            display: flex;
            align-items: center;
            gap: 6px;
            margin-top: 8px;
            cursor: pointer;
        }
        .acct-show-pass input[type="checkbox"] {
            accent-color: #cd1818;
            width: 14px;
            height: 14px;
            cursor: pointer;
        }
        .acct-show-pass label {
            font-size: 12px;
            color: #64748b;
            cursor: pointer;
            margin: 0;
            font-weight: 500;
        }

        .acct-oauth-warning {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            background: #fffbeb;
            border-radius: 8px;
            padding: 12px 15px;
            border: 1px solid #fef3c7;
        }
        .acct-oauth-warning i {
            color: #d97706;
            font-size: 18px;
        }
        .acct-oauth-warning p {
            margin: 0;
            color: #b45309;
            font-size: 12px;
            line-height: 1.5;
        }

        /* --- Responsive Styles --- */
        @media (max-width: 768px) {
            .acct-card {
                flex-direction: column;
                margin: 0 10px;
                border-radius: 12px;
            }
            .acct-sidebar {
                width: 100%;
                min-width: 100%;
                padding: 20px;
                flex-direction: row;
                flex-wrap: wrap;
                justify-content: center;
                gap: 15px;
                border-bottom-left-radius: 0;
                border-top-right-radius: 16px;
            }
            .acct-avatar-wrap {
                width: 60px;
                height: 60px;
                margin: 0;
            }
            .acct-sidebar-info {
                text-align: left;
                flex: 1;
                min-width: 0;
            }
            .acct-user-name { font-size: 15px; text-align: left; }
            .acct-user-email { text-align: left; margin-bottom: 0; }
            .acct-sidebar-nav {
                flex-direction: row;
                width: 100%;
                margin-top: 5px;
            }
            .acct-tab-btn {
                justify-content: center;
                padding: 8px 12px;
                font-size: 12px;
            }
            .acct-content {
                border-bottom-left-radius: 16px;
                border-bottom-right-radius: 16px;
            }
            .acct-tab-panel {
                padding: 20px;
            }
            .acct-form-row {
                grid-template-columns: 1fr;
                gap: 12px;
            }
        }
    </style>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        $(document).ready(() => {
            const avatarFile = $("#avatarFile");
            avatarFile.change(function (e) {
                if (e.target.files.length > 0) {
                    const imgURL = URL.createObjectURL(e.target.files[0]);
                    $("#avatarPreview").attr("src", imgURL);
                    $("#avatarPreview").css({ "display": "block" });
                    $(".acct-file-label span").text(e.target.files[0].name);
                }
            });

            // Tab switching
            $(".acct-tab-btn").click(function () {
                $(".acct-tab-btn").removeClass("active");
                $(this).addClass("active");
                $(".acct-tab-panel").removeClass("active");
                $("#" + $(this).data("tab")).addClass("active");
            });

            // Auto-show password tab if there's a password error/success
            const urlParams = new URLSearchParams(window.location.search);
            const errParam = urlParams.get('error');
            const successParam = urlParams.get('success');
            if (errParam === 'password_mismatch' || errParam === 'password_format' || errParam === 'password_same' || successParam === 'password') {
                $(".acct-tab-btn").removeClass("active");
                $('[data-tab="tabPassword"]').addClass("active");
                $(".acct-tab-panel").removeClass("active");
                $("#tabPassword").addClass("active");
            }
        });
    </script>
</head>

<body>
    <!-- Spinner Start -->
    <div id="spinner" class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50 d-flex align-items-center justify-content-center">
        <div class="spinner-grow text-primary" role="status"></div>
    </div>
    <!-- Spinner End -->

    <jsp:include page="../layout/header.jsp" />

    <!-- Single Page Header start -->
    <div class="container-fluid page-header acct-banner">
        <h1 class="text-center text-white">My Account</h1>
        <ol class="breadcrumb justify-content-center mb-0">
            <li class="breadcrumb-item"><a href="/">Home</a></li>
            <li class="breadcrumb-item active text-white">Manage Account</li>
        </ol>
    </div>
    <!-- Single Page Header End -->

    <!-- Account Management Start -->
    <section class="acct-section">
        <div class="container-fluid px-3 px-md-5">

            <!-- Toast Notifications -->
            <c:if test="${param.success == 'info'}">
                <div class="acct-toast success"><i class="fa-solid fa-circle-check"></i> Personal information updated successfully.</div>
            </c:if>
            <c:if test="${param.success == 'password'}">
                <div class="acct-toast success"><i class="fa-solid fa-circle-check"></i> Password updated successfully.</div>
            </c:if>
            <c:if test="${param.error == 'password_mismatch'}">
                <div class="acct-toast danger"><i class="fa-solid fa-circle-xmark"></i> Passwords do not match. Please try again.</div>
            </c:if>
            <c:if test="${param.error == 'password_format'}">
                <div class="acct-toast danger"><i class="fa-solid fa-circle-xmark"></i> The password must be at least 8 characters, and contain both letters and numbers.</div>
            </c:if>
            <c:if test="${param.error == 'password_same'}">
                <div class="acct-toast danger"><i class="fa-solid fa-circle-xmark"></i> New password must be different from current password.</div>
            </c:if>
            <c:if test="${param.error == 'email_exists'}">
                <div class="acct-toast danger"><i class="fa-solid fa-circle-xmark"></i> Email already exists. Please choose another one.</div>
            </c:if>
            <c:if test="${not empty updateEmailWarning}">
                <div class="acct-toast warning"><i class="fa-solid fa-triangle-exclamation"></i> ${updateEmailWarning}</div>
            </c:if>

            <!-- Profile Card -->
            <div class="acct-card">
                <!-- Left Sidebar -->
                <div class="acct-sidebar">
                    <div class="acct-avatar-wrap">
                        <img src="/images/avatar/${not empty currentUser.avatar ? currentUser.avatar : 'default-avatar.png'}" alt="Avatar">
                    </div>
                    <div class="acct-sidebar-info">
                        <div class="acct-user-name">${currentUser.fullName}</div>
                        <div class="acct-user-email">${currentUser.email}</div>
                    </div>
                    <nav class="acct-sidebar-nav">
                        <button class="acct-tab-btn active" data-tab="tabInfo">
                            <i class="fa-solid fa-user-pen"></i> Personal Info
                        </button>
                        <button class="acct-tab-btn" data-tab="tabPassword">
                            <i class="fa-solid fa-shield-halved"></i> Security
                        </button>
                    </nav>
                </div>

                <!-- Right Content -->
                <div class="acct-content">
                    <!-- Tab: Personal Info -->
                    <div class="acct-tab-panel active" id="tabInfo">
                        <div class="acct-tab-panel-title">Personal Information</div>
                        <form:form method="post" action="/account/manage/info" modelAttribute="currentUser" enctype="multipart/form-data">
                            <div class="acct-form-row">
                                <div class="acct-form-group">
                                    <label>Email Address</label>
                                    <div class="acct-input-wrap">
                                        <form:input type="email" path="email" required="required" />
                                        <i class="fa-solid fa-envelope"></i>
                                    </div>
                                </div>
                                <div class="acct-form-group">
                                    <label>Full Name</label>
                                    <div class="acct-input-wrap">
                                        <form:input type="text" path="fullName" required="required" />
                                        <i class="fa-solid fa-user"></i>
                                    </div>
                                </div>
                                <div class="acct-form-group">
                                    <label>Phone Number</label>
                                    <div class="acct-input-wrap">
                                        <form:input type="text" path="phone" />
                                        <i class="fa-solid fa-phone"></i>
                                    </div>
                                </div>
                                <div class="acct-form-group">
                                    <label>Address</label>
                                    <div class="acct-input-wrap">
                                        <form:input type="text" path="address" />
                                        <i class="fa-solid fa-location-dot"></i>
                                    </div>
                                </div>
                                <div class="acct-form-group full-width">
                                    <label>Profile Picture</label>
                                    <div class="acct-upload-box">
                                        <label class="acct-file-label" for="avatarFile">
                                            <i class="fa-solid fa-cloud-arrow-up"></i>
                                            <span>Upload new avatar</span>
                                        </label>
                                        <input class="acct-file-input" type="file" id="avatarFile" accept=".png, .jpg, .jpeg" name="avatarFile" />
                                        <div class="acct-avatar-preview-wrap">
                                            <img style="${empty currentUser.avatar ? 'display:none;' : ''}" alt="avatar preview" id="avatarPreview" src="/images/avatar/${currentUser.avatar}" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <button type="submit" class="acct-submit-btn">
                                <i class="fa-solid fa-floppy-disk"></i> Save Changes
                            </button>
                        </form:form>
                    </div>

                    <!-- Tab: Change Password -->
                    <div class="acct-tab-panel" id="tabPassword">
                        <div class="acct-tab-panel-title">Change Password</div>
                        <c:choose>
                            <c:when test="${currentUser.provider eq 'GOOGLE' or currentUser.provider eq 'FACEBOOK'}">
                                <div class="acct-oauth-warning">
                                    <i class="fa-solid fa-triangle-exclamation"></i>
                                    <p>This account uses <strong>Google/Facebook</strong> login. Password changes must be managed through your social provider's account settings.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <form method="post" action="/account/manage/password">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <div class="acct-form-row">
                                        <div class="acct-form-group">
                                            <label>New Password</label>
                                            <div class="acct-input-wrap">
                                                <input type="password" name="newPassword" id="clientNewPassword" required />
                                                <i class="fa-solid fa-lock"></i>
                                            </div>
                                        </div>
                                        <div class="acct-form-group">
                                            <label>Confirm Password</label>
                                            <div class="acct-input-wrap">
                                                <input type="password" name="confirmPassword" id="clientConfirmPassword" required />
                                                <i class="fa-solid fa-lock"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="acct-show-pass">
                                        <input type="checkbox" id="clientShowPassword" onclick="toggleClientPassword()">
                                        <label for="clientShowPassword">Show passwords</label>
                                    </div>
                                    <script>
                                        function toggleClientPassword() {
                                            var newPass = document.getElementById("clientNewPassword");
                                            var confirmPass = document.getElementById("clientConfirmPassword");
                                            if (newPass.type === "password") {
                                                newPass.type = "text";
                                                confirmPass.type = "text";
                                            } else {
                                                newPass.type = "password";
                                                confirmPass.type = "password";
                                            }
                                        }
                                    </script>
                                    <button type="submit" class="acct-submit-btn secondary">
                                        <i class="fa-solid fa-key"></i> Update Password
                                    </button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </section>
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