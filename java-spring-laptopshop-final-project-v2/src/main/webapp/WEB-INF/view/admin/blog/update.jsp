<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <title>Update Blog - Cyber World</title>
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script>
                    $(document).ready(() => {
                        const blogFile = $("#blogFile");
                        blogFile.change(function (e) {
                            const imgURL = URL.createObjectURL(e.target.files[0]);
                            $("#blogPreview").attr("src", imgURL);
                            $("#blogPreview").css({ "display": "block" });
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
                                <h1 class="mt-4">Update Blog</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item"><a href="/admin/blog">Blog</a></li>
                                    <li class="breadcrumb-item active">Update</li>
                                </ol>
                                <div class="mt-5">
                                    <div class="row">
                                        <div class="col-md-6 col-12 mx-auto">
                                            <h3>Update Blog Post</h3>
                                            <hr />
                                            <form:form method="post" action="/admin/blog/update"
                                                modelAttribute="newBlog" enctype="multipart/form-data">
                                                <form:hidden path="id" />
                                                <div class="mb-3">
                                                    <label class="form-label">Title:</label>
                                                    <form:input type="text" class="form-control" path="title" />
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label">Content:</label>
                                                    <form:textarea class="form-control" path="content" rows="8" />
                                                </div>
                                                <div class="mb-3">
                                                    <label for="blogFile" class="form-label">Image:</label>
                                                    <input class="form-control" type="file" id="blogFile"
                                                        name="blogFile" accept=".png, .jpg, .jpeg" />
                                                </div>
                                                <div class="mb-3">
                                                    <img style="max-height: 250px;" alt="Blog preview" id="blogPreview"
                                                        src="/images/blog/${newBlog.image}" />
                                                </div>
                                                <button type="submit" class="btn btn-warning">Update</button>
                                                <a href="/admin/blog" class="btn btn-secondary ms-2">Cancel</a>
                                            </form:form>
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
