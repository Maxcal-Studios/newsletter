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
	<meta name="viewport" content="width=device-width">
	<title>BrandName | Newsletter</title>
	<link rel="stylesheet" href="css/style.css">
</head>
<body>

	<header>
		<div class="container brand">
			<h1>BrandName</h1>		
		</div>
	</header>
	<div class="content">
		<section id="info" class="container">
			<h3>Newsletter</h3>
			<hr>
			<p>Ihr wollt immer auf dem Laufenden bleiben und interessiert euch f�r alles was gerade so passiert?</p>
		</section>
		<form action="AddMember" method="post" id="form" class="container">
			<table>
				<%
				
				for(ResultSet r : results) {
					r.next();
				}
				
				for(int i = 0; i < results.length; i++) {
					if(results[i].getBoolean("full")) {
						out.println("<tr>");
						out.println("<th>" + results[i].getString("text") + "</th>");
						out.println("</tr>");
						out.println("<tr>");
						out.println("<td colspan=\"2\"><input spellcheck=\"false\" type=\""+results[i].getString("type")+"\" name=\""+results[i].getString("db_name")+"\" class=\"span\"</td>");
						out.println("</tr>");						
					} else {
						out.println("<tr>");
						out.println("<th>" + results[i].getString("text") + "</th>");
						out.println("<th>" + results[i+1].getString("text") + "</th>");
						out.println("</tr>");
						out.println("<tr>");
						out.println("<td><input spellcheck=\"false\" type=\""+results[i].getString("type")+"\" name=\""+results[i].getString("db_name")+"\" class=\"span\"</td>");
						out.println("<td><input spellcheck=\"false\" type=\""+results[i+1].getString("type")+"\" name=\""+results[i+1].getString("db_name")+"\" class=\"span\"</td>");
						out.println("</tr>");
						
						i++;
					}
				}
				
				%>

				<tr>
					<td colspan="2"><button type="submit" value="AddMember" class="button1">Anmelden</button></td>
				</tr>
			</table>			
					
		</form>
	</div>
	<footer>
		<div id="links">
			<a href="login.jsp">Administration</a>
		</div>
		<div id="copy">
			<p>BrandName, Copyright &copy; 2017</p>
		</div>
	</footer>
</body>
</html>