function passwordMatcher() {
    var pass1 = $("#password").val();
    var pass2 = $("#password-confirm").val();

    if (pass1 != pass2) {
        alert("Please make sure the passwords match up.");
        return false;
    }

    return true;
}


function submitMessageAndNotify() {
    var msgUserForm = $('#message-user-form');
    var msgUserFormAlert = $('#message-user-form-alert');
    var formValues = msgUserForm.serialize();

    msgUserForm.hide();
    msgUserFormAlert.show();


    $.ajax({
        type: "POST",
        url: "message-user-action.jsp",
        data: formValues,
        success: function (data) {
            console.log("MESSAGE SENT SUCCESSFULLY.");
        },
        error: function (xhr, ajaxOptions, thrownError) {
            console.log("MESSAGE FAILED TO SEND.");
            console.log(xhr.status);
            console.log(thrownError);
        }
    });
}


function submitReportAndNotify() {
    var reportUserForm = $('#report-user-form');
    var reportUserFormAlert = $('#report-user-form-alert');
    var formValues = reportUserForm.serialize();

    reportUserForm.hide();
    reportUserFormAlert.show();

    $.ajax({
        type: "POST",
        url: "report-user-action.jsp",
        data: formValues,
        success: function (data) {
            console.log("REPORT SENT SUCCESSFULLY.");
        },
        error: function (xhr, ajaxOptions, thrownError) {
            console.log("REPORT FAILED TO SEND.");
            console.log(xhr.status);
            console.log(thrownError);
        }
    });
}

function createSyssupAndNotify() {
    var createSyssupForm = $('#create-syssup-form');
    var createSyssupFormAlert = $('#create-syssup-form-alert');
    var formValues = createSyssupForm.serialize();

    createSyssupForm.hide();
    createSyssupFormAlert.show();

    $.ajax({
        type: "POST",
        url: "create-syssup-action.jsp",
        data: formValues,
        success: function (data) {
            console.log("CREATED SUCCESSFULLY.");
        },
        error: function (xhr, ajaxOptions, thrownError) {
            console.log("FAILED TO CREATE.");
            console.log(xhr.status);
            console.log(thrownError);
        }
    });
}

function resetUserPWAndNotify() {
    var resetUserPWForm = $('#reset-userpw-form');
    var resetUserPWFormAlert = $('#reset-userpw-form-alert');
    var formValues = resetUserPWForm.serialize();

    resetUserPWForm.hide();
    resetUserPWFormAlert.show();

    $.ajax({
        type: "POST",
        url: "reset-userpw-action.jsp",
        data: formValues,
        success: function (data) {
            console.log("RESET SUCCESSFULLY.");
        },
        error: function (xhr, ajaxOptions, thrownError) {
            console.log("FAILED TO RESET.");
            console.log(xhr.status);
            console.log(thrownError);
        }
    });
}

function lockUnlockUserAndNotify() {
    var lockUnlockUserForm = $('#lock-unlock-user-form');
    var lockUnlockUserFormAlert = $('#lock-unlock-user-form-alert');
    var formValues = lockUnlockUserForm.serialize();

    lockUnlockUserForm.hide();
    lockUnlockUserFormAlert.show();

    $.ajax({
        type: "POST",
        url: "lock-unlock-user-action.jsp",
        data: formValues,
        success: function (data) {
            console.log("LOCKED/UNLOCKED SUCCESFULLY.");
        },
        error: function (xhr, ajaxOptions, thrownError) {
            console.log("FAILED TO LOCK/UNLOCK.");
            console.log(xhr.status);
            console.log(thrownError);
        }
    });
}

function queryStats() {
    var queryForm = $('#query-stats');
    var queryResult = $('#query-result');
    var formValues = queryForm.serialize();

    queryResult.val("Querying...");

    $.ajax({
        type: "POST",
        url: "query-stats-action.jsp",
        data: formValues,
        success: function (data) {
            queryResult.val(data);
        },
        error: function (xhr, ajaxOptions, thrownError) {
            queryResult.val("Query failed. Try again please.");
            console.log("FAILED TO QUERY.");
            console.log(xhr.status);
            console.log(thrownError);
        }
    });
}


function reviewUserAndNotify(formNum) {
    var reviewUserForm = $('#review-user-form'+formNum);
    var reviewUserFormAlert = $('#review-user-form-alert'+formNum);
    var formValues = reviewUserForm.serialize();

    reviewUserForm.hide();
    reviewUserFormAlert.show();

    $.ajax({
        type: "POST",
        url: "review-user-action.jsp",
        data: formValues,
        success: function (data) {
            console.log("REVIEWED SUCCESFULLY.");
        },
        error: function (xhr, ajaxOptions, thrownError) {
            console.log("FAILED TO REVIEW.");
            console.log(xhr.status);
            console.log(thrownError);
        }
    });
}
