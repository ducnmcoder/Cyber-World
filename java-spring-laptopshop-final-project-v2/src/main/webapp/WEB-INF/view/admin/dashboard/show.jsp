<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8" />
            <meta http-equiv="X-UA-Compatible" content="IE=edge" />
            <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
            <meta name="description" content="Cyber World - Dự án cyberworld" />
            <meta name="author" content="Cyber World" />
            <title>Dashboard - Cyber World</title>
            <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
            <link href="css/styles.css" rel="stylesheet" />
            <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        </head>

        <body class="sb-nav-fixed">
            <jsp:include page="../layout/header.jsp" />
            <div id="layoutSidenav">
                <jsp:include page="../layout/sidebar.jsp" />
                <div id="layoutSidenav_content">
                    <main>
                        <div class="container-fluid px-4">
                            <h1 class="mt-4">Dashboard</h1>
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item active">Statistics</li>
                            </ol>
                            <div class="row">
                                <div class="col-12">
                                    <div class="card mb-4">
                                        <div class="card-header">
                                            <i class="fas fa-chart-bar me-1"></i>
                                            Revenue by Month
                                        </div>
                                        <div class="card-body" style="min-height: 320px;"><canvas id="monthlyRevenueChart" style="width: 100%; height: 100%;"></canvas></div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                    <div class="card mb-4">
                                        <div class="card-header">
                                            <i class="fas fa-chart-bar me-1"></i>
                                            Revenue by Day
                                        </div>
                                        <div class="card-body" style="min-height: 320px;"><canvas id="dailyRevenueChart" style="width: 100%; height: 100%;"></canvas></div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                    <div class="card mb-4">
                                        <div class="card-header">
                                            <i class="fas fa-chart-bar me-1"></i>
                                            Revenue by Hour
                                        </div>
                                        <div class="card-body" style="min-height: 320px;"><canvas id="hourlyRevenueChart" style="width: 100%; height: 100%;"></canvas></div>
                                    </div>
                                </div>
                            </div>

                            <div class="card mb-4">
                                <div class="card-header">
                                    <i class="fas fa-table me-1"></i>
                                    Top Products by Revenue
                                </div>
                                <div class="card-body">
                                    <div class="table-responsive">
                                        <table class="table table-bordered" width="100%" cellspacing="0">
                                            <thead>
                                                <tr>
                                                    <th>Product ID</th>
                                                    <th>Product Name</th>
                                                    <th>Quantity Sold</th>
                                                    <th>Revenue</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${topProducts}" var="product" varStatus="loop">
                                                    <tr>
                                                        <td>${product[0]}</td>
                                                        <td>${product[1]}</td>
                                                        <td>${product[2]}</td>
                                                        <td>${product[3]}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
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
            <script src="js/scripts.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
                crossorigin="anonymous"></script>
            <script>
                const monthlyRevenueData = [
                    <c:forEach items="${monthlyRevenue}" var="entry" varStatus="status">
                        ${entry[1]}<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ];
                const monthlyRevenueLabels = [
                    <c:forEach items="${monthlyRevenue}" var="entry" varStatus="status">
                        "${entry[0]}"<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ];

                const dailyRevenueData = [
                    <c:forEach items="${dailyRevenue}" var="entry" varStatus="status">
                        ${entry[1]}<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ];
                const dailyRevenueLabels = [
                    <c:forEach items="${dailyRevenue}" var="entry" varStatus="status">
                        "${entry[0]}"<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ];

                const hourlyRevenueData = [
                    <c:forEach items="${hourlyRevenue}" var="entry" varStatus="status">
                        ${entry[1]}<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ];
                const hourlyRevenueLabels = [
                    <c:forEach items="${hourlyRevenue}" var="entry" varStatus="status">
                        "${entry[0]}"<c:if test="${!status.last}">,</c:if>
                    </c:forEach>
                ];

                function createRevenueChart(elementId, labels, data, label) {
                    const ctx = document.getElementById(elementId).getContext('2d');
                    new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: labels,
                            datasets: [{
                                label: label,
                                data: data,
                                backgroundColor: 'rgba(205, 24, 24, 0.75)',
                                borderColor: 'rgba(205, 24, 24, 1)',
                                borderWidth: 1,
                                barPercentage: 0.75,
                                categoryPercentage: 0.9,
                                maxBarThickness: 40
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            scales: {
                                xAxes: [{
                                    barPercentage: 0.75,
                                    categoryPercentage: 0.9,
                                    gridLines: {
                                        display: false
                                    },
                                    ticks: {
                                        autoSkip: false,
                                        maxRotation: 0,
                                        minRotation: 0
                                    }
                                }],
                                yAxes: [{
                                    ticks: {
                                        beginAtZero: true,
                                        callback: function(value) {
                                            return '$' + value.toLocaleString();
                                        }
                                    },
                                    gridLines: {
                                        color: 'rgba(200, 200, 200, 0.2)'
                                    }
                                }]
                            },
                            layout: {
                                padding: {
                                    top: 10,
                                    right: 10,
                                    left: 10,
                                    bottom: 10
                                }
                            },
                            legend: {
                                display: false
                            },
                            tooltips: {
                                callbacks: {
                                    label: function(tooltipItem, data) {
                                        return '$' + tooltipItem.yLabel.toLocaleString();
                                    }
                                }
                            }
                        }
                    });
                }

                createRevenueChart('monthlyRevenueChart', monthlyRevenueLabels, monthlyRevenueData, 'Monthly Revenue');
                createRevenueChart('dailyRevenueChart', dailyRevenueLabels, dailyRevenueData, 'Daily Revenue');
                createRevenueChart('hourlyRevenueChart', hourlyRevenueLabels, hourlyRevenueData, 'Hourly Revenue');
            </script>
            <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
                crossorigin="anonymous"></script>
            <script src="js/datatables-simple-demo.js"></script>
        </body>

        </html>
