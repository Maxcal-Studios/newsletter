package com.newsletter;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.DBConnector;

/**
 * Servlet implementation class addNewsletter
 */
@WebServlet("/AddNewsletter")
public class AddNewsletter extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//login check
		if(!DBConnector.isLoggedIn(request.getSession())) {
			response.sendRedirect("../../login.jsp");
		}
		
		int cols = 4;
		
		//creating a connection to the DB
		Connection con = DBConnector.getConnection();
		String sql = "INSERT INTO newsletter (title, author, description, text) Values(?, ?, ?, ?)";
		PreparedStatement st = null;
		
		try {
		
			//getting the Data
			String[] val = new String[cols];
			val[0] = request.getParameter("title");
			val[1] = request.getParameter("author");
			val[2] = request.getParameter("description");
			//val[3] = request.getParameter("editor");
			val[3] = "testtext";
			
			//Inserts new newsletter into table
			st = con.prepareStatement(sql);
			for(int i = 0; i < val.length; i++) {
				st.setString(i+1, val[i]);
			}
			st.executeUpdate();
		
		} catch (SQLException e) {e.printStackTrace();}
		finally {
		    try { st.close(); } catch (Exception e) { }
		    try { con.close(); } catch (Exception e) { }
		}
		
		//redirect user
		response.sendRedirect("../admin/publish.jsp");
	}

}
