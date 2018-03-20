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
    PreparedStatement st = null;
    ResultSet rs = null;
    String sql;
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
    <!-- Select2 -->
  	<link rel="stylesheet" href="../bootstrap/bower_components/select2/dist/css/select2.min.css">
  	<!-- Bootstrap time Picker -->
  	<link rel="stylesheet" href="../bootstrap/plugins/timepicker/bootstrap-timepicker.min.css">
  	<!-- bootstrap datepicker -->
 	<link rel="stylesheet" href="../bootstrap/bower_components/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css">
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
                                <a href="../Logout" class="btn btn-default btn-flat">Abmelden</a>
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
                <li class="active"><a href="index.jsp"><i class="fa fa-dashboard"></i><span> Dashboard</span></a></li>
                <li><a href="member.jsp"><i class="fa fa-users"></i><span> Mitglieder</span></a></li>
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
                Publizieren
                <small>Senden und Bearbeiten von Newslettern</small>
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
            <div class="box-header with-border">
              <h3 class="box-title">Geplante Newsletter</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
              <table class="table table-bordered">
                <tr>
                  <th style="width: 10px">#</th>
                  <th style="width: 25%;">Titel</th>
                  <th>Progress</th>
                  <th style="width: 40px">Label</th>
                </tr>
                <tr>
                  <td>1.</td>
                  <td>Update software</td>
                  <td>
                    <div class="progress progress-xs progress-striped active">
                      <div class="progress-bar progress-bar-yellow" style="width: 90%"></div>
                    </div>
                  </td>
                  <td><span class="badge bg-red">x</span></td>
                </tr>
                <tr>
                  <td>2.</td>
                  <td>Clean database</td>
                  <td>
                    <div class="progress progress-xs progress-striped active">
                      <div class="progress-bar progress-bar-yellow" style="width: 60%"></div>
                    </div>
                  </td>
                  <td><span class="badge bg-red">x</span></td>
                </tr>
                <tr>
                  <td>3.</td>
                  <td>Cron job running</td>
                  <td>
                    <div class="progress progress-xs progress-striped active">
                      <div class="progress-bar progress-bar-yellow" style="width: 40%"></div>
                    </div>
                  </td>
                  <td><span class="badge bg-red">x</span></td>
                </tr>
                <tr>
                  <td>4.</td>
                  <td>Fix and squish bugs</td>
                  <td>
                    <div class="progress progress-xs progress-striped active">
                      <div class="progress-bar progress-bar-yellow" style="width: 10%"></div>
                    </div>
                  </td>
                  <td><span class="badge bg-red">x</span></td>
                </tr>
              </table>
            </div>
            <!-- /.box-body -->
            <div class="box-footer clearfix">
              <ul class="pagination pagination-sm no-margin pull-right">
                <li><a href="#">&laquo;</a></li>
                <li><a href="#">1</a></li>
                <li><a href="#">2</a></li>
                <li><a href="#">3</a></li>
                <li><a href="#">&raquo;</a></li>
              </ul>
            </div>
          </div>
          <!-- /.box -->
          </div>
          </div>

		<div class="row">
                <div class="col-xs-12">
                  <div class="box">
                    <div class="box-header">
                      <h3 class="box-title">Newsletter</h3>
                    </div>
                    <!-- /.box-header -->
                      <div class="box-body">
                      <table id="table-member" class="table table-bordered table-striped">
                      		<thead>
                            <tr>
			                  <th class="col-sm-1">Optionen</th>
			                  <th class="col-sm-1">ID</th>
			                  <th class="col-sm-2">Titel</th>
			                  <th class="col-sm-2">Betreff</th>
			                  <th class="col-sm-3">Autor</th>
			                  <th class="col-sm-3">Datum</th>
			                </tr>
			                <thead>
			                <tbody>
			                <%
			                sql = "SELECT * FROM newsletter";
			                st = con.prepareStatement(sql);
			                rs = st.executeQuery();
			                rs.first();
			                
			                while(rs.next()) {
			                	out.println("<tr>");
			                	out.println("<td><a id=\"" + rs.getString("id") + "\" data-toggle=\"modal\" data-target=\"#modal-publish\"onclick=\"replace(this.id);\"><i class=\"fa fa-paper-plane\"></i></a> &nbsp; <a href=\"#\"><i class=\"fa fa-edit\"></i></a> &nbsp; <a href=\"../RemoveNewsletter?id=" + rs.getString(1) +"\"><i class=\"fa fa-trash\"></i></a></td>");
			                	for(int i = 1; i <= 5; i++) {
			                		out.println("<td id=\"" + String.valueOf(i) + rs.getString("id") + "\">" + rs.getString(i) +"</td>");
			                	}
			                	out.println("</tr>");
			                }
			                %>
			                </tbody>
			                <thead>
                            <tr>
			                  <th>Optionen</th>
			                  <th>ID</th>
			                  <th>Titel</th>
			                  <th>Betreff</th>
			                  <th>Autor</th>
			                  <th>Datum</th>
			                </tr>
			                <thead>
                          </table>
			            </div>
			            <!-- /.box-body -->
			          </div>
			          <!-- /.box -->
			        </div>
			      <!-- /.col -->
			    </div>
			  <!-- /.row -->

		<form action="../PublishNewsletter" method="get">

		<div class="modal fade" id="modal-publish">
		 	<div class="modal-dialog">
		  	    <div class="modal-content">
			        <div class="modal-header">
			          	<button type="button" class="close" data-dismiss="modal" aria-label="Close">
		 	          	<span aria-hidden="true">&times;</span></button>
		 	         	<h4 class="modal-title">Newsletter publizieren</h4>
			    	</div>
		            <div class="modal-body">
		            	
		            	<!-- Beschreibung -->
		              	<div class="box-body">
				       		<dl class="dl-horizontal">
				       			<dt>ID</dt>
				                <dd id="id">$ID</dd>
				           		<dt>Titel</dt>
				                <dd id="title">$Titel</dd>
                                <dt>Betreff</dt>
                                <dd id="subject">$Betreff</dd>
				                <dt>Autor</dt>
				                <dd id="author">$Autor</dd>
				                <dt>Erstellt</dt>
				                <dd id="date">$13.13.13</dd>
				                <dt>Beschreibung</dt>
				                <dd id="description">Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo
				                  sit amet risus.Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo
				                  sit amet risus.
				                </dd>
				         	</dl>
                 		</div>
                 		
                 		<hr>
                 		
                 		<!-- Kriterium -->
                 		<div class="form-group">
			                <label>Kriterium</label>
			               	<select name="krit" class="form-control select2" data-placeholder="W&Auml;hle ein Kriterium aus" style="width: 100%;">
								<%
								//get all krit's
								sql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'member'";
								st = con.prepareStatement(sql);
								rs = st.executeQuery();
								
								while(rs.next()) {
									if(!rs.getString(1).toLowerCase().equals("id") && 
										!rs.getString(1).toLowerCase().equals("email") && 
										!rs.getString(1).toLowerCase().equals("active") &&
										!rs.getString(1).toLowerCase().equals("hash")) 
									{
										out.print("<option>" + rs.getString(1) +"</option>");										
									}
								}			
								
								%>					            
			               	</select>
			        	</div>
			        	
			        	<!-- Elements -->
			        	<div class="form-group">
			                <label>Element</label>
			                <select name="elements" class="form-control select2" multiple="multiple" data-placeholder="W�hle ein Element aus" style="width: 100%;">
			                  	<option>Alabama</option>
			                  	<option>Alaska</option>
			                  	<option>California</option>
			                  	<option>Delaware</option>
			                  	<option>Tennessee</option>
			                  	<option>Texas</option>
			                  	<option>Washington</option>
			                </select>
			          	</div>
			          	
			          	<hr>
			          	
			          	<!-- Datum -->
			          	<div class="form-group">
			           		<label>Datum</label>
			                <div class="input-group date">
			                  	<div class="input-group-addon">
			                    	<i class="fa fa-calendar"></i>
			                  	</div>
			                  	<input name="date" type="text" class="form-control pull-right" id="datepicker">
			                </div>
			          	</div>
			          	
			          	<!-- Uhrzeit -->
			          	<div class="bootstrap-timepicker">
			                <div class="form-group">
			                  	<label>Uhrzeit</label>
			                  	<div class="input-group">
			                  		<div class="input-group-addon">
			                      		<i class="fa fa-clock-o"></i>
			                    	</div>
			                    	<input name="time" type="text" class="form-control timepicker">
			                  	</div>
			               	</div>
			         	</div>
		        	</div>
		        	
		        	<div class="modal-footer">
		           		<button type="button" class="btn btn-default pull-left" data-dismiss="modal">Beenden</button>
		           		<button type="button submit" value="schedule" name="method" class="btn btn-warning">Planen</button>
		                <button type="button submit" value="publish" name="method" class="btn btn-primary">Publizieren</button>
		        	</div>
		       	</div>
		       	<!-- /.modal-content -->
		 	</div>
		    <!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->

		</form>

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
<!-- Select2 -->
<script src="../bootstrap/bower_components/select2/dist/js/select2.full.min.js"></script>
<!-- bootstrap datepicker -->
<script src="../bootstrap/bower_components/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"></script>
<!-- bootstrap time picker -->
<script src="../bootstrap/plugins/timepicker/bootstrap-timepicker.min.js"></script>

<!-- Table jQuery -->
<script>
  $(function () {
  	//Table
    $('#table-member').DataTable()
    
    //Timepicker
    $('.timepicker').timepicker({
      showInputs: false
    })
    
    //Date picker
    $('#datepicker').datepicker({
      autoclose: true
    })
    
    //Initialize Select2 Elements
    $('.select2').select2()
  })

  function replace(id) {
      var idf = document.getElementById("1" + id).innerText;
      var title = document.getElementById("2" + id).innerText;
      var subject = document.getElementById("3" + id).innerText;
      var author = document.getElementById("4" + id).innerText;
      var date = document.getElementById("5" + id).innerText;

      document.getElementById("id").innerText = idf;
      document.getElementById("title").innerText = title;
      document.getElementById("subject").innerText = subject;
      document.getElementById("author").innerText = author;
      document.getElementById("date").innerText = date;
  }


</script>

</body>
</html>
