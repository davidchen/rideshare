<%--
Form for selecting passengers to send a ride offer to.
 --%>

<%@ include file="/partials/page-imports.jsp" %>
<%@ include file="/partials/login-required.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<% String pageTitleName = "Offer a ride"; %>
<%@ include file="/partials/head.jsp" %>

<%
Integer userid = (Integer)session.getAttribute("userid");
int offerid = Integer.parseInt(request.getParameter("offerid"));

String offerstarttime = "";
String offerstartlocation = "";
String offerendlocation = "";
int offerstatus = 0;

// Request object for storing requests, comparable by rider's rating
class Request implements Comparable<Request> {
	public int id;
	public int riderid;
	public String riderusername;
	public int riderrating;
	public int sentofferstatus = 0;
	public String toString() { return "RequestID: " + this.id + ", Rider Username: " + this.riderusername; }
	public int compareTo(Request r) { return riderrating - r.riderrating; }
}
ArrayList<Request> confirmedRequests = new ArrayList<Request>();
ArrayList<Request> repliedRequests = new ArrayList<Request>();
ArrayList<Request> matchedRequests = new ArrayList<Request>();

String url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
Class.forName("com.mysql.jdbc.Driver");
try {
	
	Connection con = DriverManager.getConnection(url, "admin", "adminadmin");
	
	// Get ride offer information
	String query0 = "SELECT O.driverid, O.starttime, O.startlocation, O.endlocation, O.status " +
					"FROM offer O " +
					"WHERE O.offerid = ?";
	PreparedStatement ps0 = con.prepareStatement(query0);
	ps0.setInt(1, offerid);
	ResultSet rs0 = ps0.executeQuery();
	if (rs0.next()) {
		// verify that offerid belongs to user
		int driverid = rs0.getInt("driverid");
		if (driverid != userid) { response.sendRedirect("../dashboard.jsp"); }
		offerstarttime = rs0.getString("starttime");
		offerstartlocation = rs0.getString("startlocation");
		offerendlocation = rs0.getString("endlocation");
		offerstatus = rs0.getInt("status");
	} else {
		throw new Exception("We couldn't find that ride offer.");
	}
	
	
	// Get confirmed passengers
	String query3 = "SELECT U.username ,U.riderrating " +
					"FROM trip T, user U " +
					"WHERE T.offerid = ? AND T.riderid = U.userid";
	PreparedStatement ps3 = con.prepareStatement(query3);
	ps3.setInt(1, offerid);
	ResultSet rs3 = ps3.executeQuery();
	while(rs3.next()) {
		Request r = new Request();
		r.riderusername = rs3.getString("username");
		r.riderrating = rs3.getInt("riderrating");
		confirmedRequests.add(r);
	}
	
	
	// Get requests to which an offer was sent
	String query2 = "SELECT U.username, U.riderrating " +
					"FROM sentoffer S, user U " +
					"WHERE S.offerid = ? AND S.riderid = U.userid";
	PreparedStatement ps2 = con.prepareStatement(query2);
	ps2.setInt(1, offerid);
	ResultSet rs2 = ps2.executeQuery();
	while (rs2.next()) {
		Request r = new Request();
		r.riderusername = rs2.getString("username");
		r.riderrating = rs2.getInt("riderrating");
		repliedRequests.add(r);
	}
	
	if (offerstatus < 1) {
		// Get matching requests
		String query1 = "SELECT R.requestid, R.riderid, U.username, U.riderrating " +
						"FROM user U, offer O, request R " + 
						"WHERE O.offerid = ? " +
						"AND O.starttime >= R.starttimebegin AND O.starttime <= R.starttimeend AND O.day = R.day " + 
						"AND O.startlocation = R.startlocation AND O.endlocation = R.endlocation " +
						"AND R.riderid = U.userid AND R.status < 1 " +
						"AND R.requestid NOT IN (SELECT requestid FROM sentoffer WHERE offerid = ?) " +
						"AND R.requestid NOT IN (SELECT requestid FROM trip WHERE offerid = ?)";
		PreparedStatement ps1 = con.prepareStatement(query1);
		ps1.setInt(1, offerid);
		ps1.setInt(2, offerid);
		ps1.setInt(3, offerid);
		ResultSet rs1 = ps1.executeQuery();
		while (rs1.next()) {
			Request r = new Request();
			r.id = rs1.getInt("requestid");
			r.riderid = rs1.getInt("riderid");
			r.riderusername = rs1.getString("username");
			r.riderrating = rs1.getInt("riderrating");
			matchedRequests.add(r);
			System.out.println("Offer " + offerid + " matched to: " + r.toString());
		}
	}
	
	con.close();

} catch (Exception e) {
	out.print("We encountered an error.");
	out.print(e);
}

