package com.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.LinkedList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.DBConnector;

/**
 * Servlet implementation class EditMember
 */
@WebServlet("/EditMember")
public class EditMember extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//creating a connection to the DB
        Connection con = DBConnector.getConnection();
        String sql;
       	PreparedStatement st = null;
       	
		try {
        	
        	//gets all the column headers of the table
        	sql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'member'";
        	st = con.prepareStatement(sql);
        	ResultSet rsLabel = st.executeQuery();
        	
        	//getting the data
        	int length = 0;
        	while(rsLabel.next()) {
        		length++;
        	}
        	rsLabel.first();
        	
        	String[] val = new String[length];
        	for(int i = 0; i < val.length; i++) {
        		val[i] = request.getParameter(rsLabel.getString(1));
        		rsLabel.next();
        	}
        	
        	//update member table
        	sql = "UPDATE member SET";
        	
        	rsLabel.first();
        	
        	while(rsLabel.next()) {
        		sql += " " + rsLabel.getString(1) + " = ?,";
        	}
        	sql = sql.substring(0, sql.length() - 1);
        	sql += " WHERE ID = ?";
        	
        	st = con.prepareStatement(sql);
        	for(int i = 1; i < val.length; i++) {
        		st.setString(i, val[i]);
        	}
        	st.setInt(val.length, Integer.parseInt(val[0]));
        	
        	st.executeUpdate();
        	
        	response.sendRedirect("../admin/member.jsp");
        	
		} catch(Exception e) {e.printStackTrace();}
		finally {
		    try { st.close(); } catch (Exception e) { }
		    try { con.close(); } catch (Exception e) { }
		}
		
	}

}