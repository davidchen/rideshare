<form method="post" onsubmit="submitReportAndNotify(); return false;" id="report-user-form">

    <div class="form-group">
        <label for="report-reason" class="form-control-label">Report reason:</label>
        <select class="form-control" id="report-reason" name="report-reason" required>
            <option value="" selected disabled>Please select</option>
            <option value="1">General</option>
            <option value="2">Abuse of website</option>
            <option value="3">Spam or inappropriate content</option>
            <option value="4">Toxic behavior</option>
            <option value="5">Theft or hacking</option>
        </select>
    </div>

    <div class="form-group">
        <label for="report-text" class="form-control-label">Message:</label>
        <textarea class="form-control" id="report-text" name="report-text" style="min-height: 150px;" required
                  maxlength="100" placeholder="Report limited to 100 characters!"></textarea>
        <input type="hidden" name="reportedID" value="<%= pageContext.getAttribute("viewing_userid") %>">
        <input type="hidden" name="reporterID" value="<%= session.getAttribute("userid") %>">

    </div>

    <div class="form-group">
        <input type="submit" class="btn btn-primary" value="Send Report">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
    </div>
</form>

<div id="report-user-form-alert" style="display:none">
    <p class="text-danger text-center">Thank you. Your report has been sent.</p>
</div>