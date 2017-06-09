<%@ include file="/partials/page-imports.jsp" %>

<%
    int adID = Integer.parseInt(request.getParameter("adID"));

    String url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
    Class.forName("com.mysql.jdbc.Driver");

    try {
        Connection conn = DriverManager.getConnection(url, "admin", "adminadmin");
        String insert = "DELETE FROM ad WHERE adid = ?";
        PreparedStatement ps = conn.prepareStatement(insert);
        ps.setInt(1, adID);
        int successCode = ps.executeUpdate();
        ps.clearParameters();
        conn.close();
        response.sendRedirect("dashboard");

    } catch (Exception e) { // db error
        System.out.println("Database error.");
        System.out.println(e);
    }

%>