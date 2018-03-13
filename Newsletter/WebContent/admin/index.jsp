<!DOCTYPE html>
<html>
<head>

        <%
        if(session.getAttribute("user") == null) {
            response.sendRedirect("../login.jsp");
        }
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setHeader("Expires", "0");
        %>

    <title>Maxcal Newsletter</title>
    <link type="text/css" rel="stylesheet" href="css/style.css" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <script src="js/Chart.js"></script>
</head>

<body>
<nav class="navbar">
    <div class="logo">LOGO</div>
    <a href="Dashboard.html" class="active">Dashboard</a>
    <a href="Newsletter.html">Newsletter</a>
    <a href="Member.html">Member</a>
    <a href="Analytics.html">Analytics</a>
    <a href="Settings.html">Settings</a>
</nav>

<div class="header">
    <div class="headerText">Aktuelles Tab</div>
</div>

<div class="wrapper">
    <div class="box box1">
        <canvas id="cpuGraph" width="300" height="300"></canvas>
    </div>
    <div class="box box2">
        2 2 Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
        <canvas id="bChart" width="300" height="300"></canvas>
    </div>
    <div class="box box3">
        <canvas id="aChart" width="300" height="300"></canvas>
        3 3 Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
    </div>
    <div class="box box4">
        4 4 Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
    </div>
    <div class="box box5">
        5 5 Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
    </div>
    <div class="box box6">
        5 5 Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
    </div>
</div>

<script>
var ctx = document.getElementById("cpuGraph");
var myDoughnutChart = new Chart(ctx, {
    type: 'bar',
    data:{
        labels: ["CPU", "RAM", "Download"],
        datasets: [{
            label: "Server",
            backgroundColor: 'rgb(99, 144, 216)',
            borderColor: 'rgb(99, 144, 216)',
            data: [30, 20, 60],
        }]
    },
    // Configuration options go here
    options: {
        responsive: false,
        legend: {
            labels: {
                fontColor: "white",
                fontSize: 18
            }
        }
    }
});
</script>

<script>
var ctx = document.getElementById("bChart");
var myDoughnutChart = new Chart(ctx, {
    type: 'line',
    data:{
        labels: ["Ruby", "Perl", "Phyton", "Angular"],
        datasets: [{
            label: "Neue Anmeldungen",
            backgroundColor: 'rgb(99, 144, 216)',
            borderColor: 'rgb(99, 144, 216)',
            data: [0, 10, 5, 0],
        }]
    },
    // Configuration options go here
    options: {
        responsive: false,
        legend: {
            labels: {
                fontColor: "white",
                fontSize: 18
            }
        }
    }
});
</script>

<script>
    var ctx = document.getElementById("aChart");
    var myD = new Chart(ctx, {
    type: 'doughnut',
    data:{
        labels: ["Ruby", "Perl", "Phyton", "Angular"],
        datasets: [{
            data: [5, 10, 15, 20],
            backgroundColor:["rgb(255, 99, 132)","rgb(54, 162, 235)","rgb(255, 205, 86)", "rgb(99, 249, 220)"],
        }]
    },
    options: {
        responsive: false,
        legend: {
            labels: {
                fontColor: "white",
                fontSize: 18
            }
        }
    }
});
</script>

</body>
</html>