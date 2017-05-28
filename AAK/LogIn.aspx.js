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

            LogIn(data);
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

function LogIn(user) {
    if (user.UserGroupCodes.indexOf("office_admin") >= 0 || user.UserGroupCodes.indexOf("office_reader"))
        window.location = appPath + "Desk.aspx";
}