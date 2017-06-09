<%--
Form for adding a vehicle to account
 --%>

<%@ include file="/partials/page-imports.jsp" %>
<%@ include file="/partials/login-required.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<% String pageTitleName = "Add a vehicle"; %>
<%@ include file="/partials/head.jsp" %>

<%
Integer userid  = (Integer)session.getAttribute("userid");
String username = (String)session.getAttribute("username"); 
%>

<body>
    <!-- Additional registration information: Add a vehicle -->
    <div class="container-fluid">
	    <div class="row content-row">
	        <div class="col-6 offset-3">
	            <div class="text-center">
					<h1>Add a vehicle</h1>
					<%@ include file="/partials/global-menu.jsp" %>
					<br>
					<h4>What are you driving?</h4>
					<br><br>
				</div>
				
				<form method="post" action="add-vehicle-action.jsp" id="vehicle-form">
					<div class="form-group">
						<label for="vehicle-make">Make</label>
						<input type="text" class="form-control" name="vehicle-make" id="vehicle-make" placeholder="Toyota" required>
					</div>

					<div class="form-group">
						<label for="vehicle-model">Model</label>
						<input type="text" class="form-control" name="vehicle-model" id="vehicle-model" placeholder="Prius" required>
					</div>

					<div class="form-group">
						<label for="vehicle-seats">Passenger seats</label>
						<input type="number" class="form-control" name="vehicle-seats" id="vehicle-seats" min="0" max="9" step="1" value="4" required>
						<!-- <input type="text" class="form-control" name="vehicle-seats" id="vehicle-seats" maxlength="1" pattern="[0-9]" required> -->
					</div>
					
					<br>
					<div class="text-center">
					
						<!-- <a href="dashboard.jsp" class="btn btn-info" role="button">Skip</a> -->
						<input type="submit" id="register-submit" class="btn btn-primary" value="Add vehicle">
					</div>
				</form>

			</div>
		</div>


	</div>
	
</body>
</html>