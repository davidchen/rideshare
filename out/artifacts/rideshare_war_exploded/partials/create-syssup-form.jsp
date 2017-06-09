<form method="post" onsubmit="createSyssupAndNotify(); return false;" id="create-syssup-form">

    <div class="form-group">
        <label for="syssup-username" class="form-control-label">Username:</label>
        <input type="text" class="form-control" name="syssup-username" id="syssup-username" required>
    </div>

    <div class="form-group">
        <label for="syssup-password" class="form-control-label">Password:</label>
        <input type="password" class="form-control" name="syssup-password" id="syssup-password" required>
    </div>

    <div class="form-group">
        <label for="syssup-email" class="form-control-label">Email:</label>
        <input type="email" class="form-control" name="syssup-email" id="syssup-email" required>
    </div>

    <div class="form-group">
        <input type="submit" class="btn btn-primary" value="Create System Support User">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
    </div>
</form>

<div id="create-syssup-form-alert" style="display:none">
    <p class="text-success text-center">System support user created. Refresh page to create another one.</p>
</div>