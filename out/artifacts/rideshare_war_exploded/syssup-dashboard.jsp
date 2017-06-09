<%@ include file="/partials/page-imports.jsp" %>
<%@ include file="/partials/login-required.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<% String pageTitleName = "Sys Support Dashboard"; %>
<%@ include file="/partials/head.jsp" %>
<%@ include file="/connections/syssup-conn.jsp" %>

<body>

<div class="container-fluid">
    <div class="row content-row">
        <div class="col-8 offset-2">
            <div class="text-center">
                <h1>Sys Support Dashboard</h1>
                <%@ include file="/partials/global-menu.jsp" %>

                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#resetUserPWModal">
                    Reset user password
                </button>
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#lockUnlockUserModal">
                    Lock/unlock a user
                </button>
            </div>

            <!-- reset user pw modal -->
            <div class="modal fade" id="resetUserPWModal" tabindex="-1" role="dialog"
                 aria-labelledby="resetUserPWModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="resetUserPWModalLabel">
                                Reset a user's password
                            </h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <%@ include file="/partials/reset-userpw-form.jsp" %>
                        </div>
                    </div>
                </div>
            </div>

            <!-- lock/unlock user  modal -->
            <div class="modal fade" id="lockUnlockUserModal" tabindex="-1" role="dialog"
                 aria-labelledby="lockUnlockUserModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="lockUnlockUserModalLabel">
                                Lock or unlock a user
                            </h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <%@ include file="/partials/lock-unlock-user-form.jsp" %>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <div class="col-12">
            <div class="row mt-5">

                <div class="col-12">
                    <h4 class="text-center"><strong>Advertisements</strong></h4>
                </div>



                <div class="col-12">

                    <% ArrayList<ArrayList<String>> ads = (ArrayList) pageContext.getAttribute("ads_list");
                        if (ads.isEmpty()) { %>
                    <p class="text-center">There are no advertisements.</p>
                    <% } else { %>

                    <table class="table table-sm" style="max-width: none; word-wrap: break-word; table-layout: fixed;">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Company</th>
                            <th>Views</th>
                            <th>Revenue</th>
                            <th>PPV</th>
                            <th>Percentage</th>
                            <th>Delete</th>
                        </tr>
                        </thead>

                        <tbody>
                        <% for (ArrayList<String> ad : ads) { %>
                        <tr>
                            <td><%= ad.get(0) %></td>
                            <td><%= ad.get(3) %></td>
                            <td><%= ad.get(4) %></td>
                            <td><%= ad.get(5) %></td>
                            <td><%= ad.get(6) %></td>
                            <td><%= ad.get(7) %></td>
                            <td>
                                <form action="${pageContext.request.contextPath}/delete-ad-action.jsp">
                                    <input type="hidden" name="adID" value="<%= ad.get(0) %>">
                                    <button class="btn btn-primary btn-sm" type="submit">Delete</button>
                                </form>
                            </td>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>

                <% } %>

                </div>


            </div>

            <div class="row">
                <div class="col-12 text-center">
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addAdModal">Add an ad</button>
                </div>
            </div>

            <!-- add an ad modal -->
            <div class="modal fade" id="addAdModal" tabindex="-1" role="dialog"
                 aria-labelledby="addAdModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addAdModalLabel">
                                Add an ad
                            </h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <%@ include file="/partials/add-ad-form.jsp" %>
                        </div>
                    </div>
                </div>
            </div>


        </div>
    </div>


</div>

</body>
</html>