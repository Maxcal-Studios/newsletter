<!DOCTYPE html>
<%@ page import="java.sql.*, com.database.*;" %>
<html>
<head>

    <%
    String username = "admin";

    if(!DBConnector.isLoggedIn(session)) {
    	response.sendRedirect("../../login.jsp");
    } else {

    	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    	response.setHeader("Pragma", "no-cache");
    	response.setHeader("Expires", "0");

    	username = session.getAttribute("user").toString();
    }

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

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <!-- Google Font -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">

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

                    <!-- User Account Menu -->
                    <li class="dropdown user user-menu">
                        <!-- Menu Toggle Button -->
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <!-- The user image in the navbar-->
                            <img src="../bootstrap/dist/img/160x160.png" class="user-image" alt="User Image">
                            <!-- hidden-xs hides the username on small devices so only the image appears. -->
                            <span class="hidden-xs"><% out.print(username); %></span>
                        </a>
                        <ul class="dropdown-menu">
                            <!-- The user image in the menu -->
                            <li class="user-header">
                                <img src="../bootstrap/dist/img/160x160.png" class="img-circle" alt="User Image">

                                <p>
                                    <% out.print(username); %> - Administrator
                                </p>
                            </li>
                            <!-- Deleted Menu Body -->

                            <!-- Edited Menu Footer-->
                            <li class="user-footer">
                                <a href="../Logout" class="btn btn-default btn-flat">Abmelden</a>
                            </li>
                        </ul>
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
                    <img src="../bootstrap/dist/img/160x160.png" class="img-circle" alt="User Image">
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
                        <li><a href="publish.jsp"><i class="fa fa-circle-o"></i>Publizieren</a></li>
                        <li><a href="history.jsp"><i class="fa fa-circle-o"></i>History</a></li>
                    </ul>
                </li>
                <li><a href="layout.jsp"><i class="glyphicon glyphicon-th-large"></i><span> Layout</span></a></li>
                <li><a href="settings.jsp"><i class="fa fa-gears"></i><span> Einstellungen</span></a></li>
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
                Mitglieder
                <small>Mitglieder verwalten</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="index.jsp"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                <li class="active">Mitglieder</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content container-fluid">
			  <div class="row">
                <div class="col-xs-12">
                  <div class="box">
                    <div class="box-header">
                      <h3 class="box-title">Mitgliederliste</h3>
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
                                    out.println("<td class=\"col-sm-1\"><a href=\"edit.jsp?id=" + member.getString(1)  +"\"><i class=\"fa fa-edit\"></i></a> &nbsp; <a href=\"../RemoveMember?id=" + member.getString(1) +"\"><i class=\"fa fa-trash\"></i></a></td>");
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

<%
	head.close();
	member.close();
	st.close();
	con.close();
 %>

</html>
