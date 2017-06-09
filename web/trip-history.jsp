<%@ include file="/partials/page-imports.jsp" %>
<%@ include file="/partials/login-required.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<% String pageTitleName = "Trip History"; %>
<%@ include file="/partials/head.jsp" %>

<%

    Integer userid = (Integer) session.getAttribute("userid");
    String username = (String) session.getAttribute("username");

//Trip object for sorting driving and riding trips in one time-based list.
    class Trip {
        public int id;
        public String drivername;
        public String ridername;
        public int driverid;
        public int riderid;
        public int reviewed;
        public int reviewedbydriver;
        public String vehicle;
        public String type;              // "Drive" or "Ride"
        public java.util.Date date;      // Date
        public String startlocation;
        public String endlocation;
    }
    ArrayList<Trip> myTrips = new ArrayList<Trip>();
    ArrayList<ArrayList<String>> drbymonths = new ArrayList<ArrayList<String>>();
    String springdrives = "";
    String falldrives = "";
    String springrides = "";
    String fallrides = "";

    int ridesGiven = 0;
    int ridesTaken = 0;

/* Get all upcoming trips, sorted by time */
    String url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
    Class.forName("com.mysql.jdbc.Driver");

    try {
        Connection con = DriverManager.getConnection(url, "admin", "adminadmin");

        // Get offers
        String query1 = "SELECT UD.username AS drivername, UD.userid as driverid, UR.username AS ridername, UR.userid as riderid, T.date, T.startlocation, T.endlocation, T.tripid, T.reviewed, T.reviewedbydriver " +
                "FROM triphistory T, user UD, user UR " +
                "WHERE T.finished = 1 AND " +
                "(? = T.driverid OR ? = T.riderid) AND T.driverid = UD.userid AND T.riderid = UR.userid " +
                "ORDER BY T.date DESC";
        PreparedStatement ps1 = con.prepareStatement(query1);
        ps1.setInt(1, userid);
        ps1.setInt(2, userid);
        ResultSet rs1 = ps1.executeQuery();
        while (rs1.next()) {
            Trip t = new Trip();
            t.drivername = rs1.getString("drivername");
            t.ridername = rs1.getString("ridername");
            t.driverid = rs1.getInt("driverid");
            t.riderid = rs1.getInt("riderid");
            t.id = rs1.getInt("tripid");
            t.reviewed = rs1.getInt("reviewed");
            t.reviewedbydriver = rs1.getInt("reviewedbydriver");
            t.type = (username.equals(t.drivername) ? "Drive" : "Ride");
            t.date = rs1.getDate("date");
            t.startlocation = rs1.getString("startlocation");
            t.endlocation = rs1.getString("endlocation");
            if (t.type.equals("Drive")) {
                ridesGiven++;
            } else {
                ridesTaken++;
            }
            myTrips.add(t);
        }


        String queryRidesByMonth = "SELECT Drives.Month AS Month, IFNULL(Drives.Drives, 0) AS Drives, IFNULL(Rides.Rides, 0) AS Rides FROM (SELECT MONTHNAME(T.date) AS Month, COUNT(*) AS Drives FROM triphistory T WHERE T.driverid = ? GROUP BY MONTHNAME(T.date) ORDER BY T.date) AS Drives JOIN (SELECT MONTHNAME(T.date) AS Month, COUNT(*) AS Rides FROM triphistory T WHERE T.riderid = ? GROUP BY MONTHNAME(T.date) ORDER BY T.date) AS Rides ON (Drives.Month = Rides.Month)";
        PreparedStatement ps2 = con.prepareStatement(queryRidesByMonth);
        ps2.setInt(1, userid);
        ps2.setInt(2, userid);
        ResultSet rs2 = ps2.executeQuery();

        while (rs2.next()) {
            ArrayList<String> drbymonth = new ArrayList<String>();
            drbymonth.add(rs2.getString("Month"));
            drbymonth.add(rs2.getString("Drives"));
            drbymonth.add(rs2.getString("Rides"));
            drbymonths.add(drbymonth);
        }

        String queryRidesBySemester = "SELECT IFNULL(Y.semester1,0) AS drives1, IFNULL(Y.semester2,0) AS drives2, IFNULL(X.semester1,0) AS Rides1, IFNULL(X.semester2,0) AS Rides2 FROM (SELECT Y.Y AS Y, Y.Semester1 AS semester1, X.Semester2 AS semester2 FROM (SELECT T.driverid AS Y, COUNT(*) AS 'Semester1' FROM triphistory T WHERE 2 >= QUARTER(T.date) AND T.driverid = ?) AS Y LEFT JOIN (SELECT T.driverid AS X, COUNT(*) AS 'Semester2' FROM triphistory T WHERE 3 <= QUARTER(T.date) AND T.driverid = 1) AS X ON (Y.Y = X.X)) AS Y LEFT JOIN (SELECT Y.Y AS X, Y.Semester1 AS semester1, X.Semester2 AS semester2 FROM (SELECT T.riderid AS Y, COUNT(*) AS 'Semester1' FROM triphistory T WHERE 2 >= QUARTER(T.date) AND T.riderid = 1) AS Y LEFT JOIN (SELECT T.riderid AS X, COUNT(*) AS 'Semester2' FROM triphistory T WHERE 3 <= QUARTER(T.date) AND T.riderid = ?) AS X ON (Y.Y = X.X)) AS X ON (Y.Y = X.X)";
        PreparedStatement ps3 = con.prepareStatement(queryRidesBySemester);
        ps3.setInt(1, userid);
        ps3.setInt(2, userid);
        ResultSet rs3 = ps3.executeQuery();

        if (rs3.next()) {
            springdrives = rs3.getString("drives1");
            falldrives = rs3.getString("drives2");
            springrides = rs3.getString("rides1");
            fallrides = rs3.getString("rides2");
        }

        con.close();

    } catch (Exception e) { // db error
        out.println("We encountered an error.\n");
        out.println("Details:");
        out.println(e);
    }

