/// <reference path="Scripts/Utilities.js" />

var appPath = window.location.protocol + "//" + window.location.host + "/";

$(document).ready(function () {
    //$(".g-signin2").click();
    ValidateUser("meholjic.emir@gmail.com");
});

function onSignIn(googleUser) {
    var profile = googleUser.getBasicProfile();
    var email = profile.getEmail();

    ValidateUser(email);
}

function ValidateUser(email) {
    ShowLoaderCenter();

    $.post(appPath + "api/user", {
        Email: email
    })
    .done(function (data) {
        if (data.Id > 0) {
            //document.cookie = 'AccessToken=; expires=Thu, 01 Jan 1970 00:00:01 GMT;';

            //var expiry = new Date();
            //expiry.setTime(expiry.getTime() + (10 * 60 * 1000 * 1008));
            //document.cookie = 'AccessToken=' + data.AccessToken + ';expires=' + expiry.toGMTString() + ';path=/';

            RenderApp(data);
            HideLoaderCenter();
        }
        else {
            HideLoaderCenter();
            ShowAlert("danger", "Prijava nije uspjela. Korisnik nema prava.");
        }
    })
    .fail(function (msg) {
        ShowAlert("danger", "Prijava nije uspjela.");
        HideLoaderCenter();
    });
}

function RenderApp(user) {
    $(".g-signin2").hide(); // Hide Google login button.

    var hasCaseRights = false, hasAdminRights = false;
    // Render appropriate menu items.
    if (user.UserGroupCodes.indexOf("office_admin") >= 0 || user.UserGroupCodes.indexOf("office_reader")) {
        $("#liMenuHome").show();
        $("#liMenuCases").show();
        $("#liMenuParties").show();
        hasCaseRights = true;
    }
    else {
        $("#liMenuHome").hide();
        $("#liMenuCases").hide();
        $("#liMenuParties").hide();
    }

    if (user.UserGroupCodes.indexOf("user_admin") >= 0) {
        $("#liMenuUsers").show();
        hasAdminRights = true;
    }
    else
        $("#liMenuUsers").hide();

    $("#divAll").show();

    if (hasCaseRights)
        MenuHome();
    else if (hasAdminRights)
        MenuUsers();
    else
        ShowAlert("danger", "Korisnik postoji ali nema dodijeljena potrebna prava za korištenje aplikacije.");
}

function MenuHome() {
    $(".menu-item").removeClass("active");
    $("#liMenuHome").addClass("active");
    $(".menu-div").hide();
    $("#divHome").show();
}

function MenuCases() {
    $(".menu-item").removeClass("active");
    $("#liMenuCases").addClass("active");
    $(".menu-div").hide();
    $("#divCases").show();
}

function MenuParties() {
    $(".menu-item").removeClass("active");
    $("#liMenuParties").addClass("active");
    $(".menu-div").hide();
    $("#divParties").show();
}

function MenuUsers() {
    $(".menu-item").removeClass("active");
    $("#liMenuUsers").addClass("active");
    $(".menu-div").hide();
    $("#divUsers").show();
}