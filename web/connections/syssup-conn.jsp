<%
    String db_url = "jdbc:mysql://cs336-final.cpek5l3nbgry.us-west-2.rds.amazonaws.com:3306/final";
    Connection conn = null;
    ResultSet result_set;
    PreparedStatement prep_stmt;
    String query;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(db_url, "admin", "adminadmin");

        // get ads
        query = "SELECT * FROM ad";
        prep_stmt = conn.prepareStatement(query);
        result_set = prep_stmt.executeQuery();

        ArrayList<ArrayList<String>> ads = new ArrayList<ArrayList<String>>();

        while (result_set.next()) {
            ArrayList<String> ad = new ArrayList<String>();
            ad.add(result_set.getString("adid"));
            ad.add(result_set.getString("adlink"));
            ad.add(result_set.getString("imageurl"));
            ad.add(result_set.getString("company"));
            ad.add(result_set.getString("views"));
            ad.add(result_set.getString("revenue"));
            ad.add(result_set.getString("payperview"));
            ad.add(result_set.getString("percentage"));

            ads.add(ad);
        }

        pageContext.setAttribute("ads_list", ads);

        // get payout table
        query = "SELECT * FROM paydrivers";
        prep_stmt = conn.prepareStatement(query);
        result_set = prep_stmt.executeQuery();

        ArrayList<ArrayList<String>> pays = new ArrayList<ArrayList<String>>();

        while (result_set.next()) {
            ArrayList<String> pay = new ArrayList<String>();
            pay.add(result_set.getString("userid"));
            pay.add(result_set.getString("payout"));

            pays.add(pay);
        }

        pageContext.setAttribute("payout_list", pays);


    } catch (Exception e) { // db connection error
        System.out.println("Database connection error.");
        System.out.println(e);
    }

    conn.close();

%>