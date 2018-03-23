package com.newsletter;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;

import com.database.DBConnector;
import com.email.MailUtils;

public class NewsletterSender {

	public static void sendNewsletter(int id, String krit, String elements) {
		
		//creating a connection to the DB
    	Connection con = DBConnector.getConnection();
    	PreparedStatement st = null;
    	ResultSet rs = null;
    	String sql = "SELECT text, subject, title FROM newsletter WHERE id = ?";
		
		try {
			
			//getting the newsletter
			st = con.prepareStatement(sql);
			st.setInt(1, id);
			rs = st.executeQuery();
			rs.first();
			
			String text = rs.getString("text");
			String subject = rs.getString("subject");
			
			sql = "INSERT INTO history (newsletterTitle, sendDate) VALUES(?, ?)";
			st = con.prepareStatement(sql);
			st.setString(1, rs.getString("title"));
			st.setTimestamp(2, new Timestamp(new Date().getTime()));
			st.executeUpdate();

			if(krit == null || elements == null || krit.equals("") || elements.equals("")) {
				sql = "SELECT email, hash FROM member WHERE active = TRUE";
			} else {
				//cutting elements
				String[] element = elements.split(" ");
				
				//getting all members
				sql = "SELECT email, hash FROM member WHERE active = TRUE AND (";
				for(int i = 0; i < element.length - 1; i++) {
					sql += " " + krit + " = " + element[i] + " OR";
				}
				sql += " " + krit + " = " + element[element.length-1] + ")";
			}
			
			st = con.prepareStatement(sql);
			rs = st.executeQuery();
			
			//populating the recipients Array
			ArrayList<Member> recipients = new ArrayList<Member>();
			while(rs.next()) {
				recipients.add(new Member(rs.getString("email"), rs.getString("hash")));
			}
			
			
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
