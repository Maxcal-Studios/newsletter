package com.login;

import com.database.DBConnector;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Login")
public class Login extends HttpServlet {
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	//getting the date from Form
        String pass  = request.getParameter("pass");
        String user = request.getParameter("user");
        
        //checking if the username and the password pair is in the database
        if (DBConnector.check(user, pass)) {
        	//getting the session
		    HttpSession session = request.getSession();
		    
		    //adding the attirbute user for security checking on later sites
		    session.setAttribute("user", user);
		    session.setAttribute("new", "true");
		    
		    //redirecting to the adminsite
		    response.sendRedirect("../admin/");
		    return;
		} else {
			//if the userdate is wrong the user will get redirected to the login site
		    response.sendRedirect("../login.jsp");
		    return;
		}
    }
}