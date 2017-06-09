<%
    // Redirect to index if not logged in (if session has no username attribute)
    if (session.getAttribute("username") == null || session.getAttribute("userid") == null) {
        response.sendRedirect("login");
        return;
    }
%>