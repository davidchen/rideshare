<%--
Lists offers for given ride request.
 --%>

<%@ include file="/partials/page-imports.jsp" %>
<%@ include file="/partials/login-required.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<% String pageTitleName = "View ride offers"; %>
<%@ include file="/partials/head.jsp" %>

<%
Integer userid = (Integer)session.getAttribute("userid");
int requestid = Integer.parseInt(request.getParameter("requestid"));

String url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
Class.forName("com.mysql.jdbc.Driver");

String requeststarttimebegin = "";
String requeststarttimeend = "";
String requeststartlocation = "";
String requestendlocation = "";
String requestday = "";

class Offer implements Comparable<Offer> {
	public int id;
	public int driverid;
	public String driverusername;
	public int driverrating;
	public String starttime;
	public int vehicleid;
	public String vehicle;
	public String toString() {
		return "OfferID: " + this.id + ", Offer Username: " + this.driverusername;
	}
	public int compareTo(Offer o) {
		return this.driverrating - o.driverrating;
	}
}

ArrayList<Offer> receivedOffers = new ArrayList<Offer>();

try {
	
	Connection con = DriverManager.getConnection(url, "admin", "adminadmin");
	
	// Get ride request information
	String query0 = "SELECT R.riderid, R.starttimebegin, R.starttimeend, R.startlocation, R.endlocation, R.day " +
					"FROM request R " +
					"WHERE R.requestid = ?";
	PreparedStatement ps0 = con.prepareStatement(query0);
	ps0.setInt(1, requestid);
	ResultSet rs0 = ps0.executeQuery();
	
	if (rs0.next()) {
		int riderid = rs0.getInt("riderid");
		if (riderid != userid) { response.sendRedirect("../dashboard.jsp"); }
		requeststarttimebegin = rs0.getString("starttimebegin");
		requeststarttimeend = rs0.getString("starttimeend");
		requeststartlocation = rs0.getString("startlocation");
		requestendlocation = rs0.getString("endlocation");
		requestday = rs0.getString("day");
	} else {
		out.print("We couldn't find that ride request.");
	}
	
	
	// Get received offers
	String query1 = "SELECT O.offerid, O.driverid, U.username, U.driverrating, O.starttime, V.vehicleid, V.make, V.model " +
					"FROM user U, vehicle V, offer O, sentoffer S " +
					"WHERE S.requestid = ? AND S.offerid = O.offerid " +
					"AND O.driverid = U.userid AND O.vehicleid = V.vehicleid";
	
	PreparedStatement ps1 = con.prepareStatement(query1);
	ps1.setInt(1, requestid);
	ResultSet rs1 = ps1.executeQuery();
	
	while (rs1.next()) {
		Offer o = new Offer();
		o.id = rs1.getInt("offerid");
		o.driverid = rs1.getInt("driverid");
		o.driverusername = rs1.getString("username");
		o.driverrating = rs1.getInt("driverrating");
		o.starttime = rs1.getString("starttime");
		o.vehicleid = rs1.getInt("vehicleid");
		o.vehicle = rs1.getString("make") + " " + rs1.getString("model");
		receivedOffers.add(o);
	}
	
	
	
	con.close();

} catch (Exception e) {
	out.print("We encountered an error.");
	out.print(e);
}

// Collections.sort(matchedRequests);

%>


<body>
<div class="container-fluid">
<div class="row content-row">
<div class="col-8 offset-2">
<!-- <div class="text-center"> -->
	<h1>Ride offers</h1>
	<%@ include file="/partials/global-menu.jsp" %>
	<br>
	<%=requeststarttimebegin%>-<%=requeststarttimeend%> | <%=requeststartlocation%> &#8594; <%=requestendlocation%>
	<br><br><br>
	<% if (receivedOffers.size() > 0) { %>
			<strong>You received <%=receivedOffers.size()%> offer<%=(receivedOffers.size() > 1 ? "s" : "")%> for your ride request.</strong>
	<% } else { %>
	   		You haven't received any offers for this trip. Check back later!
	<% } %>

<!-- </div> -->

<%  for (int i=0; i < receivedOffers.size(); i++) {
		Offer o = receivedOffers.get(i); %> 
		<form method="post" action="accept-offer.jsp">
			<a href="${pageContext.request.contextPath}/user?username=<%=o.driverusername%>"><%=o.driverusername%></a>
			(<%=(o.driverrating > 0 ? "Rating: " + o.driverrating : "Not rated")%>) | Pick-up at <%=o.starttime%> in a <%=o.vehicle%> | 
			<input type="hidden" name="requestid" value=<%=requestid%> />
			<input type="hidden" name="riderid" value=<%=userid%> />
			<input type="hidden" name="offerid" value=<%=o.id%> />
			<input type="hidden" name="driverid" value=<%=o.driverid%> />
			<input type="hidden" name="vehicleid" value=<%=o.vehicleid%> />
			<input type="hidden" name="starttime" value=<%=o.starttime%> />
			<input type="hidden" name="starttimebegin" value=<%=requeststarttimebegin%> />
			<input type="hidden" name="starttimeend" value=<%=requeststarttimeend%> />
			<input type="hidden" name="startlocation" value=<%=requeststartlocation%> />
			<input type="hidden" name="endlocation" value=<%=requestendlocation%> />
			<input type="hidden" name="day" value=<%=requestday%> />
			<input type="submit" id="offer-submit" class="btn btn-primary btn-sm" value="Accept offer">
		</form>
<% } %>

<!-- <div class="text-center"> -->
<br><br>
<a href="${pageContext.request.contextPath}/dashboard">Back to Dashboard</a>
<!-- </div> -->
</div>
</div>


</div>
	
</body>
</html>