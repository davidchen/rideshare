<%
    String db_url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
    Connection conn = null;
    ResultSet result_set;
    PreparedStatement prep_stmt;
    String query;

    int uid = (Integer) session.getAttribute("userid");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(db_url, "admin", "adminadmin");

        // get received msgs
        query = "SELECT * FROM messages INNER JOIN user ON user.userid = messages.senderid " +
                "WHERE receiverid = ? ORDER BY messageid DESC";
        prep_stmt = conn.prepareStatement(query);
        prep_stmt.setInt(1, uid);
        result_set = prep_stmt.executeQuery();

        ArrayList<ArrayList<String>> received_msgs = new ArrayList<ArrayList<String>>();

        while (result_set.next()) {
            ArrayList<String> received_msg = new ArrayList<String>();
            received_msg.add(result_set.getString("messageid"));
            received_msg.add(result_set.getString("username"));
            received_msg.add(result_set.getString("message"));
            received_msgs.add(received_msg);
        }

        pageContext.setAttribute("received_msgs_list", received_msgs);

        // get sent msgs
        query = "SELECT * FROM messages INNER JOIN user ON user.userid = messages.receiverid " +
                "WHERE senderid = ? ORDER BY messageid DESC";
        prep_stmt = conn.prepareStatement(query);
        prep_stmt.setInt(1, uid);
        result_set = prep_stmt.executeQuery();

        ArrayList<ArrayList<String>> sent_msgs = new ArrayList<ArrayList<String>>();

        while (result_set.next()) {
            ArrayList<String> sent_msg = new ArrayList<String>();
            sent_msg.add(result_set.getString("messageid"));
            sent_msg.add(result_set.getString("username"));
            sent_msg.add(result_set.getString("message"));
            sent_msgs.add(sent_msg);
        }

        pageContext.setAttribute("sent_msgs_list", sent_msgs);


    } catch (Exception e) { // db connection error
        System.out.println("Database connection error.");
        System.out.println(e);
    }

    conn.close();

%>