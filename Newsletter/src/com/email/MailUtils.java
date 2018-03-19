package com.email;

import com.email.MailUtils;

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
        String username = "maxcal.studios@gmail.com";
        String password = "M9a8x7c6a5l";
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        Session session = Session.getInstance((Properties)props, 
        		new javax.mail.Authenticator() {
        			protected PasswordAuthentication getPasswordAuthentication() {
        				return new PasswordAuthentication("maxcal.studios@gmail.com", "M9a8x7c6a5l");
        			}});
        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom((Address)new InternetAddress("maxcal.studios@gmail.com"));
            message.addRecipients(Message.RecipientType.TO, (Address[])InternetAddress.parse(recipient));
            message.setSubject(subject);
            message.setText(content);
            Transport.send((Message)message);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static void sendMail(ArrayList<String> recipients, String subject, String content) {
        String username = "maxcal.studios@gmail.com";
        String password = "M9a8x7c6a5l";
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        Session session = Session.getInstance((Properties)props, 
        		new javax.mail.Authenticator() {
        			protected PasswordAuthentication getPasswordAuthentication() {
        				return new PasswordAuthentication("maxcal.studios@gmail.com", "M9a8x7c6a5l");
        			}});
        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom((Address)new InternetAddress("maxcal.studios@gmail.com"));
            for(int i = 0; i < recipients.size(); i++) {
            	message.addRecipients(Message.RecipientType.TO, (Address[])InternetAddress.parse(recipients.get(i)));
            }
            message.setSubject(subject);
            message.setText(content);
            Transport.send((Message)message);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
    
}