package com.email;

import java.util.Properties;
import javax.ejb.LocalBean;
import javax.ejb.Stateless;
import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

@Stateless
@LocalBean
public class MailSenderBean {
    public void sendMail(String to, String subject, String message) {
        String user = "Maxcal.Studios";
        String pass = "M9a8x7c6a5l";
        String from = "Maxcal.Studios@gmail.com";
        Properties props = System.getProperties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.fallback", "false");
        Session mailSession = Session.getDefaultInstance((Properties)props, (Authenticator)null);
        mailSession.setDebug(true);
        MimeMessage mailMessage = new MimeMessage(mailSession);
        try {
            mailMessage.setFrom((Address)new InternetAddress(from));
            mailMessage.setRecipient(Message.RecipientType.TO, (Address)new InternetAddress(to));
            mailMessage.setContent((Object)message, "text/html");
            mailMessage.setSubject(subject);
            Transport transport = mailSession.getTransport("smtp");
            transport.connect("smtp.gmail.com", user, pass);
            Transport.send((Message)mailMessage, (Address[])mailMessage.getAllRecipients());
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }
}