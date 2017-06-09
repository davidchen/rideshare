<%@ include file="/partials/login-required.jsp" %>
<%
    session.setAttribute("userid", null);
    session.setAttribute("username", null);
    session.setAttribute("userpermission", null);
    session.invalidate();
    response.sendRedirect("login");
%>



