<%@page import="com.database.DBConnector, java.sql.*"%>
<html>
<head>
	<title>BrandName | name</title>
	<link rel="stylesheet" href="../css/style.css">
</head>
<body>
	<%
	//retrieves the ID of the demanded member
	String id = request.getParameter("id");
	
	//Create connection to DB
	Connection con = DBConnector.getConnection();
	
	//gets all date of demanded member
	String sql = "SELECT * FROM member WHERE ID = ?;";
	PreparedStatement st = con.prepareStatement(sql);
	st.setString(1, id);
	ResultSet rsVal = st.executeQuery();
	
	//gets all the column headers of the table
	sql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'member';";
	st = con.prepareStatement(sql);
	ResultSet rsLabel = st.executeQuery();
	
	%>
	<div class="container">
		<form action="../EditMember" method="post">
			<table width=100% >
	
	<%
	//generate HTML
	int length = 0;
	while(rsLabel.next()) {
		length++;
	}
	rsLabel.first();
	
	rsVal.first();
	
	for(int i = 1; i <= rsVal.getMetaData().getColumnCount(); i++) {
		out.println("<tr>");
		out.println("<td>" + rsLabel.getString(1) + "</td>");
		out.println("<td><input spellcheck=\"false\" id=\"input\" name=\""+ rsLabel.getString(1) +"\" value=\"" + rsVal.getString(i) + "\"></td>");
		out.println("</tr>");
		rsLabel.next();
	}
	%>
			</table>
		
			<button style="width=100%" value="../EditMember" type="submit" class="button1">Save</button>
			<a href="member.jsp"></a>
		</form>
	</div>
</body>
	<%
	st.close();
	con.close();
	%>
</html>