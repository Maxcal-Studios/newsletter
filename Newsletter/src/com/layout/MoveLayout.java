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
public class MoveLayout extends HttpServlet {
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	//creating a connection to the DB
    	Connection con = DBConnector.getConnection();
    	PreparedStatement st = null;
    	String sql;
    	
        try {
        	//getting the data
        	int pos = Integer.parseInt(request.getParameter("pos"));
        	int id = Integer.parseInt(request.getParameter("id"));
        	String direction = request.getParameter("direction");

        	if(direction.equals("up") && pos > 1) {
        		sql = "UPDATE layout SET pos = ? WHERE pos = ?";
        		st = con.prepareStatement(sql);
        		st.setInt(1, pos);
        		st.setInt(1, pos - 1);
        		st.executeUpdate();
        		
        		sql = "UPDATE layout SET pos = ? WHERE id = ?";
        		st = con.prepareStatement(sql);
        		st.setInt(1, pos - 1);
        		st.setInt(1, id);
        		st.executeUpdate();
        		
        	} else {
        		sql = "UPDATE layout SET pos = ? WHERE pos = ?";
        		st = con.prepareStatement(sql);
        		st.setInt(1, pos);
        		st.setInt(1, pos + 1);
        		st.executeUpdate();
        		
        		sql = "UPDATE layout SET pos = ? WHERE id = ?";
        		st = con.prepareStatement(sql);
        		st.setInt(1, pos + 1);
        		st.setInt(1, id);
        		st.executeUpdate();
        	}
            
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