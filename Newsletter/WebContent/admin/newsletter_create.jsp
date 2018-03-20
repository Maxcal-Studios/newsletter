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
        <a href="index2.html" class="logo">
            <!-- mini logo for sidebar mini 50x50 pixels -->
            <span class="logo-mini"><b>C</b>AL</span>
            <!-- logo for regular state and mobile devices -->
            <span class="logo-lg"><b>Max</b>CAL</span>
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
                                                <img src="../bootstrap/dist/img/user2-160x160.png" class="img-circle" alt="User Image">
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
                            <img src="../bootstrap/dist/img/user2-160x160.png" class="user-image" alt="User Image">
                            <!-- hidden-xs hides the username on small devices so only the image appears. -->
                            <span class="hidden-xs">$username</span>
                        </a>
                        <ul class="dropdown-menu">
                            <!-- The user image in the menu -->
                            <li class="user-header">
                                <img src="../bootstrap/dist/img/user2-160x160.png" class="img-circle" alt="User Image">

                                <p>
                                    $username - Admin
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
                    <img src="../bootstrap/dist/img/user2-160x160.png" class="img-circle" alt="User Image">
                </div>
                <div class="pull-left info">
                    <p>$username</p>
                    <!-- Status -->
                    <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
                </div>
            </div>

            <!-- Sidebar Menu -->
            <ul class="sidebar-menu" data-widget="tree">
                <li class="header">$INSERT CURRENT SITE</li>
                <!-- Optionally, you can add icons to the links -->
                <li><a href="index.jsp"><i class="fa fa-dashboard"></i> <span>Dashboard</span></a></li>
                <li><a href="members.jsp"><i class="fa fa-users"></i> <span>Mitglieder</span></a></li>
                <li class="treeview active">
                    <a href="#"><i class="fa fa-paper-plane"></i> <span>Newsletter</span>
                        <span class="pull-right-container">
                    <i class="fa fa-angle-left pull-right"></i>
                  </span>
                    </a>
                    <ul class="treeview-menu">
                        <li  class="active"><a href="newsletter_create.jsp"><i class="fa fa-circle-o"></i>Erstellen</a></li>
                        <li><a href="newsletter_publish.jsp"><i class="fa fa-circle-o"></i>Publizieren</a></li>
                        <li><a href="newsletter_history.jsp"><i class="fa fa-circle-o"></i>History</a></li>
                    </ul>
                </li>
                <li><a href="documentation.jsp"><i class="fa fa-book"></i><span>Dokumentation</span></a></li>
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
                Erstellen
                <small>Optional description</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
                <li class="active">Here</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content container-fluid">

            <!--------------------------
              | Your Page Content Here |
              -------------------------->

            <div class="pagecontainer" style="width:100%;height:100vh;">
                <div style="text-align: center; background-color:#3C8DBC;">
                    <div style="color:white; padding:10px" id="container">
                        <button onclick="execCmd('bold');" title="Fett" name="Web"><i class="fa fa-bold fa-2x"></i></button>
                        <button onclick="execCmd('italic');" title="Kursiv" name="Web"><i class="fa fa-italic fa-2x"></i></button>
                        <button onclick="execCmd('underline');" title="Unterstrichen" name="Web"><i class="fa fa-underline fa-2x"></i></button>
                        <button onclick="execCmd('strikethrough');" title="Durchgestrichen" name="Web"><i class="fa fa-strikethrough fa-2x"></i></button>
                        &nbsp;
                        <button onclick="execCmd('justifyLeft');" title="Linksbündig" name="Web"><i class="fa fa-align-left fa-2x"></i></button>
                        <button onclick="execCmd('justifyCenter');" title="Zentriert" name="Web"><i class="fa fa-align-center fa-2x"></i></button>
                        <button onclick="execCmd('justifyRight');" title="Rechtsbündig" name="Web"><i class="fa fa-align-right fa-2x"></i></button>
                        <button onclick="execCmd('justifyFull');" title="Blocksatz" name="Web"><i class="fa fa-align-justify fa-2x"></i></button>
                        <button onclick="execCmd('indent');" title="Einzug vergrößern" name="Web"><i class="fa fa-indent fa-2x"></i></button>
                        <button onclick="execCmd('outdent');" title="Einzug verringern" name="Web"><i class="fa fa-outdent fa-2x"></i></button>
                        &nbsp;
                        <button onclick="execCmd('insertUnorderedList');" title="Aufzählungsliste" name="Web"><i class="fa fa-list-ul fa-2x"></i></button>
                        <button onclick="execCmd('insertOrderedList');" title="Nummerierte Liste" name="Web"><i class="fa fa-list-ol fa-2x"></i></button>
                        &nbsp;
                        <button onclick="execCmdWithArg('insertImage',prompt('URL des Bildes eingeben'));" title="Bild einfügen" name="Web"><i class="fa fa-picture-o fa-2x"></i></button>
                        <button onclick="execCmdWithArg('createLink', prompt('URL eingeben', 'http://'));" title="Link erstellen" name="Web"><i class="fa fa-link fa-2x"></i></button>
                        &nbsp;
                        <button onclick="execCmd('undo');" title="Rückgängig" name="Web"><i class="fa fa-undo fa-2x"></i></button>
                        <button onclick="execCmd('redo');" title="Wiederholen" name="Web"><i class="fa fa-repeat fa-2x"></i></button>
                        &nbsp;
                        <button onclick="showHTML();this.style.display='none';document.getElementById('showEditor').style.display='inline'" title="HTML Code anzeigen" id="showHTML" name="Web"><i class="fa fa-code fa-2x"></i></button>
                        <button onclick="showEditor();this.style.display='none';document.getElementById('showHTML').style.display='inline'" title="Editor anzeigen" id="showEditor" name="Web"><i class="fa fa-code fa-2x"></i></button>
                        <div name = "Web">
                            <br name = "Web">
                            <select onclick="changeFloat(this.value);" title="Float">
                                <option value="none">keiner</option>
                                <option value="left">links</option>
                                <option value="right">rechts</option>
                            </select>

                            <select onchange="execCmdWithArg('fontName', this.value);" title="font">
                                <option value="Roboto" style="font-family: 'Roboto'!important;">Roboto</option>
                                <option value="Open Sans" style="font-family: 'Open Sans'!important;">Open Sans</option>
                                <option value="Open Sans Condensed" style="font-family: 'Open Sans Condensed'!important;">Open Sans Condensed</option>
                                <option value="Montserrat" style="font-family: 'Montserrat'!important;">Montserrat</option>
                                <option value="Courier" style="font-family: 'Courier'!important;">Courier</option>
                                <option value="Oswald" style="font-family: 'Oswald'!important;">Oswald</option>
                                <option value="Ubuntu" style="font-family: 'Ubuntu'!important;">Ubuntu</option>
                                <option value="Playfair Display" style="font-family: 'Playfair Display'!important;">Playfair Display</option>
                                <option value="Rubik Mono One" style="font-family: 'Rubik Mono One'!important;">Rubik Mono One</option>
                                <option value="Inconsolata" style="font-family: 'Inconsolata'!important;">Inconsolata</option>
                                <option value="Indie Flower" style="font-family: 'Indie Flower'!important;">Indie Flower</option>
                                <option value="Lobster" style="font-family: 'Lobster'!important;">Lobster</option>
                                <option value="Abril Fatface" style="font-family: 'Abril Fatface'!important;">Abril Fatface</option>
                                <option value="Dancing Script" style="font-family: 'Dancing Script'!important;">Dancing Script</option>
                                <option value="Archivo Black" style="font-family: 'Archivo Black'!important;">Archivo Black</option>
                                <option value="Poiret One" style="font-family: 'Poiret One'!important;">Poiret One</option>
                            </select>
                            <select onclick="execCmdWithArg('formatBlock', '<'+this.value+'>');" title="Überschrift">
                                <option value="H1">&Uuml;berschrift 1</option>
                                <option value="H2">&Uuml;berschrift 2</option>
                                <option value="H3">&Uuml;berschrift 3</option>
                                <option value="H4">&Uuml;berschrift 4</option>
                                <option value="H5">&Uuml;berschrift 5</option>newsletter_create.jsp
                                <option value="H6">&Uuml;berschrift 6</option>
                            </select>
                            <select onchange="execCmdWithArg('fontSize', this.value);" title="Textgröße">
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                                <option value="6">6</option>
                                <option value="7">7</option>
                            </select>
                            <p style="display:inline-block">Textfarbe: <input type="color" onchange="execCmdWithArg('foreColor', this.value);"/></p>
                            <p style="display:inline-block">Text Hintergrund: <input type="color" onchange="execCmdWithArg('hiliteColor', this.value);"/></p>
                            <p style="display:inline-block"> Hintergrund: <input type="color" onchange="backgroundColor(this.value);"/></p>
                        </div>
                    </div>
                </div>

                <iframe name="editor" style="height:80%; width: 100%" frameborder="0" id="editor"></iframe>
                <button onclick="test();" title="Testen"  style="margin:10px"><i class="fa fa-desktop fa-2x"></i></button>
                
                <form action="../AddNewsletter" method="post">
                
                <button type="button" onclick="exp()" class="btn btn-default" data-toggle="modal" data-target="#modal-save"><i class="fa fa-paper-plane fa-2x"></i></button>
                
                <div class="modal fade" id="modal-save">
		          <div class="modal-dialog">
		            <div class="modal-content">
		              <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		                  <span aria-hidden="true">&times;</span></button>
		                <h4 class="modal-title">Newsletter speichern</h4>
		              </div>
		              <div class="modal-body">
		              	<div class="form-group">
		                	<label for="title" class="control-label">Titel</label>
                  			<input name="title" type="text" class="form-control" id="title" placeholder="Titel">
                  		</div>
                  		<div class="form-group">
		                	<label for="subject" class="control-label">Betreff</label>
                  			<input name="subject" type="text" class="form-control" id="subject" placeholder="Betreff">
                  		</div>
                  		<div class="form-group">
		                	<label for="author" class="control-label">Autor</label>
                  			<input name="author" type="text" class="form-control" id="author" value="<% out.print(username); %>" readonly>
                  		</div>
                  		<div class="form-group">
                 			<label>Beschreibung</label>
                  			<textarea class="form-control" name="description" rows="3" placeholder="Beschreiben ..."></textarea>
                		</div>
		              </div>
		              <div class="modal-footer">
		                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Beenden</button>
		                <button type="button submit" value="../AddNewsletter" class="btn btn-primary">Speichern</button>
		              </div>
		            </div>
		            <!-- /.modal-content -->
		          </div>
		          <!-- /.modal-dialog -->
		        </div>
		        <!-- /.modal -->
                
            </div>
            <noscript>
                <style type="text/css">
                    .pagecontainer {
                        display:none;
                    }

                    body {
                        background: #D2D6DE;
                    }

                    .container {
                        width: 500px;
                        padding: 8% 0 0;
                        margin: auto;
                    }
                    .form {
                        border-radius: 10px;
                        position: relative;
                        background: #FFFFFF;
                        max-width: 500px;
                        margin: 0 auto 100px;
                        padding: 45px;
                        text-align: center;
                    }
                    .form .message a {
                        color: #9AA0A6;
                        text-decoration: none;
                    }
                </style>
                <div class="container">
                    <div class="form">
                        Bitte aktivieren Sie Javascript, damit diese Seite korrekt funktioniert.

                    </div>
                </div>
            </noscript>

            <!--Send Dialog-->

        </section>
        <!-- /.content -->

		<!-- Ghost input for sending the test to the servlet -->
		<input id="out" name="text" style="width:1px; height:1px; visibility: hidden;">

		</form>
	
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



