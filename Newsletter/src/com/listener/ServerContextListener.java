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

	Timer timer;
	
	@Override
	public void contextInitialized(ServletContextEvent sce) {
		TimerTask sheduleTimer = new SheduleTimerTask();
		
		timer = new Timer();
		timer.schedule(sheduleTimer, 1000, 5 *(60*1000));
	}
	
	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		timer.cancel();
		timer.purge();
	}
	
	class SheduleTimerTask extends TimerTask {
		Connection con = DBConnector.getConnection();
		PreparedStatement st = null;
		ResultSet rs = null;
		
		@Override
		public void run() {
			
			String sql = "SELECT * FROM schedule";
			
			try {
				st = con.prepareStatement(sql);
				rs = st.executeQuery();
				
				while(rs.next()) {
					Date publishDate = rs.getTimestamp("sendDate");
					if(publishDate.before(new Date())) {
						NewsletterSender.sendNewsletter(rs.getInt("newsletterID"), rs.getString("krit"), rs.getString("elements"));
						sql = "DELETE FROM schedule WHERE id = ?";
						st = con.prepareStatement(sql);
						st.setInt(1, rs.getInt("id"));
						st.executeUpdate();
					}
				}
			} catch (SQLException e) {e.printStackTrace();}
			
		}
	}
	
}
