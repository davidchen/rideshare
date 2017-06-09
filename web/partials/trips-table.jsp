<%--
Creates a list of upcoming trips (driving and riding).
Each trip includes information and links depending on the status of the trip.
 --%>

<%@ include file="/partials/page-imports.jsp" %>

<%

Integer userid = (Integer)session.getAttribute("userid");

// Get day of the week
Calendar cal = Calendar.getInstance();
int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
String[] days = {"", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
String today = days[dayOfWeek];

// Trip object for sorting driving and riding trips in one time-based list.
class Trip implements Comparable<Trip> {
	public int id;
	public String type;              // "Drive" or "Ride"
	public java.util.Date starttime; // Time of trip to sort by
	public String startlocation;
	public String endlocation;
	
	// for drives only
	public int passengercount;

	// for rides only
	public java.util.Date starttimeend;
	public int offercount = 0;
	public boolean confirmed = false;
	public int driverid;
	public String driverusername;
	public String vehicle;
	
	public int compareTo(Trip t) {
		return starttime.compareTo(t.starttime);
	}
}
ArrayList<Trip> myTrips = new ArrayList<Trip>();



/* Get all upcoming trips, sorted by time */
String url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
Class.forName("com.mysql.jdbc.Driver");

try {
	Connection con = DriverManager.getConnection(url, "admin", "adminadmin");
	
	// Get passenger count for each drive
	HashMap<Integer,Integer> passengerCount = new HashMap<Integer,Integer>();
	String query0 = "SELECT T.offerid, COUNT(*) AS passengers FROM trip T WHERE T.finished = 0 AND T.driverid = ? GROUP BY T.offerid";
	PreparedStatement ps0 = con.prepareStatement(query0);
	ps0.setInt(1, userid);
	ResultSet rs0 = ps0.executeQuery();
	while (rs0.next()) {
		passengerCount.put(rs0.getInt("offerid"), rs0.getInt("passengers"));
	}
	
	// Get offers
	String query1 = "SELECT O.offerid, O.starttime, O.startlocation, O.endlocation " +
	                "FROM offer O " +
			        "WHERE O.driverid = ? AND O.day = ? AND O.status < 2";
	PreparedStatement ps1 = con.prepareStatement(query1);
	ps1.setInt(1, userid);
	ps1.setString(2, today);
	ResultSet rs1 = ps1.executeQuery();
	while(rs1.next()) {
		Trip t = new Trip();
		int offerid = rs1.getInt("offerid");
		t.id = offerid;
		t.type = "Drive";
		t.starttime = rs1.getTime("starttime");
		t.startlocation = rs1.getString("startlocation");
		t.endlocation = rs1.getString("endlocation");
		if (passengerCount.containsKey(offerid)) {
			t.passengercount = passengerCount.get(offerid);
		}
		myTrips.add(t);
	}
	
	
	
	// Get offer count for each request
	HashMap<Integer,Integer> offerCount = new HashMap<Integer,Integer>();
	String query2 = "SELECT S.requestid, COUNT(*) AS offers FROM sentoffer S JOIN request R USING (requestid) WHERE S.riderid = ? GROUP BY S.requestid";
	PreparedStatement ps2 = con.prepareStatement(query2);
	ps2.setInt(1, userid);
	ResultSet rs2 = ps2.executeQuery();
	while (rs2.next()) {
		int rid = rs2.getInt("requestid");
		int off = rs2.getInt("offers");
		offerCount.put(rid, off);
		System.out.println(rid + " " + off);
	}
	
	// Get rides
 	String query4 = "SELECT R.requestid, T.starttime, R.starttimebegin, R.starttimeend, R.startlocation, R.endlocation, T.driverid, D.username, V.vehicleid, V.model, V.make FROM request R LEFT JOIN trip T ON R.requestid=T.requestid LEFT JOIN vehicle V ON T.vehicleid=V.vehicleid LEFT JOIN user D ON V.driverid=D.userid WHERE R.riderid = ? AND R.day = ? AND R.status < 2";
	PreparedStatement ps4 = con.prepareStatement(query4);
	ps4.setInt(1, userid);
	ps4.setString(2, today);
	ResultSet rs4 = ps4.executeQuery();
	while(rs4.next()) {
		Trip t = new Trip();
		int requestid = rs4.getInt("requestid");
		t.id = requestid;
		t.type = "Ride";
		java.util.Date st = rs4.getTime("starttime");
		
		// confirmed ride
		if (st != null) {
			t.starttime = st;
			t.confirmed = true;
			t.driverid = rs4.getInt("driverid");
			t.driverusername = rs4.getString("username");
			t.vehicle = rs4.getString("make") + " " + rs4.getString("model");
		}
		// open request
		else {
			t.starttime = rs4.getTime("starttimebegin");
			t.starttimeend = rs4.getTime("starttimeend");
			if (offerCount.containsKey(requestid)) {
				t.offercount = offerCount.get(requestid);
			}
		}
		t.startlocation = rs4.getString("startlocation");
		t.endlocation = rs4.getString("endlocation");
		myTrips.add(t);
	}
	
	con.close();
	
} catch(Exception e) { // db error
	out.println("We encountered an error.\n");
	out.println("Details:");
	out.println(e);
}

Collections.sort(myTrips);

%>

<br>
<div><% if (myTrips.size() > 0) { %> <h4>Your upcoming trips today</h4><br> <%} else {%> <strong>You don't have any upcoming trips today.</strong> <% } %></div>
<table class="table table-striped table-sm">
				
<thead class="thead-inverse">
    <tr>
        <th colspan="5"></th>
    </tr>
</thead>
<tbody>

<%  for (int i=0; i < myTrips.size(); i++) {
		Trip t = myTrips.get(i);
		if (t.type == "Drive") { %>
			<tr>
				<td>DRIVING</td>
				<td><%=t.starttime.toString().substring(0,5)%></td>
				<td><%=t.startlocation%> &#8594; <%=t.endlocation%></td>
				<td><a href="drive/add-riders.jsp?offerid=<%=t.id%>"><% if (t.passengercount > 0) { %> <%=t.passengercount%> passenger<%=(t.passengercount > 1 ? "s" : "")%><%} else {%>Find passengers<%}%></a></td>
				<td><a href="drive/delete-offer.jsp?offerid=<%=t.id%>">Cancel <%=(t.passengercount > 0 ? "ride" : "offer")%></a></td>
			</tr>
		<% } else { %>
			<tr>
				<td>RIDING</td>
				<td><%=t.starttime.toString().substring(0,5)%><%=(t.starttimeend != null ? "-"+t.starttimeend.toString().substring(0,5) : "")%></td>
				<td><%=t.startlocation%> &#8594; <%=t.endlocation%></td>
				<% if (t.confirmed) { %>
					<td>Driver: <a href="${pageContext.request.contextPath}/user?username=<%=t.driverusername%>"><%=t.driverusername%></a> in a <%=t.vehicle%></td>
				<%} else if (t.offercount > 0) {%>
					<td><a href="ride/view-offers.jsp?requestid=<%=t.id%>"><%=t.offercount%> offer<%=(t.offercount > 1 ? "s" : "")%></a></td>
				<%} else {%>
					<td></td>
				<%} %>
				<td><a href="ride/delete-request.jsp?requestid=<%=t.id%>">Cancel <%=(t.confirmed ? "ride" : "request")%></a></td>
			</tr>
		<% } %>

<% } %>

</tbody>
</table>
<br><br>
