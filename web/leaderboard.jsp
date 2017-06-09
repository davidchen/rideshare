<%@ include file="/partials/page-imports.jsp" %>
<%@ include file="/partials/login-required.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<% String pageTitleName = "Trip History"; %>
<%@ include file="partials/head.jsp" %>

<%

    Integer userid = (Integer) session.getAttribute("userid");
    String username = (String) session.getAttribute("username");

//Trip object for sorting driving and riding trips in one time-based list.
    class Driver {
        public String username;
        public String driverrating;
        public int numreviews;       // number of times reviewed
    }
    ArrayList<Driver> leaderBoard = new ArrayList<Driver>();

// Comment object for storing comments in comment feed
    class Comment {
        public String username;
        public String comment;
        public String timestamp;
    }
    ArrayList<Comment> commentFeed = new ArrayList<Comment>();

/* Get all upcoming trips, sorted by time */
    String url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
    Class.forName("com.mysql.jdbc.Driver");

    try {
        Connection con = DriverManager.getConnection(url, "admin", "adminadmin");

        // Get leaderboards
        String query1 = "SELECT U.username, U.driverrating, getnumberofreviews(U.userid) AS numberofreviews " +
                "FROM user U " +
                "WHERE U.driverrating > 0 " +
                "ORDER BY U.driverrating DESC, numberofreviews DESC ";
        PreparedStatement ps1 = con.prepareStatement(query1);
        ResultSet rs1 = ps1.executeQuery();
        while (rs1.next()) {
            Driver d = new Driver();
            d.username = rs1.getString("username");
            d.driverrating = rs1.getString("driverrating");
            d.numreviews = rs1.getInt("numberofreviews");
            leaderBoard.add(d);
        }

        // Get comments feed
        String query2 = "SELECT username, comment, timestamp FROM comments ORDER BY commentid DESC";
        PreparedStatement ps2 = con.prepareStatement(query2);
        ResultSet rs2 = ps2.executeQuery();
        while (rs2.next()) {
            Comment c = new Comment();
            c.username = rs2.getString("username");
            c.comment = rs2.getString("comment");
            c.timestamp = rs2.getString("timestamp");
            commentFeed.add(c);
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
        <div class="col-12">
            <div class="text-center">
                <h1>Community</h1>
                <%@ include file="/partials/global-menu.jsp" %>
            </div>
        </div>

        <div class="col-6">
            <div class="text-center">
                <h4>Leaderboards</h4>
                <% if (leaderBoard.size() == 0) { %>
                <div class="text-center">No one's been rated yet! Be the first :)</div>
                <% } %>
            </div>
            <table class="table table-striped table-sm">

                <thead class="thead-inverse">
                <tr>
                    <th colspan="1">Name</th>
                    <th colspan="1">Rating</th>
                    <th colspan="1">Number of Reviews</th>
                </tr>
                </thead>
                <tbody>

                <% for (Driver d : leaderBoard) { %>
                <tr>
                    <td><a href="${pageContext.request.contextPath}/user?username=<%=d.username%>"><%=d.username%>
                    </a></td>
                    <td><%=d.driverrating%>
                    </td>
                    <td><%=d.numreviews%>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>

        </div>


        <div class="col-6">
            <div class="text-center">
                <h4>Recent Comments</h4>
            </div>
                <% if (commentFeed.size() == 0) { %>
                <div class="text-center">No review comments to display</div>
                <% } else { %>

            <table class="table table-striped table-sm">

                <thead class="thead-inverse">
                <tr>
                    <th colspan="1">Time</th>
                    <th colspan="1">Username</th>
                    <th colspan="1">Comment</th>
                </tr>
                </thead>
                <tbody>

                <% for (Comment c : commentFeed) { %>
                <tr>
                    <td><%=c.timestamp%>
                    </td>
                    <td><a href="${pageContext.request.contextPath}/user?username=<%=c.username%>"><%=c.username%>
                    </a></td>
                    <td><%=c.comment%>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
            <%} %>
        </div>

    </div>
</div>

</body>
</html>