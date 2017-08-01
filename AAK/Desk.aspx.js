/// <reference path="Scripts/Utilities.js" />

var AppPath = window.location.href.split('?')[0].toLowerCase().replace("/desk.aspx", "") + "/";
var CurrentUser = null;
var CurrentCodeTable = null;
var Sudovi = null;
var Lica = null;
var Predmeti = null;
var Users = null;
var CaseActivities = null;
var Radnje = null;
var CurrentCase = null;

$(document).ready(function () {
    //$(".g-signin2").click();
    ValidateUser("meholjic.emir@gmail.com");
    //ValidateUser("emir.meholjic@toptal.com");
});

function onSignIn(googleUser) {
    var profile = googleUser.getBasicProfile();
    var email = profile.getEmail();

    ValidateUser(email);
}

function ValidateUser(email) {
    ShowLoaderCenter();

    $.post(AppPath + "api/user", {
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
                Email: data.Email,
                UserGroupCodes: data.UserGroupCodes,
                FirstName: data.FirstName,
                LastName: data.LastName
            };

            RenderApp(data);
            HideLoaderCenter();
        }
        else {
            alert("Prijava nije uspjela. Korisnik nema prava.");
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

    var module = GetQueryStringParameterByName("module");

    var hasCaseRights = false, hasAdminRights = false;
    // Render appropriate menu items.
    if (user.UserGroupCodes.indexOf("office_admin") >= 0 || user.UserGroupCodes.indexOf("office_reader") >= 0) {
        $("#liMenuHome").show();
        $("#liMenuCases").show();
        $("#liMenuParties").show();
        $("#liMenuSudovi").show();
        $("#liMenuCodeTables").show();
        hasCaseRights = true;
    }
    else {
        $("#liMenuHome").hide();
        $("#liMenuCases").hide();
        $("#liMenuSudovi").hide();
        $("#liMenuParties").hide();
        $("#liMenuCodeTables").hide();
    }

    if (user.UserGroupCodes.indexOf("office_admin") == -1)
        $(".only-office-admin").hide();
    else
        $(".only-office-admin").show();

    if (user.UserGroupCodes.indexOf("user_admin") >= 0) {
        $("#liMenuUsers").show();
        hasAdminRights = true;
    }
    else
        $("#liMenuUsers").hide();

    $("#divAll").show();

    if (hasCaseRights) {
        switch ((module || "").toLowerCase()) {
            case "home":
                MenuHome();
                break;
            case "cases":
                MenuCases();
                break;
            case "parties":
                MenuParties();
                break;
            case "courts":
                MenuSudovi();
                break;
            case "users":
                if (hasAdminRights)
                    MenuUsers();
                else
                    MenuHome();
                break;
            default:
                MenuHome();
                break;
        }
    }
    else if (hasAdminRights)
        MenuUsers();
    else
        ShowAlert("danger", "Korisnik postoji ali nema dodijeljena potrebna prava za korištenje aplikacije.");

    $('#dateTimePicker_DatumStanjaPredmeta,#dateTimePicker_DatumArhiviranja,#dateTimePicker_NoteDate,#dateTimePicker_ExpenseDate,#dateTimePicker_Radnja_DatumRadnje,#dateTimePicker_CaseActivity_ActivityDate').datetimepicker({
        format: 'DD.MM.YYYY'
    });

    if (window.innerWidth > 1240)
        $(".modal-admin").css("margin-left", ((window.innerWidth - 1240) / 2).toString() + "px");
}

function MenuHome() {
    DeactivateAllMenuItems();
    $("#liMenuHome").addClass("active");
    $(".menu-div").hide();
    $("#divHome").show();

    LoadCaseActivities();
    LoadRadnje();
}

function LoadRadnje() {
    ShowLoaderCenter();

    var _columns = [
        { field: 'PredmetId' },
        { field: 'Color' },
        { field: 'VrstaRadnjeName_DatumRadnje', title: 'Vrsta radnje / Datum', titleTooltip: 'Vrsta radnje / Datum' },
        { field: 'CaseNasBroj_CaseFullName_Biljeska', title: 'Predmet / Bilješka', titleTooltip: 'Predmet / Bilješka' }
    ];

    $("#tblRadnje").bootstrapTable("destroy");

    var todayDate = new Date(new Date().setHours(0, 0, 0, 0));
    var tomorrowDate = new Date(new Date().setHours(0, 0, 0, 0));
    tomorrowDate.setDate(tomorrowDate.getDate() + 1);

    $.get(AppPath + "api/radnjahome", {
        UserId: CurrentUser.Id,
        Filter: $("#txtRadnjeFilter").val(),
        RowCount: $("#ddlRadnjeRowCount").val()
    })
    .done(function (data) {
        if (data != null && data.length > 0) {
            Radnje = data;
            $(data).each(function (index, _radnja) {

                if (Date.parse(_radnja.DatumRadnje) === Date.parse(tomorrowDate))
                    _radnja.Color = "#00b6ee";
                else if (Date.parse(_radnja.DatumRadnje) === Date.parse(todayDate))
                    _radnja.Color = "#21b04b";
                else
                    _radnja.Color = "white";

                if (Date.parse(_radnja.DatumRadnje))
                    _radnja.DatumRadnje = moment(_radnja.DatumRadnje).format("DD.MM.YYYY");

                _radnja.VrstaRadnjeName_DatumRadnje = "<strong style='text-decoration:underline;'>" + _radnja.VrstaRadnjeName + "</strong><br>" + (_radnja.DatumRadnje || "");
                _radnja.CaseNasBroj_CaseFullName_Biljeska = "<strong>" + _radnja.CaseFullName + "</strong><br><strong style='font-style: italic;'>" + _radnja.Biljeske + "</strong>";

                if (index == data.length - 1) {
                    $("#tblRadnje").bootstrapTable({
                        data: data,
                        columns: _columns,
                        showHeader: true,
                        escape: false,
                        onPostBody: function () {
                            AfterBindRadnje();
                            return false;
                        }
                    });
                    HideLoaderCenter();
                }
            });
        }
        else {
            $("#tblRadnje").bootstrapTable({
                data: [],
                striped: true,
                showColumns: true,
                columns: _columns,
                escape: false
            });
            HideLoaderCenter();
        }
    })
    .fail(function (jqXHR, textStatus, errorThrown) {
        HideLoaderCenter();
        alert("error");
    });
}

function AfterBindRadnje() {
    $("#tblRadnje").find("tr").each(function (index, element) {
        if (index == 0) {
            $(element).css("background-color", "#eee");
            $(element).find("th:first-child").hide();
            $(element).find("th:nth-child(2)").hide();
        }
        else if (Radnje.length > 0) {
            var tempCaseId = parseInt($(element).find("td:first-child").html());
            var tempColor = $(element).find("td:nth-child(2)").html();
            $(element).find("td:first-child").hide();
            $(element).find("td:nth-child(2)").hide();

            switch (tempColor) {
                case "white":
                    break;
                default:
                    $(element).css("background-color", tempColor).css("color", "white");
                    $(element).find("td:nth-child(3)").css("font-weight", "bold");
                    $(element).find("td:nth-child(4)").css("font-weight", "bold");
                    $(element).find("td:nth-child(7)").css("font-weight", "bold");
                    break;
            }

            $(element).dblclick(function () {
                alert("Otvaranje predmeta " + tempCaseId.toString());
            });
        }
    });
}

function LoadCaseActivities() {
    ShowLoaderCenter();

    var _columns = [
        { field: 'Id' },
        { field: 'Color' },
        { field: 'CaseId' },
        { field: 'CaseFullName', title: 'Predmet', titleTooltip: 'Predmet', sortable: false },
        { field: 'ActivityDate', title: 'Za datum', titleTooltip: 'Za datum', sortable: false, sorter: DateSorterFunction },
        { field: 'BrojPredmeta', title: 'Broj predmeta', titleTooltip: 'Broj predmeta', sortable: false, visible: false },
        { field: 'KategorijaPredmeta', title: 'Kategorija', titleTooltip: 'Kategorija', sortable: false },
        { field: 'Note', title: 'Bilješka', titleTooltip: 'Bilješka', sortable: false },
        { field: 'ForAllUsersString', title: 'Vidljivo svima', titleTooltip: 'Vidljivo svima', sortable: false, visible: false }
    ];

    $("#tblCaseActivities").bootstrapTable("destroy");

    var todayDate = new Date(new Date().setHours(0, 0, 0, 0));
    var tomorrowDate = new Date(new Date().setHours(0, 0, 0, 0));
    tomorrowDate.setDate(tomorrowDate.getDate() + 1);

    $.get(AppPath + "api/caseactivity", {
        UserId: CurrentUser.Id,
        Filter: $("#txtCaseActivitiesFilter").val(),
        RowCount: $("#ddlCaseActivitiesRowCount").val()
    })
    .done(function (data) {
        if (data != null && data.length > 0) {
            CaseActivities = data;
            $(data).each(function (index, _caseActivity) {

                _caseActivity.ForAllUsersString = _caseActivity.ForAllUsers === true ? "Da" : "Ne";

                if (Date.parse(_caseActivity.ActivityDate) === Date.parse(tomorrowDate))
                    _caseActivity.Color = "#00b6ee";
                else if (Date.parse(_caseActivity.ActivityDate) === Date.parse(todayDate))
                    _caseActivity.Color = "#21b04b";
                else if (Date.parse(_caseActivity.ActivityDate) < Date.parse(todayDate))
                    _caseActivity.Color = "#ff8888";
                else
                    _caseActivity.Color = "white";

                if (Date.parse(_caseActivity.ActivityDate))
                    _caseActivity.ActivityDate = moment(_caseActivity.ActivityDate).format("DD.MM.YYYY");

                if (index == data.length - 1) {
                    $("#tblCaseActivities").bootstrapTable({
                        data: data,
                        showColumns: true,
                        columns: _columns,
                        escape: false,
                        onPostBody: function () {
                            AfterBindCaseActivities();
                            return false;
                        }
                    });
                    HideLoaderCenter();
                }
            });
        }
        else {
            $("#tblCaseActivities").bootstrapTable({
                data: [],
                striped: true,
                showColumns: true,
                columns: _columns,
                escape: false
            });
            HideLoaderCenter();
        }
    })
    .fail(function (jqXHR, textStatus, errorThrown) {
        HideLoaderCenter();
        alert("error");
    });
}

function AfterBindCaseActivities() {
    $("#tblCaseActivities").find("tr").each(function (index, element) {
        if (index == 0) {
            $(element).css("background-color", "#eee");
            $(element).find("th:first-child").hide();
            $(element).find("th:nth-child(2)").hide();
            $(element).find("th:nth-child(3)").hide();
            if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0)
                if ($("#caseActivitiesEmptyHeader").length == 0)
                    $(element).append("<th id='caseActivitiesEmptyHeader'></th>");
        }
        else if (CaseActivities.length > 0) {
            var tempId = parseInt($(element).find("td:first-child").html());
            var tempColor = $(element).find("td:nth-child(2)").html();
            var tempCaseId = parseInt($(element).find("td:nth-child(3)").html());
            $(element).find("td:first-child").hide();
            $(element).find("td:nth-child(2)").hide();
            $(element).find("td:nth-child(3)").hide();

            switch (tempColor) {
                case "white":
                    break;
                default:
                    $(element).css("background-color", tempColor).css("color", "white");
                    $(element).find("td:nth-child(3)").css("font-weight", "bold");
                    $(element).find("td:nth-child(4)").css("font-weight", "bold");
                    $(element).find("td:nth-child(7)").css("font-weight", "bold");
                    break;
            }

            if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0) {
                var buttonsHTML = "<td style='width: 50px;'><div class='btn-group pull-right'>";
                buttonsHTML +=
                            "<button class='btn btn-default btn-sm custom-table-button-check' data-toggle='tooltip' title='Završeno / Izbriši' onclick='DeleteCaseActivity(" + tempId.toString() + "); return false;'>"
                            + "<span class='glyphicon glyphicon-ok'></span>"
                            + "</button>";
                buttonsHTML += "</div></td>"

                $(element).append(buttonsHTML);
            }

            $(element).dblclick(function () {
                alert("Otvaranje predmeta " + tempCaseId.toString());
            });
        }
    });
}

