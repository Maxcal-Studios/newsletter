package com.newsletter;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.DBConnector;

/**
 * Servlet implementation class getDescription
 */
@WebServlet("/GetDescription")
public class GetDescription extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//setting up PrintWriter
		PrintWriter out = response.getWriter();
		
		//login check
		if(!DBConnector.isLoggedIn(request.getSession())) {
			response.sendRedirect("../../login.jsp");
		}
		
		//creating a connection to the DB
		Connection con = DBConnector.getConnection();
		PreparedStatement st = null;
		ResultSet rs = null;
		String sql = "SELECT description FROM newsletter WHERE id = ?";
		
		try {
			
			//getting the parameter
			int id = Integer.parseInt(request.getParameter("id"));
			
			//prepare statement
			st = con.prepareStatement(sql);
			st.setInt(1, id);
			
			//execute Query
			rs = st.executeQuery();
			rs.first();
			
			out.println("<p id=\"description\">" + rs.getString(1) + "</p>");
			
		} catch(Exception e) {e.printStackTrace();}
		finally {
			try { rs.close(); } catch (Exception e) { }
			try { st.close(); } catch (Exception e) { }
		    try { con.close(); } catch (Exception e) { }
		}
		
	}
}
