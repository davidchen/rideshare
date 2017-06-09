<%@ include file="/partials/page-imports.jsp" %>
<%@ include file="/partials/login-required.jsp" %>
<%@ include file="/partials/redirect-dashboard.jsp" %>
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
                <%@ include file="/partials/global-menu.jsp" %>
                <%@ include file="/partials/trips-table.jsp" %>

                <a href="${pageContext.request.contextPath}/ride/request.jsp" class="btn btn-info" role="button">Request a Ride</a>
                <a href="${pageContext.request.contextPath}/drive/offer.jsp" class="btn btn-info" role="button">Offer a Drive</a>
            </div>



        </div>
    </div>
</div>

</body>
</html>