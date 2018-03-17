package com.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

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
@WebServlet("/RemoveMember")
public class RemoveMember extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		try {
        	//creating a connection to the DB
        	Connection con = DBConnector.getConnection();
        	String sql;
        	PreparedStatement st;
        	
        	//get Data
        	int id = Integer.parseInt(request.getParameter("id"));
        	
        	out.println(id);
        	
        	//Remove entry in member table
        	sql = "DELETE FROM member WHERE id = ?";
        	st = con.prepareStatement(sql);
        	st.setInt(1, id);
        	
        	st.executeUpdate();
        	
        	//close connections
        	st.close();
        	con.close();
        	
        	response.sendRedirect("../admin/member.jsp");
        	
		} catch(Exception e) {e.printStackTrace();}
	
	}

}
