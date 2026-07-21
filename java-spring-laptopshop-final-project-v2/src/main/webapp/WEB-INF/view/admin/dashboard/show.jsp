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
                                <div class="col-xl-3 col-md-6">
                                    <div class="card text-white mb-4" style="background-color: #cd1818; border: none;">
                                        <div class="card-body">Total Users (${countUsers})</div>
                                        <div class="card-footer d-flex align-items-center justify-content-between">
                                            <a class="small text-white stretched-link" href="/admin/user">View Details</a>
                                            <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-md-6">
                                    <div class="card text-white mb-4" style="background-color: #cd1818; border: none;">
                                        <div class="card-body">Total Products (${countProducts})</div>
                                        <div class="card-footer d-flex align-items-center justify-content-between">
                                            <a class="small text-white stretched-link" href="/admin/product">View Details</a>
                                            <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-md-6">
                                    <div class="card text-white mb-4" style="background-color: #cd1818; border: none;">
                                        <div class="card-body">Total Orders (${countOrders})</div>
                                        <div class="card-footer d-flex align-items-center justify-content-between">
                                            <a class="small text-white stretched-link" href="/admin/order">View Details</a>
                                            <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-xl-3 col-md-6">
                                    <div class="card text-white mb-4" style="background-color: #cd1818; border: none;">
                                        <div class="card-body">Total Contacts (${countContacts})</div>
                                        <div class="card-footer d-flex align-items-center justify-content-between">
                                            <a class="small text-white stretched-link" href="/admin/contact">View Details</a>
                                            <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                                        </div>
                                    </div>
                                </div>
                            </div>

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
                                            <tbody id="topProductsBody">
                                                <!-- Populated dynamically via JS -->
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
                let currentYear = new Date().getFullYear();
                let currentMonth = null;
                let currentDay = null;
                let currentHour = null;

                let monthlyChart, dailyChart, hourlyChart;

                function initCharts() {
                    monthlyChart = createRevenueChart('monthlyRevenueChart', [], [], 'Monthly Revenue', handleMonthlyClick);
                    dailyChart = createRevenueChart('dailyRevenueChart', [], [], 'Daily Revenue', handleDailyClick);
                    hourlyChart = createRevenueChart('hourlyRevenueChart', [], [], 'Hourly Revenue', handleHourlyClick);
                }

                function handleMonthlyClick(evt, item) {
                    if (item.length > 0) {
                        const index = item[0]._index;
                        currentMonth = monthlyChart.data.labels[index];
                        currentDay = null;
                        currentHour = null;
                        loadDailyData(currentYear, currentMonth);
                        
                        // Clear hourly chart
                        hourlyChart.data.labels = [];
                        hourlyChart.data.datasets[0].data = [];
                        hourlyChart.update();
                        
                        loadTopProducts(currentYear, currentMonth);
                    }
                }

                function handleDailyClick(evt, item) {
                    if (item.length > 0) {
                        const index = item[0]._index;
                        currentDay = dailyChart.data.labels[index];
                        currentHour = null;
                        loadHourlyData(currentYear, currentMonth, currentDay);
                        loadTopProducts(currentYear, currentMonth, currentDay);
                    }
                }

                function handleHourlyClick(evt, item) {
                    if (item.length > 0) {
                        const index = item[0]._index;
                        currentHour = hourlyChart.data.labels[index];
                        loadTopProducts(currentYear, currentMonth, currentDay, currentHour);
                    }
                }

                function loadMonthlyData(year) {
                    fetch('/admin/api/dashboard/revenue/monthly?year=' + year)
                        .then(res => res.json())
                        .then(data => {
                            const labels = data.map(d => d[0]);
                            const values = data.map(d => d[1]);
                            monthlyChart.data.labels = labels;
                            monthlyChart.data.datasets[0].data = values;
                            monthlyChart.update();
                        });
                }

                function loadDailyData(year, month) {
                    fetch('/admin/api/dashboard/revenue/daily?year=' + year + '&month=' + month)
                        .then(res => res.json())
                        .then(data => {
                            const labels = data.map(d => d[0]);
                            const values = data.map(d => d[1]);
                            dailyChart.data.labels = labels;
                            dailyChart.data.datasets[0].data = values;
                            dailyChart.update();
                        });
                }

                function loadHourlyData(year, month, day) {
                    fetch('/admin/api/dashboard/revenue/hourly?year=' + year + '&month=' + month + '&day=' + day)
                        .then(res => res.json())
                        .then(data => {
                            const labels = data.map(d => d[0]);
                            const values = data.map(d => d[1]);
                            hourlyChart.data.labels = labels;
                            hourlyChart.data.datasets[0].data = values;
                            hourlyChart.update();
                        });
                }

                function loadTopProducts(year, month = null, day = null, hour = null) {
                    let url = '/admin/api/dashboard/top-products?year=' + year;
                    if (month) url += '&month=' + month;
                    if (day) url += '&day=' + day;
                    if (hour) url += '&hour=' + hour;

                    fetch(url)
                        .then(res => res.json())
                        .then(data => {
                            const tbody = document.getElementById('topProductsBody');
                            tbody.innerHTML = '';
                            data.forEach(product => {
                                const tr = document.createElement('tr');
                                tr.innerHTML = '<td>' + product[0] + '</td>' +
                                               '<td>' + product[1] + '</td>' +
                                               '<td>' + product[2] + '</td>' +
                                               '<td>' + product[3] + '</td>';
                                tbody.appendChild(tr);
                            });
                        });
                }

                function createRevenueChart(elementId, labels, data, label, onClickHandler) {
                    const ctx = document.getElementById(elementId).getContext('2d');
                    return new Chart(ctx, {
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
                            onClick: onClickHandler,
                            scales: {
                                xAxes: [{
                                    barPercentage: 0.75,
                                    categoryPercentage: 0.9,
                                    gridLines: { display: false },
                                    ticks: { autoSkip: false, maxRotation: 0, minRotation: 0 }
                                }],
                                yAxes: [{
                                    ticks: {
                                        beginAtZero: true,
                                        callback: function(value) { return '$' + value.toLocaleString(); }
                                    },
                                    gridLines: { color: 'rgba(200, 200, 200, 0.2)' }
                                }]
                            },
                            layout: { padding: { top: 10, right: 10, left: 10, bottom: 10 } },
                            legend: { display: false },
                            tooltips: {
                                callbacks: {
                                    label: function(tooltipItem, data) { return '$' + tooltipItem.yLabel.toLocaleString(); }
                                }
                            }
                        }
                    });
                }

                // Initialize
                initCharts();
                loadMonthlyData(currentYear);
                loadTopProducts(currentYear);
            </script>
            <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
                crossorigin="anonymous"></script>
            <script src="js/datatables-simple-demo.js"></script>
        </body>

        </html>
