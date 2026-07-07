<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Contact - Cyber World</title>

                <!-- Google Web Fonts -->
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link
                    href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                    rel="stylesheet">

                <!-- Icon Font Stylesheet -->
                <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                    rel="stylesheet">

                <!-- Libraries Stylesheet -->
                <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
                <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

                <!-- Customized Bootstrap Stylesheet -->
                <link href="/client/css/bootstrap.min.css" rel="stylesheet">

                <!-- Template Stylesheet -->
                <link href="/client/css/style.css" rel="stylesheet">

                <meta name="_csrf" content="${_csrf.token}" />
                <meta name="_csrf_header" content="${_csrf.headerName}" />
            </head>

            <body>

                <!-- Spinner Start -->
                <div id="spinner"
                    class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                    <div class="spinner-grow text-primary" role="status"></div>
                </div>
                <!-- Spinner End -->

                <jsp:include page="../layout/header.jsp" />

                <!-- Page Header Start -->
                <div class="container-fluid page-header py-5">
                    <h1 class="text-center text-white display-6">Contact</h1>
                    <ol class="breadcrumb justify-content-center mb-0">
                        <li class="breadcrumb-item"><a href="/">Home</a></li>
                        <li class="breadcrumb-item active text-white">Contact</li>
                    </ol>
                </div>
                <!-- Page Header End -->

                <!-- Contact Start -->
                <div class="container-fluid py-5">
                    <div class="container py-5">
                        <div class="row g-5">
                            <!-- Contact Info -->
                            <div class="col-lg-4">
                                <div class="bg-light rounded p-4 mb-4">
                                    <div class="d-flex align-items-center mb-4">
                                        <div class="btn-square rounded-circle bg-secondary me-3"
                                            style="width: 50px; height: 50px; display: flex; align-items: center; justify-content: center;">
                                            <i class="fas fa-map-marker-alt text-white"></i>
                                        </div>
                                        <div>
                                            <h5 class="mb-1">Address</h5>
                                            <p class="mb-0">123 ABC Street, XYZ District, HCMC</p>
                                        </div>
                                    </div>
                                    <div class="d-flex align-items-center mb-4">
                                        <div class="btn-square rounded-circle bg-secondary me-3"
                                            style="width: 50px; height: 50px; display: flex; align-items: center; justify-content: center;">
                                            <i class="fas fa-envelope text-white"></i>
                                        </div>
                                        <div>
                                            <h5 class="mb-1">Email</h5>
                                            <p class="mb-0">contact@cyberworld.vn</p>
                                        </div>
                                    </div>
                                    <div class="d-flex align-items-center mb-4">
                                        <div class="btn-square rounded-circle bg-secondary me-3"
                                            style="width: 50px; height: 50px; display: flex; align-items: center; justify-content: center;">
                                            <i class="fas fa-phone-alt text-white"></i>
                                        </div>
                                        <div>
                                            <h5 class="mb-1">Hotline</h5>
                                            <p class="mb-0">0123 456 789</p>
                                        </div>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <div class="btn-square rounded-circle bg-secondary me-3"
                                            style="width: 50px; height: 50px; display: flex; align-items: center; justify-content: center;">
                                            <i class="fas fa-clock text-white"></i>
                                        </div>
                                        <div>
                                            <h5 class="mb-1">Working Hours</h5>
                                            <p class="mb-0">Mon - Sun: 8:00 AM - 9:00 PM</p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Contact Form -->
                            <div class="col-lg-8">
                                <h2 class="text-primary mb-4">Send Us a Message</h2>

                                <c:if test="${not empty success}">
                                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                                        <i class="fas fa-check-circle me-2"></i>
                                        Thank you for contacting us! We will reply as soon as possible.
                                        <button type="button" class="btn-close" data-bs-dismiss="alert"
                                            aria-label="Close"></button>
                                    </div>
                                </c:if>

                                <form:form method="post" action="/contact" modelAttribute="newContact"
                                    class="needs-validation">
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <div class="form-floating">
                                                <form:input type="text" class="form-control" id="fullName"
                                                    placeholder="Full Name" path="fullName" />
                                                <label for="fullName">Full Name *</label>
                                                <form:errors path="fullName" cssClass="text-danger" />
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-floating">
                                                <form:input type="email" class="form-control" id="email"
                                                    placeholder="Email" path="email" />
                                                <label for="email">Email *</label>
                                                <form:errors path="email" cssClass="text-danger" />
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-floating">
                                                <form:input type="text" class="form-control" id="subject"
                                                    placeholder="Subject" path="subject" />
                                                <label for="subject">Subject</label>
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-floating">
                                                <form:textarea class="form-control" id="message"
                                                    placeholder="Message Content" path="message"
                                                    style="height: 150px" />
                                                <label for="message">Message Content *</label>
                                                <form:errors path="message" cssClass="text-danger" />
                                            </div>
                                        </div>
                                        <div class="col-12">
                                            <button type="submit"
                                                class="btn border border-secondary rounded-pill px-4 py-3 text-primary fw-bold">
                                                <i class="fas fa-paper-plane me-2"></i>Send Message
                                            </button>
                                        </div>
                                    </div>
                                </form:form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Contact End -->

                <jsp:include page="../layout/feature.jsp" />

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
