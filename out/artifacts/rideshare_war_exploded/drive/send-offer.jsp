<%--
Sends an offer to a given rider's ride request
 --%>

<%@ include file="/partials/page-imports.jsp" %>
<%@ include file="/partials/login-required.jsp" %>


<%
Integer userid  = (Integer)session.getAttribute("userid");
int requestid  = Integer.parseInt(request.getParameter("requestid"));
int riderid = Integer.parseInt(request.getParameter("riderid"));
int offerid = Integer.parseInt(request.getParameter("offerid"));
int driverid = Integer.parseInt(request.getParameter("driverid"));

String url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
Class.forName("com.mysql.jdbc.Driver");

try {
	
	Connection con = DriverManager.getConnection(url, "admin", "adminadmin");
	
	String query1 = "INSERT INTO sentoffer(offerid, requestid, driverid, riderid) VALUES (?,?,?,?)";
	PreparedStatement ps1 = con.prepareStatement(query1);
	ps1.setInt(1, offerid);
	ps1.setInt(2, requestid);
	ps1.setInt(3, driverid);
	ps1.setInt(4, riderid);
	ps1.executeUpdate();
	
	con.close();
	
	response.sendRedirect("add-riders.jsp?offerid=" + offerid);

} catch (Exception e) {
	out.println("We encountered an error.\n");
	out.println("Details:");
	out.println(e);
}

%>