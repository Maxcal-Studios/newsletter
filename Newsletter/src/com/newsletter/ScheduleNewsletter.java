package com.newsletter;

import java.io.IOException;
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
 * Servlet implementation class SceduleNewsletter
 */
@WebServlet("/ScheduleNewsletter")
public class ScheduleNewsletter extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//login check
		if(!DBConnector.isLoggedIn(request.getSession())) {
			response.sendRedirect("../../login.jsp");
		}
		
		//creating a connection to the DB
    	Connection con = DBConnector.getConnection();
    	PreparedStatement st = null;
    	String sql = "INSERT INTO scedule(newsletterID, creator, sendDate, krit, elements) VALUES(?, ?, ?, ?, ?)";
		
		try {
			
			//getting the parameters
			int newsletterID = Integer.parseInt(request.getParameter("id"));
			String creator = request.getSession().getAttribute("user").toString();
			String date = request.getParameter("date");
			String time = request.getParameter("time");
			String krit = request.getParameter("krit");
			String elements = request.getParameter("elements");
			
			//prepare Statement
			st.setInt(1, newsletterID);
			st.setString(2, creator);
			st.setString(4, krit);
			st.setString(5, elements);
			
		} catch(Exception e) {e.printStackTrace();}
		finally {
			try { st.close(); } catch (Exception e) { }
		    try { con.close(); } catch (Exception e) { }
		}
	}

}