function DeleteCaseActivity(id) {
    $(CaseActivities).each(function (index, obj) {
        if (obj.Id == id) {
            ShowPrompt(
                "Da li ste sigurni da želite izbrisati stavku pozvanih predmeta?",
                "Ovo znači da se više neće pokazivati te da je navedeni zadatak završen.",
                function () {
                    ShowLoaderCenter();
                    $.ajax({
                        url: AppPath + "api/caseactivity?Id=" + id.toString(),
                        type: "DELETE",
                        success: function () {
                            LoadCaseActivities();
                            HideLoaderCenter();
                            ShowAlert("success", "Uspješno izbrisano.");
                        },
                        error: function () {
                            HideLoaderCenter();
                            ShowAlert("danger", "Greška pri brisanju stavke pozvanih predmeta.");
                        }
                    });
                },
                function () { }
            );

            return false; // break loop
        }
    });
}

function MenuCases() {
    DeactivateAllMenuItems();
    $("#liMenuCases").addClass("active");
    $(".menu-div").hide();
    $("#divCases").show();

    // Load code table data
    LoadCodeTableData("KategorijePredmeta", $("#ddlCase_Kategorija"));
    LoadCodeTableData("Sudovi", $("#ddlCase_Sud"), "Sud");
    LoadCodeTableData("Sudije", $("#ddlCase_Sudija"));
    LoadCodeTableData("Uloge", $("#ddlCase_Uloga"));
    LoadCodeTableData("Uloge", $("#ddlCase_UlogaLica"));
    LoadCodeTableData("VrstePredmeta", $("#ddlCase_VrstaPredmeta"));
    //LoadCodeTableData("StanjaPredmeta", $("#ddlCase_StanjePredmeta"));
    LoadCodeTableData("vLica", $("#ddlCase_Lice"), "Naziv");
    LoadCodeTableData("NaciniOkoncanja", $("#ddlCase_NacinOkoncanja"));
    LoadCodeTableData("VrsteTroskova", $("#ddlCase_ExpenseVrstaTroska"));
    LoadCodeTableData("VrsteRadnji", $("#ddlCase_Radnja_VrstaRadnje"));

    SetUpStanjeAutocomplete();

    for (var i = 0; i <= 100; i++)
        $("#ddlCase_Uspjeh").append($("<option " + (i == 0 ? "selected='selected'" : "") + "></option>").attr("value", i.toString() + '%').text(i.toString() + '%'));

    LoadCases();
}

function LoadCases() {
    ShowLoaderCenter();

    var _columns = [
        { field: 'Id' },
        { field: 'NasBroj', title: 'Naš broj', titleTooltip: 'Naš broj', sortable: true },
        { field: 'StrankaNasa', title: 'Naša stranka', titleTooltip: 'Naša stranka', sortable: true },
        { field: 'StrankaProtivna', title: 'Protivna stranka', titleTooltip: 'Protivna stranka', sortable: true },
        { field: 'VrstaPredmetaName', title: 'Vrsta predmeta', titleTooltip: 'Vrsta predmeta', sortable: true },
        { field: 'BrojPredmeta', title: 'Broj predmeta', titleTooltip: 'Broj predmeta', sortable: true },
        { field: 'SudName', title: 'Sud', titleTooltip: 'Sud', sortable: true },
        { field: 'StanjePredmetaName', title: 'Stanje predmeta', titleTooltip: 'Stanje predmeta', sortable: true },
        { field: 'DatumStanjaPredmeta', title: 'Datum stanja', titleTooltip: 'Datum stanja', sortable: true, sorter: DateSorterFunction, visible: false },
        { field: 'KategorijaPredmetaName', title: 'Kategorija', titleTooltip: 'Kategorija', sortable: true },

        { field: 'SudijaName', title: 'Sudija', titleTooltip: 'Sudija', sortable: true, visible: false },
        { field: 'Iniciran', title: 'Iniciran', titleTooltip: 'Iniciran', sortable: true, sorter: DateSorterFunction, visible: false },
        { field: 'VrijednostSporaString', title: 'Vrijednost spora', titleTooltip: 'Vrijednost spora', sortable: true, align: "right", visible: false },
        { field: 'UlogaName', title: 'Uloga', titleTooltip: 'Uloga', sortable: true, visible: false },
        { field: 'PrivremeniZastupnici', title: 'Pr. zast.', titleTooltip: 'Privremeni zastupnici', sortable: true, visible: false },
        { field: 'PravniOsnov', title: 'Pravni osnov', titleTooltip: 'Pravni osnov', sortable: true, visible: false },

        { field: 'NacinOkoncanjaName', title: 'Način okončanja', titleTooltip: 'Način okončanja', sortable: true, visible: false },
        { field: 'Uspjeh', title: 'Uspjeh', titleTooltip: 'Uspjeh', sortable: true, visible: false },
        { field: 'DatumArhiviranja', title: 'Datum arhiviranja', titleTooltip: 'Datum arhiviranja', sortable: true, sorter: DateSorterFunction, visible: false },
        { field: 'BrojArhiveTotal', title: 'Br. arh/reg', titleTooltip: 'Broj u arhivi / registrator', sortable: true, visible: false }
    ];

    $("#tblCases").bootstrapTable("destroy");

    $.get(AppPath + "api/predmet", {
        UserId: CurrentUser.Id,
        Filter: $("#txtCasesFilter").val(),
        FilterNasBroj: $("#txtCasesFilterNasBroj").val(),
        RowCount: $("#ddlCasesRowCount").val()
    })
    .done(function (data) {
        if (data != null && data.length > 0) {
            Predmeti = data;
            $(data).each(function (index, _case) {
                if (Date.parse(_case.Iniciran))
                    _case.Iniciran = moment(_case.Iniciran).format("DD.MM.YYYY");

                if (Date.parse(_case.DatumStanjaPredmeta))
                    _case.DatumStanjaPredmeta = moment(_case.DatumStanjaPredmeta).format("DD.MM.YYYY");

                if (Date.parse(_case.DatumArhiviranja))
                    _case.DatumArhiviranja = moment(_case.DatumArhiviranja).format("DD.MM.YYYY");

                if (_case.VrijednostSpora != null)
                    _case.VrijednostSporaString = _case.VrijednostSpora.toFixed(2);

                _case.PrivremeniZastupnici = _case.PrivremeniZastupnici ? "Da" : "Ne";

                switch (_case.KategorijaPredmetaId) {
                    case 5:
                        // OTVOREN
                        _case.KategorijaPredmetaName = "<span style='color: #00b6ee; font-weight: bold;'>" + _case.KategorijaPredmetaName + "</span>";
                        break;
                    case 7:
                        // ARHIVIRAN
                        _case.KategorijaPredmetaName = "<span style='color: #ff8888; font-weight: bold;'>" + _case.KategorijaPredmetaName + "</span>";
                        break;
                    case 9:
                        //PO ŽALBI/PRIGOVORU
                        _case.KategorijaPredmetaName = "<span style='color: #21b04b; font-weight: bold;'>" + _case.KategorijaPredmetaName + "</span>";
                        break;
                    default:
                        _case.KategorijaPredmetaName = "<span style='color: black; font-weight: bold;'>" + _case.KategorijaPredmetaName + "</span>";
                        break;
                }

                if (index == data.length - 1) {
                    $("#tblCases").bootstrapTable({
                        data: data,
                        striped: true,
                        showColumns: true,
                        columns: _columns,
                        escape: false,
                        onPostBody: function () {
                            AfterBindCases();
                            return false;
                        }
                    });
                    HideLoaderCenter();
                }
            });
        }
        else {
            $("#tblCases").bootstrapTable({
                data: [],
                striped: true,
                showColumns: true,
                columns: _columns,
                escape: false
            });
            HideLoaderCenter();
        }
    })
    .fail(function (jqXHR, textStatus, errorThrown) {
        HideLoaderCenter();
        alert("error");
    });
}

