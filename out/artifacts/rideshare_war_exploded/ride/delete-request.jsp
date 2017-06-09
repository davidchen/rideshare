<%--
Deletes given ride request for logged in user
 --%>

<%@ include file="/partials/page-imports.jsp" %>

<%
Integer userid  = (Integer)session.getAttribute("userid");
int requestid = Integer.parseInt(request.getParameter("requestid"));

String url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
Class.forName("com.mysql.jdbc.Driver");

try {
	
	Connection con = DriverManager.getConnection(url, "admin", "adminadmin");
	
	String query1 = "DELETE FROM request WHERE riderid = ? AND requestid = ?";
	PreparedStatement ps1 = con.prepareStatement(query1);
	ps1.setInt(1, userid);
	ps1.setInt(2, requestid);
	ps1.executeUpdate();
	
	con.close();
	
	response.sendRedirect("../dashboard.jsp");

} catch (Exception e) {
	out.println("We encountered an error.\n");
	out.println("Details:");
	out.println(e);
}

%>