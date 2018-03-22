package com.member;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.DBConnector;

/**
 * Servlet implementation class GetElements
 */
@WebServlet("/GetElements")
public class GetElements extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//creating a connection to the DB
    	Connection con = DBConnector.getConnection();
    	PreparedStatement st = null;
    	ResultSet rs = null;
    	String sql = "SELECT ? FROM member";
    	
    	try {
    		
    	} catch(Exception e) {e.printStackTrace();}
		finally {
			try { rs.close(); } catch (Exception e) { }
		    try { st.close(); } catch (Exception e) { }
		    try { con.close(); } catch (Exception e) { }
		}
	}

	

}
