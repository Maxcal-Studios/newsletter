<!DOCTYPE html>
<%@ page import="java.sql.*, com.database.*;" %>
<html>
<head>

    <%
    if(session.getAttribute("user") == null) {
    response.sendRedirect("../login.jsp");
    }

    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Expires", "0");

	String username = session.getAttribute("user").toString();

    Connection con = DBConnector.getConnection();
    String sql = "SELECT * FROM member;";
    PreparedStatement st = con.prepareStatement(sql);
    ResultSet member = st.executeQuery();

    sql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'member';";
    st = con.prepareStatement(sql);
    ResultSet head = st.executeQuery();
    %>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Newsletter | Admin</title>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
    <!-- Bootstrap 3.3.7 -->
    <link rel="stylesheet" href="../bootstrap/bower_components/bootstrap/dist/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="../bootstrap/bower_components/font-awesome/css/font-awesome.min.css">
    <!-- Ionicons -->
    <link rel="stylesheet" href="../bootstrap/bower_components/Ionicons/css/ionicons.min.css">
    <!-- jvectormap -->
    <link rel="stylesheet" href="../bootstrap/bower_components/jvectormap/jquery-jvectormap.css">
    <!-- DataTables -->
    <link rel="stylesheet" href="../bootstrap/bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="../bootstrap/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="../bootstrap/dist/css/skins/skin-blue.min.css">

    <link rel="stylesheet" href="popup.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Abril+Fatface|Archivo+Black|Dancing+Script|Inconsolata|Indie+Flower|Lobster|Montserrat|Open+Sans|Open+Sans+Condensed:300|Oswald|Playfair+Display|Poiret+One|Roboto|Rubik+Mono+One|Ubuntu" rel="stylesheet">


    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <!-- Google Font -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">

    <style>
        #container i , select{color:black;}
        button{margin-bottom:5px}
        select{margin-bottom:5px}
        .popup {display: none;position: fixed;z-index: 1;left: 0;top: 0;width: 100%;height: 100%;overflow: auto;background-color: rgb(0,0,0);background-color: rgba(0,0,0,0.3);}
        .popup-content {background-color: #fefefe;margin: 15% auto;padding: 20px;border: 1px solid #888;width: 80%;}
        .close {color: #4A4E51;float: right;font-size: 28px;font-weight: bold;}
        .close:hover,
        .close:focus {color: white;text-decoration: none;cursor: pointer;}
        .popup-header {padding: 2px 16px;background-color: #3C8DBC;color: white;}
        .popup-content {background-color: #FFFFFF;padding: 0;border: 1px solid #888;width: 65%;text-align:center;}
        .popup-content input {font-size: 22;color: #4A4E51;background: #ECF0F5;width: 50%;border: 0;margin: 15px 0 15px;padding: 15px;box-sizing: border-box;}
        .popup-content button {color:white;background: #3C8DBC;width: 50%;border: 0;margin: 15px 0 15px;padding: 15px;font-size: 22;cursor: pointer;}
        .popup-content button:hover,.popup-content button:active,.popup-content button:focus {background: #367FA9;}
    </style>

</head>

<body class="hold-transition skin-blue sidebar-mini"  onload="enableEditor();" style="margin: 0;">

<div class="wrapper">


    <!-- Main Header -->
    <header class="main-header">

        <!-- Logo -->
        <a href="index.jsp" class="logo">
            <!-- mini logo for sidebar mini 50x50 pixels -->
            <span class="logo-mini">News</span>
            <!-- logo for regular state and mobile devices -->
            <span class="logo-lg"><b>News</b>letter</span>
        </a>

        <!-- Header Navbar -->
        <nav class="navbar navbar-static-top" role="navigation">
            <!-- Sidebar toggle button-->
            <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
                <span class="sr-only">Toggle navigation</span>
            </a>
            <!-- Navbar Right Menu -->
            <div class="navbar-custom-menu">
                <ul class="nav navbar-nav">
                    <!-- Messages: style can be found in dropdown.less-->
                    <li class="dropdown messages-menu">
                        <!-- Menu toggle button -->
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <i class="fa fa-envelope-o"></i>
                            <span class="label label-success">$cnt_msg</span>
                        </a>
                        <ul class="dropdown-menu">
                            <li class="header">You have $cnt_msg messages</li>
                            <li>
                                <!-- inner menu: contains the messages -->
                                <ul class="menu">
                                    <li><!-- start message -->
                                        <a href="#">
                                            <div class="pull-left">
                                                <!-- User Image -->
                                                <img src="../bootstrap/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
                                            </div>
                                            <!-- Message title and timestamp -->
                                            <h4>
                                                Support Team
                                                <small><i class="fa fa-clock-o"></i> 5 mins</small>
                                            </h4>
                                            <!-- The message -->
                                            <p>Why not buy a new awesome theme?</p>
                                        </a>
                                    </li>
                                    <!-- end message -->
                                </ul>
                                <!-- /.menu -->
                            </li>
                            <li class="footer"><a href="#">See All Messages</a></li>
                        </ul>
                    </li>
                    <!-- /.messages-menu -->

                    <!-- Notifications Menu -->
                    <li class="dropdown notifications-menu">
                        <!-- Menu toggle button -->
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <i class="fa fa-bell-o"></i>
                            <span class="label label-warning">$cnt_not</span>
                        </a>
                        <ul class="dropdown-menu">
                            <li class="header">You have $cnt_not notifications</li>
                            <li>
                                <!-- Inner Menu: contains the notifications -->
                                <ul class="menu">
                                    <li><!-- start notification -->
                                        <a href="#">
                                            <i class="fa fa-users text-aqua"></i> 5 new members joined today
                                        </a>
                                    </li>
                                    <!-- end notification -->
                                </ul>
                            </li>
                            <li class="footer"><a href="#">View all</a></li>
                        </ul>
                    </li>
                    <!-- Tasks Menu -->
                    <li class="dropdown tasks-menu">
                        <!-- Menu Toggle Button -->
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <i class="fa fa-flag-o"></i>
                            <span class="label label-danger">$cnt_tsk</span>
                        </a>
                        <ul class="dropdown-menu">
                            <li class="header">$cnt_tsk</li>
                            <li>
                                <!-- Inner menu: contains the tasks -->
                                <ul class="menu">
                                    <li><!-- Task item -->
                                        <a href="#">
                                            <!-- Task title and progress text -->
                                            <h3>
                                                Design some buttons
                                                <small class="pull-right">20%</small>
                                            </h3>
                                            <!-- The progress bar -->
                                            <div class="progress xs">
                                                <!-- Change the css width attribute to simulate progress -->
                                                <div class="progress-bar progress-bar-aqua" style="width: 20%" role="progressbar"
                                                     aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                                                    <span class="sr-only">20% Complete</span>
                                                </div>
                                            </div>
                                        </a>
                                    </li>
                                    <!-- end task item -->
                                </ul>
                            </li>
                            <li class="footer">
                                <a href="#">View all tasks</a>
                            </li>
                        </ul>
                    </li>
                    <!-- User Account Menu -->
                    <li class="dropdown user user-menu">
                        <!-- Menu Toggle Button -->
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <!-- The user image in the navbar-->
                            <img src="../bootstrap/dist/img/user2-160x160.jpg" class="user-image" alt="User Image">
                            <!-- hidden-xs hides the username on small devices so only the image appears. -->
                            <span class="hidden-xs"><% out.print(username); %></span>
                        </a>
                        <ul class="dropdown-menu">
                            <!-- The user image in the menu -->
                            <li class="user-header">
                                <img src="../bootstrap/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">

                                <p>
                                    <% out.print(username); %> - Admin
                                    <small>Mitglied seit $timestamp</small>
                                </p>
                            </li>
                            <!-- Deleted Menu Body -->

                            <!-- Edited Menu Footer-->
                            <li class="user-footer">
                                <a href="#" class="btn btn-default btn-flat">Sign out</a>
                            </li>
                        </ul>
                    </li>
                    <!-- Control Sidebar Toggle Button -->
                    <li>
                        <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
                    </li>
                </ul>
            </div>
        </nav>
    </header>
    <!-- Left side column. contains the logo and sidebar -->
    <aside class="main-sidebar">

        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">

            <!-- Sidebar user panel (optional) -->
            <div class="user-panel">
                <div class="pull-left image">
                    <img src="../bootstrap/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image">
                </div>
                <div class="pull-left info">
                    <p><% out.print(username); %></p>
                    <!-- Status -->
                    <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
                </div>
            </div>

            <!-- Sidebar Menu -->
            <ul class="sidebar-menu" data-widget="tree">
                <li class="header">NAVIGATION</li>
                <!-- Optionally, you can add icons to the links -->
                <li><a href="index.jsp"><i class="fa fa-dashboard"></i><span> Dashboard</span></a></li>
                <li class="active"><a href="member.jsp"><i class="fa fa-users"></i><span> Mitglieder</span></a></li>
                <li class="treeview">
                    <a href="#"><i class="fa fa-paper-plane"></i><span> Newsletter</span>
                        <span class="pull-right-container">
                    <i class="fa fa-angle-left pull-right"></i>
                  </span>
                    </a>
                    <ul class="treeview-menu">
                        <li><a href="newsletter_create.jsp"><i class="fa fa-circle-o"></i>Erstellen</a></li>
                        <li><a href="newsletter_publish.jsp"><i class="fa fa-circle-o"></i>Publizieren</a></li>
                        <li><a href="newsletter_history.jsp"><i class="fa fa-circle-o"></i>History</a></li>
                    </ul>
                </li>
                <li><a href="layout.jsp"><i class="glyphicon glyphicon-th-large"></i><span> Layout</span></a></li>
                <li><a href="doc.jsp"><i class="fa fa-book"></i><span> Dokumentation</span></a></li>
            </ul>
            <!-- /.sidebar-menu -->
        </section>
        <!-- /.sidebar -->
    </aside>

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>
                Dashboard
                <small>Übersicht und Analyse</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
                <li class="active">Here</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content container-fluid">
            <div class="row">
                <div class="col-xs-12">
                  <div class="box">
                    <div class="box-header">
                      <h3 class="box-title">Hover Data Table</h3>
                    </div>
                    <!-- /.box-header -->
                      <div class="box-body">
                      <table id="table-member" class="table table-bordered table-striped">
                            <thead>
                            <tr>
                              <!-- Ueberschriften -->
                              <%
                              		out.println("<th>Edit</th>");
                                while(head.next()) {
                                    out.println("<th>" + head.getString(1) + "</th>");
                                }
                               %>
                            </tr>
                            </thead>
                            <tbody>

                                <!-- Inhalte -->
                              <%

                                while(member.next()) {
                                    out.println("<tr>");
                                    out.println("<td><a href=\"edit.jsp?id=" + member.getString(1)  +"\"><i class=\"fa fa-edit\"></i></a>   <a href=\"../RemoveMember?id=" + member.getString(1) +"\"><i class=\"fa fa-trash\"></i></a></td>");
                                    for(int i = 1; i <= member.getMetaData().getColumnCount(); i++) {
                                        out.println("<td>" + member.getString(i) + "</td>");
                                    }
                                    out.println("</tr>");
                                }
                               %>
                            </tbody>
                            <tfoot>
                            <tr>
                                <!-- Ueberschriften Unten -->
                              <%
                                head.first();
                                out.println("<th>Edit</th>");
                                do {
                                    out.println("<th>" + head.getString(1) + "</th>");
                                } while(head.next());
                               %>
                            </tr>
                            </tfoot>
                          </table>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
      <!-- /.col -->
    </div>
  <!-- /.row -->

        </section>
        <!-- /.content -->

    </div>
    <!-- /.content-wrapper -->

    <!-- Main Footer -->
    <footer class="main-footer" style="height: 50px">
        <!-- To the right -->
        <div class="pull-right hidden-xs">
            Max, David, Pascal 2018
        </div>
        <!-- Default to the left -->
        <strong>Copyright &copy; 2018 <a href="https://github.com/Maxcal-Studios">Maxcal</a>.</strong> Alle Rechte vorbehalten.
    </footer>

    <!-- Control Sidebar -->
    <aside class="control-sidebar control-sidebar-dark">
        <!-- Create the tabs -->

        <!-- Tab panes -->
        <div class="tab-content">
            <div class="tab-pane active" id="control-sidebar-settings-tab">
                <!-- /.control-sidebar-menu -->

                <h3 class="control-sidebar-heading">Tasks Progress</h3>
                <ul class="control-sidebar-menu">
                    <!-- Settings Content -->
                    <li>
                        <a href="javascript:;">
                            <h4 class="control-sidebar-subheading">
                                Custom Template Design
                                <span class="pull-right-container">
                        <span class="label label-danger pull-right">70%</span>
                      </span>
                            </h4>

                            <div class="progress progress-xxs">
                                <div class="progress-bar progress-bar-danger" style="width: 70%"></div>
                            </div>
                        </a>
                    </li>
                </ul>
                <!-- /.control-sidebar-menu -->


            </div>
            <!-- /.tab-pane -->
            <!-- Stats tab content -->
            <div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
            <!-- /.tab-pane -->
            <!-- Settings tab content -->
            <div class="tab-pane" id="control-sidebar-settings-tab">
                <form method="post">
                    <h3 class="control-sidebar-heading">General Settings</h3>

                    <div class="form-group">
                        <label class="control-sidebar-subheading">
                            Report panel usage
                            <input type="checkbox" class="pull-right" checked>
                        </label>

                        <p>
                            Some information about this general settings option
                        </p>
                    </div>
                    <!-- /.form-group -->
                </form>
            </div>
            <!-- /.tab-pane -->
        </div>
    </aside>
    <!-- /.control-sidebar -->
    <!-- Add the sidebar's background. This div must be placed
    immediately after the control sidebar -->
    <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->

<!-- jQuery 3 -->
<script src="../bootstrap/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="../bootstrap/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="../bootstrap/dist/js/adminlte.min.js"></script>
<!-- DataTables -->
<script src="../bootstrap/bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="../bootstrap/bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>

<!-- Table jQuery -->
<script>
  $(function () {
    $('#table-member').DataTable()
  })
</script>


</body>
</html>