function AfterBindCases() {
    $("#tblCases").find("tr").each(function (index, element) {
        if (index == 0) {
            $(element).find("th:first-child").hide();
            if ($("#casesEmptyHeader").length == 0)
                $(element).append("<th id='casesEmptyHeader'></th>");
        }
        else {
            var tempId = parseInt($(element).find("td:first-child").html());
            $(element).find("td:first-child").hide();


            var buttonsHTML = "<td style='width: 50px;'><div class='btn-group pull-right'>";
            buttonsHTML +=
                        "<button class='btn btn-default btn-sm custom-table-button-edit' data-toggle='tooltip' title='Pregledaj / izmijeni podatke o predmetu' onclick='EditCase(" + tempId.toString() + "); return false;'>"
                        + "<span class='glyphicon glyphicon-pencil'></span>"
                        + "</button>";

            //if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0) {
            //    buttonsHTML +=
            //                "<button class='btn btn-default btn-sm custom-table-button-delete' data-toggle='tooltip' title='Izbriši predmet' onclick='DeleteCase(" + tempId.toString() + "); return false;'>"
            //                + "<span class='glyphicon glyphicon-remove'></span>"
            //                + "</button>";
            //    buttonsHTML += "</div></td>"
            //}

            $(element).dblclick(function () {
                EditCase(tempId);
            });

            $(element).append(buttonsHTML);
        }
    });
}

function MenuParties() {
    DeactivateAllMenuItems();
    $("#liMenuParties").addClass("active");
    $(".menu-div").hide();
    $("#divParties").show();

    // Load code table data
    LoadCodeTableData("Drzave", $("#ddlParty_Drzava"));

    LoadParties();
}

function LoadParties() {
    ShowLoaderCenter();

    var _columns = [
        { field: 'Id' },
        { field: 'Naziv', title: 'Ime / Naziv', titleTooltip: 'Ime / Naziv', sortable: true },
        { field: 'Ime', title: 'Ime', titleTooltip: 'Ime', sortable: true, visible: false },
        { field: 'Prezime', title: 'Prezime', titleTooltip: 'Prezime', sortable: true, visible: false },
        { field: 'PravnoLice', title: 'Pravno lice', titleTooltip: 'Pravno lice', sortable: true, visible: false },
        { field: 'Adresa', title: 'Adresa', titleTooltip: 'Adresa', sortable: true },
        { field: 'Grad', title: 'Grad', titleTooltip: 'Grad', sortable: true },
        { field: 'PostanskiBroj', title: 'Poštanski broj', titleTooltip: 'Poštanski broj', sortable: true, align: "right", visible: false },
        { field: 'DrzavaName', title: 'Država', titleTooltip: 'Država', sortable: true, visible: false },
        { field: 'Telefon', title: 'Telefon', titleTooltip: 'Telefon', sortable: true },
        { field: 'Fax', title: 'Fax', titleTooltip: 'Fax', sortable: true },
        { field: 'Email', title: 'Email', titleTooltip: 'Email', sortable: true },

        { field: 'IsMinorString', title: 'Malodobno lice', titleTooltip: 'Malodobno lice', sortable: true, visible: false },
        { field: 'ZakonskiZastupnik', title: 'Zakonski zastupnik', titleTooltip: 'Zakonski zastupnik', sortable: true, visible: false },

        { field: 'JMBG_IDBroj', title: 'JMBG / ID broj', titleTooltip: 'JMBG / ID broj', sortable: true, visible: false },
        { field: 'CreatedByName', title: 'Kreirao/la', titleTooltip: 'Kreirao/la', sortable: true, visible: false },
        { field: 'Created', title: 'Datum kreiranja', titleTooltip: 'Datum kreiranja', sortable: true, sorter: DateSorterFunction, visible: false },
        { field: 'ModifiedByName', title: 'Izmijenio/la', titleTooltip: 'Izmijenio/la', sortable: true, visible: false },
        { field: 'Modified', title: 'Datum zadnje izmjene', titleTooltip: 'Datum zadnje izmjene', sortable: true, sorter: DateSorterFunction, visible: false }
    ];
    $("#tblParties").bootstrapTable("destroy");

    $.get(AppPath + "api/lice", {
        UserId: CurrentUser.Id,
        Filter: $("#txtPartiesFilter").val(),
        RowCount: $("#ddlPartiesRowCount").val()
    })
    .done(function (data) {
        if (data != null && data.length > 0) {
            Lica = data;
            $(data).each(function (index, _party) {
                if (Date.parse(_party.Created))
                    _party.Created = moment(_party.Created).format("DD.MM.YYYY");

                if (Date.parse(_party.Modified))
                    _party.Modified = moment(_party.Modified).format("DD.MM.YYYY");

                _party.IsMinorString = _party.IsMinor ? "Da" : "Ne";

                if (index == data.length - 1) {
                    $("#tblParties").bootstrapTable({
                        data: data,
                        striped: true,
                        showColumns: true,
                        columns: _columns,
                        onPostBody: function () {
                            AfterBindParties();
                            return false;
                        }
                    });
                    HideLoaderCenter();
                }
            });
        }
        else {
            $("#tblParties").bootstrapTable({
                data: [],
                striped: true,
                showColumns: true,
                columns: _columns,
            });
            HideLoaderCenter();
        }
    })
    .fail(function (jqXHR, textStatus, errorThrown) {
        HideLoaderCenter();
        alert("error");
    });
}

function AfterBindParties() {
    $("#tblParties").find("tr").each(function (index, element) {
        if (index == 0) {
            $(element).find("th:first-child").hide();
            if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0)
                if ($("#partiesEmptyHeader").length == 0)
                    $(element).append("<th id='partiesEmptyHeader'></th>");
        }
        else {
            var tempId = parseInt($(element).find("td:first-child").html());
            $(element).find("td:first-child").hide();

            if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0) {
                var buttonsHTML = "<td style='width: 100px;'><div class='btn-group pull-right'>";
                buttonsHTML +=
                            "<button class='btn btn-default btn-sm custom-table-button-edit' data-toggle='tooltip' title='Izmijeni podatke o stranci' onclick='EditParty(" + tempId.toString() + "); return false;'>"
                            + "<span class='glyphicon glyphicon-pencil'></span>"
                            + "</button>";

                buttonsHTML +=
                            "<button class='btn btn-default btn-sm custom-table-button-delete' data-toggle='tooltip' title='Izbriši stranku' onclick='DeleteParty(" + tempId.toString() + "); return false;'>"
                            + "<span class='glyphicon glyphicon-remove'></span>"
                            + "</button>";
                buttonsHTML += "</div></td>"

                $(element).append(buttonsHTML);
            }
        }
    });
}

function MenuUsers() {
    DeactivateAllMenuItems();
    $("#liMenuUsers").addClass("active");
    $(".menu-div").hide();
    $("#divUsers").show();

    LoadUserGroups();

    LoadUsers();
}

function LoadUsers() {
    ShowLoaderCenter();

    var _columns = [
        { field: 'Id' },
        { field: 'Email', title: 'Email adresa', titleTooltip: 'Email adresa', sortable: true },
        { field: 'FirstName', title: 'Ime', titleTooltip: 'Ime', sortable: true },
        { field: 'LastName', title: 'Prezime', titleTooltip: 'Prezime', sortable: true },
        { field: 'Phone', title: 'Telefon', titleTooltip: 'Telefon', sortable: true },
        { field: 'UserGroupNames', title: 'Korisničke grupe', titleTooltip: 'Korisničke grupe', sortable: true },
        { field: 'GoogleDriveLocalFolderPath', title: 'Google Drive direktorij', titleTooltip: 'Google Drive direktorij (lokalna putanja)', sortable: true }
    ];

    $("#tblUsers").bootstrapTable("destroy");

    $.get(AppPath + "api/user", {
        UserId: CurrentUser.Id
    })
    .done(function (data) {
        if (data != null && data.length > 0) {
            Users = data;
            $("#tblUsers").bootstrapTable({
                data: data,
                striped: true,
                columns: _columns,
                search: true,
                onPostBody: function () {
                    AfterBindUsers();
                    return false;
                }
            });
            HideLoaderCenter();
        }
        else {
            $("#tblUsers").bootstrapTable({
                data: [],
                striped: true,
                columns: _columns,
                search: true
            });
            HideLoaderCenter();
        }
    })
    .fail(function (jqXHR, textStatus, errorThrown) {
        HideLoaderCenter();
        alert("error");
    });
}

function AfterBindUsers() {
    $("#tblUsers").find("tr").each(function (index, element) {
        if (index == 0) {
            $(element).find("th:first-child").hide();
            if (CurrentUser.UserGroupCodes.indexOf("user_admin") >= 0)
                if ($("#usersEmptyHeader").length == 0)
                    $(element).append("<th id='usersEmptyHeader'></th>");
        }
        else {
            var tempId = parseInt($(element).find("td:first-child").html());
            $(element).find("td:first-child").hide();

            if (CurrentUser.UserGroupCodes.indexOf("user_admin") >= 0) {
                var buttonsHTML = "<td style='width: 100px;'><div class='btn-group pull-right'>";
                buttonsHTML +=
                            "<button class='btn btn-default btn-sm custom-table-button-edit' data-toggle='tooltip' title='Izmijeni korisnika' onclick='EditUser(" + tempId.toString() + "); return false;'>"
                            + "<span class='glyphicon glyphicon-pencil'></span>"
                            + "</button>";

                buttonsHTML +=
                            "<button class='btn btn-default btn-sm custom-table-button-delete' data-toggle='tooltip' title='Izbriši korisnika' onclick='DeleteUser(" + tempId.toString() + "); return false;'>"
                            + "<span class='glyphicon glyphicon-remove'></span>"
                            + "</button>";
                buttonsHTML += "</div></td>"

                $(element).append(buttonsHTML);
            }
        }
    });
}

function EditUser(id) {
    $("#modalUser").attr("edit_id", id);

    $(Users).each(function (index, obj) {
        if (obj.Id == id) {
            $("#txtUser_Email").val(obj.Email);
            $("#txtUser_FirstName").val(obj.FirstName);
            $("#txtUser_LastName").val(obj.LastName);
            $("#txtUser_Phone").val(obj.Phone);
            $("#ddlUser_UserGroups").val("");
            $("#txtUser_GoogleDriveLocalFolderPath").val(obj.GoogleDriveLocalFolderPath);

            if (obj.UserGroupCodes.indexOf(',') != -1) {
                var userGroupCodes = obj.UserGroupCodes.split(',');
                for (var i in userGroupCodes)
                    $("#ddlUser_UserGroups").find("option[value='" + userGroupCodes[i] + "']").prop("selected", "selected");
            }
            else
                $("#ddlUser_UserGroups").find("option[value='" + obj.UserGroupCodes + "']").prop("selected", "selected");

            $("#ddlUser_UserGroups").multiselect('refresh');

            $("#modalUser").find(".modal-title").html("Izmijeni korisnika: <span style='font-style: italic; color: gray;'>" + obj.FirstName + " " + obj.LastName + "</span>");
            $("#btnOpenModalEditUser").click();

            return false; // break loop
        }
    });
}

