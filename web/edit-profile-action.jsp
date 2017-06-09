<%@ include file="/partials/page-imports.jsp" %>

<%
    String url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
    Class.forName("com.mysql.jdbc.Driver");

    Connection conn;
    PreparedStatement ps;
    ResultSet result_set;
    
    String oldpw = request.getParameter("old-password");
    String newpw = request.getParameter("new-password");
    String name = request.getParameter("full-name");
    String address = request.getParameter("address");
    String phone = request.getParameter("phone");
    String profpicurl = request.getParameter("profpicurl");


    int privacysettings;
    if (request.getParameter("privacy") == null) {
        privacysettings = 0;
    } else {
        privacysettings = 1;
    }
    
    ArrayList<String> clauses = new ArrayList<String>();
    if (!newpw.isEmpty()) { clauses.add("password = \"" + newpw + "\""); }
    if (!name.isEmpty()) { clauses.add("fullname = \"" + name + "\""); }
    if (!address.isEmpty()) { clauses.add("address = \"" + address + "\""); }
    if (!phone.isEmpty()) { clauses.add("number = \"" + phone + "\""); }
    if (!profpicurl.isEmpty()) { clauses.add("imgsrc = \"" + profpicurl + "\""); }
    clauses.add("privacysettings = " + privacysettings);
    String clause = clauses.toString().substring(1, clauses.toString().length() - 1);

    try {
        conn = DriverManager.getConnection(url, "admin", "adminadmin");
        
        if (!newpw.isEmpty()) {
        	String query0 = "SELECT * FROM user WHERE userid = ? AND password = ?";
            ps = conn.prepareStatement(query0);
            ps.setInt(1, (Integer)session.getAttribute("userid"));
            ps.setString(2, oldpw);
            result_set = ps.executeQuery();
            if (!result_set.next()) {
            	conn.close();
            	throw new Exception("Incorrect old password");
            }
            ps.clearParameters();
        
        }
        
        String query1 = "UPDATE user "+
        				"SET " + clause + " " + "WHERE userid = ?";
		ps = conn.prepareStatement(query1);
		ps.setInt(1, (Integer)session.getAttribute("userid"));
		ps.executeUpdate();
		ps.clearParameters();
		conn.close();
		
		response.sendRedirect("profile");

    } catch (Exception e) { // db error
        out.println("Database error.");
        out.println(e);
        out.println();
    }

%>