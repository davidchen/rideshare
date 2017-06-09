<%
    // Redirect to appropriate dashboard if not enough permissions
    int p = (Integer) session.getAttribute("userpermission");
    
    if (p == 0) {
        response.sendRedirect("dashboard");
        return;
    }
%>