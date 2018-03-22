<%@ page import="java.sql.*, com.database.*;" %>

<html>

<head>

	<%
		Connection con = DBConnector.getConnection();
		String sql = "SELECT * FROM layout";
		PreparedStatement st = con.prepareStatement(sql);
		ResultSet rs = st.executeQuery();
		rs.last();
		ResultSet[] results = new ResultSet[rs.getRow()];

		for(int i = 0; i < results.length; i++) {
			sql = "SELECT * FROM layout WHERE pos=" + i;
			st = con.prepareStatement(sql);
			results[i] = st.executeQuery();
		}
	%>

	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!-- Tell the browser to be responsive to screen width -->
	<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
	<!-- Bootstrap 3.3.7 -->
	<link rel="stylesheet" href="bootstrap/bower_components/bootstrap/dist/css/bootstrap.min.css">
	<!-- Font Awesome -->
	<link rel="stylesheet" href="bootstrap/bower_components/font-awesome/css/font-awesome.min.css">
	<!-- Ionicons -->
	<link rel="stylesheet" href="bootstrap/bower_components/Ionicons/css/ionicons.min.css">
	<!-- Theme style -->
	<link rel="stylesheet" href="bootstrap/dist/css/AdminLTE.min.css">
	<!-- AdminLTE Skins. Choose a skin from the css/skins
     folder instead of downloading all of them to reduce the load. -->
	<link rel="stylesheet" href="bootstrap/dist/css/skins/_all-skins.min.css">
	<!-- Morris chart -->
	<link rel="stylesheet" href="bootstrap/bower_components/morris.js/morris.css">
	<!-- jvectormap -->
	<link rel="stylesheet" href="bootstrap/bower_components/jvectormap/jquery-jvectormap.css">
	
	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
	<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
	<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
	<![endif]-->

	<!-- Google Font -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">

	<style>
		.btn-hover {
			margin-left: 32.5%;
			background: white;
		}

		.btn-hover:hover {
			background: #d3d3d3;
		}
	</style>
	<title>Newsletter | Anmelden</title>

</head>

<body style="background:#D0D5DD">
<div class="login-box">
  <div class="login-logo">
    <a href="index.jsp"><b>News</b>letter</a>
  </div>
  <!-- /.login-logo -->
  <div class="login-box-body">
    <p class="login-box-msg">Registrieren</p>

    <form action="AddMember" method="post">
      	<%
	
		for(ResultSet r : results) {
			r.next();
		}
	
		for(int i = 0; i < results.length; i++) {
			out.println("<div class=\"form-group \">");
			out.println("<input placeholder=\"" + results[i].getString("text") + "\"spellcheck=\"false\" type=\""+results[i].getString("type")+"\" name=\""+results[i].getString("db_name")+"\" class=\"form-control\">");
			out.println("</div>");
		}
		%>
      <button type="submit" class="btn btn-primary btn-block btn-flat">Registrieren</button>
    </form>

  </div>
  <!-- /.login-box-body -->
</div>
<!-- /.login-box -->

	
						
	<a href="login.jsp" style="color:black"> <button class="btn btn-flat btn-hover">Zum Adminpanel</button></a>
</body>
<!-- jQuery 3 -->
<script src="bootstrap/bower_components/jquery/dist/jquery.min.js"></script>
<!-- jQuery UI 1.11.4 -->
<script src="bootstrap/bower_components/jquery-ui/jquery-ui.min.js"></script>

<!-- Bootstrap 3.3.7 -->
<script src="bootstrap/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="bootstrap/dist/js/adminlte.min.js"></script>

<%
	rs.close();
	st.close();
	con.close();
%>

</html>