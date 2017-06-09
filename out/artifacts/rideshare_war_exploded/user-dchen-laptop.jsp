<%@ include file="/partials/page-imports.jsp" %>
<%@ include file="/partials/login-required.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%
    String pageTitleName = " ";
    if (request.getParameter("username") == null || request.getParameter("username") == "") {
        response.sendRedirect("dashboard");
    } else {
        pageTitleName = request.getParameter("username");
    }
%>

<%@ include file="/partials/head.jsp" %>
<%@ include file="/connections/profile-conn.jsp" %>


<body>

<div class="container-fluid">
    <div class="row content-row">
        <div class="col-8 offset-2">
            <div class="text-center">
                <h1>User: <%= pageTitleName %></h1>
                <p><a href="/dashboard">return to my dashboard</a></p>

            </div>

            <div class="row mt-5">
                <div class="col-4">
                    <a href="http://placehold.it"><img src="http://placehold.it/500x500" style="width:100%;"></a>
                    <p class="text-center"><a href="#">change</a> &middot; <a href="#">remove</a></p>
                    <p>
                        username: <%= session.getAttribute("username") %>
                        <br>
                        rating: stars and stuff
                    </p>
                    <p>
                        <a href="#">message user</a>
                        <br>
                        <a href="#">report user</a>
                    </p>
                </div>


                <div class="col-8">
                    <div class="row">
                        <div class="col-12">
                            <h4><strong>Reviews and Comments Received</strong></h4>
                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Numquam, repellendus!</p>
                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Deleniti, nam.</p>
                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ab, dolorem!</p>
                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusantium, molestiae?</p>
                        </div>
                    </div>

                    <div class="row mt-3">
                        <div class="col-12">
                            <h4><strong>Reports Received (visible to Admin/SS only)</strong></h4>
                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Numquam, repellendus!</p>
                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Deleniti, nam.</p>
                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ab, dolorem!</p>
                            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Accusantium, molestiae?</p>
                        </div>
                    </div>
                </div>
            </div>



        </div>
    </div>
</div>

</body>
</html>