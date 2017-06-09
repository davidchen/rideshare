<%@ include file="/partials/page-imports.jsp" %>

<%
    String uname = request.getParameter("user-uname");
    int permission = Integer.parseInt(request.getParameter("lockunlock"));

    String url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
    Class.forName("com.mysql.jdbc.Driver");

    try {
        Connection conn = DriverManager.getConnection(url, "admin", "adminadmin");
        String insert = "UPDATE user SET permissions = ? WHERE username = ? AND permissions < 1";
        PreparedStatement ps = conn.prepareStatement(insert);
        ps.setInt(1, permission);
        ps.setString(2, uname);
        int successCode = ps.executeUpdate();
        ps.clearParameters();
        conn.close();

    } catch (Exception e) { // db error
        System.out.println("Database error.");
        System.out.println(e);
    }

%>