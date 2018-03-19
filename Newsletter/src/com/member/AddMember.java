package com.member;

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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddMember")
public class AddMember extends HttpServlet {
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	//login check
    	if(!DBConnector.isLoggedIn(request.getSession())) {
    		response.sendRedirect("../../login.jsp");
    	}
    	
    	//creating a connection to the DB
    	Connection con = DBConnector.getConnection();
    	PreparedStatement st = null;
    	ResultSet rs = null;
    	String sql;
    	
    	//create cookie to track the time the last member was added to prevent spam
        Cookie cookie = new Cookie("newsletter.time", Long.toString(System.currentTimeMillis()));
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            Cookie[] arrcookie = cookies;
            int n = arrcookie.length;
            int n2 = 0;
            while (n2 < n) {
                Cookie iCookie = arrcookie[n2];
                //checking if the last time the owner of the cookie created a member is larger then 15sec.
                if (cookie.getName().equals(iCookie.getName()) && Long.parseLong(iCookie.getValue()) > System.currentTimeMillis() - 15000) {
                    return;
                }
                ++n2;
            }
        }
        
        try {
        
        	//A list of all DB values wich need to be safed
        	LinkedList<String> DBcols = new LinkedList<String>();
        	
        	//index of the email String in the val Array
        	int emailIndex = 0;
        	
        	//getting all db_name's from layout ordered by ID and adding them to the list
        	sql = "SELECT db_name FROM layout ORDER BY ID";
        	st = con.prepareStatement(sql);
        	rs = st.executeQuery();
        	while(rs.next()) {
        		DBcols.add(rs.getString(1));
        	}
	        
        	//getting all form inputs and adding them in the Array
        	String[] val = new String[DBcols.size()];
        	for(int i = 0; i < val.length; i++) {
        		val[i] = request.getParameter(DBcols.get(i));
        		if(val[i] == "email") emailIndex = i;
        	}
        	
        	//generate MD5 hash
	        Random r = new Random();
	        int num = r.nextInt(100000);
	        String plaintext = String.valueOf(num);
            MessageDigest m = MessageDigest.getInstance("MD5");
            m.reset();
            m.update(plaintext.getBytes());
            byte[] digest = m.digest();
            BigInteger bigInt = new BigInteger(1, digest);
            String hash = bigInt.toString(16);
            while(hash.length() < 32) {
                hash = "0" + hash;
            }
            
            //send email
            MailUtils.sendMail(new String[] {val[emailIndex]}, "Newsletter", ("maxcal.hopto.org/Authentication?hash=" + hash));
            
            //generate  and execute the sql query to insert the new member
            sql = "INSERT INTO member(";
            for(String s : DBcols) {
            	sql += s + ",";
            }
            sql += "hash) VALUES(";
            for(String s : DBcols) {
            	sql += "?,";
            }
            sql += "?)";
            
            st = con.prepareStatement(sql);
            for(int i = 0; i < val.length; i++) {
            	st.setString(i+1, val[i]);
            }
            st.setString(val.length + 1, hash);
            st.executeUpdate();
            
            //closing the connections
            con.close();
            st.close();
        }
        catch (Exception e) {e.printStackTrace();}
        finally {
        	try { rs.close(); } catch (Exception e) { }
		    try { st.close(); } catch (Exception e) { }
		    try { con.close(); } catch (Exception e) { }
		}
        
        //adding the cookie with a timestamp
        response.addCookie(cookie);
        
        //redirect to auth.html
        response.sendRedirect("../auth.html");
    }
}