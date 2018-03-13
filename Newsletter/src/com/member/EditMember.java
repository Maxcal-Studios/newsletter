package com.member;

import java.io.IOException;
import java.sql.Connection;
import java.util.LinkedList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.database.DBConnector;

/**
 * Servlet implementation class EditMember
 */
@WebServlet("/EditMember")
public class EditMember extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
        	//creating a connection to the DB
        	Connection con = DBConnector.getConnection();
        	
        	//A list of all DB values wich need to be safed
        	LinkedList<String> DBcols = new LinkedList<String>();
        	
		} catch(Exception e) {e.printStackTrace();}
		
	}

}