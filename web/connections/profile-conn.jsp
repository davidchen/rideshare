<%
    String db_url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
    Connection conn = null;
    ResultSet result_set;
    PreparedStatement prep_stmt;
    String query;

    String uname = (String) session.getAttribute("username");
    int uid = (Integer) session.getAttribute("userid");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(db_url, "admin", "adminadmin");

        query = "SELECT email, password, fullname, address, number, imgsrc, privacysettings, forwarding FROM user WHERE username = ? AND userid = ?";
        prep_stmt = conn.prepareStatement(query);
        prep_stmt.setString(1, uname);
        prep_stmt.setInt(2, uid);
        result_set = prep_stmt.executeQuery();

        if (result_set.next()) {

            String email = result_set.getString("email");
            if (email != null && !email.isEmpty()) {
                pageContext.setAttribute("user_email", email);
            } else {
                pageContext.setAttribute("user_email", "");
            }

            String pass = result_set.getString("password");
            if (pass != null && !pass.isEmpty()) {
                pageContext.setAttribute("user_pass", pass);
            } else {
                pageContext.setAttribute("user_pass", "");
            }

            String name = result_set.getString("fullname");
            if (name != null && !name.isEmpty()) {
                pageContext.setAttribute("user_name", name);
            } else {
                pageContext.setAttribute("user_name", "");
            }

            String address = result_set.getString("address");
            if (address != null && !address.isEmpty()) {
                pageContext.setAttribute("user_address", address);
            } else {
                pageContext.setAttribute("user_address", "");
            }

            String phone = result_set.getString("number");
            if (phone != null && !phone.isEmpty()) {
                pageContext.setAttribute("user_phone", phone);
            } else {
                pageContext.setAttribute("user_phone", "");
            }

            String img = result_set.getString("imgsrc");
            if (img != null && !img.isEmpty()) {
                pageContext.setAttribute("user_img", img);
            } else {
                pageContext.setAttribute("user_img", "http://placehold.it/500x500");
            }

            int privacysettings = result_set.getInt("privacysettings");
            pageContext.setAttribute("user_privacysettings", privacysettings);

            int forwarding = result_set.getInt("forwarding");
            pageContext.setAttribute("forwarding", forwarding);


        }

        // get logged in user's vehicles and stuff
        query = "SELECT make, model, seats, vehicleid FROM vehicle WHERE driverid = ?";
        prep_stmt = conn.prepareStatement(query);
        prep_stmt.setInt(1, uid);
        result_set = prep_stmt.executeQuery();

        ArrayList<ArrayList<String>> vehicles = new ArrayList<ArrayList<String>>();

        while (result_set.next()) {
            ArrayList<String> vehicle = new ArrayList<String>();
            vehicle.add(result_set.getString("make"));
            vehicle.add(result_set.getString("model"));
            vehicle.add(result_set.getString("seats"));
            vehicle.add(String.valueOf(result_set.getInt("vehicleid")));

            vehicles.add(vehicle);
        }

        pageContext.setAttribute("u_vehicle_list", vehicles);

        // then get all of that user's reviews and reports received
        query = "SELECT comment, rating, username FROM reviews INNER JOIN user ON " +
                "reviews.reviewerid = user.userid WHERE revieweeid = ?";
        prep_stmt = conn.prepareStatement(query);
        prep_stmt.setInt(1, uid);
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


    } catch (Exception e) { // db connection error
        System.out.println("Database connection error.");
        System.out.println(e);
    }

    conn.close();

%>