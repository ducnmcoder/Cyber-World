<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8" />
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
            <meta name="description" content="Hỏi Dân IT - Dự án cyberworld" />
            <meta name="author" content="Hỏi Dân IT" />
            <title>Contact Detail - Cyber World</title>
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
                            <h1 class="mt-4">Contact Detail</h1>
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                <li class="breadcrumb-item"><a href="/admin/contact">Contact</a></li>
                                <li class="breadcrumb-item active">Detail #${id}</li>
                            </ol>
                            <div class="mt-5">
                                <div class="row">
                                    <div class="col-8 mx-auto">
                                        <div class="card">
                                            <div class="card-header">
                                                <h4>Contact Details #${contact.id}</h4>
                                            </div>
                                            <div class="card-body">
                                                <table class="table">
                                                    <tbody>
                                                        <tr>
                                                            <th style="width: 200px;">ID</th>
                                                            <td>${contact.id}</td>
                                                        </tr>
                                                        <tr>
                                                            <th>Full Name</th>
                                                            <td>${contact.fullName}</td>
                                                        </tr>
                                                        <tr>
                                                            <th>Email</th>
                                                            <td>${contact.email}</td>
                                                        </tr>
                                                        <tr>
                                                            <th>Subject</th>
                                                            <td>${contact.subject}</td>
                                                        </tr>
                                                        <tr>
                                                            <th>Content</th>
                                                            <td>${contact.message}</td>
                                                        </tr>
                                                        <tr>
                                                            <th>Status</th>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${contact.status == 'PENDING'}">
                                                                        <span class="badge bg-warning text-dark">PENDING</span>
                                                                    </c:when>
                                                                    <c:when test="${contact.status == 'READ'}">
                                                                        <span class="badge bg-info">READ</span>
                                                                    </c:when>
                                                                    <c:when test="${contact.status == 'REPLIED'}">
                                                                        <span class="badge bg-success">REPLIED</span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="badge bg-secondary">${contact.status}</span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <th>Date Sent</th>
                                                            <td>${contact.createdAt}</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="card-footer">
                                                <a href="/admin/contact" class="btn btn-secondary">Back</a>
                                                <a href="/admin/contact/update/${contact.id}"
                                                    class="btn btn-warning">Update Status</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>
                    <jsp:include page="../layout/footer.jsp" />
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                crossorigin="anonymous"></script>
            <script src="/js/scripts.js"></script>

        </body>

        </html>