function DeleteUser(id) {
    $(Users).each(function (index, obj) {
        if (obj.Id == id) {
            ShowPrompt(
                "Da li ste sigurni da želite izbrisati korisnika?",
                "<span style='font-style: italic; color: gray;'>" + obj.FirstName + " " + obj.LastName + "</span>",
                function () {
                    ShowLoaderCenter();
                    $.ajax({
                        url: AppPath + "api/user?Id=" + id.toString(),
                        type: "DELETE",
                        success: function () {
                            LoadUsers();
                            HideLoaderCenter();
                            ShowAlert("success", "Uspješno izbrisan korisnik.");
                        },
                        error: function () {
                            HideLoaderCenter();
                            ShowAlert("danger", "Greška pri brisanju korisnika.");
                        }
                    });
                },
                function () { }
            );

            return false; // break loop
        }
    });
}

function MenuSudovi() {
    DeactivateAllMenuItems();
    $("#liMenuSudovi").addClass("active");
    $(".menu-div").hide();
    $("#divSudovi").show();

    LoadSudovi();
}

function LoadSudovi() {
    ShowLoaderCenter();

    var _columns = [
        { field: 'Id' },
        { field: 'Naziv', title: 'Naziv', titleTooltip: 'Naziv', sortable: true },
        { field: 'Adresa', title: 'Adresa', titleTooltip: 'Adresa', sortable: true },
        { field: 'PostanskiBroj', title: 'Poštanski broj', titleTooltip: 'Poštanski broj', sortable: true, align: "right" },
        { field: 'Grad', title: 'Grad', titleTooltip: 'Grad', sortable: true },
        { field: 'Telefon', title: 'Telefon', titleTooltip: 'Telefon', sortable: true },
        { field: 'Fax', title: 'Fax', titleTooltip: 'Fax', sortable: true },
        { field: 'RacunTakse', title: 'Račun takse', titleTooltip: 'Račun takse', sortable: true },
        { field: 'RacunVjestacenja', title: 'Račun vještačenja', titleTooltip: 'Račun vještačenja', sortable: true },
        { field: 'CreatedByName', title: 'Kreirao/la', titleTooltip: 'Kreirao/la', sortable: true, visible: false },
        { field: 'Created', title: 'Datum kreiranja', titleTooltip: 'Datum kreiranja', sortable: true, visible: false, sorter: DateSorterFunction },
        { field: 'ModifiedByName', title: 'Izmijenio/la', titleTooltip: 'Izmijenio/la', sortable: true, visible: false },
        { field: 'Modified', title: 'Datum zadnje izmjene', titleTooltip: 'Datum zadnje izmjene', sortable: true, visible: false, sorter: DateSorterFunction }
    ];

    $("#tblSudovi").bootstrapTable("destroy");

    $.get(AppPath + "api/sud", {
        UserId: CurrentUser.Id
    })
    .done(function (data) {
        if (data != null && data.length > 0) {
            Sudovi = data;
            $(data).each(function (index, _sud) {

                if (Date.parse(_sud.Created))
                    _sud.Created = moment(_sud.Created).format("DD.MM.YYYY");

                if (Date.parse(_sud.Modified))
                    _sud.Modified = moment(_sud.Modified).format("DD.MM.YYYY");

                if (index == data.length - 1) {
                    $("#tblSudovi").bootstrapTable({
                        data: data,
                        striped: true,
                        showColumns: true,
                        columns: _columns,
                        search: true,
                        onPostBody: function () {
                            AfterBindSudovi();
                            return false;
                        }
                    });
                    HideLoaderCenter();
                }
            });
        }
        else {
            $("#tblSudovi").bootstrapTable({
                data: [],
                striped: true,
                showColumns: true,
                columns: _columns,
                search: true
            });
            HideLoaderCenter();
        }
    })
    .fail(function (jqXHR, textStatus, errorThrown) {
        HideLoaderCenter();
        alert("error");
    });
}

function AfterBindSudovi() {
    $("#tblSudovi").find("tr").each(function (index, element) {
        if (index == 0) {
            $(element).find("th:first-child").hide();
            if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0)
                if ($("#sudoviEmptyHeader").length == 0)
                    $(element).append("<th id='sudoviEmptyHeader'></th>");
        }
        else {
            var tempId = parseInt($(element).find("td:first-child").html());
            $(element).find("td:first-child").hide();

            if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0) {
                var buttonsHTML = "<td style='width: 100px;'><div class='btn-group pull-right'>";
                buttonsHTML +=
                            "<button class='btn btn-default btn-sm custom-table-button-edit' data-toggle='tooltip' title='Izmijeni podatke o sudu' onclick='EditSud(" + tempId.toString() + "); return false;'>"
                            + "<span class='glyphicon glyphicon-pencil'></span>"
                            + "</button>";

                buttonsHTML +=
                            "<button class='btn btn-default btn-sm custom-table-button-delete' data-toggle='tooltip' title='Izbriši sud' onclick='DeleteSud(" + tempId.toString() + "); return false;'>"
                            + "<span class='glyphicon glyphicon-remove'></span>"
                            + "</button>";
                buttonsHTML += "</div></td>"

                $(element).append(buttonsHTML);
            }
        }
    });
}

function EditSud(id) {
    $("#modalSud").attr("edit_id", id);

    $(Sudovi).each(function (index, obj) {
        if (obj.Id == id) {
            $("#txtSud_Naziv").val(obj.Naziv);
            $("#txtSud_Adresa").val(obj.Adresa);
            $("#txtSud_PostanskiBroj").val(obj.PostanskiBroj);
            $("#txtSud_Grad").val(obj.Grad);
            $("#txtSud_Telefon").val(obj.Telefon);
            $("#txtSud_Fax").val(obj.Fax);
            $("#txtSud_RacunTakse").val(obj.RacunTakse);
            $("#txtSud_RacunVjestacenja").val(obj.RacunVjestacenja);

            $("#modalSud").find(".modal-title").html("Izmijeni sud: <span style='font-style: italic; color: gray;'>" + obj.Naziv + "</span>");
            $("#btnOpenModalEditSud").click();

            return false; // break loop
        }
    });
}

function DeleteSud(id) {
    $(Sudovi).each(function (index, obj) {
        if (obj.Id == id) {
            ShowPrompt(
                "Da li ste sigurni da želite izbrisati sud?",
                "<span style='font-style: italic; color: gray;'>" + obj.Naziv + "</span>",
                function () {
                    ShowLoaderCenter();
                    $.ajax({
                        url: AppPath + "api/sud?Id=" + id.toString(),
                        type: "DELETE",
                        success: function () {
                            LoadSudovi();
                            HideLoaderCenter();
                            ShowAlert("success", "Uspješno izbrisan sud.");
                        },
                        error: function () {
                            HideLoaderCenter();
                            ShowAlert("danger", "Greška pri brisanju suda.");
                        }
                    });
                },
                function () { }
            );

            return false; // break loop
        }
    });
}

function DeactivateAllMenuItems() {
    $(".menu-item").removeClass("active");
    $(".menu-sub-item").css("background-color", "");
}

function SaveCaseActivity() {
    if ($("#txtCase_CaseActivity_Note").val() != "" && $("#txtCase_CaseActivity_ActivityDate").val() != "") {
        ShowLoaderCenter();
        $.post(AppPath + "api/caseactivity", {
            CaseId: CurrentCase.Id,
            Note: $("#txtCase_CaseActivity_Note").val(),
            ActivityDate: ConvertBSDateToUSDateString($("#txtCase_CaseActivity_ActivityDate").val()),
            ForAllUsers: $("#cbCase_CaseActivity_ForAllUsers").prop("checked"),
            CreatedBy: CurrentUser.Id
        })
        .done(function (data) {
            if (data && data > 0)
                HideLoaderCenter();
            else {
                HideLoaderCenter();
                ShowAlert("danger", "Greška pri spašavanju pozivanja predmeta.");
            }
        })
        .fail(function (response) {
            HideLoaderCenter();
            ShowAlert("danger", "Greška pri spašavanju pozivanja predmeta.");
        });
    }
}

function SaveCase() {
    ShowLoaderCenter();

    var reqObj = {
        CreatedBy: CurrentUser.Id,
        KategorijaPredmetaId: $("#ddlCase_Kategorija").val(),
        UlogaId: $("#ddlCase_Uloga").val(),
        PrivremeniZastupnici: $("#cbCase_PrivremeniZastupnici").prop("checked"),
        BrojPredmeta: $("#txtCase_BrojPredmeta").val(),
        SudId: $("#ddlCase_Sud").val(),
        SudijaId: $("#ddlCase_Sudija").val(),
        VrijednostSpora: $("#txtCase_VrijednostSpora").val(),
        VrstaPredmetaId: $("#ddlCase_VrstaPredmeta").val(),
        DatumStanjaPredmeta: ConvertBSDateToUSDateString($("#txtCase_DatumStanjaPredmeta").val()),
        //StanjePredmetaId: $("#ddlCase_StanjePredmeta").val(),
        StanjePredmetaName: $("#txtCase_StanjePredmeta").val(),

        NacinOkoncanjaId: $("#ddlCase_NacinOkoncanja").val(),
        Uspjeh: $("#ddlCase_Uspjeh").val(),
        DatumArhiviranja: ConvertBSDateToUSDateString($("#txtCase_DatumArhiviranja").val()),
        BrojArhive: $("#txtCase_BrojArhive").val(),
        BrojArhiveRegistrator: $("#txtCase_BrojArhiveRegistrator").val(),

        PravniOsnov: $("#txtCase_PravniOsnov").val(),

        Parties: CurrentCase.Parties,
        Notes: CurrentCase.Notes,
        Expenses: CurrentCase.Expenses,
        Radnje: CurrentCase.Radnje
    };

    var tempId = $("#modalCase").attr("edit_id");

    if (tempId != undefined) {
        reqObj.Id = tempId;
        reqObj.ModifiedBy = CurrentUser.Id;
    }

    $.post(AppPath + "api/predmet", reqObj)
    .done(function (data) {
        if (data && data > 0) {
            ShowAlert("success", "Uspješno spašen predmet.");
            SaveCaseActivity();
            HideLoaderCenter();
            LoadCases();
        }
        else {
            HideLoaderCenter();
            ShowAlert("danger", "Greška pri spašavanju predmeta.");
        }
    })
    .fail(function (response) {
        HideLoaderCenter();
        ShowAlert("danger", "Greška pri spašavanju predmeta.");
    });
}

