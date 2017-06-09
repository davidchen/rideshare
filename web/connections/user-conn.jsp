<%@ include file="/partials/page-imports.jsp" %>

<%
    String usernameToSearch = request.getParameter("username");

    if (usernameToSearch == null || usernameToSearch.equals("")) {
        response.sendRedirect("dashboard");
    }

    usernameToSearch = usernameToSearch.toLowerCase();

    if (usernameToSearch.equals((String) session.getAttribute("username"))) {  // check if searching for self
        response.sendRedirect("profile");
    }

    // else if username isn't themselves, look up user in DB to see if valid user

    pageTitleName = usernameToSearch;
    pageContext.setAttribute("viewing_username", pageTitleName);

    String db_url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
    Connection conn = null;
    ResultSet result_set;
    PreparedStatement prep_stmt;
    String query;

    String viewingUsername, viewingImg;
    int viewingUserID, viewingUserPermission;
    int viewingUserPrivacy;
    String viewingUserEmail;
    String viewingUserFullName;
    String viewingUserAddress;
    String viewingUserPhone;


    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(db_url, "admin", "adminadmin");

        query = "SELECT * FROM user WHERE username = ?";
        prep_stmt = conn.prepareStatement(query);
        prep_stmt.setString(1, (String) pageContext.getAttribute("viewing_username"));
        result_set = prep_stmt.executeQuery();

        if (result_set.next()) { // if user exists...
            viewingUsername = result_set.getString("username");
            viewingImg = result_set.getString("imgsrc");
            viewingUserID = result_set.getInt("userid");
            viewingUserPermission = result_set.getInt("permissions");

            viewingUserPrivacy = result_set.getInt("privacysettings");
            viewingUserEmail = result_set.getString("email");
            viewingUserFullName = result_set.getString("fullname");
            viewingUserAddress = result_set.getString("address");
            viewingUserPhone = result_set.getString("number");

            pageContext.setAttribute("viewing_username", viewingUsername);
            pageContext.setAttribute("viewing_userid", viewingUserID);
            pageContext.setAttribute("viewing_userperm", viewingUserPermission);

            pageContext.setAttribute("viewing_userprivacy", viewingUserPrivacy);
            pageContext.setAttribute("viewing_useremail", viewingUserEmail);
            pageContext.setAttribute("viewing_userfullname", viewingUserFullName);
            pageContext.setAttribute("viewing_useraddress", viewingUserAddress);
            pageContext.setAttribute("viewing_userphone", viewingUserPhone);

            if (viewingImg != null && !viewingImg.isEmpty()) {
                pageContext.setAttribute("viewing_img", viewingImg);
            } else {
                pageContext.setAttribute("viewing_img", "http://placehold.it/500x500");
            }

            // then get all of that user's reviews and reports received
            query = "SELECT comment, rating, username FROM reviews INNER JOIN user ON " +
                    "reviews.reviewerid = user.userid WHERE revieweeid = ?";
            prep_stmt = conn.prepareStatement(query);
            prep_stmt.setInt(1, viewingUserID);
            result_set = prep_stmt.executeQuery();

            ArrayList<ArrayList<String>> reviews = new ArrayList<ArrayList<String>>();

            while (result_set.next()) {
                ArrayList<String> review = new ArrayList<String>();

                review.add(result_set.getString("comment"));
                review.add(result_set.getString("rating"));
                review.add(result_set.getString("username"));

                reviews.add(review);
            }

            pageContext.setAttribute("u_reviews_list", reviews);

            query = "SELECT * FROM reports INNER JOIN user ON " +
                    "reports.accuserid = user.userid WHERE accusedid = ?";
            prep_stmt = conn.prepareStatement(query);
            prep_stmt.setInt(1, viewingUserID);
            result_set = prep_stmt.executeQuery();

            ArrayList<ArrayList<String>> reports = new ArrayList<ArrayList<String>>();

            while (result_set.next()) {
                ArrayList<String> report = new ArrayList<String>();

                report.add(result_set.getString("username")); // reporter username
                report.add(result_set.getString("details")); // report details
                report.add(result_set.getString("reason")); // report code

                reports.add(report);
            }

            pageContext.setAttribute("u_reports_list", reports);


        } else {
            pageContext.setAttribute("viewing_error", "No such user exists.");
        }

    } catch (Exception e) { // db connection error
        System.out.println("Database connection error.");
        System.out.println(e);
    }

    conn.close();


%>