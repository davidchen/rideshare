<%@ include file="/partials/page-imports.jsp" %>

<%
    String url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
    Class.forName("com.mysql.jdbc.Driver");

    Connection conn;
    PreparedStatement ps;
    ResultSet result_set;

    String receiverUsername = request.getParameter("recipient-input");
    int receiverID;
    int senderID = Integer.parseInt(request.getParameter("senderID"));
    String message = request.getParameter("message");

    try {
        conn = DriverManager.getConnection(url, "admin", "adminadmin");
        if (receiverUsername == null) { // if string is null, then ID must be present
            receiverID = Integer.parseInt(request.getParameter("receiverID"));
        } else {  // else the username is present and we have to match this to an ID
            String query = "SELECT * FROM user WHERE username = ?";
            ps = conn.prepareStatement(query);
            ps.setString(1, receiverUsername);
            result_set = ps.executeQuery();
            result_set.next();
            receiverID = result_set.getInt("userid");
        }

        String insert = "INSERT INTO messages (senderid, receiverid, message) VALUES (?, ?, ?)";
        ps = conn.prepareStatement(insert);
        ps.setInt(1, senderID);
        ps.setInt(2, receiverID);
        ps.setString(3, message);
        int successCode = ps.executeUpdate();
        ps.clearParameters();
        conn.close();

        if (receiverUsername != null) {
            response.sendRedirect("inbox");
        }

    } catch (Exception e) { // db error
        System.out.println("Database error.");
        System.out.println(e);
    }

%>