Collections.sort(matchedRequests); // sort matched ride requests by rider rating

%>


<body>
<div class="container-fluid">
<div class="row content-row">
<div class="col-6 offset-3">
<!-- <div class="text-center"> -->
	<h1>Add passengers</h1>
	<%@ include file="/partials/global-menu.jsp" %>
	<br>
	<%=offerstarttime%> | <%=offerstartlocation%> &#8594; <%=offerendlocation%>
	<br><br><br>
	
	<% /* Confirmed riders: */ 
		if (confirmedRequests.size() > 0) { %>
			<strong>Confirmed passengers</strong>
			<br>
	<% 		for (int i=0; i < confirmedRequests.size(); i++) {
				Request r = confirmedRequests.get(i); %>
				<a href="${pageContext.request.contextPath}/user?username=<%=r.riderusername%>"><%=r.riderusername%></a>
				 | (<%=(r.riderrating > 0 ? "Rating: " + r.riderrating : "Not rated")%>)<br>
	<%  	} %>	
			<br><br>
	<%  } %>
	
	
	<% /* Offers sent to: */ 
		if (repliedRequests.size() > 0) { %>
			<strong>Offer sent to</strong>
			<br>
	<% 		for (int i=0; i < repliedRequests.size(); i++) {
				Request r = repliedRequests.get(i); %>
				<%=r.riderusername%> | (<%=(r.riderrating > 0 ? "Rating: " + r.riderrating : "Not rated")%>)<br>
	<%  	} %>	
			<br><br>
	<%  } %>
	
	
	<% /* Matched requests */
		if (offerstatus > 0) { %>
			<strong>Your car is full.</strong>
	<%  } else {
			if (matchedRequests.size() > 0) { %>
				<strong>We found <%=matchedRequests.size()%> ride request<%=(matchedRequests.size() > 1 ? "s" : "")%></strong> matching your offer.
		<%  } else { %>
		   		<strong>No new requests. Check back later!</strong>
		<%  }
			for (int i=0; i < matchedRequests.size(); i++) {
				Request r = matchedRequests.get(i); %> 
				<form method="post" action="send-offer.jsp" class="ride-request">
					<input type="hidden" name="requestid" value=<%=r.id%> />
					<input type="hidden" name="riderid" value=<%=r.riderid%> />
					<input type="hidden" name="driverid" value=<%=userid%> />
					<input type="hidden" name="offerid" value=<%=offerid%> />
					<a href="${pageContext.request.contextPath}/user?username=<%=r.riderusername%>"><%=r.riderusername%></a> 
					(<%=(r.riderrating > 0 ? "Rating: " + r.riderrating : "Not rated")%>) |  
					<input type="submit" id="offer-submit" class="btn btn-primary btn-sm" value="Offer ride">
				</form>
		<% } 
	   } %>
<!-- </div> -->

<br><br><br>
<!-- <div class="text-center"> -->
<a href="../dashboard.jsp">Back to Dashboard</a>
<!-- </div> -->
</div>
</div>


</div>
	
</body>
</html>