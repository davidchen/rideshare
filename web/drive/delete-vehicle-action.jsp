<%--
Called from profile to delete vehicle from your account
 --%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<%
Integer userid  = (Integer)session.getAttribute("userid");
String username = (String)session.getAttribute("username");
String vehicleid = request.getParameter("vehicleid");

String url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
Class.forName("com.mysql.jdbc.Driver");

try {
	
	Connection con = DriverManager.getConnection(url, "admin", "adminadmin");
	
	String query2 = "DELETE FROM vehicle WHERE driverid = ? AND vehicleid = ?";
	PreparedStatement ps2 = con.prepareStatement(query2);
	ps2.setInt(1, userid);
	ps2.setString(2, vehicleid);
	int successCode = ps2.executeUpdate();
	
	con.close();

	System.out.println(successCode);
	
	response.sendRedirect("../profile");

} catch (Exception e) {
	out.println("We encountered an error.\n");
	out.println("Details:");
	out.println(e);
}

%>