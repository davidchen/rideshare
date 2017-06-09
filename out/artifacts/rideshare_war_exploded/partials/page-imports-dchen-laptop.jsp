<%@ page pageEncoding="ISO-8859-1"
         trimDirectiveWhitespaces="true"
         import="java.io.*, java.util.*, java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%@ page isELIgnored="false" %>

<%
    response.addHeader("Cache-Control", "no-cache,no-store,private,must-revalidate,max-stale=0,post-check=0,pre-check=0");
    response.addHeader("Pragma", "no-cache");
    response.addDateHeader("Expires", 0);
%>

