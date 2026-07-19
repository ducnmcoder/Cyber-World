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
                        const avatarFile = $("#avatarFile");
                        const orgImage = "${newProduct.image}";
                        if (orgImage) {
                            const urlImage = "/images/product/" + orgImage;
                            $("#avatarPreview").attr("src", urlImage);
                            $("#avatarPreview").css({ "display": "block" });
                        }

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
                                    <li class="breadcrumb-item active">Update</li>
                                </ol>
                                <div class=" mt-5">
                                    <div class="row">
                                        <div class="col-md-6 col-12 mx-auto">
                                            <h3>Update a product</h3>
                                            <hr />
                                            <form:form method="post" action="/admin/product/update" class="row"
                                                enctype="multipart/form-data" modelAttribute="newProduct">
                                                <c:set var="errorName">
                                                    <form:errors path="name" cssClass="invalid-feedback" />
                                                </c:set>
                                                <c:set var="errorPrice">
                                                    <form:errors path="price" cssClass="invalid-feedback" />
                                                </c:set>
                                                <c:set var="errorDetailDesc">
                                                    <form:errors path="detailDesc" cssClass="invalid-feedback" />
                                                </c:set>
                                                <c:set var="errorShortDesc">
                                                    <form:errors path="shortDesc" cssClass="invalid-feedback" />
                                                </c:set>
                                                <c:set var="errorQuantity">
                                                    <form:errors path="quantity" cssClass="invalid-feedback" />
                                                </c:set>

                                                <div class="mb-3" style="display: none;">
                                                    <label class="form-label">Id:</label>
                                                    <form:input type="text" class="form-control" path="id" />
                                                </div>

                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Name:</label>
                                                    <form:input type="text"
                                                        class="form-control ${not empty errorName ? 'is-invalid' : ''}"
                                                        path="name" />
                                                    ${errorName}
                                                </div>
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Price:</label>
                                                    <form:input type="number"
                                                        class="form-control ${not empty errorPrice ? 'is-invalid' : ''}"
                                                        path="price" />
                                                    ${errorPrice}
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
                                                              <li class="dropdown-item px-2 py-1">
                                                                  <div class="form-check">
                                                                      <input class="form-check-input target-checkbox" type="checkbox" value="GAMING" id="target_1">
                                                                      <label class="form-check-label w-100" for="target_1">Gaming</label>
                                                                  </div>
                                                              </li>
                                                              <li class="dropdown-item px-2 py-1">
                                                                  <div class="form-check">
                                                                      <input class="form-check-input target-checkbox" type="checkbox" value="SINHVIEN-VANPHONG" id="target_2">
                                                                      <label class="form-check-label w-100" for="target_2">Sinh viÃªn - VÄƒn phÃ²ng</label>
                                                                  </div>
                                                              </li>
                                                              <li class="dropdown-item px-2 py-1">
                                                                  <div class="form-check">
                                                                      <input class="form-check-input target-checkbox" type="checkbox" value="THIET-KE-DO-HOA" id="target_3">
                                                                      <label class="form-check-label w-100" for="target_3">Thiáº¿t káº¿ Ä‘á»“ há»a</label>
                                                                  </div>
                                                              </li>
                                                              <li class="dropdown-item px-2 py-1">
                                                                  <div class="form-check">
                                                                      <input class="form-check-input target-checkbox" type="checkbox" value="MONG-NHE" id="target_4">
                                                                      <label class="form-check-label w-100" for="target_4">Má»ng nháº¹</label>
                                                                  </div>
                                                              </li>
                                                              <li class="dropdown-item px-2 py-1">
                                                                  <div class="form-check">
                                                                      <input class="form-check-input target-checkbox" type="checkbox" value="DOANH-NHAN" id="target_5">
                                                                      <label class="form-check-label w-100" for="target_5">Doanh nhÃ¢n</label>
                                                                  </div>
                                                              </li>
                                                          </ul>
                                                          <form:input type="hidden" path="target" id="hiddenTarget" />
                                                      </div>
                                                  </div>
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">CPU:</label>
                                                    <form:input type="text" class="form-control" path="cpu" />
                                                </div>
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">RAM:</label>
                                                    <form:input type="text" class="form-control" path="ram" />
                                                </div>
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Screen Size:</label>
                                                    <form:input type="text" class="form-control" path="screenSize" />
                                                </div>
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Storage:</label>
                                                    <form:input type="text" class="form-control" path="storage" />
                                                </div>
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Color:</label>
                                                    <form:input type="text" class="form-control" path="color" />
                                                </div>
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label for="avatarFile" class="form-label">Image File:</label>
                                                    <input class="form-control" type="file" id="avatarFile"
                                                        accept=".png, .jpg, .jpeg" name="imageFile" />
                                                </div>
                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Or Image URL:</label>
                                                    <input type="text" class="form-control" name="imageUrl" id="imageUrl" placeholder="http://example.com/image.jpg" />
                                                </div>
                                                <div class="col-12 mb-3">
                                                    <img style="max-height: 250px; display: none;" alt="avatar preview"
                                                        id="avatarPreview" />
                                                </div>
                                                <h4 class="mt-5 mb-3 w-100" style="border-bottom: 1px solid #ccc; padding-bottom: 10px;">Detailed Specifications</h4>
