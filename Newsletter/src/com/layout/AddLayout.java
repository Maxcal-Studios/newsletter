package com.layout;

import com.database.DBConnector;
import com.email.MailUtils;
import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.LinkedList;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddLayout")
public class AddLayout extends HttpServlet {
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	//creating a connection to the DB
    	Connection con = DBConnector.getConnection();
    	PreparedStatement st = null;
    	String sql;
    	
        try {
        	//getting the data
        	String name = request.getParameter("name");
        	String text = request.getParameter("text");
        	int pos = Integer.parseInt(request.getParameter("pos"));
        	
        	//creating new entry in the layout table
        	sql = "INSERT INTO layout (name, text, db_name, pos) VALUES(?, ?, ?, ?)";
        	st = con.prepareStatement(sql);
        	st.setString(1, name);
        	st.setString(2, text);
        	st.setString(3, name);
        	st.setInt(4, pos);
        	
        	st.executeUpdate();
        	
        	//adding new col to member table
        	sql = "ALTER TABLE member ADD ? varchar(128)";
        	st = con.prepareStatement(sql);
        	st.setString(1, name);
        	
        	st.executeUpdate();
            
        }
        catch (Exception e) {e.printStackTrace();}
        finally {
		    try { st.close(); } catch (Exception e) { }
		    try { con.close(); } catch (Exception e) { }
		}

      response.sendRedirect("../admin/layout.jsp");
      return;
    }
}