function EditCase(id) {
    $("#modalCase").attr("edit_id", id);

    // LicePredmet
    $("#ddlCase_Lice").val(-1);
    $("#ddlCase_UlogaLica").val(-1);
    $("#ddlCase_GlavnaStranka").val("");
    $("#ddlCase_UlogaOrdinalNo").val("1");
    $("#btnAppendPartyToCase").attr("disabled", "disabled");

    // Notes
    $("#txtCase_NoteDate").val("");
    $("#txtCase_NoteText").val("");
    $("#btnAppendNoteToCase").attr("disabled", "disabled");

    // Expenses
    $("#ddlCase_ExpenseVrstaTroska").val(-1);
    $("#txtCase_ExpenseAmount").val("");
    $("#txtCase_ExpenseDate").val("");
    $("#ddlCase_ExpensePaidBy").val("");
    $("#btnAppendExpenseToCase").attr("disabled", "disabled");

    // Radnje
    $("#ddlCase_Radnja_VrstaRadnje").val(-1);
    $("#txtCase_Radnja_DatumRadnje").val("");
    //$("#ddlCase_Radnja_Troskovi").val("");
    $("#txtCase_Radnja_Biljeske").val("");
    $("#btnAppendRadnjaToCase").attr("disabled", "disabled");

    $("#txtCase_CaseActivity_ActivityDate").val("");
    $("#txtCase_CaseActivity_Note").val("");
    $("#cbCase_CaseActivity_ForAllUsers").prop("checked", "checked");
    $("#txtCase_CaseActivity_ActivityDate").removeAttr("disabled");
    $("#txtCase_CaseActivity_Note").removeAttr("disabled");
    $("#cbCase_CaseActivity_ForAllUsers").removeAttr("disabled");

    if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0)
        $("#btnSaveCase").show();

    $(Predmeti).each(function (index, obj) {
        if (obj.Id == id) {

            CurrentCase = $.extend(true, {}, obj);
            $("#txtCase_NasBroj").val(CurrentCase.NasBroj);
            $("#ddlCase_Kategorija").val(CurrentCase.KategorijaPredmetaId);
            $("#ddlCase_Uloga").val(CurrentCase.UlogaId);
            $("#cbCase_PrivremeniZastupnici").prop("checked", CurrentCase.PrivremeniZastupnici);
            $("#txtCase_BrojPredmeta").val(CurrentCase.BrojPredmeta);
            $("#ddlCase_Sud").val(CurrentCase.SudId);
            $("#ddlCase_Sudija").val(CurrentCase.SudijaId);
            $("#txtCase_VrijednostSpora").val(CurrentCase.VrijednostSpora);
            $("#ddlCase_VrstaPredmeta").val(CurrentCase.VrstaPredmetaId);
            $("#txtCase_DatumStanjaPredmeta").val(CurrentCase.DatumStanjaPredmeta);
            //$("#ddlCase_StanjePredmeta").val(CurrentCase.StanjePredmetaId);
            $("#txtCase_StanjePredmeta").val(CurrentCase.StanjePredmetaName);

            $("#ddlCase_NacinOkoncanja").val(CurrentCase.NacinOkoncanjaId);
            $("#ddlCase_Uspjeh").val(CurrentCase.Uspjeh);
            $("#txtCase_DatumArhiviranja").val(CurrentCase.DatumArhiviranja);
            $("#txtCase_BrojArhive").val(CurrentCase.BrojArhive);
            $("#txtCase_BrojArhiveRegistrator").val(CurrentCase.BrojArhiveRegistrator);

            $("#txtCase_PravniOsnov").val(CurrentCase.PravniOsnov);

            $("#modalCase").find(".modal-title").html("Izmijeni predmet: <span style='font-style: italic; color: gray;'>" + CurrentCase.NasBroj + "</span>");

            ShowLoaderCenter();
            $.get(AppPath + "api/licepredmet", {
                Id: CurrentCase.Id
            })
            .done(function (data) {
                CurrentCase.Parties = data;
                BindCaseParties(CurrentCase.Parties);
                HideLoaderCenter();
            })
            .fail(function (jqXHR, textStatus, errorThrown) {
                HideLoaderCenter();
                alert("error loading parties");
            });

            ShowLoaderCenter();
            $.get(AppPath + "api/note", {
                CaseId: CurrentCase.Id
            })
            .done(function (data) {
                CurrentCase.Notes = data;
                BindCaseNotes(CurrentCase.Notes);
                HideLoaderCenter();
            })
            .fail(function (jqXHR, textStatus, errorThrown) {
                HideLoaderCenter();
                alert("error loading notes");
            });

            ShowLoaderCenter();
            $.get(AppPath + "api/expense", {
                CaseId: CurrentCase.Id
            })
            .done(function (data) {
                CurrentCase.Expenses = data;
                BindCaseExpenses(CurrentCase.Expenses);
                HideLoaderCenter();
            })
            .fail(function (jqXHR, textStatus, errorThrown) {
                HideLoaderCenter();
                alert("error loading expenses");
            });

            ShowLoaderCenter();
            $.get(AppPath + "api/radnja", {
                PredmetId: CurrentCase.Id
            })
            .done(function (data) {
                CurrentCase.Radnje = data;
                BindCaseRadnje(CurrentCase.Radnje);
                HideLoaderCenter();
            })
            .fail(function (jqXHR, textStatus, errorThrown) {
                HideLoaderCenter();
                alert("error loading radnje");
            });

            $("#btnOpenModalEditCase").click();
            return false; // break loop
        }
    });
}

//function DeleteCase(id) {
//    $(Predmeti).each(function (index, obj) {
//        if (obj.Id == id) {
//            ShowPrompt(
//                "Da li ste sigurni da želite izbrisati predmet?",
//                "<span style='font-style: italic; color: gray;'>" + obj.NasBroj + "</span>",
//                function () {
//                    ShowLoaderCenter();
//                    $.ajax({
//                        url: AppPath + "api/predmet?Id=" + id.toString(),
//                        type: "DELETE",
//                        success: function () {
//                            LoadCases();
//                            HideLoaderCenter();
//                            ShowAlert("success", "Uspješno izbrisan predmet.");
//                        },
//                        error: function () {
//                            HideLoaderCenter();
//                            ShowAlert("danger", "Greška pri brisanju predmeta.");
//                        }
//                    });
//                },
//                function () { }
//            );

//            return false; // break loop
//        }
//    });
//}

function ClearModalUser() {
    $("#modalUser").removeAttr("edit_id");
    $("#txtUser_Email").val("");
    $("#txtUser_FirstName").val("");
    $("#txtUser_LastName").val("");
    $("#txtUser_Phone").val("");
    $("#txtUser_GoogleDriveLocalFolderPath").val("");
    $("#ddlUser_UserGroups").val("");
    $("#ddlUser_UserGroups").multiselect('refresh');
    $("#modalUser").find(".modal-title").html("Novi korisnik");
}

function SaveUser() {
    ShowLoaderCenter();

    var reqObj = {
        Email: $("#txtUser_Email").val(),
        FirstName: $("#txtUser_FirstName").val(),
        LastName: $("#txtUser_LastName").val(),
        Phone: $("#txtUser_Phone").val(),
        GoogleDriveLocalFolderPath: $("#txtUser_GoogleDriveLocalFolderPath").val(),
        UserGroupCodes: GetDataFromMultiselect("ddlUser_UserGroups")
    };

    var tempId = $("#modalUser").attr("edit_id");

    if (tempId != undefined)
        reqObj.Id = tempId;

    $.post(AppPath + "api/user", reqObj)
    .done(function (data) {
        if (data && data > 0) {
            ShowAlert("success", "Uspješno spašen korisnik.");
            HideLoaderCenter();
            LoadUsers();
        }
        else {
            HideLoaderCenter();
            ShowAlert("danger", "Greška pri spašavanju korisnika.");
        }
    })
    .fail(function (response) {
        HideLoaderCenter();
        ShowAlert("danger", "Greška pri spašavanju korisnika.");
    });
}


function ClearModalSud() {
    $("#modalSud").removeAttr("edit_id");
    $("#txtSud_Naziv").val("");
    $("#txtSud_Adresa").val("");
    $("#txtSud_PostanskiBroj").val("");
    $("#txtSud_Grad").val("");
    $("#txtSud_Telefon").val("");
    $("#txtSud_Fax").val("");
    $("#txtSud_RacunTakse").val("");
    $("#txtSud_RacunVjestacenja").val("");
    $("#modalSud").find(".modal-title").html("Novi sud");
}

function SaveSud() {
    ShowLoaderCenter();

    var reqObj = {
        CreatedBy: CurrentUser.Id,
        Naziv: $("#txtSud_Naziv").val(),
        Adresa: $("#txtSud_Adresa").val(),
        PostanskiBroj: $("#txtSud_PostanskiBroj").val(),
        Grad: $("#txtSud_Grad").val(),
        Telefon: $("#txtSud_Telefon").val(),
        Fax: $("#txtSud_Fax").val(),
        RacunTakse: $("#txtSud_RacunTakse").val(),
        RacunVjestacenja: $("#txtSud_RacunVjestacenja").val()
    };

    var tempId = $("#modalSud").attr("edit_id");

    if (tempId != undefined) {
        reqObj.Id = tempId;
        reqObj.ModifiedBy = CurrentUser.Id;
    }

    $.post(AppPath + "api/sud", reqObj)
    .done(function (data) {
        if (data && data > 0) {
            ShowAlert("success", "Uspješno spašen sud.");
            HideLoaderCenter();
            LoadSudovi();
        }
        else {
            HideLoaderCenter();
            ShowAlert("danger", "Greška pri spašavanju suda.");
        }
    })
    .fail(function (response) {
        HideLoaderCenter();
        ShowAlert("danger", "Greška pri spašavanju suda.");
    });
}

