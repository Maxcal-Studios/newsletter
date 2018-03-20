package com.newsletter;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedList;

import com.database.DBConnector;
import com.email.MailUtils;

public class NewsletterSender {

	public static void sendNewsletter(int id, String krit, String elements) {
		
		//creating a connection to the DB
    	Connection con = DBConnector.getConnection();
    	PreparedStatement st = null;
    	ResultSet rs = null;
    	String sql = "SELECT text, subject FROM newsletter WHERE id = ?";
		
		try {
			
			//getting the newsletter
			st = con.prepareStatement(sql);
			st.setInt(1, id);
			rs = st.executeQuery();
			rs.first();
			
			String text = rs.getString(1);
			String subject = rs.getString(2);
			
			//cutting elements
			String[] element = elements.split(" ");
			
			//getting all members
			sql = "SELECT email FROM member WHERE active = TRUE AND (";
			for(int i = 0; i < element.length - 1; i++) {
				sql += " " + krit + " = " + element[i] + " OR";
			}
			sql += " " + krit + " = " + element[element.length-1] + ")";
			
			st = con.prepareStatement(sql);
			rs = st.executeQuery();
			rs.first();
			
			//populating the recipients Array
			ArrayList<String> recipients = new ArrayList<String>();
			do {
				recipients.add(rs.getString(1));
			}
			while(rs.next());
			
			//send email
			MailUtils.sendMail(recipients, subject, text);
			
		} catch(Exception e) {e.printStackTrace();}
		finally {
			try { rs.close(); } catch (Exception e) { }
			try { st.close(); } catch (Exception e) { }
		    try { con.close(); } catch (Exception e) { }
		}
		
	}
	
}
