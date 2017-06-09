<%
    // Redirect to appropriate dashboard if not enough permissions
    int p = (Integer) session.getAttribute("userpermission");

    if (p == 1) {
        response.sendRedirect("syssup");
        return;
    }

    if (p == 0) {
        response.sendRedirect("dashboard");
        return;
    }
%>