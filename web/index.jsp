<%@ include file="/partials/page-imports.jsp" %>
<%@ include file="/partials/logout-required.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<% String pageTitleName = "Home"; %>
<%@ include file="/partials/head.jsp" %>

<body>

<div class="container-fluid">
    <div class="row content-row">
        <div class="col-6 offset-3">
            <div class="text-center">
                <h1>CS336 - Rideshare Project</h1>
                <p>Register for an account here or click "Log In" if you already have one</p>
                <% if (session.getAttribute("error") != null) { %>
                <p class="text-danger"><%= session.getAttribute("error") %></p>
                <% session.setAttribute("error", null);} %>
            </div>

            <%@ include file="/partials/registration-form.jsp" %>
            <p class="text-center mt-3"><a href="${pageContext.request.contextPath}/login">Already have an account? Log in!</a></p>
        </div>
    </div>
</div>

</body>
</html>