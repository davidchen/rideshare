<%--
Accept a ride offer to a given ride request
Creates an entry in trip table, which will trigger status update for the request and offer.
 --%>

<%@ include file="/partials/page-imports.jsp" %>
<%@ include file="/partials/login-required.jsp" %>


<%
Integer userid  = (Integer)session.getAttribute("userid");
int offerid = Integer.parseInt(request.getParameter("offerid"));
int requestid  = Integer.parseInt(request.getParameter("requestid"));
int driverid = Integer.parseInt(request.getParameter("driverid"));
int riderid = Integer.parseInt(request.getParameter("riderid"));
int vehicleid = Integer.parseInt(request.getParameter("vehicleid"));
String startlocation = request.getParameter("startlocation");
String starttime = request.getParameter("starttime");
String endlocation = request.getParameter("endlocation");
String day = request.getParameter("day");

String url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
Class.forName("com.mysql.jdbc.Driver");

try {
	
	Connection con = DriverManager.getConnection(url, "admin", "adminadmin");
	
	String query1 = "INSERT INTO trip(offerid, requestid, driverid, riderid, vehicleid, startlocation, starttime, endlocation, day) " +
					"VALUES (?,?,?,?,?,?,?,?,?)";
	PreparedStatement ps1 = con.prepareStatement(query1);
	ps1.setInt(1, offerid);
	ps1.setInt(2, requestid);
	ps1.setInt(3, driverid);
	ps1.setInt(4, riderid);
	ps1.setInt(5, vehicleid);
	ps1.setString(6, startlocation);
	ps1.setString(7, starttime);
	ps1.setString(8, endlocation);
	ps1.setString(9, day);
	ps1.executeUpdate();
	
	con.close();
	
	response.sendRedirect("../dashboard.jsp");

} catch (Exception e) {
	out.println("We encountered an error.\n");
	out.println("Details:");
	out.println(e);
}

%>