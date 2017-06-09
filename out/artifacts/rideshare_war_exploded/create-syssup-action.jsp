<%@ include file="/partials/page-imports.jsp" %>

<%
    String sysuname = request.getParameter("syssup-username");
    String syspassword = request.getParameter("syssup-password");
    String sysemail = request.getParameter("syssup-email");

    String url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
    Class.forName("com.mysql.jdbc.Driver");

    try {
        Connection conn = DriverManager.getConnection(url, "admin", "adminadmin");
        String insert = "INSERT INTO user (username, password, email, permissions) VALUES (?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(insert);
        ps.setString(1, sysuname);
        ps.setString(2, syspassword);
        ps.setString(3, sysemail);
        ps.setInt(4, 1);
        int successCode = ps.executeUpdate();
        ps.clearParameters();
        conn.close();

    } catch (Exception e) { // db error
        System.out.println("Database error.");
        System.out.println(e);
    }

%>