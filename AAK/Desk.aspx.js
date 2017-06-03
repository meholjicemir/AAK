/// <reference path="Scripts/Utilities.js" />

var appPath = window.location.protocol + "//" + window.location.host + "/";
var CurrentUser = null;

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

            CurrentUser = {
                Id: data.Id,
                Email: data.Email
            };

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

    ShowLoaderCenter();
    $.get(appPath + "api/predmet", {
        UserId: CurrentUser.Id,
        Filter: "test"
    })
    .done(function (data) {
        if (data != null && data.length > 0) {

            $(data).each(function (index, _case) {
                if (Date.parse(_case.Iniciran))
                    _case.Iniciran = moment(_case.Iniciran).format("LLL");
                
                if (Date.parse(_case.DatumStanjaPredmeta))
                    _case.DatumStanjaPredmeta = moment(_case.DatumStanjaPredmeta).format("LLL");

                if (Date.parse(_case.DatumArhiviranja))
                    _case.DatumArhiviranja = moment(_case.DatumArhiviranja).format("LLL");

                if (index == data.length - 1) {
                    var _columns = [
                        { field: 'NasBroj', title: 'Naš broj', titleTooltip: 'Naš broj', sortable: true },
                        { field: 'BrojPredmeta', title: 'Broj predmeta', titleTooltip: 'Broj predmeta', sortable: true },
                        { field: 'Sudija', title: 'Sudija', titleTooltip: 'Sudija', sortable: true },
                        { field: 'Iniciran', title: 'Iniciran', titleTooltip: 'Iniciran', sortable: true },
                        { field: 'VrijednostSpora', title: 'Vrijednost spora', titleTooltip: 'Vrijednost spora', sortable: true },
                        { field: 'Kategorija', title: 'Kategorija', titleTooltip: 'Kategorija', sortable: true },
                        { field: 'Uloga', title: 'Uloga', titleTooltip: 'Uloga', sortable: true },
                        { field: 'VrstaPredmeta', title: 'Vrsta predmeta', titleTooltip: 'Vrsta predmeta', sortable: true },
                        { field: 'Uspjeh', title: 'Uspjeh', titleTooltip: 'Uspjeh', sortable: true },
                        { field: 'PravniOsnov', title: 'Pravni osnov', titleTooltip: 'Pravni osnov', sortable: true },
                        { field: 'DatumStanjaPredmeta', title: 'Datum stanja predmeta', titleTooltip: 'Datum stanja predmeta', sortable: true },
                        { field: 'StanjePredmeta', title: 'Stanje predmeta', titleTooltip: 'Stanje predmeta', sortable: true },
                        { field: 'DatumArhiviranja', title: 'Datum arhiviranja', titleTooltip: 'Datum arhiviranja', sortable: true }
                    ];

                    $("#tblCases").bootstrapTable("destroy");
                    $("#tblCases").bootstrapTable({
                        data: data,
                        striped: true,
                        showColumns: true,
                        showRefresh: false,
                        showToggle: true,
                        columns: _columns,
                        search: true
                    });
                    HideLoaderCenter();
                }
            });
        }
        else
            HideLoaderCenter();
    })
    .fail(function (jqXHR, textStatus, errorThrown) {
        HideLoaderCenter();
        alert("error");
    });
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