<div class="mb-3 col-12 col-md-4"><label class="form-label">CPU Company:</label><form:input type="text" class="form-control" path="specification.cpuCompany" /></div>
<div class="mb-3 col-12 col-md-4">
    <label class="form-label">CPU Technology:</label>
    <form:input type="text" class="form-control" path="specification.cpuTechnology" list="cpuTechList" />
    <datalist id="cpuTechList">
        <option value="Apple M5 series"></option>
        <option value="Apple M4 series"></option>
        <option value="Intel Core Ultra X"></option>
        <option value="Intel Core Ultra 9"></option>
        <option value="Intel Core Ultra 7"></option>
        <option value="CPU háº­u tá»‘ H"></option>
    </datalist>
</div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">CPU Type:</label><form:input type="text" class="form-control" path="specification.cpuType" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">CPU Speed:</label><form:input type="text" class="form-control" path="specification.cpuSpeed" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">CPU Max Speed:</label><form:input type="text" class="form-control" path="specification.cpuMaxSpeed" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">GPU Company:</label><form:input type="text" class="form-control" path="specification.gpuCompany" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">GPU Model:</label><form:input type="text" class="form-control" path="specification.gpuModel" /></div>
<div class="mb-3 col-12 col-md-4">
    <label class="form-label">GPU Full Name:</label>
    <form:input type="text" class="form-control" path="specification.gpuFullName" list="gpuList" />
    <datalist id="gpuList">
        <option value="NVIDIA GeForce MX Series"></option>
        <option value="NVIDIA GeForce RTX 30 Series"></option>
        <option value="NVIDIA GeForce RTX 40 Series"></option>
        <option value="NVIDIA GeForce RTX 50 Series"></option>
    </datalist>
</div>
<div class="mb-3 col-12 col-md-4">
    <label class="form-label">RAM Capacity:</label>
    <form:input type="text" class="form-control" path="specification.ramCapacity" list="ramList" />
    <datalist id="ramList">
        <option value="8GB"></option>
        <option value="16GB"></option>
        <option value="32GB"></option>
        <option value="64GB"></option>
        <option value="128GB"></option>
        <option value="512GB"></option>
    </datalist>
