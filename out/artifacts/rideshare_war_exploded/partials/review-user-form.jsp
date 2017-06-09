<form method="post" onsubmit="reviewUserAndNotify(<%= reviewButtonID %>); return false;" id="review-user-form<%=reviewButtonID%>">

    <div class="form-group">
        <label for="trip-rating" class="form-control-label">Trip rating:</label>
        <select class="form-control" id="trip-rating" name="trip-rating" required>
            <option value="" selected disabled>Please select</option>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
        </select>
    </div>

    <div class="form-group">
        <label for="review-text" class="form-control-label">Comments:</label>
        <textarea class="form-control" id="review-text" name="review-text" style="min-height: 150px;" maxlength="100" placeholder="Review comment limited to 100 characters!"></textarea>
        <input type="hidden" name="reviewerID" value="<%= session.getAttribute("userid") %>">
        <input type="hidden" name="revieweeID" value="<%= recipientID %>">
        <input type="hidden" name="tripID" value="<%= t.id %>">
        <input type="hidden" name="tripType" value="<%= reviewType %>">
    </div>

    <div class="form-group">
        <input type="checkbox" name="posttofeed" id="posttofeed" value="true">
        <label for="posttofeed">Show this comment publicly (on the global comments board)</label>
    </div>

    <div class="form-group">
        <button type="submit" class="btn btn-primary">Send Review</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
    </div>
</form>


<div id="review-user-form-alert<%=reviewButtonID%>" style="display:none">
    <p class="text-success text-center">Thank you for the review.</p>
</div>