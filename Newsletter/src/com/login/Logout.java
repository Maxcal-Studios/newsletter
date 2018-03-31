package com.login;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Logout")
public class Logout
extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	//getting the session
        HttpSession session = request.getSession();
        
        //removing the "user" attribute to make sure the user can't use locked content anymore
        session.removeAttribute("user");
        session.invalidate();
        
        //redirecting the user to the index.jsp
        response.sendRedirect("../index.jsp");
        return;
    }
}