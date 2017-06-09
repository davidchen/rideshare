<form method="post" onsubmit="queryStats(); return false;" id="query-stats">

    <div class="row">
        <div class="col-12">
            <p class="text-danger">Leave fields blank for wildcards (e.g. leave username input blank to search query from all users)</p>
        </div>
    </div>

    <div class="row">
        <div class="form-group col-4">
            <label class="form-control-label">Username:</label>
            <input type="text" class="form-control" name="query-username" id="query-username" placeholder="Any username">

        </div>

        <div class="form-group col-4">
            <label class="form-control-label">Origin:</label>
            <input type="text" class="form-control" name="query-origin" id="query-origin" placeholder="Any origin">
        </div>

        <div class="form-group col-4">
            <label class="form-control-label">Destination:</label>
            <input type="text" class="form-control" name="query-dest" id="query-dest" placeholder="Any destination">
        </div>
    </div>

    <div class="row">


        <div class="form-group col-4">
            <label class="form-control-label">Day of week:</label>
            <select class="form-control" id="query-day-week" name="query-day-week">
                <option value="" selected>Any day of week</option>
                <option value="Monday">Monday</option>
                <option value="Tuesday">Tuesday</option>
                <option value="Wednesday">Wednesday</option>
                <option value="Thursday">Thursday</option>
                <option value="Friday">Friday</option>
                <option value="Saturday">Saturday</option>
            </select>

        </div>

        <div class="form-group col-4">
            <label class="form-control-label">Month:</label>
            <select class="form-control" id="query-month" name="query-month">
                <option value="" selected>Any month</option>
                <option value="January">January</option>
                <option value="February">February</option>
                <option value="March">March</option>
                <option value="April">April</option>
                <option value="May">May</option>
                <option value="June">June</option>
                <option value="July">July</option>
                <option value="August">August</option>
                <option value="September">September</option>
                <option value="October">October</option>
                <option value="November">November</option>
                <option value="December">December</option>
            </select>
        </div>

        <div class="form-group col-4">
            <label class="form-control-label">Year:</label>
            <input type="number" maxlength="4" min="1900" max="2099" step="1" class="form-control" name="query-year" id="query-year" placeholder="Any year">
        </div>

    </div>

    <div class="row">

        <div class="form-group col-6">
            <label class="form-control-label">Start Date:</label>
            <input type="date" class="form-control" name="query-start-date" id="query-start-date" placeholder="Any date">
        </div>

        <div class="form-group col-6">
            <label class="form-control-label">End Date:</label>
            <input type="date" class="form-control" name="query-end-date" id="query-end-date" placeholder="Any date">
        </div>
    </div>

    <div class="row">
        <div class="form-group col-6">
            <label class="form-control-label">Start Time:</label>
            <input type="time" class="form-control" name="query-start-time" id="query-start-time" placeholder="Any time">
        </div>

        <div class="form-group col-6">
            <label class="form-control-label">End Time:</label>
            <input type="time" class="form-control" name="query-end-time" id="query-end-time" placeholder="Any time">
        </div>
    </div>

    <div class="row">
        <div class="form-group col-2">
            <input type="submit" class="btn btn-primary" value="Query">
        </div>
        <div class="form-group col-12">
            <label class="form-control-label">Result:</label>
            <input type="text" class="form-control" name="query-result" id="query-result" readonly>
        </div>
    </div>

</form>

