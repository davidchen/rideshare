<%--
Form for creating an offer to drive.
 --%>

<%@ include file="/partials/page-imports.jsp" %>
<%@ include file="/partials/login-required.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<% String pageTitleName = "Offer a ride"; %>
<%@ include file="/partials/head.jsp" %>

<%
Integer userid  = (Integer)session.getAttribute("userid");
String username = (String)session.getAttribute("username");

Calendar cal = Calendar.getInstance();
int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
String[] days = {"", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
String today = days[dayOfWeek];

String url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
Class.forName("com.mysql.jdbc.Driver");

class Vehicle {
	public int vehicleid;
	public String make;
	public String model;
	public int seats;
}
ArrayList<Vehicle> myVehicles = new ArrayList<Vehicle>();

try {
	/* Get user's vehicles */
	Connection con = DriverManager.getConnection(url, "admin", "adminadmin");
	
	String query1 = "SELECT * FROM vehicle WHERE driverid = ?";
	PreparedStatement ps1 = con.prepareStatement(query1);
	ps1.setInt(1, userid);
	ResultSet rs1 = ps1.executeQuery();
	
	while (rs1.next()) {
		Vehicle v = new Vehicle();
		v.vehicleid = rs1.getInt("vehicleid");
		v.make = rs1.getString("make");
		v.model = rs1.getString("model");
		v.seats = rs1.getInt("seats");
		myVehicles.add(v);
	}
	
	// if user doesn't have a vehicle, redirect to add-vehicle
	if (myVehicles.size() == 0) {
		response.sendRedirect("add-vehicle.jsp");
	}
	
	
	
} catch (Exception e) {
	out.println("We encountered an error.\n");
	out.println("Details:");
	out.println(e);
}
%>

<body>
	<div class="container-fluid">
		<div class="row content-row">
			<div class="col-8 offset-2">
				<div class="text-center">
					<h1>Offer a ride</h1>
					<%@ include file="/partials/global-menu.jsp" %>
					<br><br>
				</div>
				
				
				<form method="post" action="post-offer.jsp" id="offer-form">
					<div class="form-inline">
						I'm driving from &nbsp;
						<input type="text" class="form-control" name="start-location" id="start-location" placeholder="Hill Center" required/>
						&nbsp; to &nbsp;
						<input type="text" class="form-control" name="end-location" id="end-location" placeholder="Livi Quads" required/>
					</div>
					<br>
				    <div class="form-inline">
				    	at &nbsp;
				    	<input type="time" class="form-control" name="start-time" id="start-time" placeholder="HH:mm" required/>
						&nbsp;&nbsp;&nbsp;
						<input type="checkbox" name="repeating" id="repeating" value="true"/>
						&nbsp;
						<label for="repeating">every <%=today%></label>
					    <input type="hidden" name="day" id="day" value=<%=today%> />
					</div>
					
					<br><br>
				    
					<div class="form-inline">
			    <%  for (Vehicle v : myVehicles) { %>
			    	<div class="form-group">
			    		<input type="radio" name="vehicleid" value="<%=v.vehicleid%>" checked="checked" required/>
			    		&nbsp;
			    		<label for="vehicleid"><%=v.make + " " + v.model%> (<%=v.seats%> seats)</label>
			    		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			    	</div>
			    <%  }  %>
			    	<a href="add-vehicle.jsp">Add a new vehicle</a>
			    	</div>
			    	
			    	<br><br>
				    
				    <div class="text-center">
				        <input type="submit" id="offer-submit" class="btn btn-primary" value="Find passengers">
				    </div>
				    
				</form>

			</div>
		</div>


	</div>
	
</body>
</html>