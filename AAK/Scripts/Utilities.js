var noOfLoadersRunning = 0;
var noOfCenterLoadersRunning = 0;
var alertNo = 0;

var pathInvalidCharCodes = [34, 60, 62, 124, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 58, 42, 63, 92, 47];

function ShowAlert(type, message, noAutoClose, timeout, div) {
    alertNo++;
    var id = "divAlert_" + alertNo.toString();
    var cssClass = "";

    switch (type) {
        case "info":
            cssClass = "alert-info";
            break;
        case "success":
            cssClass = "alert-success";
            break;
        case "warning":
            cssClass = "alert-warning";
            break;
        case "danger":
            cssClass = "alert-danger";
            break;
        default:
            cssClass = "alert-info";
            break;
    }

    var markUp = '<div id="' + id + '" class="alert ' + cssClass + ' fade in" style="display: none;> \
            <a href="#" class="close" aria-label="close" onclick="$(\'#'+ id + '\').hide();">&times;</a> \
            <strong><span>' + message + '</span></strong> \
        </div';

    if (div == undefined)
        $("#divAlertGeneral").append(markUp);
    else
        div.append(markUp);

    if (timeout == undefined || timeout == null)
        timeout = 3000;

    if (noAutoClose == true)
        $("#" + id).fadeTo(timeout, 500);
    else
        $("#" + id).fadeTo(timeout, 500).slideUp(500);

    window.scrollTo(0, 0);
}

function ShowLoader(immediate, div) {
    if (div == undefined || div == null)
        div = $("#divLoading");

    noOfLoadersRunning++;
    if (noOfLoadersRunning == 1) {
        if (immediate)
            div.show();
        else
            div.slideDown(200);
    }
}

function HideLoader(immediate, div) {
    if (div == undefined || div == null)
        div = $("#divLoading");

    noOfLoadersRunning--;
    if (noOfLoadersRunning < 0)
        noOfLoadersRunning = 0;

    if (noOfLoadersRunning == 0) {
        if (immediate)
            div.hide();
        else
            div.slideUp(200);
    }
}

$(window).scroll(function (e) {
    var $el = $('.loading-bar');
    var isPositionFixed = ($el.css('position') == 'fixed');
    if ($(this).scrollTop() > 77 && !isPositionFixed) {
        var loadingBarWidth = $(document).width() * 0.96; // assume 2% padding on each side
        $('.loading-bar').css({ 'position': 'fixed', 'top': '0px' });
        if (loadingBarWidth > 0)
            $('.loading-bar').css('width', loadingBarWidth.toString() + 'px');
    }
    if ($(this).scrollTop() < 77 && isPositionFixed) {
        var loadingBarWidth = $(document).width() * 0.96; // assume 2% padding on each side
        $('.loading-bar').css({ 'position': 'static', 'top': '0px' });
        if (loadingBarWidth > 0)
            $('.loading-bar').css('width', loadingBarWidth.toString() + 'px');
    }
});

function GetQueryStringParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}

function pad(num, size) {
    var s = num + "";
    while (s.length < size) s = "0" + s;
    return s;
}

// Converts Date format to string in format "MM/DD/YYYY HH:mm:ss"
function ConvertDateToUSFormatString(input, dateOnly) {
    var output = "";
    if (dateOnly === true)
        output = pad(input.getMonth() + 1, 2) + "/" + pad(input.getDate(), 2) + "/" + pad(input.getFullYear(), 4);
    else
        output = pad(input.getMonth() + 1, 2) + "/" + pad(input.getDate(), 2) + "/" + pad(input.getFullYear(), 4) + " " + pad(input.getHours(), 2) + ":" + pad(input.getMinutes(), 2) + ":" + pad(input.getSeconds(), 2);
    return output;
}

function ConvertBSDateToUSDateString(input) {
    if (input == null)
        return null;

    var arr = input.split('.');
    return arr[1] + "/" + arr[0] + "/" + arr[2];
}

function ShowPrompt(title, message, yesFunction, noFunction) {
    $("#promptTitle").html(title);
    $("#promptMessage").html(message);

    $("#btnPromptYes").off("click");
    $("#btnPromptNo").off("click");

    $("#btnPromptYes").click(yesFunction);
    $("#btnPromptNo").click(noFunction);

    $("#btnOpenModalPrompt").trigger("click");
}

function SetUserInfo() {
    if ($("#linkLogOut").length > 0) {
        $("#linkLogOut").click(function () {
            LogOut();
        });
    }

    $("#divCurrentUser").slideDown(500);
    $("#btnCurrentUser").html("Welcome, " + CurrentUser.UserName);
}

function LogOut() {
    window.location.href = '../DashBoard/frmLogout.aspx';
}

