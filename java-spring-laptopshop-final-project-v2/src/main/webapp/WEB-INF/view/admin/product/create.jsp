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
                <title>Create Product - Cyber World</title>
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script>
                    $(document).ready(() => {
                        const avatarFile = $("#avatarFile");
                        avatarFile.change(function (e) {
                            const imgURL = URL.createObjectURL(e.target.files[0]);
                            $("#avatarPreview").attr("src", imgURL);
                            $("#avatarPreview").css({ "display": "block" });
                        });

                        $("#imageUrl").on("input", function() {
                            const url = $(this).val();
                            if (url) {
                                $("#avatarPreview").attr("src", url);
                                $("#avatarPreview").css({ "display": "block" });
                            }
                        });
                    });
                </script>
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
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
                                    <li class="breadcrumb-item"><a href="/admin/product">Product</a></li>
                                    <li class="breadcrumb-item active">Create</li>
                                </ol>
                                <div class="mt-5">
                                    <div class="row">
                                        <div class="col-md-8 col-12 mx-auto">
                                            <h3>Create a product</h3>
                                            <hr />
                                            <form:form method="post" action="/admin/product/create" class="row"
                                                enctype="multipart/form-data" modelAttribute="newProduct">
                                                <c:set var="errorName"><form:errors path="name" cssClass="invalid-feedback" /></c:set>
                                                <c:set var="errorPrice"><form:errors path="price" cssClass="invalid-feedback" /></c:set>
                                                <c:set var="errorDetailDesc"><form:errors path="detailDesc" cssClass="invalid-feedback" /></c:set>
                                                <c:set var="errorShortDesc"><form:errors path="shortDesc" cssClass="invalid-feedback" /></c:set>
                                                <c:set var="errorQuantity"><form:errors path="quantity" cssClass="invalid-feedback" /></c:set>

                                                <!-- Section 1: Basic Information -->
                                                <div class="card mb-4 px-0">
                                                    <div class="card-header bg-light"><strong>Thông tin cơ bản</strong></div>
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
                                                                class="form-control"
                                                                path="originalPrice" placeholder="Ví dụ: 19000000" />
                                                        </div>
                                                        <div class="mb-3 col-12 col-md-6">
                                                            <label class="form-label">Discounted Price:</label>
                                                            <form:input type="number" step="1"
                                                                class="form-control ${not empty errorPrice ? 'is-invalid' : ''}"
                                                                path="price" placeholder="Ví dụ: 17000000" />
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
                                                            <label class="form-label">Target (có thể chọn nhiều loại):</label>
                                                            <div class="dropdown w-100">
                                                                <button class="form-select text-start bg-white" type="button" id="targetDropdown" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false">
                                                                    Select Targets
                                                                </button>
                                                                <ul class="dropdown-menu w-100" aria-labelledby="targetDropdown">
                                                                    <li class="dropdown-item px-2 py-1">
                                                                        <div class="form-check">
                                                                            <input class="form-check-input target-checkbox" type="checkbox" value="GAMING" id="target_1">
                                                                            <label class="form-check-label w-100" for="target_1">Gaming</label>
                                                                        </div>
                                                                    </li>
                                                                    <li class="dropdown-item px-2 py-1">
                                                                        <div class="form-check">
                                                                            <input class="form-check-input target-checkbox" type="checkbox" value="SINHVIEN-VANPHONG" id="target_2">
                                                                            <label class="form-check-label w-100" for="target_2">Sinh viên - Văn phòng</label>
                                                                        </div>
                                                                    </li>
                                                                    <li class="dropdown-item px-2 py-1">
                                                                        <div class="form-check">
                                                                            <input class="form-check-input target-checkbox" type="checkbox" value="THIET-KE-DO-HOA" id="target_3">
                                                                            <label class="form-check-label w-100" for="target_3">Thiết kế đồ họa</label>
                                                                        </div>
                                                                    </li>
                                                                    <li class="dropdown-item px-2 py-1">
                                                                        <div class="form-check">
                                                                            <input class="form-check-input target-checkbox" type="checkbox" value="MONG-NHE" id="target_4">
                                                                            <label class="form-check-label w-100" for="target_4">Mỏng nhẹ</label>
                                                                        </div>
                                                                    </li>
                                                                    <li class="dropdown-item px-2 py-1">
                                                                        <div class="form-check">
                                                                            <input class="form-check-input target-checkbox" type="checkbox" value="DOANH-NHAN" id="target_5">
                                                                            <label class="form-check-label w-100" for="target_5">Doanh nhân</label>
                                                                        </div>
                                                                    </li>
                                                                </ul>
                                                                <form:input type="hidden" path="target" id="hiddenTarget" />
                                                            </div>
                                                        </div>
                                                        <div class="mb-3 col-12 col-md-6">
                                                            <label class="form-label">Color (chọn nhiều loại màu):</label>
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
                                                            <label for="avatarFile" class="form-label">Image File (có thể chọn nhiều tệp):</label>
                                                            <input class="form-control" type="file" id="avatarFile"
                                                                accept=".png, .jpg, .jpeg" name="imageFiles" multiple="multiple" />
                                                        </div>
                                                        <div class="mb-3 col-12 col-md-6">
                                                            <label class="form-label">Or Image URL:</label>
                                                            <textarea class="form-control" name="imageUrl" id="imageUrl" rows="3" placeholder="Dán các liên kết ảnh, mỗi liên kết nằm trên một dòng (nhấn Enter để xuống dòng)..."></textarea>
                                                        </div>
                                                        <div class="col-12 mb-3">
                                                            <img style="max-height: 250px; display: none;" alt="avatar preview"
                                                                id="avatarPreview" />
                                                        </div>
                                                    </div>
                                                </div>

                                                <!-- Group 1: Bộ xử lý & Đồ họa -->
                                                <div class="card mb-4 px-0">
                                                    <div class="card-header bg-light"><strong>Bộ xử lý & Đồ họa</strong></div>
                                                    <div class="card-body row">
                                                        <div class="mb-3 col-12 col-md-6"><label class="form-label">Loại card đồ họa:</label><form:input type="text" class="form-control" path="specification.gpuFullName" /></div>
                                                        <div class="mb-3 col-12 col-md-6"><label class="form-label">Loại CPU:</label><form:input type="text" class="form-control" path="specification.cpuType" /></div>
                                                    </div>
                                                </div>

                                                <!-- Group 2: Bộ nhớ RAM, Ổ cứng -->
                                                <div class="card mb-4 px-0">
                                                    <div class="card-header bg-light"><strong>Bộ nhớ RAM, Ổ cứng</strong></div>
                                                    <div class="card-body row">
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Dung lượng RAM:</label><form:input type="text" class="form-control" path="specification.ramCapacity" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Loại RAM:</label><form:input type="text" class="form-control" path="specification.ramType" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Số khe ram:</label><form:input type="text" class="form-control" path="specification.ramSlots" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Ổ cứng:</label><form:input type="text" class="form-control" path="specification.storageCapacity" /></div>
                                                    </div>
                                                </div>

                                                <!-- Group 3: Màn hình -->
                                                <div class="card mb-4 px-0">
                                                    <div class="card-header bg-light"><strong>Màn hình</strong></div>
                                                    <div class="card-body row">
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Tần số quét:</label><form:input type="text" class="form-control" path="specification.screenRefreshRate" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Chất liệu tấm nền:</label><form:input type="text" class="form-control" path="specification.screenPanel" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Kích thước màn hình:</label><form:input type="text" class="form-control" path="specification.screenTechnology" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Độ sáng:</label><form:input type="text" class="form-control" path="specification.screenBrightness" /></div>
                                                        <div class="mb-3 col-12 col-md-4"><label class="form-label">Độ phủ màu:</label><form:input type="text" class="form-control" path="specification.screenColorCoverage" /></div>
                                                        <div class="mb-3 col-12 col-md-4"><label class="form-label">Tỉ lệ màn hình:</label><form:input type="text" class="form-control" path="specification.screenRatio" /></div>
                                                        <div class="mb-3 col-12 col-md-4"><label class="form-label">Độ phân giải màn hình:</label><form:input type="text" class="form-control" path="specification.screenResolution" /></div>
                                                    </div>
                                                </div>

                                                <!-- Group 4: Âm thanh -->
                                                <div class="card mb-4 px-0">
                                                    <div class="card-header bg-light"><strong>Âm thanh</strong></div>
                                                    <div class="card-body row">
                                                        <div class="mb-3 col-12"><label class="form-label">Công nghệ âm thanh:</label><form:input type="text" class="form-control" path="specification.audioTechnology" /></div>
                                                    </div>
                                                </div>

                                                <!-- Group 5: Cổng kết nối -->
                                                <div class="card mb-4 px-0">
                                                    <div class="card-header bg-light"><strong>Cổng kết nối</strong></div>
                                                    <div class="card-body row">
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Khe đọc thẻ nhớ:</label><form:input type="text" class="form-control" path="specification.cardReader" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Wi-Fi:</label><form:input type="text" class="form-control" path="specification.wifi" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Bluetooth:</label><form:input type="text" class="form-control" path="specification.bluetooth" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Cổng giao tiếp:</label><form:input type="text" class="form-control" path="specification.ports" /></div>
                                                    </div>
                                                </div>

                                                <!-- Group 6: Kích thước & Trọng lượng -->
                                                <div class="card mb-4 px-0">
                                                    <div class="card-header bg-light"><strong>Kích thước & Trọng lượng</strong></div>
                                                    <div class="card-body row">
                                                        <div class="mb-3 col-12 col-md-4"><label class="form-label">Chất liệu:</label><form:input type="text" class="form-control" path="specification.material" /></div>
                                                        <div class="mb-3 col-12 col-md-4"><label class="form-label">Chất liệu vỏ trên:</label><form:input type="text" class="form-control" path="specification.materialTop" /></div>
                                                        <div class="mb-3 col-12 col-md-4"><label class="form-label">Chất liệu vỏ dưới:</label><form:input type="text" class="form-control" path="specification.materialBottom" /></div>
                                                        <div class="mb-3 col-12 col-md-6"><label class="form-label">Kích thước:</label><form:input type="text" class="form-control" path="specification.dimensions" /></div>
                                                        <div class="mb-3 col-12 col-md-6"><label class="form-label">Trọng lượng:</label><form:input type="text" class="form-control" path="specification.weight" /></div>
                                                    </div>
                                                </div>

                                                <!-- Group 7: Tiện ích khác -->
                                                <div class="card mb-4 px-0">
                                                    <div class="card-header bg-light"><strong>Tiện ích khác</strong></div>
                                                    <div class="card-body row">
                                                        <div class="mb-3 col-12"><label class="form-label">Tính năng đặc biệt:</label><form:input type="text" class="form-control" path="specification.specialFeatures" /></div>
                                                    </div>
                                                </div>

                                                <!-- Group 8: Tính năng khác -->
                                                <div class="card mb-4 px-0">
                                                    <div class="card-header bg-light"><strong>Tính năng khác</strong></div>
                                                    <div class="card-body row">
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Loại đèn bàn phím:</label><form:input type="text" class="form-control" path="specification.keyboardLight" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Bảo mật:</label><form:input type="text" class="form-control" path="specification.security" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Webcam:</label><form:input type="text" class="form-control" path="specification.webcam" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">OS Name:</label><form:input type="text" class="form-control" path="specification.osName" /></div>
                                                        <div class="mb-3 col-12 col-md-12"><label class="form-label">OS Version:</label><form:input type="text" class="form-control" path="specification.osVersion" /></div>
                                                    </div>
                                                </div>

                                                <!-- Group 9: Pin & công nghệ sạc -->
                                                <div class="card mb-4 px-0">
                                                    <div class="card-header bg-light"><strong>Pin & công nghệ sạc</strong></div>
                                                    <div class="card-body row">
                                                        <div class="mb-3 col-12 col-md-6"><label class="form-label">Pin (Dung lượng pin):</label><form:input type="text" class="form-control" path="specification.batteryCapacity" /></div>
                                                        <div class="mb-3 col-12 col-md-6"><label class="form-label">Công nghệ sạc (Power Supply):</label><form:input type="text" class="form-control" path="specification.powerSupply" /></div>
                                                    </div>
                                                </div>

                                                <!-- Group 10: Thông tin hàng hóa -->
                                                <div class="card mb-4 px-0">
                                                    <div class="card-header bg-light"><strong>Thông tin hàng hóa</strong></div>
                                                    <div class="card-body row">
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">P/N:</label><form:input type="text" class="form-control" path="specification.partNumber" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Xuất xứ:</label><form:input type="text" class="form-control" path="specification.origin" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Năm ra mắt:</label><form:input type="text" class="form-control" path="specification.releaseYear" /></div>
                                                        <div class="mb-3 col-12 col-md-3"><label class="form-label">Thời gian bảo hành:</label><form:input type="text" class="form-control" path="specification.warranty" /></div>
                                                    </div>
                                                </div>

                                                <div class="col-12 mb-5">
                                                    <button type="submit" class="btn btn-primary px-4">Create</button>
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
