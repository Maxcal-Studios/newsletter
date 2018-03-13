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
		try {
            String hash = request.getParameter("hash");
            Connection con = DBConnector.getConnection();
            String sql = "UPDATE member SET active = FALSE WHERE hash=?";
            PreparedStatement st = con.prepareStatement(sql);
            st = con.prepareStatement(sql);
            st.setString(1, hash);
            st.executeUpdate();
            con.close();
            st.close();
        }catch (SQLException e) {
            e.printStackTrace();
        }
        response.sendRedirect("../deactivated.html");
	}

}