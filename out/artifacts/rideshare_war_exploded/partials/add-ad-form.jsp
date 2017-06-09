<form method="post" action="add-ad-action.jsp" id="add-ad-form">

    <div class="form-group">
        <label for="adlink" class="form-control-label">Advertisement Link:</label>
        <input type="url" class="form-control" name="adlink" id="adlink" required placeholder="URL redirect if user clicks on ad (must be valid URL, e.g. begins with http:// etc.)">
    </div>

    <div class="form-group">
        <label for="adimgurl" class="form-control-label">Ad Image URL:</label>
        <input type="url" class="form-control" name="adimgurl" id="adimgurl" required placeholder="URL for ad's image (must be valid URL, e.g. begins with http:// etc.)">
    </div>

    <div class="form-group">
        <label for="adcompany" class="form-control-label">Company:</label>
        <input type="text" class="form-control" name="adcompany" id="adcompany" required placeholder="Ad company's name">
    </div>

    <div class="form-group">
        <label for="adppv" class="form-control-label">Pay Per View Amount:</label>
        <input type="number" step="0.01" maxlength="10" class="form-control" name="adppv" id="adppv" required placeholder="Amount company pays us per ad display on our website">
    </div>

    <div class="form-group">
        <label for="adpercentage" class="form-control-label">Driver Earning Percentage:</label>
        <input type="number" step="0.01" maxlength="10" class="form-control" name="adpercentage" id="adpercentage" required placeholder="Percentage of this ad's revenue split with all drivers">
    </div>

    <div class="form-group">
        <input type="submit" class="btn btn-primary" value="Create Ad">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
    </div>
</form>