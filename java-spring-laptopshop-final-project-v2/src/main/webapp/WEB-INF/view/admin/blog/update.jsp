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
                                                    <label class="form-label">Type:</label>
                                                    <form:select class="form-control" path="type" id="blogType">
                                                        <form:option value="ARTICLE">Article</form:option>
                                                        <form:option value="VIDEO">Video</form:option>
                                                    </form:select>
                                                </div>
                                                <div class="mb-3" id="videoUrlContainer" style="${newBlog.type == 'VIDEO' ? '' : 'display: none;'}">
                                                    <label class="form-label">Video URL (optional, if you have a link):</label>
                                                    <form:input type="text" class="form-control" path="videoUrl" placeholder="Enter video link (e.g., YouTube URL)" />
                                                    
                                                    <label class="form-label mt-2">Or Upload Video File (max 200MB):</label>
                                                    <input class="form-control" type="file" name="videoFile" accept=".mp4, .avi, .mkv, .webm" />
                                                </div>
                                                <script>
                                                    $(document).ready(function() {
                                                        $('#blogType').change(function() {
                                                            if ($(this).val() === 'VIDEO') {
                                                                $('#videoUrlContainer').show();
                                                                
                                                            } else {
                                                                $('#videoUrlContainer').hide();
                                                                
                                                            }
                                                        });
                                                    });
                                                </script>
                                                <div class="mb-3">
                                                    <label class="form-label">Content:</label>
                                                    <form:textarea class="form-control" path="content" rows="8" />
                                                </div>
                                                <div class="mb-3" id="imageContainer" >
                                                    <label class="form-label">Image URL (optional, if you have a link):</label><input class="form-control" type="text" name="imageUrl" placeholder="Enter image link (e.g., https://...)" value="${(not empty newBlog.image and newBlog.image.startsWith('http')) ? newBlog.image : ''}" /><label for="blogFile" class="form-label mt-2">Or Upload Image File:</label>
                                                    <input class="form-control" type="file" id="blogFile"
                                                        name="blogFile" accept=".png, .jpg, .jpeg" />
                                                    <img style="max-height: 250px; margin-top: 10px;" alt="Blog preview" id="blogPreview"
                                                        src="${newBlog.displayImage}" />
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

