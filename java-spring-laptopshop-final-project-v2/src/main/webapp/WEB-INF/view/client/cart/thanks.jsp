<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Order - Cyber World</title>

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

            </head>

            <body>

                <!-- Spinner Start -->
                <div id="spinner"
                    class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                    <div class="spinner-grow text-primary" role="status"></div>
                </div>
                <!-- Spinner End -->

                <jsp:include page="../layout/header.jsp" />


                <div class="container" style="margin-top: 100px; min-height: 50vh; display: flex; align-items: center; justify-content: center;">
                    <div class="row w-100">
                        <div class="col-md-8 offset-md-2 text-center mt-5">
                            <div style="background: white; border-radius: 15px; padding: 50px 30px; box-shadow: 0 10px 30px rgba(0,0,0,0.08); animation: fadeInUp 0.6s ease-out;">
                                <div style="width: 80px; height: 80px; background: #cd1818; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 40px; margin: 0 auto 25px;">
                                    <i class="fa-solid fa-check"></i>
                                </div>
                                <h2 style="font-weight: 800; color: #333; margin-bottom: 15px;">Payment Successful!</h2>
                                <p style="color: #666; font-size: 16px; margin-bottom: 30px; line-height: 1.6;">
                                    Thank you for trusting and shopping at <strong>Cyber World</strong>.<br>
                                    Your order has been confirmed and is being processed. We will contact you shortly.
                                </p>
                                <div class="d-flex justify-content-center gap-3">
                                    <a href="/" class="btn" style="background: #cd1818; color: white; padding: 12px 30px; font-weight: 600; border-radius: 30px; text-transform: uppercase; font-size: 14px; letter-spacing: 1px; transition: all 0.3s ease; box-shadow: 0 4px 15px rgba(205, 24, 24, 0.3);">
                                        <i class="fa-solid fa-house me-2"></i> Back to Home
                                    </a>
                                    <a href="/order-history" class="btn" style="background: white; color: #333; border: 2px solid #eee; padding: 10px 30px; font-weight: 600; border-radius: 30px; text-transform: uppercase; font-size: 14px; letter-spacing: 1px; transition: all 0.3s ease;">
                                        <i class="fa-solid fa-clock-rotate-left me-2"></i> Order History
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <style>
                    @keyframes fadeInUp {
                        from { opacity: 0; transform: translateY(30px); }
                        to { opacity: 1; transform: translateY(0); }
                    }
                    .btn:hover {
                        transform: translateY(-2px);
                    }
                </style>


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
