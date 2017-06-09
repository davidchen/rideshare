<form method="post" action="${pageContext.request.contextPath}/message-user-action.jsp" id="compose-message-form">
    <div class="form-group">
        <label for="recipient-input" class="form-control-label">Recipient:</label>
        <input type="text" class="form-control" id="recipient-input" name="recipient-input" required
               placeholder="Recipient's username (make sure username is valid)">
    </div>

    <div class="form-group">

        <label for="message-text" class="form-control-label">Message:</label>
        <textarea class="form-control" id="message-text" name="message" style="min-height: 150px;" required
                  maxlength="100" placeholder="Message limited to 100 characters!"></textarea>
        <input type="hidden" name="senderID" value="<%= session.getAttribute("userid") %>">
    </div>

    <div class="form-group">
        <button type="submit" class="btn btn-primary">Send Message</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
    </div>
</form>