%>

<body>

<div class="container-fluid">
    <div class="row content-row">
        <div class="col-8 offset-2">
            <!-- <div class="text-center"> -->
            <div class="text-center">
                <h1>Your past trips</h1>
                <%@ include file="/partials/global-menu.jsp" %>


                <br>
                You've given <%=ridesGiven%> rides and taken <%=ridesTaken%> rides.
                <br><br>
            </div>

            <%if (myTrips.size() > 0) { %>
            <div style="max-height: 300px; overflow: auto;">
                <table class="table table-striped table-sm">

                    <thead class="thead-inverse">
                    <tr>

                        <th colspan="5" class="text-center">Trip History</th>
                    </tr>
                    </thead>
                    <tbody>

                    <%  int reviewButtonID = 1;
                        for (Trip t : myTrips) { %>
                    <tr>
                        <td><%=t.date%>
                        </td>
                        <td><%=t.type%>
                        </td>
                        <td><%=t.startlocation%> &rarr; <%=t.endlocation%>
                        </td>
                        <td>
                            <% String recipientUsername = ""; int reviewType, recipientID; %>
                            <%if (t.type.equals("Drive")) { recipientUsername = t.ridername; reviewType = 1; recipientID = t.riderid; %>
                            Drove <a
                                href="${pageContext.request.contextPath}/user?username=<%=t.ridername%>"><%=t.ridername%>
                        </a>
                            <%} else { recipientUsername = t.drivername; reviewType = 0; recipientID = t.driverid; %>
                            Driven by <a
                                href="${pageContext.request.contextPath}/user?username=<%=t.drivername%>"><%=t.drivername%>
                        </a>
                            <%} %>
                        </td>
                        <td>
                            <% if ((t.reviewed == 0 && t.type.equals("Ride")) || (t.reviewedbydriver == 0 && t.type.equals("Drive"))) { %>
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#giveUserReviewModal<%=reviewButtonID%>">Review</button>
                            <!-- Create review modal for this button -->
                            <div class="modal fade" id="giveUserReviewModal<%=reviewButtonID%>" tabindex="-1" role="dialog"
                                 aria-labelledby="giveUserReviewModal<%=reviewButtonID%>Label" aria-hidden="true">
                                <div class="modal-dialog modal-lg" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="giveUserReviewModal<%=reviewButtonID%>Label">
                                                Review this trip and <%=recipientUsername%>
                                            </h5>
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body">
                                            <%@ include file="/partials/review-user-form.jsp" %>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <% reviewButtonID += 1; } else { %>
                            <p>Reviewed</p> <% } %>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>

                </table>
            </div>

            <%} %>



            <table class="table table-striped table-sm">
                <thead class="thead-inverse">
                <tr>
                    <th>Month</th>
                    <th>Drives Given</th>
                    <th>Rides Taken</th>
                </tr>
                </thead>
                <tbody>

                <% for (ArrayList<String> d : drbymonths) { %>

                <tr>
                    <td><%= d.get(0) %></td>
                    <td><%= d.get(1) %></td>
                    <td><%= d.get(2) %></td>
                </tr>

                <% } %>
                </tbody>

                <thead class="thead-inverse">
                <tr>
                    <th>Semester</th>
                    <th>Drives Given</th>
                    <th>Rides Taken</th>
                </tr>
                </thead>
                <tbody>

                <tr>
                    <td>Fall</td>
                    <td><%= falldrives %></td>
                    <td><%= fallrides %></td>
                </tr>
                <tr>
                    <td>Spring</td>
                    <td><%= springdrives %></td>
                    <td><%= springrides %></td>
                </tr>
                </tbody>
            </table>


        </div>
    </div>
</div>

</body>
</html>