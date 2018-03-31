package com.layout;

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
;
/**
 * Servlet implementation class RemoveMember
 */
@WebServlet("/RemoveLayout")
public class RemoveLayout extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//login check
		if(!DBConnector.isLoggedIn(request.getSession())) {
			response.sendRedirect("../../login.jsp");
			return;
		} 
		
		//creating a connection to the DB
    	Connection con = DBConnector.getConnection();
    	PreparedStatement st = null;
    	ResultSet rs = null;
    	String sql;
		
		try {
        	
        	//getting the data
        	int id = Integer.parseInt(request.getParameter("id"));
        	
        	//Remove entry in member table
        	sql = "DELETE FROM layout WHERE id = ?";
        	st = con.prepareStatement(sql);
        	st.setInt(1, id);
        	
        	st.executeUpdate();
        	
        	//reset pos
        	sql = "SELECT id FROM layout ORDER BY pos ASC";
        	st = con.prepareStatement(sql);
        	rs = st.executeQuery();
        	
        	int i = 0;
        	while(rs.next()) {
        		sql = "UPDATE layout SET pos = ? WHERE id = ?";
        		st = con.prepareStatement(sql);
        		st.setInt(1, i);
        		st.setInt(2, rs.getInt("id"));
        		st.executeUpdate();
        		
        		i++;
        	}
        			
		} catch(Exception e) {e.printStackTrace();}
		finally {
			try { rs.close(); } catch (Exception e) { }
		    try { st.close(); } catch (Exception e) { }
		    try { con.close(); } catch (Exception e) { }
		}
		
		//redirect the user
		response.sendRedirect("../admin/layout.jsp");
		return;
	}

}
