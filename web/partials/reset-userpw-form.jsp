<form method="post" onsubmit="resetUserPWAndNotify(); return false;" id="reset-userpw-form">

    <div class="form-group">
        <label for="user-uname" class="form-control-label">Username of user:</label>
        <input type="text" class="form-control" name="user-uname" id="user-uname" required>
    </div>

    <div class="form-group">
        <label for="user-new-pw" class="form-control-label">Enter new password:</label>
        <input type="text" class="form-control" name="user-new-pw" id="user-new-pw" required>
    </div>

    <div class="form-group">
        <input type="submit" class="btn btn-primary" value="Submit">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
    </div>
</form>

<div id="reset-userpw-form-alert" style="display:none">
    <p class="text-success text-center">The user's password has been changed. Please refresh this page to reset another password.</p>
</div>