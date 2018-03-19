package com.newsletter;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.DBConnector;
import com.email.MailUtils;

/**
 * Servlet implementation class publishNewsletter
 */
@WebServlet("/PublishNewsletter")
public class PublishNewsletter extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//login check
		if(!DBConnector.isLoggedIn(request.getSession())) {
			response.sendRedirect("../../login.jsp");
		}
		
		//getting the formdata
		int id = Integer.parseInt(request.getParameter("id"));
		
		NewsletterSender.sendNewsletter(id);
		
		response.sendRedirect("../admin/publish.jsp");
	}
}
