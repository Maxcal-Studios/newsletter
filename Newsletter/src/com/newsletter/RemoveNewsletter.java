package com.newsletter;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.DBConnector;

/**
 * Servlet implementation class RemoveNewsletter
 */
@WebServlet("/RemoveNewsletter")
public class RemoveNewsletter extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//login check
		if(!DBConnector.isLoggedIn(request.getSession())) {
			response.sendRedirect("../../login.jsp");
		}
		
		//creating a connection to the DB
    	Connection con = DBConnector.getConnection();
    	PreparedStatement st = null;
    	String sql = "DELETE FROM newsletter WHERE id = ?";
    	
    	//var
    	int id = -1;
    	
    	try {
    		//getting data
    		id = Integer.parseInt(request.getParameter("id"));
    		
    		//create Statement
    		st = con.prepareStatement(sql);
    		st.setInt(1, id);
    		
    		//executing querry
    		st.executeUpdate();
    		
    	} catch(Exception e) {e.printStackTrace();}
    	finally {
    		try { st.close(); } catch (Exception e) { }
		    try { con.close(); } catch (Exception e) { }
    	}
    	
    	response.sendRedirect("../admin/publish.jsp");
    	
	}

}
