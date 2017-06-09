<%@ include file="/partials/page-imports.jsp" %>
<%@ include file="/partials/login-required.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<% String pageTitleName = "Profile"; %>
<%@ include file="/partials/head.jsp" %>
<%@ include file="/connections/profile-conn.jsp" %>


<body>

<div class="container-fluid">
    <div class="row content-row">
        <div class="col-8 offset-2">
            <div class="text-center">
                <h1>Profile</h1>
                <p><%= session.getAttribute("username") %> &middot; <a href="/dashboard">dashboard</a> &middot; <a
                        href="/logout-action.jsp">logout</a></p>

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
                        <div class="col-8"><p><strong
                                class="mr-2">email:</strong><%= pageContext.getAttribute("user_email") %>
                        </p></div>
                        <div class="col-4"><p><a href="#">change</a></p></div>

                        <div class="col-8"><strong
                                class="mr-2">password:</strong><%= pageContext.getAttribute("user_pass") %>
                        </div>
                        <div class="col-4"><p><a href="#">change</a></p></div>

                        <div class="col-8"><p><strong
                                class="mr-2">name:</strong><%= pageContext.getAttribute("user_name") %>
                        </p></div>
                        <div class="col-4"><p><a href="#">change</a></p></div>

                        <div class="col-8"><p><strong
                                class="mr-2">address:</strong><%= pageContext.getAttribute("user_address") %>
                        </p></div>
                        <div class="col-4"><p><a href="#">change</a></p></div>

                        <div class="col-8"><p><strong
                                class="mr-2">phone:</strong><%= pageContext.getAttribute("user_phone") %>
                        </p></div>
                        <div class="col-4"><p><a href="#">change</a></p></div>

                        <%--<div class="col-8"><p><strong class="mr-2">alt-email:</strong>test2@test.com</p></div>--%>
                        <%--<div class="col-4"><p><a href="#">change</a></p></div>--%>

                        <div class="col-12 mt-3">
                            <p><strong>vehicles</strong></p>
                            <% ArrayList<ArrayList<String>> vehicles = (ArrayList) pageContext.getAttribute("u_vehicle_list");
                                for (ArrayList<String> vehicle : vehicles) { %>

                            <p>
                                <%= vehicle.get(0) %>&nbsp;
                                <%= vehicle.get(1) %>&nbsp;
                                <%= vehicle.get(2) %> &middot;
                                <strong><%= vehicle.get(4) %>
                                </strong> &middot;
                                <strong><%= vehicle.get(3) %> seat(s)</strong> &middot;
                                <a href="#">edit</a> &middot; <a href="#">delete</a>
                            </p>
                            <% } %>

                            <a href="#">Add a vehicle...</a>
                        </div>


                    </div>
                </div>
            </div>

            <div class="row mt-3">
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

</body>
</html>