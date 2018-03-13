package com.login;

import com.database.DBConnector;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Login")
public class Login
extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pass  = request.getParameter("pass");
        String user = request.getParameter("user");
        if (DBConnector.check(user, pass)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("new", "true");
            response.sendRedirect("../admin/");
        } else {
            response.sendRedirect("../login.jsp");
        }
    }
}