function GetMoneyFormat(input) {
    if (input == undefined || input == null || input == "")
        return "";

    input = parseFloat(input.toString().replace(/,/g, '.'));

    var moneyFormat = AddThousandsSeparator(parseFloat(Math.round(input * 100) / 100).toFixed(2)) + " KM";
    moneyFormat = moneyFormat.replace(/,/g, '#').replace(/\./g, ',').replace(/#/g, '.');
    return moneyFormat;
}

function AddThousandsSeparator(nStr) {
    nStr += '';
    var x = nStr.split('.');
    var x1 = x[0];
    var x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + ',' + '$2');
    }
    return x1 + x2;
}

function GetCurrentDateUSFormat() {
    var today = new Date();
    var dd = today.getDate();

    var mm = today.getMonth() + 1;
    var yyyy = today.getFullYear();
    if (dd < 10)
        dd = '0' + dd;

    if (mm < 10)
        mm = '0' + mm;

    return mm + '/' + dd + '/' + yyyy;
}


function GetDateUSFormat(input) {
    var dd = input.getDate();

    var mm = input.getMonth() + 1;
    var yyyy = input.getFullYear();
    if (dd < 10)
        dd = '0' + dd;

    if (mm < 10)
        mm = '0' + mm;

    return mm + '/' + dd + '/' + yyyy;
}

function GetDateUSFormatFromJSON(input) {
    return GetDateUSFormat(new Date(parseInt(input.substr(6))));
}

function DateSorterFunction(a, b) {
    if (a == undefined || a == null)
        a = "";
    if (b == undefined || b == null)
        b = "";

    if (a == "" && b == "")
        return 0;
    else if (a == "")
        return -1;
    else if (b == "")
        return 1;
    else {
        var aDate = new Date(a);
        var bDate = new Date(b);
        if (aDate == bDate)
            return 0;
        else if (aDate > bDate)
            return 1;
        else
            return -1;
    }
}

function CreateNewDocument(uploadedFile, fileName, documentNode, caseId, forceOverwrite, callback) {
    if (uploadedFile != null) {
        ShowLoader();

        var formData = new FormData();
        formData.append("UploadedFiles", uploadedFile);
        formData.append("AccessToken", CurrentUser.AccessToken);
        formData.append("NodeForGrid", documentNode.Path.replace(/\\/g, '/'));
        formData.append("FileName", MakeStringValidPath(fileName));
        formData.append("CaseId", caseId);
        formData.append("ForceOverwrite", forceOverwrite);

        $.ajax({
            url: WebAPIURL + "/fileupload",
            type: 'POST',
            data: formData,
            cache: false,
            contentType: false,
            processData: false
        }).done(function (data) {
            if (data) {
                if (data == -1) {
                    ShowAlert("danger", "File name exists, please choose another name.");
                    HideLoader();
                }
                else {
                    data.UserId = CurrentUser.Id;
                    HideLoader();
                    SaveDocumentToDB(data, callback);
                }
            }
            else {
                HideLoader();
                ShowAlert("danger", "Unknown error creating document.");
            }
        })
        .fail(function (response) {
            HideLoader();
            if (response.status == 403) {
                ShowAlert("danger", "Session expired. Please log in again.", true);
                LogOut();
            }
            else
                ShowAlert("danger", "POST request to " + WebAPIURL + "api/fileupload failed.");
        });
    }
}

function MakeStringValidPath(string) {
    for (var i = 0; i < string.length; i++) {
        var indexIfExists = pathInvalidCharCodes.indexOf(string.charCodeAt(i));
        if (indexIfExists >= 0) {
            string = string.replace(String.fromCharCode(pathInvalidCharCodes[indexIfExists]), '');
            i--;
        }
    }

    return string;
}

function ShowLoaderCenter() {
    noOfCenterLoadersRunning++;

    if (noOfCenterLoadersRunning == 1)
        $("body").append('<div class="loader-center"><span class="glyphicon glyphicon-refresh spinning"></span></div>');
}

function HideLoaderCenter() {
    noOfCenterLoadersRunning--;

    if (noOfCenterLoadersRunning == 0)
        $(".loader-center").remove();
}

function GetDataFromMultiselect(dropdownId) {
    var dropdown = $("#" + dropdownId);
    var data = dropdown.val() == null ? "" : dropdown.val().toString();
    return data;
}

function SetupHistoryHandling() {
    $(document).mousedown(function () {
        clearTimeout(window.userInteractionTimeout);
        window.userInteractionInHTMLArea = true;
        window.userInteractionTimeout = setTimeout(function () {
            window.userInteractionInHTMLArea = false;
        }, 500);
    });

    $(document).keydown(function () {
        clearTimeout(window.userInteractionTimeout);
        window.userInteractionInHTMLArea = true;
        window.userInteractionTimeout = setTimeout(function () {
            window.userInteractionInHTMLArea = false;
        }, 500);
    });

    if (window.history && window.history.pushState) {
        $(window).on('popstate', function () {
            //if (!window.userInteractionInHTMLArea) {
            //    alert('Browser Back or Forward button was pressed.');
            //}
            if (window.onBrowserHistoryButtonClicked)
                window.onBrowserHistoryButtonClicked();
        });
    }
}