package com.email;

import com.database.DBConnector;
import com.email.MailUtils;
import com.newsletter.Member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;
import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailUtils {
    public static void sendMail(String recipient, String subject, String content) {
    	
    	//creating a connection to the DB
    	Connection con = DBConnector.getConnection();
    	String sql = "SELECT * FROM email";
    	PreparedStatement st = null;
    	ResultSet rs = null;
    	
    	try {
    		st = con.prepareStatement(sql);
    		rs = st.executeQuery();
    		rs.first();
    	
	        String username = rs.getString("email");
	        String password = rs.getString("password");
	        Properties props = new Properties();
	        props.put("mail.smtp.auth", "true");
	        props.put("mail.smtp.starttls.enable", "true");
	        props.put("mail.smtp.host", "smtp.gmail.com");
	        props.put("mail.smtp.port", "587");
	        
	        Session session = Session.getInstance((Properties)props, 
	        		new javax.mail.Authenticator() {
	        			protected PasswordAuthentication getPasswordAuthentication() {
	        				return new PasswordAuthentication(username, password);
	        			}});
	            MimeMessage message = new MimeMessage(session);
	            message.setFrom((Address)new InternetAddress(username));
	            message.addRecipients(Message.RecipientType.BCC, (Address[])InternetAddress.parse(recipient));
	            message.setSubject(subject);
	            message.setContent(content, "text/html; charset=utf-8");
	            Transport.send((Message)message);
    	} catch (Exception e) {
            e.printStackTrace();
        }
        
        try {
			rs.close();
			st.close();
	        con.close();
		} catch (SQLException e) {}
        
    }
    
    public static void sendMail(ArrayList<Member> recipients, String subject, String content) {
    	
    	//creating a connection to the DB
    	Connection con = DBConnector.getConnection();
    	String sql = "SELECT * FROM email";
    	PreparedStatement st = null;
    	ResultSet rs = null;
    	
    	try {
    	st = con.prepareStatement(sql);
		rs = st.executeQuery();
		rs.first();
	
        String username = rs.getString("email");
        String password = rs.getString("password");
    	Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        Session session = Session.getInstance((Properties)props, 
        		new javax.mail.Authenticator() {
        			protected PasswordAuthentication getPasswordAuthentication() {
        				return new PasswordAuthentication(username, password);
        			}});
            MimeMessage message = new MimeMessage(session);
            message.setFrom((Address)new InternetAddress(username));
            message.setSubject(subject);
            for(int i = 0; i < recipients.size(); i++) {
            	message.setRecipients(Message.RecipientType.BCC, recipients.get(i).getAddress());
            	String custom = content.replace("$deaktivated", recipients.get(i).getHash());
            	message.setContent(custom, "text/html; charset=utf-8");
            	Transport.send((Message)message);
            }
            
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    	
    	 try {
 			rs.close();
 			st.close();
 	        con.close();
 		} catch (SQLException e) {}
    }
    
}