function LoadUserGroups() {
    ShowLoaderCenter();
    $.get(AppPath + "api/usergroup", {
        UserId: CurrentUser.Id
    })
    .done(function (data) {
        if (data) {
            $(data).each(function (index, obj) {
                $("#ddlUser_UserGroups").append($("<option></option>").attr("value", obj.Code).text(obj.Name));
                if (index == data.length - 1) {
                    $("#ddlUser_UserGroups").multiselect({
                        includeSelectAllOption: false,
                        allSelectedText: "Sve grupe",
                        //selectAllText: "Odaberi sve / ništa",
                        maxHeight: 200
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

function LoadCodeTableData(tableName, dropDown, columnName) {
    if (columnName == undefined)
        columnName = "Name";

    ShowLoaderCenter();
    $.get(AppPath + "api/codetable", {
        Name: tableName,
        ColumnName: columnName,
        Filter: ""
    })
    .done(function (data) {
        if (data) {
            $(data).each(function (index, obj) {
                dropDown.append($("<option></option>").attr("value", obj.Id).text(obj.Name));
                if (index == data.length - 1)
                    HideLoaderCenter();
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

function LoadCodeTableUI(element, title, tableName, columnName) {
    $(".menu-item").removeClass("active");
    $("#liMenuCodeTables").addClass("active");
    $(".menu-sub-item").css("background-color", "");
    $(element).parent().css("background-color", "#e7e7e7");
    $(".menu-div").hide();
    $("#divCodeTable").show();
    CurrentCodeTable = {
        Element: element,
        Title: title,
        TableName: tableName,
        ColumnName: columnName
    };

    $("#divCodeTable").find(".panel-heading").html("<strong>" + title + "</strong>");

    ShowLoaderCenter();

    if (columnName == undefined)
        columnName = "Name";

    $("#tblCodeTableData").bootstrapTable("destroy");

    $.get(AppPath + "api/codetable", {
        Name: tableName,
        ColumnName: columnName
    })
    .done(function (data) {
        if (data) {
            CurrentCodeTable.Data = data;
            var _columns = [
                { field: 'Id' },
                { field: 'OrdinalNo', width: 100 },
                { field: 'Name' }
            ];

            $("#tblCodeTableData").bootstrapTable("destroy");
            $("#tblCodeTableData").bootstrapTable({
                data: data,
                striped: true,
                showRefresh: false,
                columns: _columns,
                search: true,
                showHeader: false,
                onPostBody: function () {
                    AfterBindCodeTableData();
                    return false;
                }
            });

            HideLoaderCenter();
        }
        else
            HideLoaderCenter();
    })
    .fail(function (jqXHR, textStatus, errorThrown) {
        HideLoaderCenter();
        alert("error");
    });
}

function AfterBindCodeTableData() {
    $("#tblCodeTableData").find("tr").each(function (index, element) {
        var tempId = parseInt($(element).find("td:first-child").html());
        $(element).find("td:first-child").hide();

        if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0) {
            var buttonsHTML = "<td style='width: 100px;'><div class='btn-group pull-right'>";
            buttonsHTML +=
                        "<button class='btn btn-default btn-sm custom-table-button-edit' data-toggle='tooltip' title='Izmijeni' onclick='EditCodeTableRecord(" + tempId.toString() + "); return false;'>"
                        + "<span class='glyphicon glyphicon-pencil'></span>"
                        + "</button>";

            buttonsHTML +=
                        "<button class='btn btn-default btn-sm custom-table-button-delete' data-toggle='tooltip' title='Izbriši' onclick='DeleteCodeTableRecord(" + tempId.toString() + "); return false;'>"
                        + "<span class='glyphicon glyphicon-remove'></span>"
                        + "</button>";
            buttonsHTML += "</div></td>"

            $(element).append(buttonsHTML);
        }
    });
}

function EditCodeTableRecord(id) {
    $("#modalCodeTableRecord").attr("edit_id", id);

    $(CurrentCodeTable.Data).each(function (index, obj) {
        if (obj.Id == id) {
            $("#txtCodeTableRecord_Name").val(obj.Name);
            $("#modalCodeTableRecord").find(".modal-title").html(CurrentCodeTable.Title + " - Izmijeni: <span style='font-style: italic; color: gray;'>" + obj.Name + "</span>");
            $("#btnOpenModalEditCodeTableRecord").click();

            return false; // break loop
        }
    });
}

function NewCodeTableRecord() {
    $("#modalCodeTableRecord").removeAttr("edit_id");

    $("#txtCodeTableRecord_Name").val("");
    $("#modalCodeTableRecord").find(".modal-title").html(CurrentCodeTable.Title + " - Novi unos");
}

function DeleteCodeTableRecord(id) {
    $(CurrentCodeTable.Data).each(function (index, obj) {
        if (obj.Id == id) {
            ShowPrompt(
                "Da li ste sigurni da želite izbrisati?",
                "<span style='font-style: italic; color: gray;'>" + obj.Name + "</span>",
                function () {
                    ShowLoaderCenter();
                    $.ajax({
                        url: AppPath + "api/codetable?TableName=" + CurrentCodeTable.TableName + "&Id=" + id.toString(),
                        type: "DELETE",
                        success: function () {
                            LoadCodeTableUI(CurrentCodeTable.Element, CurrentCodeTable.Title, CurrentCodeTable.TableName, CurrentCodeTable.ColumnName);
                            HideLoaderCenter();
                            ShowAlert("success", "Uspješno izbrisano.");
                        },
                        error: function () {
                            HideLoaderCenter();
                            ShowAlert("danger", "Greška pri brisanju.");
                        }
                    });
                },
                function () { }
            );

            return false; // break loop
        }
    });
}

function SaveCodeTableRecord() {
    ShowLoaderCenter();

    var reqObj = {
        TableName: CurrentCodeTable.TableName,
        Name: $("#txtCodeTableRecord_Name").val()
    };

    var tempId = $("#modalCodeTableRecord").attr("edit_id");

    if (tempId != undefined)
        reqObj.Id = tempId;

    $.post(AppPath + "api/codetable", reqObj)
    .done(function (data) {
        if (data && data > 0) {
            LoadCodeTableUI(CurrentCodeTable.Element, CurrentCodeTable.Title, CurrentCodeTable.TableName, CurrentCodeTable.ColumnName);
            HideLoaderCenter();
            ShowAlert("success", "Uspješno spašen podatak.");
        }
        else {
            HideLoaderCenter();
            ShowAlert("danger", "Greška pri spašavanju podatka.");
        }
    })
    .fail(function (response) {
        HideLoaderCenter();
        ShowAlert("danger", "Greška pri spašavanju podatka.");
    });
}

function ClearModalCase() {
    $("#modalCase").removeAttr("edit_id");

    $("#txtCase_NasBroj").val("(biti će automatski dodijeljen)");
    $("#ddlCase_Kategorija").val(-1);
    $("#ddlCase_Uloga").val(-1);
    $("#cbCase_PrivremeniZastupnici").prop("checked", false);
    $("#txtCase_BrojPredmeta").val("");
    $("#ddlCase_Sud").val(-1);
    $("#ddlCase_Sudija").val(-1);
    $("#txtCase_VrijednostSpora").val("");
    $("#ddlCase_VrstaPredmeta").val(-1);
    $("#txtCase_DatumStanjaPredmeta").val("");
    //$("#ddlCase_StanjePredmeta").val(-1);
    $("#txtCase_StanjePredmeta").val("");

    $("#ddlCase_NacinOkoncanja").val(-1);
    $("#ddlCase_Uspjeh").val("0%");
    $("#txtCase_DatumArhiviranja").val("");
    $("#txtCase_BrojArhive").val("");
    $("#txtCase_BrojArhiveRegistrator").val("");

    $("#txtCase_PravniOsnov").val("");

    // LicePredmet
    $("#ddlCase_Lice").val(-1);
    $("#ddlCase_UlogaLica").val(-1);
    $("#ddlCase_GlavnaStranka").val("");
    $("#btnAppendPartyToCase").attr("disabled", "disabled");

    // Notes
    $("#txtCase_NoteDate").val("");
    $("#txtCase_NoteText").val("");
    $("#btnAppendNoteToCase").attr("disabled", "disabled");

    // Expenses
    $("#ddlCase_ExpenseVrstaTroska").val(-1);
    $("#txtCase_ExpenseAmount").val("");
    $("#txtCase_ExpenseDate").val("");
    $("#ddlCase_ExpensePaidBy").val("");
    $("#btnAppendExpenseToCase").attr("disabled", "disabled");

    // Radnje
    $("#ddlCase_Radnja_VrstaRadnje").val(-1);
    $("#txtCase_Radnja_DatumRadnje").val("");
    //$("#ddlCase_Radnja_Troskovi").val("");
    $("#txtCase_Radnja_Biljeske").val("");
    $("#btnAppendRadnjaToCase").attr("disabled", "disabled");

    $("#modalCase").find(".modal-title").html("Novi predmet");
    $("#tblCaseParties").bootstrapTable("destroy");

    // Pozivanje predmeta
    $("#txtCase_CaseActivity_ActivityDate").val("");
    $("#txtCase_CaseActivity_Note").val("");
    $("#cbCase_CaseActivity_ForAllUsers").prop("checked", "checked");
    $("#txtCase_CaseActivity_ActivityDate").attr("disabled", "disabled");
    $("#txtCase_CaseActivity_Note").attr("disabled", "disabled");
    $("#cbCase_CaseActivity_ForAllUsers").attr("disabled", "disabled");

    $("#btnSaveCase").hide();
}

function ClearModalParty() {
    $("#modalParty").removeAttr("edit_id");
    $("#txtParty_Prezime").val("");
    $("#txtParty_Ime").val("");
    $("#cbParty_IsMinor").prop("checked", false);
    $("#txtParty_ZakonskiZastupnik").val("");
    $("#txtParty_PravnoLice").val("");
    $("#txtParty_Adresa").val("");
    $("#txtParty_PostanskiBroj").val("");
    $("#txtParty_Grad").val("");
    $("#ddlParty_Drzava").val("-1");
    $("#txtParty_Telefon").val("");
    $("#txtParty_Fax").val("");
    $("#txtParty_Email").val("");
    $("#txtParty_JMBG_IDBroj").val("");
    $("#txtParty_Biljeske").val("");
    $("#modalParty").find(".modal-title").html("Nova stranka");
}

function SaveParty() {
    ShowLoaderCenter();

    var reqObj = {
        CreatedBy: CurrentUser.Id,
        Prezime: $("#txtParty_Prezime").val(),
        Ime: $("#txtParty_Ime").val(),
        IsMinor: $("#cbParty_IsMinor").prop("checked"),
        ZakonskiZastupnik: $("#txtParty_ZakonskiZastupnik").val(),
        PravnoLice: $("#txtParty_PravnoLice").val(),
        Adresa: $("#txtParty_Adresa").val(),
        PostanskiBroj: $("#txtParty_PostanskiBroj").val(),
        Grad: $("#txtParty_Grad").val(),
        DrzavaId: $("#ddlParty_Drzava").val() == -1 ? null : $("#ddlParty_Drzava").val(),
        Telefon: $("#txtParty_Telefon").val(),
        Fax: $("#txtParty_Fax").val(),
        Email: $("#txtParty_Email").val(),
        JMBG_IDBroj: $("#txtParty_JMBG_IDBroj").val(),
        Biljeske: $("#txtParty_Biljeske").val()
    };

    var tempId = $("#modalParty").attr("edit_id");

    if (tempId != undefined) {
        reqObj.Id = tempId;
        reqObj.ModifiedBy = CurrentUser.Id;
    }

    $.post(AppPath + "api/lice", reqObj)
    .done(function (data) {
        if (data && data > 0) {
            ShowAlert("success", "Uspješno spašena stranka.");
            HideLoaderCenter();
            LoadParties();
        }
        else {
            HideLoaderCenter();
            ShowAlert("danger", "Greška pri spašavanju stranke.");
        }
    })
    .fail(function (response) {
        HideLoaderCenter();
        ShowAlert("danger", "Greška pri spašavanju stranke.");
    });
}

function EditParty(id) {
    $("#modalParty").attr("edit_id", id);

    $(Lica).each(function (index, obj) {
        if (obj.Id == id) {
            $("#txtParty_Prezime").val(obj.Prezime);
            $("#txtParty_Ime").val(obj.Ime);
            $("#cbParty_IsMinor").prop("checked", obj.IsMinor);
            $("#txtParty_ZakonskiZastupnik").val(obj.ZakonskiZastupnik);
            $("#txtParty_PravnoLice").val(obj.PravnoLice);
            $("#txtParty_Adresa").val(obj.Adresa);
            $("#txtParty_PostanskiBroj").val(obj.PostanskiBroj);
            $("#txtParty_Grad").val(obj.Grad);
            $("#ddlParty_Drzava").val(obj.DrzavaId);
            $("#txtParty_Telefon").val(obj.Telefon);
            $("#txtParty_Fax").val(obj.Fax);
            $("#txtParty_Email").val(obj.Email);
            $("#txtParty_JMBG_IDBroj").val(obj.JMBG_IDBroj);
            $("#txtParty_Biljeske").val(obj.Biljeske);

            $("#modalParty").find(".modal-title").html("Izmijeni stranku: <span style='font-style: italic; color: gray;'>" + obj.Naziv + "</span>");
            $("#btnOpenModalEditParty").click();

            return false; // break loop
        }
    });
}

function DeleteParty(id) {
    $(Lica).each(function (index, obj) {
        if (obj.Id == id) {
            ShowPrompt(
                "Da li ste sigurni da želite izbrisati stranku?",
                "<span style='font-style: italic; color: gray;'>" + obj.Naziv + "</span>",
                function () {
                    ShowLoaderCenter();
                    $.ajax({
                        url: AppPath + "api/lice?Id=" + id.toString(),
                        type: "DELETE",
                        success: function () {
                            LoadParties();
                            HideLoaderCenter();
                            ShowAlert("success", "Uspješno izbrisana stranka.");
                        },
                        error: function () {
                            HideLoaderCenter();
                            ShowAlert("danger", "Greška pri brisanju lica.");
                        }
                    });
                },
                function () { }
            );

            return false; // break loop
        }
    });
}

function StartBuildingNewCase() {
    CurrentCase = {};
    CurrentCase.Parties = [];
    CurrentCase.Notes = [];
    CurrentCase.Expenses = [];
    CurrentCase.Radnje = [];

    ClearModalCase();

    //CurrentCase = {};
    //ShowLoaderCenter();
    //$.get(AppPath + "api/nasbroj")
    //.done(function (data) {
    //    if (data && data > 0) {
    //        HideLoaderCenter();
    //        $("#txtCase_NasBroj").val(data);
    //    }
    //    else {
    //        HideLoaderCenter();
    //        ShowAlert("danger", 'Greška pri generisanju nove vrijednosti za polje "Naš broj". Molim unesite ga ručno.', undefined, undefined, $("#divNewCaseModalBodyTop"));
    //        $("#txtCase_NasBroj").removeAttr("disabled");
    //    }
    //})
    //.fail(function (jqXHR, textStatus, errorThrown) {
    //    HideLoaderCenter();
    //    ShowAlert("danger", 'Greška pri generisanju nove vrijednosti za polje "Naš broj". Molim unesite ga ručno.', undefined, undefined, $("#divNewCaseModalBodyTop"));
    //    $("#txtCase_NasBroj").removeAttr("disabled");
    //});

    BindCaseParties([]);
    BindCaseNotes([]);
    BindCaseExpenses([]);
}

function AppendPartyToCase() {
    if ($("#ddlCase_Lice").val() != -1 && $("#ddlCase_UlogaLica").val() != -1) {

        if (CurrentCase.Parties == undefined)
            CurrentCase.Parties = [];

        CurrentCase.Parties.push({
            LiceId: $("#ddlCase_Lice").val(),
            Lice: $("#ddlCase_Lice option:selected").text(),
            UlogaId: $("#ddlCase_UlogaLica").val(),
            Uloga: $("#ddlCase_UlogaLica option:selected").text(),
            //GlavnaStrankaValue: $("#ddlCase_GlavnaStranka").val(),
            GlavnaStranka: $("#ddlCase_GlavnaStranka option:selected").text(),
            IsNasaStranka: $("#ddlCase_GlavnaStranka").val() == "ns",
            IsProtivnaStranka: $("#ddlCase_GlavnaStranka").val() == "ps",
            Broj: $("#ddlCase_UlogaOrdinalNo").val()
        });

        BindCaseParties(CurrentCase.Parties);
    }
}

function BindCaseParties(_data) {
    var _columns = [
        { field: 'Lice', title: 'Stranka', titleTooltip: 'Stranka', sortable: true },
        { field: 'Broj', title: 'Broj', titleTooltip: 'Broj', sortable: true },
        { field: 'Uloga', title: 'Uloga', titleTooltip: 'Uloga', sortable: true },
        { field: 'GlavnaStranka', title: 'Vrsta stranke', titleTooltip: 'Vrsta stranke', sortable: true }
    ];

    $("#tblCaseParties").bootstrapTable("destroy");

    $("#tblCaseParties").bootstrapTable({
        data: _data,
        striped: true,
        columns: _columns,
        onPostBody: function () {
            AfterBindCaseParties();
            return false;
        }
    });
}

function AfterBindCaseParties() {
    $("#tblCaseParties").find("tr").each(function (index, element) {
        if (index == 0) {
            if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0 && CurrentCase.Parties.length > 0)
                if ($("#casePartiesEmptyHeader").length == 0)
                    $(element).append("<th id='casePartiesEmptyHeader'></th>");
        }
        else if (CurrentCase.Parties.length > 0) {
            if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0) {
                var buttonsHTML = "<td style='width: 50px;'><div class='btn-group pull-right'>";
                buttonsHTML +=
                            "<button class='btn btn-default btn-sm custom-table-button-delete' data-toggle='tooltip' title='Izbriši stranku' onclick='DeleteCaseParty(" + (index - 1) + "); return false;'>"
                            + "<span class='glyphicon glyphicon-remove'></span>"
                            + "</button>";
                buttonsHTML += "</div></td>"

                $(element).append(buttonsHTML);
            }
        }
    });
}

function DeleteCaseParty(index) {
    CurrentCase.Parties.splice(index, 1);
    BindCaseParties(CurrentCase.Parties);
}

function AppendNoteToCase() {
    if ($("#txtCase_NoteText").val() != "" && $("#txtCase_NoteDate").val() != "") {

        if (CurrentCase.Notes == undefined)
            CurrentCase.Notes = [];

        CurrentCase.Notes.push({
            NoteText: $("#txtCase_NoteText").val(),
            NoteDate: ConvertBSDateToUSDateString($("#txtCase_NoteDate").val()),
            CreatedBy: CurrentUser.Id,
            CreatedByName: CurrentUser.FirstName + " " + CurrentUser.LastName,
            CaseId: CurrentCase.Id
        });

        BindCaseNotes(CurrentCase.Notes);
    }
}

function BindCaseNotes(_data) {
    var _columns = [
        { field: 'NoteDate', title: 'Datum', titleTooltip: 'Datum', sortable: true, sorter: DateSorterFunction },
        { field: 'NoteText', title: 'Bilješka', titleTooltip: 'Bilješka', sortable: true },
        { field: 'CreatedByName', title: 'Izrađena od', titleTooltip: 'Izrađena od', sortable: true }
    ];

    $("#tblCaseNotes").bootstrapTable("destroy");

    if (_data && _data.length > 0) {
        $(_data).each(function (index, _note) {
            if (Date.parse(_note.NoteDate))
                _note.NoteDate = moment(_note.NoteDate).format("DD.MM.YYYY");

            if (index == _data.length - 1) {
                $("#tblCaseNotes").bootstrapTable({
                    data: _data,
                    striped: true,
                    columns: _columns,
                    onPostBody: function () {
                        AfterBindCaseNotes();
                        return false;
                    }
                });

                $(CurrentCase.Notes).each(function (indexN, objN) {
                    if (objN.NoteDate != null)
                        objN.NoteDate = ConvertBSDateToUSDateString(objN.NoteDate);
                });
            }
        });
    }
    else {
        $("#tblCaseNotes").bootstrapTable({
            data: [],
            striped: true,
            columns: _columns
        });
    }
}

function AfterBindCaseNotes() {
    $("#tblCaseNotes").find("tr").each(function (index, element) {
        if (index == 0) {
            if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0 && CurrentCase.Notes.length > 0)
                if ($("#caseNotesEmptyHeader").length == 0)
                    $(element).append("<th id='caseNotesEmptyHeader'></th>");
        }
        else if (CurrentCase.Notes.length > 0) {
            if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0) {
                var buttonsHTML = "<td style='width: 50px;'><div class='btn-group pull-right'>";
                buttonsHTML +=
                            "<button class='btn btn-default btn-sm custom-table-button-delete' data-toggle='tooltip' title='Izbriši bilješku' onclick='DeleteCaseNote(" + (index - 1) + "); return false;'>"
                            + "<span class='glyphicon glyphicon-remove'></span>"
                            + "</button>";
                buttonsHTML += "</div></td>"

                $(element).append(buttonsHTML);
            }
        }
    });
}

function DeleteCaseNote(index) {
    CurrentCase.Notes.splice(index, 1);
    BindCaseNotes(CurrentCase.Notes);
}

function AppendRadnjaToCase() {
    if ($("#ddlCase_Radnja_VrstaRadnje").val() != -1 && $("#txtCase_Radnja_DatumRadnje").val() != "") {

        if (CurrentCase.Radnje == undefined)
            CurrentCase.Radnje = [];

        CurrentCase.Radnje.push({
            VrstaRadnjeId: $("#ddlCase_Radnja_VrstaRadnje").val(),
            VrstaRadnjeName: $("#ddlCase_Radnja_VrstaRadnje option:selected").text(),
            DatumRadnje: $("#txtCase_Radnja_DatumRadnje").val(),
            Troskovi: '', //$("#ddlCase_Radnja_Troskovi").val(),
            Biljeske: $("#txtCase_Radnja_Biljeske").val(),
            PredmetId: CurrentCase.Id
        });

        BindCaseRadnje(CurrentCase.Radnje);
    }
}

function BindCaseRadnje(_data) {
    var _columns = [
        { field: 'VrstaRadnjeName', title: 'Vrsta radnje', titleTooltip: 'Vrsta radnje', sortable: true },
        { field: 'DatumRadnje', title: 'Datum', titleTooltip: 'Datum', sortable: true, sorter: DateSorterFunction },
        //{ field: 'Troskovi', title: 'Troškovi', titleTooltip: 'Troškovi', sortable: true, align: "right" },
        { field: 'Biljeske', title: 'Bilješke', titleTooltip: 'Bilješke', sortable: true }
    ];

    $("#tblCaseRadnje").bootstrapTable("destroy");

    if (_data && _data.length > 0) {
        $(_data).each(function (index, _radnja) {
            if (Date.parse(_radnja.DatumRadnje))
                _radnja.DatumRadnje = moment(_radnja.DatumRadnje).format("DD.MM.YYYY");

            if (index == _data.length - 1) {
                $("#tblCaseRadnje").bootstrapTable({
                    data: _data,
                    striped: true,
                    columns: _columns,
                    onPostBody: function () {
                        AfterBindCaseRadnje();
                        return false;
                    }
                });

                $(CurrentCase.Radnje).each(function (indexR, objR) {
                    if (objR.DatumRadnje != null)
                        objR.DatumRadnje = ConvertBSDateToUSDateString(objR.DatumRadnje);
                });
            }
        });
    }
    else {
        $("#tblCaseRadnje").bootstrapTable({
            data: [],
            striped: true,
            columns: _columns
        });
    }
}

function AfterBindCaseRadnje() {
    $("#tblCaseRadnje").find("tr").each(function (index, element) {
        if (index == 0) {
            if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0 && CurrentCase.Radnje.length > 0)
                if ($("#caseRadnjeEmptyHeader").length == 0)
                    $(element).append("<th id='caseRadnjeEmptyHeader'></th>");
        }
        else if (CurrentCase.Radnje.length > 0) {
            if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0) {
                var buttonsHTML = "<td style='width: 50px;'><div class='btn-group pull-right'>";
                buttonsHTML +=
                            "<button class='btn btn-default btn-sm custom-table-button-delete' data-toggle='tooltip' title='Izbriši radnju' onclick='DeleteCaseRadnja(" + (index - 1) + "); return false;'>"
                            + "<span class='glyphicon glyphicon-remove'></span>"
                            + "</button>";
                buttonsHTML += "</div></td>"

                $(element).append(buttonsHTML);
            }
        }
    });
}

function DeleteCaseRadnja(index) {
    CurrentCase.Radnje.splice(index, 1);
    BindCaseRadnje(CurrentCase.Radnje);
}

function AppendExpenseToCase() {
    if ($("#ddlCase_ExpenseVrstaTroska").val() != -1 && $("#txtCase_ExpenseAmount").val() != "") {

        if (CurrentCase.Expenses == undefined)
            CurrentCase.Expenses = [];

        CurrentCase.Expenses.push({
            VrstaTroskaId: $("#ddlCase_ExpenseVrstaTroska").val(),
            VrstaTroskaName: $("#ddlCase_ExpenseVrstaTroska option:selected").text(),
            Amount: $("#txtCase_ExpenseAmount").val(),
            ExpenseDate: $("#txtCase_ExpenseDate").val(),
            PaidBy: $("#ddlCase_ExpensePaidBy").val(),
            CaseId: CurrentCase.Id
        });

        BindCaseExpenses(CurrentCase.Expenses);
    }
}

function BindCaseExpenses(_data) {
    var _columns = [
        { field: 'VrstaTroskaName', title: 'Vrsta troška', titleTooltip: 'Vrsta troška', sortable: true },
        { field: 'Amount', title: 'Iznos (BAM)', titleTooltip: 'Iznos (BAM)', sortable: true, align: "right" },
        { field: 'ExpenseDate', title: 'Datum plaćanja', titleTooltip: 'Datum plaćanja', sortable: true, sorter: DateSorterFunction },
        { field: 'PaidBy', title: 'Plaćeno od', titleTooltip: 'Plaćeno od', sortable: true }
    ];

    $("#tblCaseExpenses").bootstrapTable("destroy");

    if (_data && _data.length > 0) {
        $(_data).each(function (index, _expense) {
            if (Date.parse(_expense.ExpenseDate))
                _expense.ExpenseDate = moment(_expense.ExpenseDate).format("DD.MM.YYYY");

            if (index == _data.length - 1) {
                $("#tblCaseExpenses").bootstrapTable({
                    data: _data,
                    striped: true,
                    columns: _columns,
                    onPostBody: function () {
                        AfterBindCaseExpenses();
                        return false;
                    }
                });

                $(CurrentCase.Expenses).each(function (indexE, objE) {
                    if (objE.ExpenseDate != null)
                        objE.ExpenseDate = ConvertBSDateToUSDateString(objE.ExpenseDate);
                });
            }
        });
    }
    else {
        $("#tblCaseExpenses").bootstrapTable({
            data: [],
            striped: true,
            columns: _columns
        });
    }
}

function AfterBindCaseExpenses() {
    $("#tblCaseExpenses").find("tr").each(function (index, element) {
        if (index == 0) {
            if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0 && CurrentCase.Expenses.length > 0)
                if ($("#caseExpensesEmptyHeader").length == 0)
                    $(element).append("<th id='caseExpensesEmptyHeader'></th>");
        }
        else if (CurrentCase.Expenses.length > 0) {
            if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0) {
                var buttonsHTML = "<td style='width: 50px;'><div class='btn-group pull-right'>";
                buttonsHTML +=
                            "<button class='btn btn-default btn-sm custom-table-button-delete' data-toggle='tooltip' title='Izbriši trošak' onclick='DeleteCaseExpense(" + (index - 1) + "); return false;'>"
                            + "<span class='glyphicon glyphicon-remove'></span>"
                            + "</button>";
                buttonsHTML += "</div></td>"

                $(element).append(buttonsHTML);
            }
        }
    });
}

function DeleteCaseExpense(index) {
    CurrentCase.Expenses.splice(index, 1);
    BindCaseExpenses(CurrentCase.Expenses);
}

$("#ddlCase_Lice,#ddlCase_UlogaLica").change(function () {
    if ($("#ddlCase_Lice").val() != -1 && $("#ddlCase_UlogaLica").val() != -1)
        $("#btnAppendPartyToCase").removeAttr("disabled");
    else
        $("#btnAppendPartyToCase").attr("disabled", "disabled");
});

$("#txtCase_NoteText,#txtCase_NoteDate").change(function () {
    if ($("#txtCase_NoteText").val() != "" && $("#txtCase_NoteDate").val() != "")
        $("#btnAppendNoteToCase").removeAttr("disabled");
    else
        $("#btnAppendNoteToCase").attr("disabled", "disabled");
});

$("#ddlCase_ExpenseVrstaTroska").change(function () {
    if ($("#ddlCase_ExpenseVrstaTroska").val() != -1 && $("#txtCase_ExpenseAmount").val() != "")
        $("#btnAppendExpenseToCase").removeAttr("disabled");
    else
        $("#btnAppendExpenseToCase").attr("disabled", "disabled");
});

$("#txtCase_ExpenseAmount").keyup(function () {
    if ($("#ddlCase_ExpenseVrstaTroska").val() != -1 && $("#txtCase_ExpenseAmount").val() != "")
        $("#btnAppendExpenseToCase").removeAttr("disabled");
    else
        $("#btnAppendExpenseToCase").attr("disabled", "disabled");
});

$("#ddlCase_Radnja_VrstaRadnje").change(function () {
    if ($("#ddlCase_Radnja_VrstaRadnje").val() != -1 && $("#txtCase_Radnja_DatumRadnje").val() != "")
        $("#btnAppendRadnjaToCase").removeAttr("disabled");
    else
        $("#btnAppendRadnjaToCase").attr("disabled", "disabled");
});

$("#dateTimePicker_Radnja_DatumRadnje").on('dp.change', function () {
    if ($("#ddlCase_Radnja_VrstaRadnje").val() != -1 && $("#txtCase_Radnja_DatumRadnje").val() != "")
        $("#btnAppendRadnjaToCase").removeAttr("disabled");
    else
        $("#btnAppendRadnjaToCase").attr("disabled", "disabled");
});

function OpenOtherTab(element, divId) {
    $(".other-tab").hide();
    $("#" + divId).show();
    $("#ulOtherTabs").find("li").removeClass("active");
    $(element).parent().addClass("active");
}


function SetUpStanjeAutocomplete() {
    $("#txtCase_StanjePredmeta").autocomplete({
        source: function (request, response) {
            $("#spinner_txtCase_StanjePredmeta").show();

            $.get(AppPath + "api/codetable", {
                Name: "StanjaPredmeta",
                ColumnName: "Name",
                Filter: $("#txtCase_StanjePredmeta").val()
            })
            .done(function (data) {
                response($.map(data, function (item) {
                    return {
                        label: item.Name,
                        value: item.Name
                    };
                }));
                $("#spinner_txtSearch_CaseName").hide();
            })
            .fail(function (jqXHR, textStatus, errorThrown) {
                alert("error");
            });
        },
        delay: 500,
        appendTo: ".case-column-for-stanje"
    });
}