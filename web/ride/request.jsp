<%--
Form for creating a ride request.
 --%>

<%@ include file="/partials/page-imports.jsp" %>
<%@ include file="/partials/login-required.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<% String pageTitleName = "Request a ride"; %>
<%@ include file="/partials/head.jsp" %>

<%
	String username = (String)session.getAttribute("username"); 
	if (username == null) {
		response.sendRedirect("index.jsp");
	}
	
	Calendar cal = Calendar.getInstance();
	int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK);
	String[] days = {"", "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};
	String today = days[dayOfWeek];
%>

<body>
	<div class="container-fluid">
		<div class="row content-row">
			<div class="col-8 offset-2">
				<div class="text-center">
					<h1>Request a ride</h1>
					<%@ include file="/partials/global-menu.jsp" %>
					<br><br>
				</div>
				
				
				<form method="post" action="post-request.jsp" id="request-form">
				
				    <div class="form-inline">
				    	I want to leave from &nbsp;
				    	<input type="text" class="form-control" name="start-location" id="start-location" placeholder="Kilmer Library" required>
				    </div>
				    <br>
				    <div class="form-inline">
					    sometime between &nbsp;
					    <input type="time" class="form-control" name="start-time-begin" id="start-time-begin" placeholder="HH:mm" required>
					    &nbsp; and &nbsp;
					    <input type="time" class="form-control" name="start-time-end" id="start-time-end" placeholder="HH:mm" required>
					    &nbsp;&nbsp;&nbsp;
					    <input type="checkbox" name="repeating" id="repeating" value="true">
					    <label for="repeating">&nbsp; every <%=today%></label> 
				    </div>
				    <br>
				    <div class="form-inline">
				    	to get to &nbsp;
				    	<input type="text" class="form-control" name="end-location" id="end-location" placeholder="My Happy Place" required>
				    </div>
				    
				    <br><br>
				    
				    <input type="hidden" name="day" id="day" value=<%=today%> />
				    
				    <div class="text-center">
				        <input type="submit" id="offer-submit" class="btn btn-primary" value="Request ride">
				    </div>
				    
				</form>

			</div>
		</div>


	</div>
	
</body>
</html>