</div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">RAM Type:</label><form:input type="text" class="form-control" path="specification.ramType" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">RAM Slots:</label><form:input type="text" class="form-control" path="specification.ramSlots" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">RAM Remaining Slots:</label><form:input type="text" class="form-control" path="specification.ramRemainingSlots" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">RAM Max Support:</label><form:input type="text" class="form-control" path="specification.ramMaxSupport" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Storage Type:</label><form:input type="text" class="form-control" path="specification.storageType" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Storage Total Slots:</label><form:input type="text" class="form-control" path="specification.storageTotalSlots" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Storage Remaining Slots:</label><form:input type="text" class="form-control" path="specification.storageRemainingSlots" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Storage Max Upgrade:</label><form:input type="text" class="form-control" path="specification.storageMaxUpgrade" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Storage SSD Type:</label><form:input type="text" class="form-control" path="specification.storageSsdType" /></div>
<div class="mb-3 col-12 col-md-4">
    <label class="form-label">Storage Capacity:</label>
    <form:input type="text" class="form-control" path="specification.storageCapacity" list="storageList" />
    <datalist id="storageList">
        <option value="128 GB"></option>
        <option value="256 GB"></option>
        <option value="512 GB"></option>
        <option value="1 TB"></option>
        <option value="2 TB"></option>
    </datalist>
</div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Screen Technology:</label><form:input type="text" class="form-control" path="specification.screenTechnology" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Screen Resolution:</label><form:input type="text" class="form-control" path="specification.screenResolution" /></div>
<div class="mb-3 col-12 col-md-4">
    <label class="form-label">Screen Refresh Rate:</label>
    <form:input type="text" class="form-control" path="specification.screenRefreshRate" list="refreshRateList" />
    <datalist id="refreshRateList">
        <option value="<= 120 Hz"></option>
        <option value="144 Hz"></option>
        <option value="165 Hz"></option>
        <option value="240 Hz"></option>
    </datalist>
</div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Screen Panel:</label><form:input type="text" class="form-control" path="specification.screenPanel" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Screen Brightness:</label><form:input type="text" class="form-control" path="specification.screenBrightness" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Screen Color Coverage:</label><form:input type="text" class="form-control" path="specification.screenColorCoverage" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Screen Ratio:</label><form:input type="text" class="form-control" path="specification.screenRatio" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Ports:</label><form:input type="text" class="form-control" path="specification.ports" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Wi-Fi:</label><form:input type="text" class="form-control" path="specification.wifi" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Bluetooth:</label><form:input type="text" class="form-control" path="specification.bluetooth" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Webcam:</label><form:input type="text" class="form-control" path="specification.webcam" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">OS Name:</label><form:input type="text" class="form-control" path="specification.osName" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">OS Version:</label><form:input type="text" class="form-control" path="specification.osVersion" /></div>
<div class="mb-3 col-12 col-md-4">
    <label class="form-label">Security:</label>
    <form:input type="text" class="form-control" path="specification.security" list="securityList" />
    <datalist id="securityList">
        <option value="Fingerprint"></option>
        <option value="Face ID"></option>
    </datalist>
</div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Keyboard Type:</label><form:input type="text" class="form-control" path="specification.keyboardType" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Numpad:</label><form:input type="text" class="form-control" path="specification.numpad" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Keyboard Light:</label><form:input type="text" class="form-control" path="specification.keyboardLight" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Touchpad:</label><form:input type="text" class="form-control" path="specification.touchpad" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Battery Capacity:</label><form:input type="text" class="form-control" path="specification.batteryCapacity" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Power Supply:</label><form:input type="text" class="form-control" path="specification.powerSupply" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Accessories:</label><form:input type="text" class="form-control" path="specification.accessories" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Dimensions:</label><form:input type="text" class="form-control" path="specification.dimensions" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Weight:</label><form:input type="text" class="form-control" path="specification.weight" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Material:</label><form:input type="text" class="form-control" path="specification.material" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Part Number:</label><form:input type="text" class="form-control" path="specification.partNumber" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Origin:</label><form:input type="text" class="form-control" path="specification.origin" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Release Year:</label><form:input type="text" class="form-control" path="specification.releaseYear" /></div>
<div class="mb-3 col-12 col-md-4"><label class="form-label">Warranty:</label><form:input type="text" class="form-control" path="specification.warranty" /></div>
<div class="col-12 mb-5">
    <button type="submit" class="btn btn-warning">Update</button>
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
