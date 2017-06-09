<%@ include file="/partials/page-imports.jsp" %>
<%@ include file="/partials/login-required.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<% String pageTitleName = "Inbox"; %>
<%@ include file="/partials/head.jsp" %>
<%@ include file="/connections/inbox-conn.jsp" %>


<body>

<div class="container-fluid">
    <div class="row content-row">
        <div class="col-8 offset-2">
            <div class="text-center">
                <h1>Inbox</h1>
                <%@ include file="/partials/global-menu.jsp" %>

                <button type="button" class="btn btn-primary" data-toggle="modal"
                        data-target="#composeMessageModal">Compose a Message
                </button>

            </div>



            <!-- Compose Message Modal -->
            <div class="modal fade" id="composeMessageModal" tabindex="-1" role="dialog"
                 aria-labelledby="composeMessageModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="composeMessageModalLabel">Compose message</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <%@ include file="/partials/compose-message-form.jsp" %>
                        </div>
                    </div>
                </div>
            </div>



        </div>

        <div class="col-12">
            <div class="row mt-3">
                <div class="col-12">

                    <h4 class="text-center"><strong>Messages Received</strong></h4>

                    <% ArrayList<ArrayList<String>> r_msgs = (ArrayList) pageContext.getAttribute("received_msgs_list");
                        if (r_msgs.isEmpty()) { %>
                    <p class="text-center">You have no received messages yet.</p>
                    <% } else { %>

                    <div class="mb-2" style="max-height: 300px; overflow: auto;">
                        <table class="table table-sm" style="max-width: none; word-wrap: break-word; table-layout: fixed;">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>From</th>
                                <th colspan="9">Message</th>
                            </tr>
                            </thead>

                            <tbody>
                            <% for (ArrayList<String> r_msg : r_msgs) { %>
                            <tr>
                                <td><%= r_msg.get(0) %></td>
                                <td><a href="${pageContext.request.contextPath}/user?username=<%= r_msg.get(1) %>"><%= r_msg.get(1) %></a></td>
                                <td colspan="9"><%= r_msg.get(2) %></td>
                            </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>

                    <% } %>

                </div>
            </div>


            <div class="row mt-3">
                <div class="col-12">

                    <h4 class="text-center"><strong>Messages Sent</strong></h4>

                    <% ArrayList<ArrayList<String>> s_msgs = (ArrayList) pageContext.getAttribute("sent_msgs_list");
                        if (s_msgs.isEmpty()) { %>
                    <p class="text-center">You have no received messages yet.</p>
                    <% } else { %>

                    <div class="mb-2" style="max-height: 300px; overflow: auto;">
                        <table class="table table-sm" style="max-width: none; word-wrap: break-word; table-layout: fixed;">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>To</th>
                                <th colspan="9">Message</th>
                            </tr>
                            </thead>

                            <tbody>
                            <% for (ArrayList<String> s_msg : s_msgs) { %>
                            <tr>
                                <td><%= s_msg.get(0) %></td>
                                <td><a href="${pageContext.request.contextPath}/user?username=<%= s_msg.get(1) %>"><%= s_msg.get(1) %></a></td>
                                <td colspan="9"><%= s_msg.get(2) %></td>
                            </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>

                    <% } %>

                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>