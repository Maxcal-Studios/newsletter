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
@WebServlet("/addNewsletter")
public class AddNewsletter extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int cols = 4;
		
		//creating a connection to the DB
		Connection con = DBConnector.getConnection();
		String sql = "INSERT INTO newsletter (name, author, time, text) Values(?, ?, ?);";
		PreparedStatement st = null;
		
		try {
		
			//getting the Data
			String[] val = new String[cols];
			val[0] = request.getParameter("title");
			val[1] = request.getParameter("author");
			val[2] = request.getParameter("text");
			
			//Inserts new newsletter into table
			st = con.prepareStatement(sql);
			for(int i = 0; i < val.length; i++) {
				st.setString(i+1, val[i]);
			}
			st.executeQuery();
		
		} catch (SQLException e) {e.printStackTrace();}
		finally {
		    try { st.close(); } catch (Exception e) { }
		    try { con.close(); } catch (Exception e) { }
		}
	}

}
