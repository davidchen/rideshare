<form method="post" action="${pageContext.request.contextPath}/edit-profile-action.jsp" id="edit-profile-form">
	
    <div class="form-group">
        <label for="old-password" class="form-control-label">Old password</label>
        <input type="password" class="form-control" id="old-password" name="old-password"
               placeholder="">
    </div>
    
    <div class="form-group">
        <label for="new-password" class="form-control-label">New password</label>
        <input type="password" class="form-control" id="new-password" name="new-password"
               placeholder="">
    </div>
    
    <div class="form-group">
    	<label for="full-name" class="form-control-label">Full name</label>
        <input type="text" class="form-control" id="full-name" name="full-name"
               placeholder="" value="<%= pageContext.getAttribute("user_name") %>">
    </div>
    
    <div class="form-group">
    	<label for="address" class="form-control-label">Address</label>
        <input type="text" class="form-control" id="address" name="address"
               placeholder="" value="<%= pageContext.getAttribute("user_address") %>">
    </div>
    
    <div class="form-group">
    	<label for="phone" class="form-control-label">Phone</label>
        <input type="tel" class="form-control" id="phone" name="phone"
               placeholder="" value="<%= pageContext.getAttribute("user_phone") %>">
    </div>

    <div class="form-group">
        <label for="profpicurl" class="form-control-label">Profile Pic URL</label>
        <input type="tel" class="form-control" id="profpicurl" name="profpicurl"
               placeholder="" value="<%= pageContext.getAttribute("user_img") %>">
    </div>


    <div class="form-group">
    	<input type="hidden" name="privacy" id="privacy" value="hide"/>
    	<input type="checkbox" name="privacy" id="privacy" value="show" <%if ((Integer)pageContext.getAttribute("user_privacysettings")==1) {%> checked <%}%>>
    	<label for="privacy">Show this information publicly</label>
    </div>

    <div class="form-group">
        <button type="submit" class="btn btn-primary">Save Changes</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
    </div>
</form>