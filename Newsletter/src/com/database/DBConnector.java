package com.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBConnector {
    private static final String url = "jdbc:mysql://localhost:3306/newsletter";
    private static final String DBuser = "maxcal";
    private static final String DBpass = "maxcal";

    public static boolean check(String user, String pass) {
        Connection con;
        PreparedStatement st;
        try {
            String preSt = "SELECT * FROM admin WHERE user=? AND pass=?";
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/newsletter", DBuser, DBpass);
            st = con.prepareStatement(preSt);
            st.setString(1, user);
            st.setString(2, pass);
            ResultSet rs = st.executeQuery();
            if(rs.next()) {
            	st.close();
            	con.close();
            	return true;
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/newsletter", DBuser, DBpass);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
}