package com.member;

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
 * Servlet implementation class Deactivation
 */
@WebServlet("/Deactivation")
public class Deactivation extends HttpServlet {
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//login check
		if(!DBConnector.isLoggedIn(request.getSession())) {
			response.sendRedirect("../../login.jsp");
		}
		
		String hash = request.getParameter("hash");
        Connection con = DBConnector.getConnection();
        String sql = "UPDATE member SET active = FALSE WHERE hash=?";
        PreparedStatement st = null;
		
		try {
            st = con.prepareStatement(sql);
            st.setString(1, hash);
            st.executeUpdate();
        }catch (SQLException e) {e.printStackTrace();}
		finally {
		    try { st.close(); } catch (Exception e) { }
		    try { con.close(); } catch (Exception e) { }
		}
		
        response.sendRedirect("../deactivated.html");
	}

}