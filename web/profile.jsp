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
                <%@ include file="/partials/global-menu.jsp" %>

            </div>

            <div class="row mt-5">
                <div class="col-4">
                    <img src="<%= pageContext.getAttribute("user_img") %>"
                         style="width:100%; max-height: 300px; display: block; margin: 0 auto; padding-bottom: 25px;">
                    <!-- <p class="text-center"><a href="#">change</a> &middot; <a href="#">remove</a></p> -->
                    <%--<p>--%>
                        <%-- username: <%= session.getAttribute("username") %> --%>
                        <%--<br>average rating: stars and stuff--%>
                    <%--</p>--%>
                </div>
                <div class="col-8">
                    <div class="row">
                        <div class="col-12">
                            <p>
                                <strong class="mr-2">email:</strong>
                                <%= pageContext.getAttribute("user_email") %>
                            </p>
                        </div>


                        <%--                         <div class="col-12">
                                                    <p>
                                                        <strong class="mr-2">password:</strong>
                                                        <%= pageContext.getAttribute("user_pass") %>
                                                    </p>

                                                </div> --%>


                        <div class="col-12">
                            <p>
                                <strong class="mr-2">name:</strong>
                                <%= pageContext.getAttribute("user_name") %>
                            </p>
                        </div>


                        <div class="col-12">
                            <p>
                                <strong class="mr-2">address:</strong>
                                <%= pageContext.getAttribute("user_address") %>
                            </p>
                        </div>


                        <div class="col-12">
                            <p>
                                <strong class="mr-2">phone:</strong>
                                <%= pageContext.getAttribute("user_phone") %>
                            </p>
                        </div>

                        <div class="col-12">
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editProfileModal">
                                Edit profile
                            </button>
                        </div>

                        <div class="col-12 mt-3">
                            <p><strong>vehicles</strong></p>
                            <% ArrayList<ArrayList<String>> vehicles = (ArrayList) pageContext.getAttribute("u_vehicle_list");
                                for (ArrayList<String> vehicle : vehicles) { %>

                            <p>
                            <form class="form-inline" action="${pageContext.request.contextPath}/drive/delete-vehicle-action.jsp" id="vehicle-item">
                                <span><%= vehicle.get(0) %></span>
                                <%= vehicle.get(1) %> &middot;
                                <strong><%= vehicle.get(2) %> seat(s)</strong> &middot;
                                <input type="hidden" name="vehicleid" id="vehicleid" value=<%= vehicle.get(3) %>>
                                <button type="submit" class="btn btn-sm btn-secondary">Delete</button>
                            </form>
                            </p>
                            <% } %>

                            <%--<a href="#">add a vehicle...</a>--%>
                        </div>

                        <div class="col-12">
                            <a href="${pageContext.request.contextPath}/drive/add-vehicle.jsp" class="btn btn-primary">Add vehicle</a>
                            <!--                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addVehicleModal">
                                                            Add a vehicle
                                                        </button> -->
                        </div>


                    </div>
                </div>
            </div>

            <div class="row mt-3">
                <div class="col-12">

                    <h4 class="text-center"><strong>Reviews Received</strong></h4>

                    <% ArrayList<ArrayList<String>> reviews = (ArrayList) pageContext.getAttribute("u_reviews_list");
                        if (reviews.isEmpty()) { %>
                    <p class="text-center">You have no reviews yet.</p>
                    <% } else { %>

                    <div class="mb-2" style="max-height: 300px; overflow: auto;">
                        <table class="table table-sm">
                            <thead>
                            <tr>
                                <th>From</th>
                                <th>Review</th>
                                <th>Rating</th>
                            </tr>
                            </thead>

                            <tbody>
                            <% for (ArrayList<String> review : reviews) { %>
                            <tr>
                                <td>
                                    <a href="${pageContext.request.contextPath}/user?username=<%= review.get(2) %>"><%= review.get(2) %>
                                    </a>
                                </td>
                                <td>
                                    <%= review.get(0) %>
                                </td>
                                <td>
                                    <%= review.get(1) %>
                                </td>
                            </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>

                    <% } %>

                </div>
            </div>


            <!-- Edit Profile Modal -->
            <div class="modal fade" id="editProfileModal" tabindex="-1" role="dialog"
                 aria-labelledby="editProfileModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editProfileModalLabel">Edit Profile</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <%@ include file="/partials/edit-profile-form.jsp" %>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>
</div>

</body>
</html>