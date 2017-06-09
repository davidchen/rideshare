<%@ include file="/partials/page-imports.jsp" %>

<%
    String username = ((String)request.getParameter("username")).toLowerCase();
    String pwd = request.getParameter("password");
    String email = ((String)request.getParameter("email")).toLowerCase();

    String url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
    Class.forName("com.mysql.jdbc.Driver");

    try {
        // add new user
        Connection conn = DriverManager.getConnection(url, "admin", "adminadmin");
        String query1 = "INSERT INTO user(username, password, email) VALUES (?, ?, ?)";
        PreparedStatement ps1 = conn.prepareStatement(query1);
        ps1.setString(1, username);
        ps1.setString(2, pwd);
        ps1.setString(3, email);
        ps1.executeUpdate();

        // get userid of new user
        String query2 = "SELECT * FROM user WHERE username = ?";
        PreparedStatement ps2 = conn.prepareStatement(query2);
        ps2.setString(1, username);
        ResultSet rs = ps2.executeQuery();

        rs.next();
        int userid = rs.getInt("userid");
        int userperm = rs.getInt("permissions");

        conn.close();

        // save userid and username and user permissions to session
        session.setAttribute("userid", userid);
        session.setAttribute("username", username);
        session.setAttribute("userpermission", userperm);

        response.sendRedirect("dashboard");

        // we don't need to test if the query returned anything, since that'll be caught as an exception.

    } catch (Exception e) {
        System.out.println(e);
        session.setAttribute("error", "Sorry, username or email already taken. Try again.");
        response.sendRedirect("register");
    }

%>