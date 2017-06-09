<%@ include file="/partials/page-imports.jsp" %>

<%
Integer userid  = (Integer)session.getAttribute("userid");
String username = (String)session.getAttribute("username");

String startLocation  = request.getParameter("start-location");

String startTimeString = request.getParameter("start-time");
System.out.println(startTimeString);
java.util.Date startTimeDate = new SimpleDateFormat("HH:mm").parse(startTimeString);
java.sql.Time startTime = new Time(startTimeDate.getTime());

String endLocation    = request.getParameter("end-location");
String day            = request.getParameter("day");
Boolean repeating     = (request.getParameter("repeating") == "true");
int vehicleid         = Integer.parseInt(request.getParameter("vehicleid"));

String url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
Class.forName("com.mysql.jdbc.Driver");

try {
	
	Connection con = DriverManager.getConnection(url, "admin", "adminadmin");
	
	// Add new ride offer to database
	String query2 = "INSERT INTO offer(driverid, vehicleid, startlocation, starttime, endlocation, day, repeating) VALUES (?, ?, ?, ?, ?, ?, ?)";
	PreparedStatement ps2 = con.prepareStatement(query2);
	ps2.setInt(1, userid);
	ps2.setInt(2, vehicleid);
	ps2.setString(3, startLocation);
	ps2.setTime(4, startTime);
	ps2.setString(5, endLocation);
	ps2.setString(6, day);
	ps2.setBoolean(7, repeating);
	int i = ps2.executeUpdate();
	
	// Get offerid of new ride offer
	String query3 = "SELECT LAST_INSERT_ID() AS offerid FROM offer";
	PreparedStatement ps3 = con.prepareStatement(query3);
	ResultSet rs3 = ps3.executeQuery();
	rs3.next();
	int offerid = rs3.getInt("offerid");
	
	con.close();
	
	response.sendRedirect("add-riders.jsp?offerid=" + offerid); // successful registration

} catch (Exception e) {
	out.println("We encountered an error.\n");
	out.println("Details:");
	out.println(e);
}

%>