<%@ include file="/partials/page-imports.jsp" %>
<%@ include file="/partials/login-required.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<% String pageTitleName = ""; %>
<%@ include file="/connections/user-conn.jsp" %>
<%@ include file="/partials/head.jsp" %>


<body>

<div class="container-fluid">
    <div class="row content-row">
        <div class="col-8 offset-2">

            <% if (pageContext.getAttribute("viewing_error") == null) { %>
            <div class="text-center">
                <h1><%= pageContext.getAttribute("viewing_username") %>
                    <% int v_p = (Integer) pageContext.getAttribute("viewing_userperm");
                        if (v_p == 2) { %>
                    [admin] <% } else if (v_p == 1) { %>
                    [sys support] <% } else if (v_p < 0) { %>
                    <span class="text-danger"> [locked]</span> <% } %>
                </h1>
                <p><a href="${pageContext.request.contextPath}/dashboard">return to my dashboard</a></p>
            </div>
            <div class="row mt-5">
                <div class="col-4">
                    <img src="<%= pageContext.getAttribute("viewing_img") %>"
                         style="width: 100%; max-height: 300px; display: block; margin: 0 auto; padding-bottom: 25px;">


                    <button type="button" class="btn btn-primary btn-block" data-toggle="modal"
                            data-target="#messageModal">
                        Message User
                    </button>
                    <button type="button" class="btn btn-primary btn-block" data-toggle="modal"
                            data-target="#reportModal">
                        Report User
                    </button>

                    <!-- Message Modal -->
                    <div class="modal fade" id="messageModal" tabindex="-1" role="dialog"
                         aria-labelledby="messageModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="messageModalLabel">New message
                                        to <%= pageContext.getAttribute("viewing_username") %>
                                    </h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <%@ include file="/partials/message-user-form.jsp" %>
                                </div>
                            </div>
                        </div>
                    </div>


                    <!-- Report Modal -->
                    <div class="modal fade" id="reportModal" tabindex="-1" role="dialog"
                         aria-labelledby="reportModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="reportModalLabel">
                                        Report <%= pageContext.getAttribute("viewing_username") %>
                                    </h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <%@ include file="/partials/report-user-form.jsp" %>
                                </div>
                            </div>
                        </div>
                    </div>


                </div>




                <div class="col-8">

                    <% if ((Integer) session.getAttribute("userpermission") > 0 || (Integer) pageContext.getAttribute("viewing_userprivacy") > 0) { %>

                    <div class="row mt-3">
                        <div class="col-12">
                            <h4 class="text-center"></h4>

                            <% if (pageContext.getAttribute("viewing_useremail") != null) { %>
                            <div class="col-12">
                                <p>
                                    <strong class="mr-2">email:</strong>
                                    <%= pageContext.getAttribute("viewing_useremail") %>
                                </p>
                            </div>
                            <% } %>


                            <%--                         <div class="col-12">
                                                        <p>
                                                            <strong class="mr-2">password:</strong>
                                                            <%= pageContext.getAttribute("user_pass") %>
                                                        </p>

                                                    </div> --%>

                            <% if (pageContext.getAttribute("viewing_userfullname") != null) { %>
                            <div class="col-12">
                                <p>
                                    <strong class="mr-2">name:</strong>
                                    <%=pageContext.getAttribute("viewing_userfullname")%>
                                </p>
                            </div>
                            <% } %>


                            <% if (pageContext.getAttribute("viewing_useraddress") != null) { %>
                            <div class="col-12">
                                <p>
                                    <strong class="mr-2">address:</strong>
                                    <%= pageContext.getAttribute("viewing_useraddress") %>
                                </p>
                            </div>
                            <% } %>

                            <% if (pageContext.getAttribute("viewing_userphone") != null) { %>
                            <div class="col-12">
                                <p>
                                    <strong class="mr-2">phone:</strong>
                                    <%= pageContext.getAttribute("viewing_userphone") %>
                                </p>
                            </div>
                            <% } %>

                        </div>
                    </div>

                    <% } %>

                    <div class="row">
                        <div class="col-12">

                            <h4 class="text-center"><strong>Reviews Received</strong></h4>

                            <%
                                ArrayList<ArrayList<String>> reviews = (ArrayList) pageContext.getAttribute("u_reviews_list");
                                if (reviews.isEmpty()) { %>
                            <p class="text-center">This user has no reviews yet.</p>
                            <% } else { %>

                            <div style="max-height: 300px; overflow: auto;">
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

                    <% if ((Integer) session.getAttribute("userpermission") > 0) { %>

                    <div class="row mt-3">
                        <div class="col-12">
                            <h4 class="text-center"><strong>Reports Received</strong></h4>

                            <% ArrayList<ArrayList<String>> reports = (ArrayList) pageContext.getAttribute("u_reports_list");
                                if (reports.isEmpty()) { %>
                            <p class="text-center">This user has no reports.</p>
                            <% } else { %>

                            <div style="max-height: 300px; overflow: auto;">
                                <table class="table table-sm">
                                    <thead>
                                    <tr>
                                        <th>Reporter</th>
                                        <th>Code</th>
                                        <th>Details</th>
                                    </tr>
                                    </thead>

                                    <tbody>
                                    <% for (ArrayList<String> report : reports) { %>
                                    <tr>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/user?username=<%= report.get(0) %>">
                                                <%= report.get(0) %>
                                            </a>
                                        </td>
                                        <td><%= report.get(1) %>
                                        </td>
                                        <td><%= report.get(2) %>
                                        </td>
                                    </tr>
                                    <% } %>
                                    </tbody>
                                </table>
                            </div>

                            <% } %>

                        </div>
                    </div>

                    <% } %>
                </div>
            </div>

            <% } else { %>
            <div class="text-center">
                <h1>User does not exist.</h1>
                <p><a href="${pageContext.request.contextPath}/dashboard">return to my dashboard</a></p>
            </div>
            <% } %>


        </div>
    </div>
</div>

</body>
</html>