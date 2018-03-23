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

        ResultSet data;
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

    <style>
        #container i , select{color:black;}
        button{margin-bottom:5px}
        select{margin-bottom:5px}
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
                <li><a href="member.jsp"><i class="fa fa-users"></i><span> Mitglieder</span></a></li>
                <li class="treeview active">
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
                Erstellen
                <small>Einen neuen Newsletter erstellen</small>
            </h1>
            <ol class="breadcrumb">
                <li><a href="index.jsp"><i class="fa fa-dashboard"></i> Dashboard</a></li>
                <li>Newsletter</li>
                <li class="active">Erstellen</li>
            </ol>
        </section>

        <!-- Main content -->
        <section class="content container-fluid">

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

</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->

<!-- jQuery 3 -->
<script src="../bootstrap/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="../bootstrap/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="../bootstrap/dist/js/adminlte.min.js"></script>
<!-- ChartJS -->
<script src="../bootstrap/bower_components/chart.js/Chart.js"></script>

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
        src = src.replace("<html>", "");
        src = src.replace("</html>", "");
        src = src.replace("<head>", "");
        src = src.replace("</head>", "");
        src = src.replace("<body>", "");
        src = src.replace("</body>", "");
        src = src + "<br><hr><footer>Vom Newsletter abmelden: $deaktivated</footer>";

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
        src = src.replace("<html>", "");
        src = src.replace("</html>", "");
        src = src.replace("<head>", "");
        src = src.replace("</head>", "");
        src = src.replace("<body>", "");
        src = src.replace("</body>", "");
        src = src + "<br><hr><footer>Vom Newsletter abmelden: $deaktivated</footer>";
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

<%
    head.close();
    member.close();
    st.close();
    con.close();
%>

</html>
