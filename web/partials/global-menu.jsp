<p>
    <%= session.getAttribute("username") %> &middot;
    <a href="${pageContext.request.contextPath}/dashboard">dashboard</a> &middot;
    <a href="${pageContext.request.contextPath}/profile">profile</a> &middot;
    <a href="${pageContext.request.contextPath}/leaderboard">leaderboard</a> &middot;
    <a href="${pageContext.request.contextPath}/inbox">inbox</a> &middot;
    <a href="${pageContext.request.contextPath}/history">trip history</a> &middot;
    <a href="${pageContext.request.contextPath}/logout-action.jsp">logout</a>
</p>
