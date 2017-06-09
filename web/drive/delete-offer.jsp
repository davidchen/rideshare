<%--
Deletes given ride offer for logged in user
 --%>

<%@ include file="/partials/page-imports.jsp" %>

<%
Integer userid  = (Integer)session.getAttribute("userid");
int offerid = Integer.parseInt(request.getParameter("offerid"));

String url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
Class.forName("com.mysql.jdbc.Driver");

try {
	
	Connection con = DriverManager.getConnection(url, "admin", "adminadmin");
	
	String query1 = "DELETE FROM offer WHERE driverid = ? AND offerid = ?";
	PreparedStatement ps1 = con.prepareStatement(query1);
	ps1.setInt(1, userid);
	ps1.setInt(2, offerid);
	ps1.executeUpdate();
	
	con.close();
	
	response.sendRedirect("../dashboard.jsp");

} catch (Exception e) {
	out.println("We encountered an error.\n");
	out.println("Details:");
	out.println(e);
}

%>