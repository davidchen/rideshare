<form method="post" onsubmit="lockUnlockUserAndNotify(); return false;" id="lock-unlock-user-form">

    <div class="form-group">
        <label for="user-uname" class="form-control-label">Username of user:</label>
        <input type="text" class="form-control" name="user-uname" id="user-uname" required>
    </div>

    <div class="form-group">
        <label class="btn btn-primary">
            <input type="radio" name="lockunlock" id="lockuser" value="-1" autocomplete="off">Lock user
        </label>
        <label class="btn btn-primary">
            <input type="radio" name="lockunlock" id="unlockuser" value="0" autocomplete="off" checked>Unlock user
        </label>
    </div>

    <div class="form-group">
        <input type="submit" class="btn btn-primary" value="Submit">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
    </div>
</form>

<div id="lock-unlock-user-form-alert" style="display:none">
    <p class="text-success text-center">The user's lock status has been changed. Please refresh to lock/unlock another user.</p>
</div>