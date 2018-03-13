package com.member;

import com.database.DBConnector;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(value={"/Authentication"})
public class Authentication extends HttpServlet {
	
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String hash = request.getParameter("hash");
            Connection con = DBConnector.getConnection();
            String sql = "UPDATE member SET active = TRUE WHERE hash=?";
            PreparedStatement st = con.prepareStatement(sql);
            st = con.prepareStatement(sql);
            st.setString(1, hash);
            st.executeUpdate();
            con.close();
            st.close();
        }catch (SQLException e) {
            e.printStackTrace();
        }
        response.sendRedirect("../activated.html");
    }
}
