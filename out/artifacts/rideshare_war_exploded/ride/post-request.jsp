<%--
Posts ride request and displays an ad.
 --%>

<%@ include file="/partials/page-imports.jsp" %>

<%
    Integer userid = (Integer) session.getAttribute("userid");
    String username = (String) session.getAttribute("username");

/* Get parameters for request post */

    String startLocation = request.getParameter("start-location");

//get SQL-readable starttimebegin
    String startTimeBeginString = request.getParameter("start-time-begin");
    java.util.Date startTimeBeginDate = new SimpleDateFormat("HH:mm").parse(startTimeBeginString);
    java.sql.Time startTimeBegin = new Time(startTimeBeginDate.getTime());

//get SQL-readable starttimeend
    String startTimeEndString = request.getParameter("start-time-end");
    java.util.Date startTimeEndDate = new SimpleDateFormat("HH:mm").parse(startTimeEndString);
    java.sql.Time startTimeEnd = new Time(startTimeEndDate.getTime());

    String endLocation = request.getParameter("end-location");
    String day = request.getParameter("day");
    Boolean repeating;


    if (request.getParameter("repeating") == null) {
        repeating = false;
    } else {
        repeating = true;
    }

    int adid = -1;
    String adcompany = "";
    String adlink = "";
    String adimageurl = "";

    String url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
    Class.forName("com.mysql.jdbc.Driver");

    int result = -1;
    int requestid = -1; // if request was succesfully inserted

    try {

        Connection con = DriverManager.getConnection(url, "admin", "adminadmin");

        // Get ad 1
        String query0 = "SELECT adid, company, adlink, imageurl FROM ad ORDER BY RAND() LIMIT 0,1";
        PreparedStatement ps0 = con.prepareStatement(query0);
        ResultSet rs0 = ps0.executeQuery();
        while (rs0.next()) {
            adid = rs0.getInt("adid");
            adcompany = rs0.getString("company");
            adlink = rs0.getString("adlink");
            adimageurl = rs0.getString("imageurl");
        }

        // Add new ride offer to database
        String query2 = "INSERT INTO request(riderid, startlocation, starttimebegin, starttimeend, endlocation, day, repeating, adid) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps2 = con.prepareStatement(query2);
        ps2.setInt(1, userid);
        ps2.setString(2, startLocation);
        ps2.setTime(3, startTimeBegin);
        ps2.setTime(4, startTimeEnd);
        ps2.setString(5, endLocation);
        ps2.setString(6, day);
        ps2.setBoolean(7, repeating);
        ps2.setInt(8, adid);
        result = ps2.executeUpdate();

        // Get requestid of new ride request
        String query3 = "SELECT LAST_INSERT_ID() AS requestid FROM request";
        PreparedStatement ps3 = con.prepareStatement(query3);
        ResultSet rs3 = ps3.executeQuery();
        rs3.next();
        requestid = rs3.getInt("requestid");

        con.close();
	
	/* response.sendRedirect("../dashboard.jsp"); // successfully posted request */

    } catch (Exception e) {
        out.println("We encountered an error.\n");
        out.println("Details:");
        out.println(e);
    }

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<% String pageTitleName = "Brought to you by " + adcompany; %>
<%@ include file="/partials/head.jsp" %>


<body>
<div class="container-fluid">
    <div class="row content-row">
        <div class="col-6 offset-3">
            <% if (requestid > 0) { %>
            <div class="text-center">
                <h1>Now we wait...</h1>
                <br>
                <strong>You successfully posted a ride request!</strong><br>
                <%=startTimeBegin%>-<%=startTimeEnd%> | <%=startLocation%> &#8594; <%=endLocation%><br>
                We'll let you know when someone offers you a ride.
                <br><br><br>
                Now here's a little ad from <strong><%=adcompany%>
            </strong> to keep the lights on...
                <br>
                <a href="<%=adlink%>"><img src="<%=adimageurl%>" style="max-width:100%"/></a>
                <br><br><br>
                <a href="${pageContext.request.contextPath}/dashboard.jsp">Back to Dashboard</a>
            </div>
            <% } else { %>
            There was a problem with posting your request.
            <% } %>
        </div>
    </div>
</div>
</body>
</html>


