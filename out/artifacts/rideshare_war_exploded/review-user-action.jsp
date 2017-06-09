<%@ include file="/partials/page-imports.jsp" %>

<%
    int reviewerID = Integer.parseInt(request.getParameter("reviewerID"));
    int revieweeID = Integer.parseInt(request.getParameter("revieweeID"));

    int tripID = Integer.parseInt(request.getParameter("tripID"));
    int rating = Integer.parseInt(request.getParameter("trip-rating"));
    int reviewType = Integer.parseInt(request.getParameter("tripType"));

    String reviewText = request.getParameter("review-text");

    boolean posttofeed;

    if (request.getParameter("posttofeed") != null) {
        posttofeed = true;
    } else {
        posttofeed = false;
    }

    String url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
    Class.forName("com.mysql.jdbc.Driver");

    try {
        Connection conn = DriverManager.getConnection(url, "admin", "adminadmin");
        String insert = "INSERT INTO reviews (tripid, reviewerid, revieweeid, type, rating, comment) VALUES (?,?,?,?,?,?)";
        PreparedStatement ps = conn.prepareStatement(insert);
        ps.setInt(1, tripID);
        ps.setInt(2, reviewerID);
        ps.setInt(3, revieweeID);
        ps.setInt(4, reviewType);
        ps.setInt(5, rating);
        ps.setString(6, reviewText);
        int successCode = ps.executeUpdate();
        ps.clearParameters();

        if (posttofeed) {
            String q = "INSERT INTO comments (reviewerid, revieweeid, username, comment) VALUES (?,?,?,?)";
            ps = conn.prepareStatement(q);
            ps.setInt(1, reviewerID);
            ps.setInt(2, revieweeID);
            ps.setString(3, (String)session.getAttribute("username"));
            ps.setString(4, reviewText);
            ps.executeUpdate();
        }
        conn.close();

    } catch (Exception e) { // db error
        System.out.println("Database error.");
        System.out.println(e);
    }

%>