<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="Cyber World - Dá»± Ã¡n cyberworld" />
                <meta name="author" content="Cyber World" />
                <title>Update Product - Cyber World</title>
                <link href="/css/styles.css" rel="stylesheet" />

                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

                <script>
                    $(document).ready(() => {
                        function appendImage(src) {
                            const img = $("<img>").attr("src", src).css({
                                "max-height": "250px",
                                "margin-right": "10px",
                                "margin-bottom": "10px",
                                "border": "1px solid #ccc",
                                "border-radius": "4px",
                                "padding": "5px"
                            });
                            $("#previewContainer").append(img);
                        }

                        function updatePreviews() {
                            const container = $("#previewContainer");
                            container.empty();
                            
                            let hasNewPreviews = false;
                            
                            const files = $("#avatarFile")[0].files;
                            if (files && files.length > 0) {
                                hasNewPreviews = true;
                                for (let i = 0; i < files.length; i++) {
                                    const imgURL = URL.createObjectURL(files[i]);
                                    appendImage(imgURL);
                                }
                            }
                            const text = $("#imageUrl").val();
                            if (text) {
                                hasNewPreviews = true;
                                const urls = text.split(/[\n,]+/);
                                urls.forEach(url => {
                                    const trimmedUrl = url.trim();
                                    if (trimmedUrl) {
                                        appendImage(trimmedUrl);
                                    }
                                });
                            }

                            if (!hasNewPreviews) {
                                // show existing images
                                <c:forEach items="${newProduct.images}" var="img">
                                    appendImage("${img}");
                                </c:forEach>
                            }
                        }

                        updatePreviews();

                        $("#avatarFile").change(updatePreviews);
                        $("#imageUrl").on("input", updatePreviews);
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
                                <h1 class="mt-4">Products</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item"><a href="/admin/product?page=${page}">Product</a></li>
                                    <li class="breadcrumb-item active">Update</li>
                                </ol>
                                <div class=" mt-5">
                                    <div class="row">
                                        <div class="col-md-8 col-12 mx-auto">
                                            <h3>Update a product</h3>
                                            <hr />
                                            <form:form method="post" action="/admin/product/update?page=${page}" class="row"
                                                enctype="multipart/form-data" modelAttribute="newProduct">
                                                <c:set var="errorName"><form:errors path="name" cssClass="invalid-feedback" /></c:set>
                                                <c:set var="errorPrice"><form:errors path="price" cssClass="invalid-feedback" /></c:set>
                                                <c:set var="errorDetailDesc"><form:errors path="detailDesc" cssClass="invalid-feedback" /></c:set>
                                                <c:set var="errorShortDesc"><form:errors path="shortDesc" cssClass="invalid-feedback" /></c:set>
                                                <c:set var="errorQuantity"><form:errors path="quantity" cssClass="invalid-feedback" /></c:set>
                                                <c:set var="errorOriginalPrice"><form:errors path="originalPrice" cssClass="invalid-feedback" /></c:set>

                                                <div class="mb-3" style="display: none;">
                                                    <label class="form-label">Id:</label>
                                                    <form:input type="text" class="form-control" path="id" />
                                                </div>

                                                <!-- Section 1: Basic Information -->
                                                <div class="card mb-4 px-0">
                                                    <div class="card-header bg-light"><strong>Basic Information</strong></div>
                                                    <div class="card-body row">
                                                        <div class="mb-3 col-12 col-md-6">
                                                            <label class="form-label">Name:</label>
                                                            <form:input type="text"
                                                                class="form-control ${not empty errorName ? 'is-invalid' : ''}"
                                                                path="name" />
                                                            ${errorName}
                                                        </div>
                                                        <div class="mb-3 col-12 col-md-6">
                                                            <label class="form-label">Original Price:</label>
                                                            <form:input type="number" step="1"
                                                                class="form-control ${not empty errorOriginalPrice ? 'is-invalid' : ''}"
                                                                path="originalPrice" placeholder="Example: 19000000" />
                                                            ${errorOriginalPrice}
                                                        </div>
                                                        <div class="mb-3 col-12 col-md-6">
                                                            <label class="form-label">Discounted Price:</label>
                                                            <form:input type="number" step="1"
                                                                class="form-control ${not empty errorPrice ? 'is-invalid' : ''}"
                                                                path="price" placeholder="Example: 17000000" />
                                                            ${errorPrice}
                                                        </div>
                                                        <div class="mb-3 col-12 col-md-6">
                                                            <label class="form-label">Promo End Date:</label>
                                                            <form:input type="datetime-local"
                                                                class="form-control"
                                                                path="promoEndDate" />
                                                        </div>
                                                        <div class="mb-3 col-12">
                                                            <label class="form-label">Detail description:</label>
                                                            <form:textarea type="text"
                                                                class="form-control ${not empty errorDetailDesc ? 'is-invalid' : ''}"
                                                                path="detailDesc" />
                                                            ${errorDetailDesc}
                                                        </div>
                                                        <div class="mb-3 col-12 col-md-6">
                                                            <label class="form-label">Short description:</label>
                                                            <form:input type="text"
                                                                class="form-control ${not empty errorShortDesc ? 'is-invalid' : ''}"
                                                                path="shortDesc" />
                                                            ${errorShortDesc}
                                                        </div>
                                                        <div class="mb-3 col-12 col-md-6">
                                                            <label class="form-label">Quantity:</label>
                                                            <form:input type="number"
                                                                class="form-control ${not empty errorQuantity ? 'is-invalid' : ''}"
                                                                path="quantity" />
                                                            ${errorQuantity}
                                                        </div>
                                                        <div class="mb-3 col-12 col-md-6">
                                                            <label class="form-label">Factory:</label>
                                                            <form:select class="form-select" path="factory">
                                                                <form:option value="APPLE">Apple (MacBook)</form:option>
                                                                <form:option value="ASUS">Asus</form:option>
                                                                <form:option value="LENOVO">Lenovo</form:option>
                                                                <form:option value="DELL">Dell</form:option>
                                                                <form:option value="LG">LG</form:option>
                                                                <form:option value="ACER">Acer</form:option>
                                                            </form:select>
                                                        </div>
                                                        <div class="mb-3 col-12 col-md-6">
                                                            <label class="form-label">Target:</label>
                                                            <div class="dropdown w-100">
                                                                <button class="form-select text-start bg-white" type="button" id="targetDropdown" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
                                                                    Select Targets
                                                                </button>
                                                                <ul class="dropdown-menu w-100" aria-labelledby="targetDropdown">
                                                                    <li class="dropdown-item px-2 py-1"><div class="form-check"><input class="form-check-input target-checkbox" type="checkbox" value="GAMING" id="target_1"><label class="form-check-label w-100" for="target_1">Gaming</label></div></li>
                                                                    <li class="dropdown-item px-2 py-1"><div class="form-check"><input class="form-check-input target-checkbox" type="checkbox" value="SINHVIEN-VANPHONG" id="target_2"><label class="form-check-label w-100" for="target_2">Student - Office</label></div></li>
                                                                    <li class="dropdown-item px-2 py-1"><div class="form-check"><input class="form-check-input target-checkbox" type="checkbox" value="THIET-KE-DO-HOA" id="target_3"><label class="form-check-label w-100" for="target_3">Graphic Design</label></div></li>
                                                                    <li class="dropdown-item px-2 py-1"><div class="form-check"><input class="form-check-input target-checkbox" type="checkbox" value="MONG-NHE" id="target_4"><label class="form-check-label w-100" for="target_4">Thin & Light</label></div></li>
                                                                    <li class="dropdown-item px-2 py-1"><div class="form-check"><input class="form-check-input target-checkbox" type="checkbox" value="DOANH-NHAN" id="target_5"><label class="form-check-label w-100" for="target_5">Business</label></div></li>
                                                                    <li class="dropdown-item px-2 py-1"><div class="form-check"><input class="form-check-input target-checkbox" type="checkbox" value="AI-LAPTOP" id="target_6"><label class="form-check-label w-100" for="target_6">AI Laptop</label></div></li>
                                                                </ul>
                                                                <form:input type="hidden" path="target" id="hiddenTarget" />
                                                            </div>
                                                        </div>
                                                        <div class="mb-3 col-12 col-md-6">
                                                            <label class="form-label">Color:</label>
                                                            <div class="dropdown w-100">
                                                                <button class="form-select text-start bg-white" type="button" id="colorDropdown" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
                                                                    Select Colors
                                                                </button>
                                                                <ul class="dropdown-menu w-100" aria-labelledby="colorDropdown" style="max-height: 250px; overflow-y: auto;">
                                                                    <li class="dropdown-item px-2 py-1"><div class="form-check"><input class="form-check-input color-checkbox" type="checkbox" value="Black" id="col_black"><label class="form-check-label w-100" for="col_black">Black</label></div></li>
                                                                    <li class="dropdown-item px-2 py-1"><div class="form-check"><input class="form-check-input color-checkbox" type="checkbox" value="White" id="col_white"><label class="form-check-label w-100" for="col_white">White</label></div></li>
                                                                    <li class="dropdown-item px-2 py-1"><div class="form-check"><input class="form-check-input color-checkbox" type="checkbox" value="Silver" id="col_silver"><label class="form-check-label w-100" for="col_silver">Silver</label></div></li>
                                                                    <li class="dropdown-item px-2 py-1"><div class="form-check"><input class="form-check-input color-checkbox" type="checkbox" value="Gray" id="col_gray"><label class="form-check-label w-100" for="col_gray">Gray</label></div></li>
                                                                    <li class="dropdown-item px-2 py-1"><div class="form-check"><input class="form-check-input color-checkbox" type="checkbox" value="Space Gray" id="col_s_gray"><label class="form-check-label w-100" for="col_s_gray">Space Gray</label></div></li>
                                                                    <li class="dropdown-item px-2 py-1"><div class="form-check"><input class="form-check-input color-checkbox" type="checkbox" value="Blue" id="col_blue"><label class="form-check-label w-100" for="col_blue">Blue</label></div></li>
                                                                    <li class="dropdown-item px-2 py-1"><div class="form-check"><input class="form-check-input color-checkbox" type="checkbox" value="Green" id="col_green"><label class="form-check-label w-100" for="col_green">Green</label></div></li>
                                                                    <li class="dropdown-item px-2 py-1"><div class="form-check"><input class="form-check-input color-checkbox" type="checkbox" value="Pink" id="col_pink"><label class="form-check-label w-100" for="col_pink">Pink</label></div></li>
                                                                    <li class="dropdown-item px-2 py-1"><div class="form-check"><input class="form-check-input color-checkbox" type="checkbox" value="Gold" id="col_gold"><label class="form-check-label w-100" for="col_gold">Gold</label></div></li>
                                                                    <li class="dropdown-item px-2 py-1"><div class="form-check"><input class="form-check-input color-checkbox" type="checkbox" value="Purple" id="col_purple"><label class="form-check-label w-100" for="col_purple">Purple</label></div></li>
                                                                </ul>
                                                                <form:input type="hidden" path="color" id="hiddenColor" />
                                                            </div>
                                                        </div>
                                                        <div class="mb-3 col-12 col-md-6">
                                                             <label for="avatarFile" class="form-label">Image File:</label>
                                                             <input class="form-control" type="file" id="avatarFile"
                                                                 accept=".png, .jpg, .jpeg" name="imageFiles" multiple="multiple" />
                                                         </div>
                                                         <div class="mb-3 col-12 col-md-6">
                                                             <label class="form-label">Or Image URL:</label>
                                                             <textarea class="form-control" name="imageUrl" id="imageUrl" rows="3" placeholder="Paste image URLs here, each on a new line (press Enter to separate)..."></textarea>
                                                         </div>
                                                        <div class="col-12 mb-3" id="previewContainer">
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Group 1: Processor & Graphics -->
                                                <div class="card mb-4 px-0">
                                                    <div class="card-header bg-light"><strong>Processor & Graphics</strong></div>
                                                    <div class="card-body row">
                                                        <div class="mb-3 col-12 col-md-6"><label class="form-label">GPU Type:</label><form:input type="text" class="form-control" path="specification.gpuFullName" /></div>
                                                        <div class="mb-3 col-12 col-md-6"><label class="form-label">CPU Type:</label><form:input type="text" class="form-control" path="specification.cpuType" /></div>
                                                    </div>
                                                </div>

                                                <!-- Group 2: Memory & Storage -->
                                                <div class="card mb-4 px-0">
                                                    <div class="card-header bg-light"><strong>Memory & Storage</strong></div>
                                                    <div class="card-body row">
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">RAM Capacity:</label><form:input type="text" class="form-control" path="specification.ramCapacity" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">RAM Type:</label><form:input type="text" class="form-control" path="specification.ramType" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">RAM Slots:</label><form:input type="text" class="form-control" path="specification.ramSlots" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Storage:</label><form:input type="text" class="form-control" path="specification.storageCapacity" /></div>
                                                    </div>
                                                </div>

                                                <!-- Group 3: Display -->
                                                <div class="card mb-4 px-0">
                                                    <div class="card-header bg-light"><strong>Display</strong></div>
                                                    <div class="card-body row">
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Refresh Rate:</label><form:input type="text" class="form-control" path="specification.screenRefreshRate" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Panel Type:</label><form:input type="text" class="form-control" path="specification.screenPanel" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Screen Technology:</label><form:input type="text" class="form-control" path="specification.screenTechnology" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Brightness:</label><form:input type="text" class="form-control" path="specification.screenBrightness" /></div>
                                                        <div class="mb-3 col-12 col-md-4"><label class="form-label">Color Coverage:</label><form:input type="text" class="form-control" path="specification.screenColorCoverage" /></div>
                                                        <div class="mb-3 col-12 col-md-4"><label class="form-label">Screen Ratio:</label><form:input type="text" class="form-control" path="specification.screenRatio" /></div>
                                                        <div class="mb-3 col-12 col-md-4"><label class="form-label">Screen Resolution:</label><form:input type="text" class="form-control" path="specification.screenResolution" /></div>
                                                    </div>
                                                </div>

                                                <!-- Group 4: Audio -->
                                                <div class="card mb-4 px-0">
                                                    <div class="card-header bg-light"><strong>Audio</strong></div>
                                                    <div class="card-body row">
                                                        <div class="mb-3 col-12"><label class="form-label">Audio Technology:</label><form:input type="text" class="form-control" path="specification.audioTechnology" /></div>
                                                    </div>
                                                </div>

                                                <!-- Group 5: Connectivity -->
                                                <div class="card mb-4 px-0">
                                                    <div class="card-header bg-light"><strong>Connectivity</strong></div>
                                                    <div class="card-body row">
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Card Reader:</label><form:input type="text" class="form-control" path="specification.cardReader" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Wi-Fi:</label><form:input type="text" class="form-control" path="specification.wifi" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Bluetooth:</label><form:input type="text" class="form-control" path="specification.bluetooth" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Ports:</label><form:input type="text" class="form-control" path="specification.ports" /></div>
                                                    </div>
                                                </div>

                                                <!-- Group 6: Dimensions & Weight -->
                                                <div class="card mb-4 px-0">
                                                    <div class="card-header bg-light"><strong>Dimensions & Weight</strong></div>
                                                    <div class="card-body row">
                                                        <div class="mb-3 col-12 col-md-4"><label class="form-label">Material:</label><form:input type="text" class="form-control" path="specification.material" /></div>
                                                        <div class="mb-3 col-12 col-md-4"><label class="form-label">Top Cover Material:</label><form:input type="text" class="form-control" path="specification.materialTop" /></div>
                                                        <div class="mb-3 col-12 col-md-4"><label class="form-label">Bottom Cover Material:</label><form:input type="text" class="form-control" path="specification.materialBottom" /></div>
                                                        <div class="mb-3 col-12 col-md-6"><label class="form-label">Dimensions:</label><form:input type="text" class="form-control" path="specification.dimensions" /></div>
                                                        <div class="mb-3 col-12 col-md-6"><label class="form-label">Weight:</label><form:input type="text" class="form-control" path="specification.weight" /></div>
                                                    </div>
                                                </div>

                                                <!-- Group 7: Other Utilities -->
                                                <div class="card mb-4 px-0">
                                                    <div class="card-header bg-light"><strong>Other Utilities</strong></div>
                                                    <div class="card-body row">
                                                        <div class="mb-3 col-12"><label class="form-label">Special Features:</label><form:input type="text" class="form-control" path="specification.specialFeatures" /></div>
                                                    </div>
                                                </div>

                                                <!-- Group 8: Other Features -->
                                                <div class="card mb-4 px-0">
                                                    <div class="card-header bg-light"><strong>Other Features</strong></div>
                                                    <div class="card-body row">
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Keyboard Backlight:</label><form:input type="text" class="form-control" path="specification.keyboardLight" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Security:</label><form:input type="text" class="form-control" path="specification.security" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Webcam:</label><form:input type="text" class="form-control" path="specification.webcam" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">OS Name:</label><form:input type="text" class="form-control" path="specification.osName" /></div>
                                                        <div class="mb-3 col-12 col-md-12"><label class="form-label">OS Version:</label><form:input type="text" class="form-control" path="specification.osVersion" /></div>
                                                    </div>
                                                </div>

                                                <!-- Group 9: Battery & Power -->
                                                <div class="card mb-4 px-0">
                                                    <div class="card-header bg-light"><strong>Battery & Power</strong></div>
                                                    <div class="card-body row">
                                                        <div class="mb-3 col-12 col-md-6"><label class="form-label">Battery Capacity:</label><form:input type="text" class="form-control" path="specification.batteryCapacity" /></div>
                                                        <div class="mb-3 col-12 col-md-6"><label class="form-label">Power Supply:</label><form:input type="text" class="form-control" path="specification.powerSupply" /></div>
                                                    </div>
                                                </div>

                                                <!-- Group 10: Product Details -->
                                                <div class="card mb-4 px-0">
                                                    <div class="card-header bg-light"><strong>Product Details</strong></div>
                                                    <div class="card-body row">
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">P/N:</label><form:input type="text" class="form-control" path="specification.partNumber" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Origin:</label><form:input type="text" class="form-control" path="specification.origin" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Release Year:</label><form:input type="text" class="form-control" path="specification.releaseYear" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Warranty Period:</label><form:input type="text" class="form-control" path="specification.warranty" /></div>
                                                        <div class="mb-3 col-12"><label class="form-label">Accessories:</label><form:input type="text" class="form-control" path="specification.accessories" /></div>
                                                    </div>
                                                </div>

                                                <div class="col-12 mb-5">
                                                    <button type="submit" class="btn btn-warning px-4">Update</button>
                                                </div>
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

                <script>
                    $(document).ready(function() {
                        var initialTargets = $('#hiddenTarget').val();
                        if (initialTargets) {
                            var targetArr = initialTargets.split(',');
                            $('.target-checkbox').each(function() {
                                if (targetArr.includes($(this).val())) {
                                    $(this).prop('checked', true);
                                }
                            });
                            var selectedText = targetArr.length > 0 ? targetArr.length + " selected" : "Select Targets";
                            $('#targetDropdown').text(selectedText);
                        }
                
                        var initialColors = $('#hiddenColor').val();
                        if (initialColors) {
                            var colorArr = initialColors.split(',');
                            $('.color-checkbox').each(function() {
                                if (colorArr.includes($(this).val())) {
                                    $(this).prop('checked', true);
                                }
                            });
                            var selectedColorText = colorArr.length > 0 ? colorArr.length + " selected" : "Select Colors";
                            $('#colorDropdown').text(selectedColorText);
                        }
                
                        $('.color-checkbox').change(function() {
                            var selectedColors = [];
                            $('.color-checkbox:checked').each(function() {
                                selectedColors.push($(this).val());
                            });
                            $('#hiddenColor').val(selectedColors.join(','));
                            var text = selectedColors.length > 0 ? selectedColors.length + " selected" : "Select Colors";
                            $('#colorDropdown').text(text);
                        });

                        $('.target-checkbox').change(function() {
                            var selected = [];
                            $('.target-checkbox:checked').each(function() {
                                selected.push($(this).val());
                            });
                            $('#hiddenTarget').val(selected.join(','));
                            var text = selected.length > 0 ? selected.length + " selected" : "Select Targets";
                            $('#targetDropdown').text(text);
                        });
                    });
                </script>

            </body>

            </html>
