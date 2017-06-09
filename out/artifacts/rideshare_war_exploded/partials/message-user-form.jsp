<form method="post" onsubmit="submitMessageAndNotify(); return false;" id="message-user-form">
    <div class="form-group">
        <label for="message-text" class="form-control-label">Message:</label>
        <textarea class="form-control" id="message-text" name="message" style="min-height: 150px;" required
                  maxlength="100" placeholder="Message limited to 100 characters!"></textarea>
        <input type="hidden" name="senderID" value="<%= session.getAttribute("userid") %>">
        <input type="hidden" name="receiverID" value="<%= pageContext.getAttribute("viewing_userid") %>">
    </div>

    <div class="form-group">
        <input type="submit" class="btn btn-primary" value="Send Message">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
    </div>
</form>

<div id="message-user-form-alert" style="display:none">
    <p class="text-success text-center">Thank you. Your message has been sent.</p>
    <p class="text-success text-center">Refresh this page to send another message.</p>
</div>
<%--action="${pageContext.request.contextPath}/message-user-action.jsp"--%>