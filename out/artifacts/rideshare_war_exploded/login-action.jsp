<%@ include file="/partials/page-imports.jsp" %>

<%
    String username = request.getParameter("username");
    String pwd = request.getParameter("password");


    String url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
    Class.forName("com.mysql.jdbc.Driver");

    try {
        ResultSet result_set;
        Connection conn = DriverManager.getConnection(url, "admin", "adminadmin");
        String query = "SELECT * FROM user WHERE username = ? AND password = ?";
        PreparedStatement ps = conn.prepareStatement(query);
        ps.setString(1, username);
        ps.setString(2, pwd);
        result_set = ps.executeQuery();

        if (result_set.next()) { // login successful because there is row found with these credentials
            int userid = result_set.getInt("userid");
            String uname = result_set.getString("username");
            int upermission = result_set.getInt("permissions");
            session.setAttribute("userid", userid);
            session.setAttribute("username", uname);
            session.setAttribute("userpermission", upermission);
            session.setAttribute("error", null);
            conn.close();

            if (upermission == 2) {
                response.sendRedirect("admin");
            }
            else if (upermission == 1) {
                response.sendRedirect("syssup");
            }
            else if (upermission == 0) {
                response.sendRedirect("dashboard");
            }
            else {
                session.setAttribute("error", "Your account is locked. Please contact admin/sys support.");
                session.setAttribute("userid", null);
                session.setAttribute("username", null);
                session.setAttribute("userpermission", null);
                response.sendRedirect("login");
            }

        } else { // login failed because no matching query returned
            session.setAttribute("error", "Sorry, bad username or password. Try again.");
            conn.close();
            response.sendRedirect("login");
        }

    } catch (Exception e) { // db error
        System.out.println("Database error.");
        System.out.println(e);
    }

%>