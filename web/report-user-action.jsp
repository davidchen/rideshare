<%@ include file="/partials/page-imports.jsp" %>

<%
    int reportedID = Integer.parseInt(request.getParameter("reportedID"));
    int reporterID = Integer.parseInt(request.getParameter("reporterID"));

    int reportReason = Integer.parseInt(request.getParameter("report-reason"));
    String reportText = request.getParameter("report-text");

    String url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
    Class.forName("com.mysql.jdbc.Driver");

    try {
        Connection conn = DriverManager.getConnection(url, "admin", "adminadmin");
        String insert = "INSERT INTO reports (accusedid, accuserid, reason, details) VALUES (?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(insert);
        ps.setInt(1, reportedID);
        ps.setInt(2, reporterID);
        ps.setInt(3, reportReason);
        ps.setString(4, reportText);
        int successCode = ps.executeUpdate();
        ps.clearParameters();
        conn.close();

    } catch (Exception e) { // db error
        System.out.println("Database error.");
        System.out.println(e);
    }

%>