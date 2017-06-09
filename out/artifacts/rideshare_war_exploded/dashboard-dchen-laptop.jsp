<%@ include file="/partials/page-imports.jsp" %>
<%@ include file="/partials/login-required.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<% String pageTitleName = "Dashboard"; %>
<%@ include file="/partials/head.jsp" %>

<body>

<div class="container-fluid">
    <div class="row content-row">
        <div class="col-8 offset-2">
            <div class="text-center">
                <h1>Dashboard</h1>
                <p><%= session.getAttribute("username") %> | 3 requests | 2 offers | 0 trips | <a href="/profile">profile</a> | <a href="/logout-action.jsp">logout</a></p>
                <%@ include file="/partials/requests-offers-table.jsp" %>

                <a href="#" class="btn btn-info" role="button">Request a Ride</a>
                <a href="#" class="btn btn-info" role="button">Offer a Drive</a>
            </div>



        </div>
    </div>
</div>

</body>
</html>