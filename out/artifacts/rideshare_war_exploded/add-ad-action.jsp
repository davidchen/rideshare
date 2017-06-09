<%@ include file="/partials/page-imports.jsp" %>

<%
    String adlink = request.getParameter("adlink");
    String adimgurl = request.getParameter("adimgurl");
    String adcompany = request.getParameter("adcompany");
    double adppv = Double.parseDouble(request.getParameter("adppv"));
    double adpercentage = Double.parseDouble(request.getParameter("adpercentage"));

    String url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
    Class.forName("com.mysql.jdbc.Driver");

    try {
        Connection conn = DriverManager.getConnection(url, "admin", "adminadmin");
        String insert = "INSERT INTO ad (adlink, imageurl, company, payperview, percentage) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(insert);
        ps.setString(1, adlink);
        ps.setString(2, adimgurl);
        ps.setString(3, adcompany);
        ps.setDouble(4, adppv);
        ps.setDouble(5, adpercentage);
        int successCode = ps.executeUpdate();
        ps.clearParameters();
        conn.close();
        response.sendRedirect("dashboard");

    } catch (Exception e) { // db error
        System.out.println("Database error.");
        System.out.println(e);
    }

%>