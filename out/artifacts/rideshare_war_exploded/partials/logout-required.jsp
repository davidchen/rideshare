<%
    // Redirect to dashboard if already logged in (if session already has a username attribute)
    if (session.getAttribute("username") != null && session.getAttribute("userid") != null) {
        response.sendRedirect("/dashboard");
        return;
    }
%>