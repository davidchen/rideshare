<form method="post" action="${pageContext.request.contextPath}/login-action.jsp" id="login-form">
    <div class="form-group row">
        <label class="col-form-label col-5" for="username">Username</label>
        <div class="col-7">
            <input type="text" class="form-control" name="username" id="username" maxlength="15"
               pattern="[0-9A-Za-z]+" title="Usernames can contain numbers and letters only." required>
        </div>
    </div>

    <div class="form-group row">
        <label class="col-form-label col-5" for="password">Password</label>
        <div class="col-7">
            <input type="password" class="form-control" name="password" id="password" required>
        </div>
    </div>

    <div class="form-group row">
        <div class="col-12">
            <button type="submit" id="login-submit" class="btn btn-primary btn-block">Login</button>
        </div>
    </div>
</form>