<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->
</body>

<script>

    document.getElementById('showEditor').style.display='none';
    editor.document.body.style.background = 'white';

    var src;
    function enableEditor(){
        editor.document.designMode = 'On';

        var fontLink = document.createElement("link");
        fontLink.href = "https://fonts.googleapis.com/css?family=Abril+Fatface|Archivo+Black|Dancing+Script|Inconsolata|Indie+Flower|Lobster|Montserrat|Open+Sans|Open+Sans+Condensed:300|Oswald|Playfair+Display|Poiret+One|Roboto|Rubik+Mono+One|Ubuntu";
        fontLink.rel = "stylesheet";
        frames['editor'].document.head.appendChild(fontLink);
        editor.document.body.style.margin = 0;

    }

    function backgroundColor(arg){
        editor.document.body.style.background = arg;

    }

    function execCmd(command){
        editor.document.execCommand(command, false, null);
    }

    function execCmdWithArg(command, arg){
        editor.document.execCommand(command, false, arg);
    }

    function showHTML(){
        format();
        document.getElementById('editor').contentWindow.document.body.innerText = src;
        document.getElementById('editor').contentWindow.document.body.style.backgroundColor = 'white';
        document.getElementById('editor').contentWindow.document.body.style.color = 'black';
        var w = document.getElementsByName("Web");
        for (i = 0; i < w.length; i++) {
            w[i].style.display = 'none';
        }
    }

    function showEditor(){
        src = document.getElementById('editor').contentWindow.document.body.innerText;
        src = src.replace(/(\r\n|\n|\r)/gm,"");
        document.getElementById('editor').contentWindow.document.documentElement.innerHTML = src;
        editor.document.designMode = 'On';
        changeifb();
        var w = document.getElementsByName("Web");
        for (i = 0; i < w.length; i++) {
            w[i].style.display = 'inline';
        }
    }

    function format(){
        src = document.getElementById('editor').contentWindow.document.documentElement.outerHTML;
        var i = 0;
        var z = 0;
        while(i < src.length){

            if (z == 0) {
                var n = src.indexOf('<', i);
                src = src.substr(0, n) + '\n' + src.substr(n);
                if (n == -1){
                    break;
                }
                i = n+2;
                z = 1;
            }
            if (z == 1) {
                var n = src.indexOf('>', i);
                if (n == -1){
                    break;
                }
                src = src.substr(0, n+1) + '\n' + src.substr(n+1);
                i = n+2;
                z = 0;
            }
        }

    }
    function test(){
        if(document.getElementById('showHTML').style.display === 'none'){
            src = document.getElementById('editor').contentWindow.document.body.innerText;
        }else{
            src = document.getElementById('editor').contentWindow.document.documentElement.outerHTML;
        }
        var test = window.open("", "", "width=600,height=800,location=0,menubar=0,resizable=1,status=0,toolbar=0,scrollbars=1");
        test.document.open();
        test.document.write(src);
        test.document.close();
    }
    function exp(){
        if(document.getElementById('showHTML').style.display === 'none'){
            src = document.getElementById('editor').contentWindow.document.body.innerText;
        }else{
            src = document.getElementById('editor').contentWindow.document.documentElement.outerHTML;
        }
        document.getElementById("out").value = src;
    }

    var popup = document.getElementById('send');
    var btn = document.getElementById("openSend");
    var span = document.getElementsByClassName("close")[0];

    btn.onclick = function() {
        popup.style.display = "block";
    };

    span.onclick = function() {
        popup.style.display = "none";
    };



</script>
<script src='https://code.jquery.com/jquery-1.10.1.js' type='text/javascript'></script>
<script>
    var img;
    var iframeBody;
    iframeBody = $('body', $('#editor')[0].contentWindow.document);
    click();

    function changeifb(){
        iframeBody = $('body', $('#editor')[0].contentWindow.document);
        $(iframeBody).off('click');
        click();
    }

    function click(){
        $(iframeBody).on('click', 'img', function() {
            img = $(this);
        });
    }

    function changeFloat(arg){
        $(img).css('float', arg);
    }
</script>

</html>
