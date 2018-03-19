package com.listener;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import com.database.DBConnector;
import com.newsletter.NewsletterSender;

@WebListener
public class ServerContextListener implements ServletContextListener {

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		TimerTask sheduleTimer = new SheduleTimerTask();
		
		Timer timer = new Timer();
		//timer.schedule(sheduleTimer, 1000, 15*(60 * 1000));
	}
	
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		
	}
	
	class SheduleTimerTask extends TimerTask {
		Connection con = DBConnector.getConnection();
		PreparedStatement st = null;
		ResultSet rs = null;
		
		@Override
		public void run() {
			
			String sql = "SELECT * FROM shedule";
			
			try {
				st = con.prepareStatement(sql);
				rs = st.executeQuery();
				
				while(rs.next()) {
					Date publishDate = rs.getTimestamp("publishDate");
					if(publishDate.after(new Date())) {
						NewsletterSender.sendNewsletter(rs.getInt("id"));
						sql = "DELETE FROM shedule WHERE id = ?";
						st = con.prepareStatement(sql);
						st.setInt(1, rs.getInt("id"));
						st.executeUpdate();
					}
				}
			} catch (SQLException e) {e.printStackTrace();}
			
		}
	}
	
}
