<%@ include file="/partials/page-imports.jsp" %>

<%
    // default values
    String username = request.getParameter("query-username");
    String origin = request.getParameter("query-origin");
    String destination = request.getParameter("query-dest");
    String dayofweek = request.getParameter("query-day-week");
    String month = request.getParameter("query-month");
    String year = request.getParameter("query-year");
    String startdate = request.getParameter("query-start-date");
    String enddate = request.getParameter("query-end-date");
    String starttime = request.getParameter("query-start-time");
    String endtime = request.getParameter("query-end-time");

    if (username == null || username.isEmpty()) {
        username = "U.username";
    } else {
        username = "\"" + username + "\"";
    }
    if (origin == null || origin.isEmpty()) {
        origin = "T.startlocation";
    } else {
        origin = "\"" + origin + "\"";
    }
    if (destination == null || destination.isEmpty()) {
        destination = "T.endlocation";
    } else {
        destination = "\"" + destination + "\"";
    }
    if (dayofweek == null || dayofweek.isEmpty()) {
        dayofweek = "DAYNAME(T.date)";
    } else {
        dayofweek = "\"" + dayofweek + "\"";
    }
    if (month == null || month.isEmpty()) {
        month = "MONTHNAME(T.date)";
    } else {
        month = "\"" + month + "\"";
    }
    if (year == null || year.isEmpty()) {
        year = "YEAR(T.date)";
    } else {
        year = "\"" + year + "\"";
    }
    if (startdate == null || startdate.isEmpty()) {
        startdate = "DATE(T.date)";
    } else {
        startdate = "\"" + startdate + "\"";
    }
    if (enddate == null || enddate.isEmpty()) {
        enddate = "DATE(T.date)";
    } else {
        enddate = "\"" + enddate + "\"";
    }
    if (starttime == null || starttime.isEmpty()) {
        starttime = "TIME(T.date)";
    } else {
        starttime = "\"" + starttime + "\"";
    }
    if (endtime == null || endtime.isEmpty()) {
        endtime = "TIME(T.date)";
    } else {
        endtime = "\"" + endtime + "\"";
    }

    String queryresult;
    String url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
    Class.forName("com.mysql.jdbc.Driver");

    try {
        Connection conn = DriverManager.getConnection(url, "admin", "adminadmin");
//        String query = String.format("SELECT COUNT(*) as querycount FROM triphistory T, user U " +
//                "WHERE (U.userid = T.driverid OR U.userid = T.riderid) " +
//                "AND TIME(T.date) >= %s " +
//                "AND TIME(T.date) <= %s " +
//                "AND DAYNAME(T.date) = %s " +
//                "AND MONTHNAME(T.date) = %s " +
//                "AND YEAR(T.date) = %s " +
//                "AND DATE(T.date) >= %s " +
//                "AND DATE(T.date) <= %s " +
//                "AND T.startlocation = %s " +
//                "AND T.endlocation = %s " +
//                "AND U.username = %s " +
//                "AND T.finished = 1", starttime, endtime, dayofweek, month, year, startdate, enddate, origin, destination, username);


        String query = String.format("SELECT COUNT(*) as querycount FROM (SELECT T.tripid AS tripid, T.requestid AS requestid FROM " +
                "triphistory T, user U " +
                "WHERE TIME(T.date) >= %s " +
                "AND TIME(T.date) <= %s " +
                "AND DAYNAME(T.date) = %s " +
                "AND MONTHNAME(T.date) = %s " +
                "AND YEAR(T.date) = %s " +
                "AND DATE(T.date) >= %s " +
                "AND DATE(T.date) <= %s " +
                "AND T.startlocation = %s " +
                "AND T.endlocation = %s " +
                "AND U.username = %s " +
                "AND T.finished = 1 " +
                "AND U.userid IN (T.driverid) UNION SELECT T.tripid AS tripid, T.requestid AS requestid FROM " +
                "triphistory T, user U " +
                "WHERE TIME(T.date) >= %s " +
                "AND TIME(T.date) <= %s " +
                "AND DAYNAME(T.date) = %s " +
                "AND MONTHNAME(T.date) = %s " +
                "AND YEAR(T.date) = %s " +
                "AND DATE(T.date) >= %s " +
                "AND DATE(T.date) <= %s " +
                "AND T.startlocation = %s " +
                "AND T.endlocation = %s " +
                "AND U.username = %s " +
                "AND T.finished = 1 " +
                "AND U.userid IN (T.riderid)) AS X", starttime, endtime, dayofweek, month, year, startdate, enddate, origin, destination, username,
                starttime, endtime, dayofweek, month, year, startdate, enddate, origin, destination, username);

//        System.out.println(query);

        Statement statement = conn.createStatement();
        ResultSet rs1 = statement.executeQuery(query);

        response.setContentType("text/html");

        if (rs1.next()) {
            queryresult = rs1.getString("querycount");
            response.getWriter().write(queryresult);
        } else {
            response.getWriter().write("0");

        }



        conn.close();


    } catch (Exception e) { // db error
        System.out.println("Database error.");
        System.out.println(e);
    }

%>