﻿/// <reference path="Scripts/Utilities.js" />
/// <reference path="Scripts/google.js" />

var AppPath = window.location.href.split('?')[0].toLowerCase().replace("/desk.aspx", "").replace(/#/g, '') + "/";
var CurrentModule = "home";
var CurrentGoogleDocSelection = null;
var CurrentUser = null;
var CurrentCodeTable = null;
var Sudovi = null;
var Labels = null;
var Lica = null;
var Predmeti = null;
var Users = null;
var CaseActivities = null;
var Radnje = null;
var CurrentCase = null;
var SelectedCases = [];
var CaseDocumentClipboard = null;
var DownloadButtonMarkUp = "<button class='btn btn-default btn-sm' data-toggle='tooltip' title='##TOOLTIP##' onclick='##ON_CLICK##' style='color:blue;'><span class='glyphicon glyphicon-cloud-download'></span></button>";

var _columnsCases = [
    { field: 'Id' },
    { checkbox: true },
    { field: 'NasBrojName', title: 'NB', titleTooltip: 'Naš broj', sortable: true, sorter: NasBrojSorterFunction, width: "50px" },
    { field: 'StrankaNasa', title: 'Naša stranka', titleTooltip: 'Naša stranka', sortable: true },
    { field: 'StrankaProtivna', title: 'Protivna stranka', titleTooltip: 'Protivna stranka', sortable: true },
    { field: 'VrstaPredmetaName', title: 'Vrsta predmeta', titleTooltip: 'Vrsta predmeta', sortable: true },
    { field: 'BrojPredmeta', title: 'Broj predmeta', titleTooltip: 'Broj predmeta', sortable: true },
    { field: 'SudName', title: 'Sud', titleTooltip: 'Sud', sortable: true },
    { field: 'StanjePredmetaName', title: 'Stanje predmeta', titleTooltip: 'Stanje predmeta', sortable: true },
    { field: 'DatumStanjaPredmeta', title: 'Datum stanja', titleTooltip: 'Datum stanja', sortable: true, sorter: DateSorterFunction, visible: false },
    { field: 'KategorijaPredmetaName', title: 'Kategorija', titleTooltip: 'Kategorija', sortable: true },

    { field: 'Labels', title: 'Oznake', titleTooltip: 'Oznake', sortable: false, visible: false },

    { field: 'SudijaName', title: 'Sudija', titleTooltip: 'Sudija', sortable: true, visible: false },
    { field: 'Iniciran', title: 'Iniciran', titleTooltip: 'Iniciran', sortable: true, sorter: DateSorterFunction, visible: false },
    { field: 'VrijednostSporaString', title: 'Vrijednost spora', titleTooltip: 'Vrijednost spora', sortable: true, align: "right", visible: false },
    { field: 'UlogaName', title: 'Uloga', titleTooltip: 'Uloga', sortable: true, visible: false },
    { field: 'PrivremeniZastupniciString', title: 'Pr. zast.', titleTooltip: 'Privremeni zastupnici', sortable: true, visible: false },
    { field: 'PristupPredmetuString', title: 'Pristup putem Interneta', titleTooltip: 'Pristup predmetu putem interneta', sortable: true, visible: false },
    { field: 'PravniOsnov', title: 'Pravni osnov', titleTooltip: 'Pravni osnov', sortable: true, visible: false },

    { field: 'NacinOkoncanjaName', title: 'Način okončanja', titleTooltip: 'Način okončanja', sortable: true, visible: false },
    { field: 'Uspjeh', title: 'Uspjeh', titleTooltip: 'Uspjeh', sortable: true, visible: false },
    { field: 'DatumArhiviranja', title: 'Datum arhiviranja', titleTooltip: 'Datum arhiviranja', sortable: true, sorter: DateSorterFunction, visible: false },
    { field: 'BrojArhiveTotal', title: 'Br. arh/reg', titleTooltip: 'Broj u arhivi / registrator', sortable: true, visible: false }
];

window.userInteractionTimeout = null;
window.userInteractionInHTMLArea = false;
window.onBrowserHistoryButtonClicked = function () {
    var locationToMoveTo = window.location.toString();
    CurrentModule = GetQueryStringParameterByName("module", locationToMoveTo).toLowerCase();
    if (CurrentModule != undefined && CurrentModule != null && CurrentModule.length > 0) {
        try {
            OpenMenuByModule();
        }
        catch (err) {
        }
    }
};

function ValidateUser(email, token, access_token) {
    ShowLoaderCenter();

    $.post(AppPath + "api/user", {
        Email: email,
        Token: token
    })
        .done(function (data) {
            if (data.Id > 0) {
                SetupHistoryHandling();

                CurrentUser = {
                    Id: data.Id,
                    Email: data.Email,
                    UserGroupCodes: data.UserGroupCodes,
                    FirstName: data.FirstName,
                    LastName: data.LastName,
                    //GoogleDriveLocalFolderPath: data.GoogleDriveLocalFolderPath,
                    PictureLink: data.PictureLink,
                    Token: data.Token,
                    AccessToken: access_token
                };

                $("#imgUserPicture")
                    .attr("title", CurrentUser.FirstName + " " + CurrentUser.LastName + " (" + CurrentUser.Email + ")")
                    .attr("alt", CurrentUser.FirstName + " " + CurrentUser.LastName);

                if (CurrentUser.PictureLink != undefined && CurrentUser.PictureLink != null && CurrentUser.PictureLink.length > 0)
                    $("#imgUserPicture").attr("src", CurrentUser.PictureLink)

                $("#imgUserPicture").show();

                RenderApp(data);
                HideLoaderCenter();
            }
            else {
                HideLoaderCenter();
                ShowAlert("danger", "Prijava nije uspjela.", true, undefined, $("#divGoogleSignInAlert"));
            }
        })
        .fail(function (jqXHR) {
            if (jqXHR.status == 403)
                ShowAlert("danger", "Prijava nije uspjela.", true, undefined, $("#divGoogleSignInAlert"));
            else
                ShowAlert("danger", "Greška prilikom prijave. Probajte ponovo ili kontaktirajte administratora.", true, undefined, $("#divGoogleSignInAlert"));
            ShowAlert("danger", "Prijava nije uspjela.");
            HideLoaderCenter();
        });
}

function RenderApp(user) {
    $("#divGoogleSignIn").hide(); // Hide Google login button.

    var module = GetQueryStringParameterByName("module");

    var hasCaseRights = false, hasAdminRights = false;
    // Render appropriate menu items.
    if (user.UserGroupCodes.indexOf("office_admin") >= 0 || user.UserGroupCodes.indexOf("office_reader") >= 0) {
        $("#liMenuHome").show();
        $("#liMenuCases").show();
        $("#liMenuParties").show();
        $("#liMenuReports").show();
        $("#liMenuSudovi").show();
        $("#liMenuLabels").show();
        $("#liMenuCodeTables").show();
        hasCaseRights = true;
    }
    else {
        $("#liMenuHome").hide();
        $("#liMenuCases").hide();
        $("#liMenuSudovi").hide();
        $("#liMenuParties").hide();
        $("#liMenuReports").hide();
        $("#liMenuLabels").hide();
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
        CurrentModule = (module || "").toLowerCase();
        OpenMenuByModule();
    }
    else if (hasAdminRights) {
        CurrentModule = "users";
        MenuUsers();
    }
    else
        ShowAlert("danger", "Korisnik postoji ali nema dodijeljena potrebna prava za korištenje aplikacije.");

    $('#dateTimePicker_Iniciran,#dateTimePicker_DatumStanjaPredmeta,#dateTimePicker_DatumArhiviranja,#dateTimePicker_NoteDate,#dateTimePicker_ExpenseDate,#dateTimePicker_CaseActivity_ActivityDate,#dateTimePicker_Search_DatumStanjaPredmeta,#dateTimePicker_Search_IniciranFrom,#dateTimePicker_Search_IniciranTo,#dateTimePicker_Search_ArhiviranFrom,#dateTimePicker_Search_ArhiviranTo').datetimepicker({
        format: 'DD.MM.YYYY',
        showTodayButton: true
    });

    $("#dateTimePicker_Radnja_DatumRadnje").datetimepicker({
        format: 'DD.MM.YYYY HH:mm',
        showTodayButton: true
    });

    if (window.innerWidth > 1240)
        $(".modal-admin").css("margin-left", ((window.innerWidth - 1240) / 2).toString() + "px");

    SetMenuLocation();
}

function OpenMenuByModule() {
    switch (CurrentModule) {
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
        case "labels":
            MenuLabels();
            break;
        case "users":
            if (CurrentUser.UserGroupCodes.indexOf("user_admin") >= 0)
                MenuUsers();
            else
                MenuHome();
            break;
        case "advanced_search":
            MenuReports();
            break;
        default:
            $("#liMenuCodeTables").find("a").each(function (index, element) {
                if ($(element).html().toLowerCase() == CurrentModule) {
                    $(element).click();
                    return false;
                }
                if (index == $("#liMenuCodeTables").find("a").length - 1) {
                    CurrentModule = "home";
                    MenuHome();
                }
            });
            break;
    }
}

function MenuHome() {
    CurrentModule = "home";
    var location = document.location.href.split('?')[0] + "?module=" + CurrentModule;
    history.pushState({ foo: "bar" }, "Početna", location);

    DeactivateAllMenuItems();
    $("#liMenuHome").addClass("active");
    $(".menu-div").hide();
    $("#divHome").show();

    LoadCaseActivities();
    LoadRadnje();
    LoadLabels(true, false);
}

function LoadRadnje() {
    ShowLoaderCenter();

    var _columns = [
        { field: 'PredmetId' },
        { field: 'Color' },
        { field: 'VrstaRadnjeName_DatumRadnje', title: 'Vrsta radnje / Datum', titleTooltip: 'Vrsta radnje / Datum', width: "150px" },
        { field: 'CaseNasBroj_CaseFullName_Biljeska', title: 'Predmet / Bilješka', titleTooltip: 'Predmet / Bilješka' }
    ];

    $("#tblRadnje").bootstrapTable("destroy");

    var todayDate = new Date(new Date().setHours(0, 0, 0, 0));
    var tomorrowDate = new Date(new Date().setHours(0, 0, 0, 0));
    tomorrowDate.setDate(tomorrowDate.getDate() + 1);

    $.get(AppPath + "api/radnjahome", {
        UserId: CurrentUser.Id,
        Filter: $("#txtRadnjeFilter").val(),
        RowCount: $("#ddlRadnjeRowCount").val(),
        Token: CurrentUser.Token,
        Email: CurrentUser.Email
    })
        .done(function (data) {
            if (data != null && data.length > 0) {
                Radnje = data;
                $(data).each(function (index, _radnja) {

                    if (new Date(_radnja.DatumRadnje).setHours(0, 0, 0, 0) === Date.parse(tomorrowDate))
                        _radnja.Color = "#00b6ee";
                    else if (new Date(_radnja.DatumRadnje).setHours(0, 0, 0, 0) === Date.parse(todayDate))
                        _radnja.Color = "#21b04b";
                    else
                        _radnja.Color = "white";

                    if (Date.parse(_radnja.DatumRadnje))
                        _radnja.DatumRadnje = moment(_radnja.DatumRadnje).format("DD.MM.YYYY HH:mm");

                    _radnja.DatumRadnje = _radnja.DatumRadnje.replace(" 00:00", "");

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
            if (jqXHR.status == 403)
                AlertUserSessionError();
            else
                ShowAlert("danger", "Greška prilikom učitavanja radnji. Probajte ponovo ili kontaktirajte administratora.");
            HideLoaderCenter();
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
                Predmeti = null;
                EditCase(tempCaseId);
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
        { field: 'ActivityDate', title: 'Za datum', titleTooltip: 'Za datum', sortable: false, sorter: DateSorterFunction, width: "100px", "class": "bold" },
        { field: 'CaseFullName', title: 'Predmet', titleTooltip: 'Predmet', sortable: false, "class": "bold" },
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
        RowCount: $("#ddlCaseActivitiesRowCount").val(),
        Token: CurrentUser.Token,
        Email: CurrentUser.Email
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
                        _caseActivity.Color = "#ff0000";
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
            if (jqXHR.status == 403)
                AlertUserSessionError();
            else
                ShowAlert("danger", "Greška prilikom učitavanja pozvanih predmeta. Probajte ponovo ili kontaktirajte administratora.");
            HideLoaderCenter();
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
                    break;
            }

            if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0) {
                var buttonsHTML = "<td style='width: 50px;'><div class='btn-group pull-right'>";
                buttonsHTML +=
                    "<button class='btn btn-default btn-sm custom-table-button-check' data-toggle='tooltip' title='Završeno / Izbriši' onclick='DeleteCaseActivity(" + tempId.toString() + "); return false;'>"
                    + "<span class='glyphicon glyphicon-ok'></span>"
                    + "</button>";
                buttonsHTML += "</div></td>";

                $(element).append(buttonsHTML);
            }

            $(element).dblclick(function () {
                Predmeti = null;
                EditCase(tempCaseId);
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
                        url: AppPath + "api/caseactivitydelete?Id=" + id.toString() + "&Token=" + CurrentUser.Token + "&Email=" + CurrentUser.Email,
                        type: "GET",
                        success: function () {
                            LoadCaseActivities();
                            HideLoaderCenter();
                            ShowAlert("success", "Uspješno izbrisano.");
                        },
                        error: function (jqXHR) {
                            if (jqXHR.status == 403)
                                AlertUserSessionError();
                            else
                                ShowAlert("danger", "Greška prilikom brisanja stavke pozvanih predmeta. Probajte ponovo ili kontaktirajte administratora.");
                            HideLoaderCenter();
                        }
                    });
                },
                function () { }
            );

            return false; // break loop
        }
    });
}

var menuCases_DataLoadingCounter = 0;
function MenuCases_LoadDataOnly(callback) {
    if (menuCases_DataLoadingCounter === 0) {
        // Load code table data

        menuCases_DataLoadingCounter += 10;

        LoadCodeTableData("vLica_Id_Naziv", $("#ddlCase_Lice"), "Naziv", function () { menuCases_DataLoadingCounter--; });
        LoadCodeTableData("KategorijePredmeta", $("#ddlCase_Kategorija"), undefined, function () { menuCases_DataLoadingCounter--; });
        LoadCodeTableData("Sudovi", $("#ddlCase_Sud"), "Sud", function () { menuCases_DataLoadingCounter--; });
        LoadCodeTableData("Sudije", $("#ddlCase_Sudija"), undefined, function () { menuCases_DataLoadingCounter--; });
        LoadCodeTableData("Uloge", $("#ddlCase_Uloga"), undefined, function () { menuCases_DataLoadingCounter--; });
        LoadCodeTableData("Uloge", $("#ddlCase_UlogaLica"), undefined, function () { menuCases_DataLoadingCounter--; });
        LoadCodeTableData("VrstePredmeta", $("#ddlCase_VrstaPredmeta"), undefined, function () { menuCases_DataLoadingCounter--; });
        LoadCodeTableData("NaciniOkoncanja", $("#ddlCase_NacinOkoncanja"), undefined, function () { menuCases_DataLoadingCounter--; });
        LoadCodeTableData("VrsteTroskova", $("#ddlCase_ExpenseVrstaTroska"), undefined, function () { menuCases_DataLoadingCounter--; });
        LoadCodeTableData("VrsteRadnji", $("#ddlCase_Radnja_VrstaRadnje"), undefined, function () { menuCases_DataLoadingCounter--; });
        //LoadCodeTableData("TipoviDokumenata", $("#ddlCase_Document_TipDokumenta"));

        SetUpStanjeAutocomplete();
        SetUpPredatoUzAutocomplete();
        SetUpCaseConnectionAutocomplete();
        SetUpTipDokumentaAutocomplete();

        $("#ddlCase_Kategorija").html("<option>-----</option>");

        $("#ddlCase_Uspjeh").html('<option value="" selected="selected"></option>');
        for (var i = 0; i <= 100; i++)
            $("#ddlCase_Uspjeh").append($("<option " + (i == 0 ? "selected='selected'" : "") + "></option>").attr("value", i.toString() + '%').text(i.toString() + '%'));
    }

    if (callback != undefined)
        callback();
}

function MenuCases() {
    CurrentModule = "cases";
    var location = document.location.href.split('?')[0] + "?module=" + CurrentModule;
    history.pushState({ foo: "bar" }, "Predmeti", location);

    DeactivateAllMenuItems();
    $("#liMenuCases").addClass("active");
    $(".menu-div").hide();
    $("#divCases").show();

    SelectedCases = [];
    MenuCases_LoadDataOnly();

    LoadLabels(true);
    //LoadCases();
}

function ApplyLabel(_contentType, isCaseEdit) {
    ShowLoaderCenter();

    var contentIds = "";
    switch (_contentType) {
        case "case":
            if (isCaseEdit === true)
                contentIds = $("#modalCase").attr("edit_id");
            else
                for (var i = 0; i < SelectedCases.length; i++)
                    contentIds += SelectedCases[i].Id.toString() + ",";
            break;
        default:
            ShowAlert("danger", "Problem pri dodavanju oznake.");
            return;
    }

    var reqObj = {
        LabelId: (isCaseEdit === true ? $("#ddlCase_Labels").val() : $("#ddlLabels").val()),
        ContentType: _contentType,
        ContentIds: contentIds,
        Token: CurrentUser.Token,
        Email: CurrentUser.Email
    };

    $.post(AppPath + "api/labelConnection", reqObj)
        .done(function (data) {
            if (data) {

                $(data).each(function (index, _labelConnection) {
                    switch (_contentType) {
                        case "case":
                            for (var i = 0; i < Predmeti.length; i++) {
                                if (Predmeti[i].Id == _labelConnection.ContentId) {
                                    if (Predmeti[i].LabelIds && Predmeti[i].LabelIds.length > 0) {
                                        var tempLabelIds = Predmeti[i].LabelIds.split(',');
                                        if (tempLabelIds.indexOf(_labelConnection.LabelId.toString()) == -1) {
                                            tempLabelIds.push(_labelConnection.LabelId.toString());
                                            tempLabelIds.sort();
                                            Predmeti[i].LabelIds = tempLabelIds.join();
                                        }
                                    }
                                    else
                                        Predmeti[i].LabelIds = _labelConnection.LabelId.toString();
                                    $("span[name='spanContentLabels_" + _contentType + "_" + _labelConnection.ContentId.toString() + "']").html(
                                        BuildLabelsHTML(Predmeti[i].LabelIds, _contentType, _labelConnection.ContentId, isCaseEdit)
                                    );
                                    break;
                                }
                            }
                            break;
                        default:
                            ShowAlert("danger", "Problem pri dodavanju oznake.");
                            return;
                    }
                });
                $("#ddlLabels").val("");
                SelectedCases = [];
                $("#tblCases").find("input[type='checkbox']").each(function (index, element) {
                    if ($(element).prop("checked"))
                        $(element).trigger("click");
                });
                $("#divOznake").hide();
                HideLoaderCenter();
            }
            else {
                HideLoaderCenter();
                ShowAlert("danger", "Problem pri dodavanju oznake.");
            }
        })
        .fail(function (response) {
            if (jqXHR.status == 403)
                AlertUserSessionError();
            else
                ShowAlert("danger", "Greška prilikom dodavanja oznake. Probajte ponovo ili kontaktirajte administratora.");
            HideLoaderCenter();
        });
}

function DeleteLabelConnection(element, labelId, contentType, contentId) {
    ShowLoaderCenter()
    $.ajax({
        url: AppPath + "api/labelConnectiondelete?LabelId="
            + labelId.toString() + "&ContentType=" + contentType + "&ContentId=" + contentId.toString()
            + "&Token=" + CurrentUser.Token + "&Email=" + CurrentUser.Email,
        type: "GET",
        success: function () {
            for (var i = 0; i < Predmeti.length; i++)
                if (Predmeti[i].Id == contentId) {
                    var tempLabelIds = Predmeti[i].LabelIds.split(',');
                    tempLabelIds.splice(tempLabelIds.indexOf(labelId.toString()), 1);
                    tempLabelIds.sort();
                    Predmeti[i].LabelIds = tempLabelIds.join();
                    break;
                }

            $(element).parent().next().remove();
            $(element).parent().remove();
            HideLoaderCenter();
        },
        error: function (jqXHR) {
            if (jqXHR.status == 403)
                AlertUserSessionError();
            else
                ShowAlert("danger", "Greška prilikom brisanja oznake. Probajte ponovo ili kontaktirajte administratora.");
            HideLoaderCenter();
        }
    });
}

function LoadCases(caseId, callback, filter, isCaseJustSaved) {
    ShowLoaderCenter();

    if (filter != undefined && filter != null && filter.length > 0) {
        $("#txtCasesFilter").val(filter);
        $("#txtCasesFilterNasBroj").val("");
    }

    $("#tblCases").bootstrapTable("destroy");

    if (caseId == undefined)
        caseId = null;

    if (caseId != null)
        $("#txtCasesFilterNasBroj").val("");

    $.get(AppPath + "api/predmet", {
        UserId: CurrentUser.Id,
        Filter: $("#txtCasesFilter").val(),
        FilterNasBroj: $("#txtCasesFilterNasBroj").val(),
        RowCount: $("#ddlCasesRowCount").val(),
        CaseId: caseId,
        Token: CurrentUser.Token,
        Email: CurrentUser.Email
    })
        .done(function (data) {
            if (data != null && data.length > 0) {
                Predmeti = data;
                $(data).each(function (index, _case) {
                    if (Date.parse(_case.Iniciran))
                        _case.Iniciran = moment(_case.Iniciran).format("DD.MM.YYYY");

                    if (Date.parse(_case.DatumStanjaPredmeta))
                        _case.DatumStanjaPredmeta = moment(_case.DatumStanjaPredmeta).format("DD.MM.YYYY");

                    if (Date.parse(_case.SkontroDatum))
                        _case.SkontroDatum = moment(_case.SkontroDatum).format("DD.MM.YYYY");

                    if (Date.parse(_case.DatumArhiviranja))
                        _case.DatumArhiviranja = moment(_case.DatumArhiviranja).format("DD.MM.YYYY");

                    if (_case.VrijednostSpora != null)
                        _case.VrijednostSporaString = GetMoneyFormat(_case.VrijednostSpora);

                    _case.PrivremeniZastupniciString = _case.PrivremeniZastupnici ? "Da" : "Ne";
                    _case.PristupPredmetuString = _case.PristupPredmetu ? "Da" : "Ne";

                    _case.NasBrojName = "<strong>" + _case.NasBroj + "</strong>";

                    if (Labels != null)
                        _case.Labels = BuildLabelsHTML(_case.LabelIds, "case", _case.Id);

                    switch (_case.KategorijaPredmetaId) {
                        case 5:
                            // OTVOREN
                            _case.KategorijaPredmetaName = "<span style='color: #00b6ee; font-weight: bold;'>" + _case.KategorijaPredmetaName + "</span>";
                            break;
                        case 8:
                            // ARHIVIRAN
                            _case.KategorijaPredmetaName = "<span style='color: #ff0000; font-weight: bold;'>" + _case.KategorijaPredmetaName + "</span>";
                            break;
                        case 10:
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
                            columns: _columnsCases,
                            escape: false,
                            clickToSelect: false,
                            onPostBody: function () {
                                AfterBindCases();
                                if (isCaseJustSaved !== true && $("#txtCasesFilterNasBroj").val() != null && $("#txtCasesFilterNasBroj").val() != "")
                                    EditCase(data[0].Id);
                                else if (callback != undefined && typeof (callback) == "function")
                                    callback();
                                return false;
                            },
                            onCheck: function (row, element) {
                                SelectedCases.push(row);
                                $("#divOznake").show();
                            },
                            onUncheck: function (row, element) {
                                $(SelectedCases).each(function (index, _selectedCase) {
                                    if (_selectedCase.Id == row.Id) {
                                        SelectedCases.splice(index, 1);

                                        if (SelectedCases.length == 0)
                                            $("#divOznake").hide();

                                        return false;
                                    }
                                });
                            },
                            onCheckAll: function (rows) {
                                $(Predmeti).each(function (index, _case) {
                                    SelectedCases.push(_case);
                                });
                                $("#divOznake").show();
                            },
                            onUncheckAll: function (rows) {
                                SelectedCases = [];
                                $("#divOznake").hide();
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
                    columns: _columnsCases,
                    escape: false
                });
                HideLoaderCenter();
            }
        })
        .fail(function (jqXHR, textStatus, errorThrown) {
            if (jqXHR.status == 403)
                AlertUserSessionError();
            else
                ShowAlert("danger", "Greška prilikom učitavanja predmeta. Probajte ponovo ili kontaktirajte administratora.");
            HideLoaderCenter();
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


            var buttonsHTML = "<td style='width: 120px;'><div class='btn-group pull-right'>";
            buttonsHTML +=
                "<button class='btn btn-default btn-sm custom-table-button-edit' data-toggle='tooltip' title='Pregledaj / izmijeni podatke o predmetu' onclick='EditCase(" + tempId.toString() + "); return false;'>"
                + "<span class='glyphicon glyphicon-pencil'></span>"
                + "</button>";

            buttonsHTML +=
                "<button class='btn btn-default btn-sm custom-table-button-template' data-toggle='tooltip' title='Generiši dokument iz predloška' onclick='GenerateTemplateForCase(" + tempId.toString() + "); return false;'>"
                + "<span class='glyphicon glyphicon-file'></span>"
                + "</button>";

            if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0) {
                buttonsHTML +=
                    "<button class='btn btn-default btn-sm custom-table-button-delete' data-toggle='tooltip' title='Izbriši predmet' onclick='DeleteCase(" + tempId.toString() + "); return false;'>"
                    + "<span class='glyphicon glyphicon-remove'></span>"
                    + "</button>";
            }

            buttonsHTML += "</div></td>";
            $(element).append(buttonsHTML);

            $(element).dblclick(function () {
                EditCase(tempId);
            });
        }
    });
}

function DeleteCase(id) {
    $(Predmeti).each(function (index, obj) {
        if (obj.Id == id) {
            ShowPrompt(
                "Da li ste sigurni da želite izbrisati predmet?",
                "<span style='font-style: italic; color: gray;'>" + obj.NasBroj + "</span>",
                function () {
                    ShowLoaderCenter();
                    $.ajax({
                        url: AppPath + "api/predmetdelete?Id=" + id.toString() + "&Token=" + CurrentUser.Token + "&Email=" + CurrentUser.Email,
                        type: "GET",
                        success: function () {
                            LoadCases();
                            HideLoaderCenter();
                            ShowAlert("success", "Uspješno izbrisan predmet.");
                        },
                        error: function () {
                            HideLoaderCenter();
                            ShowAlert("danger", "Greška pri brisanju predmeta.");
                        }
                    });
                },
                function () { }
            );

            return false; // break loop
        }
    });
}

function MenuReports() {
    CurrentModule = "advanced_search";
    var location = document.location.href.split('?')[0] + "?module=" + CurrentModule;
    history.pushState({ foo: "bar" }, "Napredna pretraga", location);

    DeactivateAllMenuItems();
    $("#liMenuReports").addClass("active");
    $(".menu-div").hide();
    $("#divReports").show();

    LoadCodeTableData("KategorijePredmeta", $("#ddlCase_Search_Kategorija"), undefined, function () { SetMultiSelect($("#ddlCase_Search_Kategorija"), "Sve kategorije", false); });
    LoadCodeTableData("Sudovi", $("#ddlCase_Search_Sud"), "Sud", function () { SetMultiSelect($("#ddlCase_Search_Sud"), "Svi sudovi", false); });
    LoadCodeTableData("Sudije", $("#ddlCase_Search_Sudija"), undefined, function () { SetMultiSelect($("#ddlCase_Search_Sudija"), "Sve sudije", false); });
    LoadCodeTableData("Uloge", $("#ddlCase_Search_Uloga"), undefined, function () { SetMultiSelect($("#ddlCase_Search_Uloga"), "Sve uloge", false); });
    LoadCodeTableData("VrstePredmeta", $("#ddlCase_Search_VrstaPredmeta"), undefined, function () { SetMultiSelect($("#ddlCase_Search_VrstaPredmeta"), "Sve vrste predmeta", false); });
    LoadLabels(false, true);

    $("#ddlCase_Search_UspjehFrom").html("");
    $("#ddlCase_Search_UspjehTo").html("");
    for (var i = 0; i <= 100; i++) {
        $("#ddlCase_Search_UspjehFrom").append($("<option " + (i == 0 ? "selected='selected'" : "") + "></option>").attr("value", i.toString() + '%').text(i.toString() + '%'));
        $("#ddlCase_Search_UspjehTo").append($("<option " + (i == 0 ? "selected='selected'" : "") + "></option>").attr("value", i.toString() + '%').text(i.toString() + '%'));
    }
    $("#ddlCase_Search_UspjehFrom").val("0%");
    $("#ddlCase_Search_UspjehTo").val("100%");
}

function MenuParties() {
    var queryStringPartyId = GetQueryStringParameterByName("party_id");

    CurrentModule = "parties";
    var location = document.location.href.split('?')[0] + "?module=" + CurrentModule;
    if (queryStringPartyId != undefined && queryStringPartyId != null)
        location += "&party_id=" + queryStringPartyId;

    history.pushState({ foo: "bar" }, "Stranke", location);

    DeactivateAllMenuItems();
    $("#liMenuParties").addClass("active");
    $(".menu-div").hide();
    $("#divParties").show();

    // Load code table data
    LoadCodeTableData("Drzave", $("#ddlParty_Drzava"));

    LoadParties(queryStringPartyId);
}

function LoadParties(queryStringPartyId) {
    ShowLoaderCenter();

    var _columns = [
        { field: 'Id' },
        { field: 'Naziv', title: 'Ime / Naziv', titleTooltip: 'Ime / Naziv', sortable: true, "class": "bold" },
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
        RowCount: $("#ddlPartiesRowCount").val(),
        PartyId: ((queryStringPartyId != undefined && queryStringPartyId != null) ? queryStringPartyId : null),
        Token: CurrentUser.Token,
        Email: CurrentUser.Email
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
                                AfterBindParties(queryStringPartyId);
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
            if (jqXHR.status == 403)
                AlertUserSessionError();
            else
                ShowAlert("danger", "Greška prilikom učitavanja stranki. Probajte ponovo ili kontaktirajte administratora.");
            HideLoaderCenter();
        });
}

function AfterBindParties(queryStringPartyId) {
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
                buttonsHTML += "</div></td>";

                $(element).append(buttonsHTML);
            }

            $(element).dblclick(function () {
                EditParty(tempId);
            });

            if (queryStringPartyId == tempId)
                $(element).dblclick();
        }
    });
}

function MenuUsers() {
    CurrentModule = "users";
    var location = document.location.href.split('?')[0] + "?module=" + CurrentModule;
    history.pushState({ foo: "bar" }, "Korisnici", location);

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
        { field: 'UserGroupNames', title: 'Korisničke grupe', titleTooltip: 'Korisničke grupe', sortable: true }
        //{ field: 'GoogleDriveLocalFolderPath', title: 'Google Drive direktorij', titleTooltip: 'Google Drive direktorij (lokalna putanja)', sortable: true }
    ];

    $("#tblUsers").bootstrapTable("destroy");

    $.get(AppPath + "api/user", {
        UserId: CurrentUser.Id,
        Token: CurrentUser.Token,
        Email: CurrentUser.Email
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
            if (jqXHR.status == 403)
                AlertUserSessionError();
            else
                ShowAlert("danger", "Greška prilikom učitavanja korisnika. Probajte ponovo ili kontaktirajte administratora.");
            HideLoaderCenter();
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
                buttonsHTML += "</div></td>";

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
            //$("#txtUser_GoogleDriveLocalFolderPath").val(obj.GoogleDriveLocalFolderPath);

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
                        url: AppPath + "api/userdelete?Id=" + id.toString()
                            + "&Token=" + CurrentUser.Token + "&Email=" + CurrentUser.Email,
                        type: "GET",
                        success: function () {
                            LoadUsers();
                            HideLoaderCenter();
                            ShowAlert("success", "Uspješno izbrisan korisnik.");
                        },
                        error: function (jqXHR) {
                            if (jqXHR.status == 403)
                                AlertUserSessionError();
                            else
                                ShowAlert("danger", "Greška prilikom brisanja korisnika. Probajte ponovo ili kontaktirajte administratora.");
                            HideLoaderCenter();
                        }
                    });
                },
                function () { }
            );

            return false; // break loop
        }
    });
}

function MenuLabels() {
    CurrentModule = "labels";
    var location = document.location.href.split('?')[0] + "?module=" + CurrentModule;
    history.pushState({ foo: "bar" }, "Oznake", location);

    DeactivateAllMenuItems();
    //$("#liMenuLabels").addClass("active");
    $(".menu-div").hide();
    $("#divLabels").show();

    LoadLabels(false);
}

function LoadLabels(inCasesModule, inAdvancedSearchModule) {
    ShowLoaderCenter();

    if (!inCasesModule) {
        var _columns = [
            { field: 'Id' },
            { field: 'Name', title: 'Naziv', titleTooltip: 'Naziv', sortable: true },
            { field: 'Colors', title: 'Boja', titleTooltip: 'Boja', sortable: true }
        ];
        $("#tblLabels").bootstrapTable("destroy");
    }

    $.get(AppPath + "api/label", {
        UserId: CurrentUser.Id,
        Token: CurrentUser.Token,
        Email: CurrentUser.Email
    })
        .done(function (data) {
            if (data != null && data.length > 0) {
                Labels = data;

                if (inCasesModule) {
                    $("#ddlLabels").html('<option value="" selected="selected">----</option>');
                    $("#ddlCase_Labels").html("");
                    $(Labels).each(function (index, _label) {
                        $("#ddlLabels").append($("<option></option>").attr("value", _label.Id).text(_label.Name));
                        $("#ddlCase_Labels").append($("<option></option>").attr("value", _label.Id).text(_label.Name));
                    });
                    HideLoaderCenter();
                }
                else if (inAdvancedSearchModule) {
                    if (Labels && Labels.length > 0)
                        $(Labels).each(function (index, _label) {
                            $("#ddlCase_Search_Labels").append($("<option></option>").attr("value", _label.Id).text(_label.Name));
                            if (index == Labels.length - 1)
                                SetMultiSelect($("#ddlCase_Search_Labels"), "Sve oznake", false);
                        });
                    else
                        SetMultiSelect($("#ddlCase_Search_Labels"), "Sve oznake");

                    HideLoaderCenter();
                }
                else {
                    $("#ddlCase_Labels").html("");
                    $(Labels).each(function (index, _label) {
                        $("#ddlCase_Labels").append($("<option></option>").attr("value", _label.Id).text(_label.Name));
                        _label.Colors = "<div style='padding:3px; display:inline-block; background-color:" + _label.BackgroundColor + "; color:" + _label.FontColor + "'>" + _label.Name + "</div>";

                        if (index == Labels.length - 1) {
                            $("#tblLabels").bootstrapTable({
                                data: data,
                                striped: true,
                                showColumns: true,
                                columns: _columns,
                                search: true,
                                escape: false,
                                onPostBody: function () {
                                    AfterBindLabels();
                                    return false;
                                }
                            });
                            HideLoaderCenter();
                        }
                    });
                }
            }
            else {
                if (!inCasesModule) {
                    $("#tblLabels").bootstrapTable({
                        data: [],
                        striped: true,
                        showColumns: true,
                        columns: _columns,
                        search: true
                    });
                }
                HideLoaderCenter();
            }
        })
        .fail(function (jqXHR, textStatus, errorThrown) {
            if (jqXHR.status == 403)
                AlertUserSessionError();
            else
                ShowAlert("danger", "Greška prilikom učitavanja oznaka. Probajte ponovo ili kontaktirajte administratora.");
            HideLoaderCenter();
        });
}

function AfterBindLabels() {
    $("#tblLabels").find("tr").each(function (index, element) {
        if (index == 0) {
            $(element).find("th:first-child").hide();
            if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0)
                if ($("#labelsEmptyHeader").length == 0)
                    $(element).append("<th id='labelsEmptyHeader'></th>");
        }
        else {
            var tempId = parseInt($(element).find("td:first-child").html());
            $(element).find("td:first-child").hide();

            if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0) {
                var buttonsHTML = "<td style='width: 100px;'><div class='btn-group pull-right'>";
                buttonsHTML +=
                    "<button class='btn btn-default btn-sm custom-table-button-edit' data-toggle='tooltip' title='Izmijeni oznaku' onclick='EditLabel(" + tempId.toString() + "); return false;'>"
                    + "<span class='glyphicon glyphicon-pencil'></span>"
                    + "</button>";

                buttonsHTML +=
                    "<button class='btn btn-default btn-sm custom-table-button-delete' data-toggle='tooltip' title='Izbriši oznaku' onclick='DeleteLabel(" + tempId.toString() + "); return false;'>"
                    + "<span class='glyphicon glyphicon-remove'></span>"
                    + "</button>";
                buttonsHTML += "</div></td>";

                $(element).append(buttonsHTML);
            }
        }
    });
}

function EditLabel(id) {
    $("#modalLabel").attr("edit_id", id);

    $(Labels).each(function (index, obj) {
        if (obj.Id == id) {
            $("#txtLabel_Name").val(obj.Name);
            $("#txtLabel_BackgroundColor").val(obj.BackgroundColor);
            $("#txtLabel_FontColor").val(obj.FontColor);

            $("#txtLabel_Name").css("background-color", $("#txtLabel_BackgroundColor").val());
            $("#txtLabel_Name").css("color", $("#txtLabel_FontColor").val());

            $("#modalLabel").find(".modal-title").html("Izmijeni oznaku: <span style='font-style: italic; color: gray;'>" + obj.Name + "</span>");
            $("#btnOpenModalEditLabel").click();

            return false; // break loop
        }
    });
}

function DeleteLabel(id) {
    $(Labels).each(function (index, obj) {
        if (obj.Id == id) {
            ShowPrompt(
                "Da li ste sigurni da želite izbrisati oznaku?",
                "<span style='font-style: italic; color: gray;'>" + obj.Name + "</span>",
                function () {
                    ShowLoaderCenter();
                    $.ajax({
                        url: AppPath + "api/labeldelete?Id=" + id.toString()
                            + "&Token=" + CurrentUser.Token + "&Email=" + CurrentUser.Email,
                        type: "GET",
                        success: function () {
                            LoadLabels();
                            HideLoaderCenter();
                            ShowAlert("success", "Uspješno izbrisana oznaka.");
                        },
                        error: function (jqXHR) {
                            if (jqXHR.status == 403)
                                AlertUserSessionError();
                            else
                                ShowAlert("danger", "Greška prilikom brisanja oznake. Probajte ponovo ili kontaktirajte administratora.");
                            HideLoaderCenter();
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
    CurrentModule = "courts";
    var location = document.location.href.split('?')[0] + "?module=" + CurrentModule;
    history.pushState({ foo: "bar" }, "Sudovi", location);

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
        { field: 'Naziv', title: 'Naziv', titleTooltip: 'Naziv', sortable: true, "class": "bold" },
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
        UserId: CurrentUser.Id,
        Token: CurrentUser.Token,
        Email: CurrentUser.Email
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
            if (jqXHR.status == 403)
                AlertUserSessionError();
            else
                ShowAlert("danger", "Greška prilikom učitavanja sudova. Probajte ponovo ili kontaktirajte administratora.");
            HideLoaderCenter();
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
                buttonsHTML += "</div></td>";

                $(element).append(buttonsHTML);
            }

            $(element).dblclick(function () {
                EditSud(tempId);
            });
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
                        url: AppPath + "api/suddelete?Id=" + id.toString()
                            + "&Token=" + CurrentUser.Token + "&Email=" + CurrentUser.Email,
                        type: "GET",
                        success: function () {
                            LoadSudovi();
                            HideLoaderCenter();
                            ShowAlert("success", "Uspješno izbrisan sud.");
                        },
                        error: function (jqXHR) {
                            if (jqXHR.status == 403)
                                AlertUserSessionError();
                            else
                                ShowAlert("danger", "Greška prilikom brisanja suda. Probajte ponovo ili kontaktirajte administratora.");
                            HideLoaderCenter();
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
            ActivityDaysOffset: $("#txtCase_CaseActivity_ActivityDaysOffset").val(),
            ForAllUsers: $("#cbCase_CaseActivity_ForAllUsers").prop("checked"),
            CreatedBy: CurrentUser.Id,
            Token: CurrentUser.Token,
            Email: CurrentUser.Email
        })
            .done(function (data) {
                if (data && data > 0) {
                    LoadCaseActivities();
                    HideLoaderCenter();
                }
                else {
                    HideLoaderCenter();
                    ShowAlert("danger", "Greška pri spašavanju pozivanja predmeta.");
                }
            })
            .fail(function (jqXHR) {
                if (jqXHR.status == 403)
                    AlertUserSessionError();
                else
                    ShowAlert("danger", "Greška prilikom spašavanja pozivanja predmeta. Probajte ponovo ili kontaktirajte administratora.");
                HideLoaderCenter();
            });
    }
}

function SaveCase() {
    ShowLoaderCenter();

    var _stanjePredmetaName = "";
    //if ($("#ddlCase_Search_StanjaPredmeta").val() != -1)
    //    _stanjePredmetaName = $("#ddlCase_Search_StanjaPredmeta option:selected").text();
    //else
    _stanjePredmetaName = $("#txtCase_StanjePredmeta").val();

    var reqObj = {
        CreatedBy: CurrentUser.Id,
        KategorijaPredmetaId: $("#ddlCase_Kategorija").val(),
        UlogaId: $("#ddlCase_Uloga").val(),
        PrivremeniZastupnici: $("#cbCase_PrivremeniZastupnici").prop("checked"),
        PristupPredmetu: $("#cbCase_PristupPredmetu").prop("checked"),
        Iniciran: ConvertBSDateToUSDateString($("#txtCase_Iniciran").val()),
        BrojPredmeta: $("#txtCase_BrojPredmeta").val(),
        SudId: $("#ddlCase_Sud").val(),
        SudijaId: $("#ddlCase_Sudija").val(),
        VrijednostSpora: $("#txtCase_VrijednostSpora").attr("number_value"),
        VrstaPredmetaId: $("#ddlCase_VrstaPredmeta").val(),
        DatumStanjaPredmeta: ConvertBSDateToUSDateString($("#txtCase_DatumStanjaPredmeta").val()),
        //StanjePredmetaId: $("#ddlCase_StanjePredmeta").val(),
        StanjePredmetaName: _stanjePredmetaName,

        NacinOkoncanjaId: $("#ddlCase_NacinOkoncanja").val(),
        Uspjeh: $("#ddlCase_Uspjeh").val(),
        DatumArhiviranja: ConvertBSDateToUSDateString($("#txtCase_DatumArhiviranja").val()),
        BrojArhive: $("#txtCase_BrojArhive").val(),
        BrojArhiveRegistrator: $("#txtCase_BrojArhiveRegistrator").val(),

        PravniOsnov: $("#txtCase_PravniOsnov").val(),

        Parties: CurrentCase.Parties,
        Notes: CurrentCase.Notes,
        Expenses: CurrentCase.Expenses,
        Radnje: CurrentCase.Radnje,
        Documents: CurrentCase.Documents,
        Connections: CurrentCase.Connections,

        Token: CurrentUser.Token,
        Email: CurrentUser.Email
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

                UpdateRadnje_GoogleEvents();

                if ($("#cbCase_CaseActivity_SaveNew").prop("checked"))
                    SaveCaseActivity();

                HideLoaderCenter();
                if (CurrentModule == "home") // Case activities loaded in SaveCaseActivity()
                    LoadRadnje();
                else if (CurrentModule == "cases")
                    LoadCases(undefined, undefined, undefined, true);
            }
            else {
                HideLoaderCenter();
                ShowAlert("danger", "Greška pri spašavanju predmeta.");
            }
        })
        .fail(function (jqXHR) {
            if (jqXHR.status == 403)
                AlertUserSessionError();
            else
                ShowAlert("danger", "Greška prilikom spašavanja predmeta. Probajte ponovo ili kontaktirajte administratora.");
            HideLoaderCenter();
        });
}

function UpdateRadnje_GoogleEvents() {
    $.get(AppPath + "api/radnja", {
        PredmetId: CurrentCase.Id,
        UserId: CurrentUser.Id,
        Token: CurrentUser.Token,
        Email: CurrentUser.Email
    })
        .done(function (data) {
            CurrentCase.Radnje = data;

            $(CurrentCase.Radnje).each(function (index, _radnja) {
                if (_radnja.CreateCalendarEvent
                    && (_radnja.GoogleEventId == undefined || _radnja.GoogleEventId == null || _radnja.GoogleEventId == ""))
                    CreateGoogleCalendarEvent(_radnja, UpdateRadnja_GoogleEventId);
            });

            $(CurrentCase.DeletedRadnje).each(function (index, _radnja) {
                DeleteGoogleCalendarEvent(_radnja.GoogleEventId);
            });
        })
        .fail(function (jqXHR, textStatus, errorThrown) {
            if (jqXHR.status == 403)
                AlertUserSessionError();
            else
                ShowAlert("danger", "Greška prilikom učitavanja radnji. Probajte ponovo ili kontaktirajte administratora.");
        });
}

function UpdateRadnja_GoogleEventId(radnja) {
    $.post(AppPath + "api/radnja", {
        Id: radnja.Id,
        GoogleEventId: radnja.GoogleEventId,
        Token: CurrentUser.Token,
        Email: CurrentUser.Email
    })
        .done(function (data) {
        })
        .fail(function (jqXHR) {
            if (jqXHR.status == 403)
                AlertUserSessionError();
            else
                ShowAlert("danger", "Greška prilikom kreiranja radnje u Google kalendaru. Kontaktirajte administratora.");
        });
}


function ClearInputSectionRadnje() {
    $("#ddlCase_Radnja_VrstaRadnje").val(-1);
    $("#txtCase_Radnja_DatumRadnje").val("");
    $("#txtCase_Radnja_Biljeske").val("");
    $("#aCase_Radnja_DocumentLink").html("");
    $("#aCase_Radnja_DocumentLink").removeAttr("href");
    $("#aCase_Radnja_DocumentLink").removeAttr("google_drive_doc_id");
    $("#btnCase_Radnja_RemoveGoogleDoc").hide();
    $("#btnAppendRadnjaToCase").attr("disabled", "disabled");
}

function ClearInputSectionDocuments() {
    //$("#ddlCase_Document_TipDokumenta").val(-1);
    $("#txtCase_Document_TipDokumenta").val("");
    $("#txtCase_Document_PredatoUz").val("");
    $("#txtCase_Document_Note").val("");
    $("#aCase_Document_DocumentLink").html("");
    $("#aCase_Document_DocumentLink").removeAttr("href");
    $("#aCase_Document_DocumentLink").removeAttr("google_drive_doc_id");
    $("#btnCase_Document_RemoveGoogleDoc").hide();
    $("#btnAppendDocumentToCase").attr("disabled", "disabled");
}

function ClearInputSectionConnections() {
    $("#txtCase_Connection_ConnectionCase").val("");
    $("#txtCase_Connection_ConnectionCase").attr("caseId", -1);
    $("#txtCase_Connection_Note").val("");
    $("#btnAppendConnectionToCase").attr("disabled", "disabled");
}

function ClearInputSectionExpenses() {
    $("#ddlCase_ExpenseVrstaTroska").val(-1);
    $("#txtCase_ExpenseAmount").val("");
    $("#txtCase_ExpenseAmount").removeAttr("number_value");
    $("#txtCase_ExpenseDate").val("");
    $("#ddlCase_ExpensePaidBy").val("");
    $("#btnAppendExpenseToCase").attr("disabled", "disabled");
}

function ClearInputSectionNotes() {
    $("#txtCase_NoteDate").val("");
    $("#txtCase_NoteText").val("");
    $("#btnAppendNoteToCase").attr("disabled", "disabled");
}

function EditCase(id) {
    $("#modalCase").attr("edit_id", id);

    OpenOtherTab($("#aRadnjeOtherTab"), "divRadnje");

    // LicePredmet
    $("#ddlCase_Lice").val(-1);
    $("#ddlCase_UlogaLica").val(-1);
    $("#ddlCase_GlavnaStranka").val("");
    $("#ddlCase_UlogaOrdinalNo").val("");
    $("#btnAppendPartyToCase").attr("disabled", "disabled");

    // Notes
    ClearInputSectionNotes();

    // Expenses
    ClearInputSectionExpenses();

    // Radnje
    ClearInputSectionRadnje();

    // Documents
    ClearInputSectionDocuments();

    // Connections
    ClearInputSectionConnections();

    // Skontro
    $("#cbCase_CaseActivity_SaveNew").removeAttr("disabled");
    $("#cbCase_CaseActivity_SaveNew").prop("checked", false);

    $("#txtCase_CaseActivity_ActivityDaysOffset").val(0);
    $("#txtCase_CaseActivity_ActivityDate").val("");
    $("#txtCase_CaseActivity_Note").val("");
    $("#cbCase_CaseActivity_ForAllUsers").prop("checked", true);
    $("#txtCase_CaseActivity_ActivityDate").attr("disabled", "disabled");
    $("#txtCase_CaseActivity_ActivityDaysOffset").attr("disabled", "disabled");
    $("#txtCase_CaseActivity_Note").attr("disabled", "disabled");
    $("#cbCase_CaseActivity_ForAllUsers").attr("disabled", "disabled");

    $("#btnGenerateTemplateForCase").off("click");

    $("#btnSaveCase").hide();
    $("#btnSaveAndCloseCase").hide();

    if (Predmeti == null)
        MenuCases_LoadDataOnly(
            function () {
                LoadCases(id, function () {
                    EditCase(id);
                });
            });
    else {
        var caseFound = false;
        $(Predmeti).each(function (index, obj) {
            if (obj.Id == id) {
                caseFound = true;
                CurrentCase = $.extend(true, {}, obj);
                $("#txtCase_NasBroj").val(CurrentCase.NasBroj);
                $("#ddlCase_Kategorija").val(CurrentCase.KategorijaPredmetaId).change();
                $("#ddlCase_Uloga").val(CurrentCase.UlogaId);
                $("#cbCase_PrivremeniZastupnici").prop("checked", CurrentCase.PrivremeniZastupnici);
                $("#cbCase_PristupPredmetu").prop("checked", CurrentCase.PristupPredmetu);
                $("#txtCase_Iniciran").val(CurrentCase.Iniciran);
                $("#txtCase_BrojPredmeta").val(CurrentCase.BrojPredmeta);
                $("#ddlCase_Sud").val(CurrentCase.SudId);
                $("#ddlCase_Sudija").val(CurrentCase.SudijaId);
                $("#txtCase_VrijednostSpora").attr("number_value", CurrentCase.VrijednostSpora);
                $("#txtCase_VrijednostSpora").val(GetMoneyFormat(CurrentCase.VrijednostSpora));
                $("#ddlCase_VrstaPredmeta").val(CurrentCase.VrstaPredmetaId);
                $("#txtCase_DatumStanjaPredmeta").val(CurrentCase.DatumStanjaPredmeta);
                //$("#ddlCase_Search_StanjaPredmeta").val(CurrentCase.StanjePredmetaId);
                $("#txtCase_StanjePredmeta").val(CurrentCase.StanjePredmetaName);

                $("#ddlCase_NacinOkoncanja").val(CurrentCase.NacinOkoncanjaId);
                $("#ddlCase_Uspjeh").val(CurrentCase.Uspjeh);
                $("#txtCase_DatumArhiviranja").val(CurrentCase.DatumArhiviranja);
                $("#txtCase_BrojArhive").val(CurrentCase.BrojArhive);
                $("#txtCase_BrojArhiveRegistrator").val(CurrentCase.BrojArhiveRegistrator);

                $("#txtCase_PravniOsnov").val(CurrentCase.PravniOsnov);

                //Skontro
                $("#txtCase_CaseActivity_ActivityDaysOffset").val(CurrentCase.SkontroDan);
                $("#txtCase_CaseActivity_ActivityDate").val(CurrentCase.SkontroDatum);
                $("#txtCase_CaseActivity_Note").val(CurrentCase.SkontroBiljeska);

                if (CurrentCase.SkontroDan != null)
                    $("#cbCase_CaseActivity_ForAllUsers").prop("checked", CurrentCase.Skontro_ForAllUsers);
                else
                    $("#cbCase_CaseActivity_ForAllUsers").prop("checked", true);

                $("#modalCase").find(".modal-title").html("Izmijeni predmet: <span style='font-style: italic; color: gray;'>" + CurrentCase.Naziv + "</span>");

                CurrentCase.Labels = BuildLabelsHTML(CurrentCase.LabelIds, "case", CurrentCase.Id, true);
                $("#divCase_Labels").html(CurrentCase.Labels);
                setTimeout(function () {
                    $("#divCase_Labels").css("max-width", ($("#divCase_Labels").parent().parent().width() / 2).toString() + "px");
                }, 1000);

                var allLoadedFlag = 0;

                function HandleAllLoadedFlag() {
                    allLoadedFlag--;
                    if (allLoadedFlag <= 0 && CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0) {
                        $("#btnSaveCase").show();
                        $("#btnSaveAndCloseCase").show();
                    }
                };

                ShowLoaderCenter();
                allLoadedFlag++;
                $.get(AppPath + "api/licepredmet", {
                    Id: CurrentCase.Id,
                    Token: CurrentUser.Token,
                    Email: CurrentUser.Email
                })
                    .done(function (data) {
                        CurrentCase.Parties = data;
                        BindCaseParties(CurrentCase.Parties);
                        HideLoaderCenter();
                        HandleAllLoadedFlag();
                    })
                    .fail(function (jqXHR, textStatus, errorThrown) {
                        if (jqXHR.status == 403)
                            AlertUserSessionError();
                        else
                            ShowAlert("danger", "Greška prilikom učitavanja stranki. Probajte ponovo ili kontaktirajte administratora.");
                        HideLoaderCenter();
                        HandleAllLoadedFlag();
                    });

                ShowLoaderCenter();
                allLoadedFlag++;
                $.get(AppPath + "api/note", {
                    CaseId: CurrentCase.Id,
                    Token: CurrentUser.Token,
                    Email: CurrentUser.Email
                })
                    .done(function (data) {
                        CurrentCase.Notes = data;
                        BindCaseNotes(CurrentCase.Notes);
                        HideLoaderCenter();
                        HandleAllLoadedFlag();
                    })
                    .fail(function (jqXHR, textStatus, errorThrown) {
                        if (jqXHR.status == 403)
                            AlertUserSessionError();
                        else
                            ShowAlert("danger", "Greška prilikom učitavanja bilješki. Probajte ponovo ili kontaktirajte administratora.");
                        HideLoaderCenter();
                        HandleAllLoadedFlag();
                    });

                ShowLoaderCenter();
                allLoadedFlag++;
                $.get(AppPath + "api/expense", {
                    CaseId: CurrentCase.Id,
                    Token: CurrentUser.Token,
                    Email: CurrentUser.Email
                })
                    .done(function (data) {
                        CurrentCase.Expenses = data;
                        BindCaseExpenses(CurrentCase.Expenses);
                        HideLoaderCenter();
                        HandleAllLoadedFlag();
                    })
                    .fail(function (jqXHR, textStatus, errorThrown) {
                        if (jqXHR.status == 403)
                            AlertUserSessionError();
                        else
                            ShowAlert("danger", "Greška prilikom učitavanja troškova. Probajte ponovo ili kontaktirajte administratora.");
                        HideLoaderCenter();
                        HandleAllLoadedFlag();
                    });

                ShowLoaderCenter();
                allLoadedFlag++;
                $.get(AppPath + "api/radnja", {
                    PredmetId: CurrentCase.Id,
                    UserId: CurrentUser.Id,
                    Token: CurrentUser.Token,
                    Email: CurrentUser.Email
                })
                    .done(function (data) {
                        CurrentCase.Radnje = data;
                        CurrentCase.DeletedRadnje = [];
                        BindCaseRadnje(CurrentCase.Radnje);
                        HideLoaderCenter();
                        HandleAllLoadedFlag();
                    })
                    .fail(function (jqXHR, textStatus, errorThrown) {
                        if (jqXHR.status == 403)
                            AlertUserSessionError();
                        else
                            ShowAlert("danger", "Greška prilikom učitavanja radnji. Probajte ponovo ili kontaktirajte administratora.");
                        HideLoaderCenter();
                        HandleAllLoadedFlag();
                    });

                ShowLoaderCenter();
                allLoadedFlag++;
                $.get(AppPath + "api/document", {
                    CaseId: CurrentCase.Id,
                    UserId: CurrentUser.Id,
                    Token: CurrentUser.Token,
                    Email: CurrentUser.Email
                })
                    .done(function (data) {
                        CurrentCase.Documents = data;
                        BindCaseDocuments(CurrentCase.Documents);
                        HideLoaderCenter();
                        HandleAllLoadedFlag();
                    })
                    .fail(function (jqXHR, textStatus, errorThrown) {
                        if (jqXHR.status == 403)
                            AlertUserSessionError();
                        else
                            ShowAlert("danger", "Greška prilikom učitavanja dokumenata. Probajte ponovo ili kontaktirajte administratora.");
                        HideLoaderCenter();
                        HandleAllLoadedFlag();
                    });

                ShowLoaderCenter();
                allLoadedFlag++;
                $.get(AppPath + "api/connection", {
                    CaseId: CurrentCase.Id,
                    UserId: CurrentUser.Id,
                    Token: CurrentUser.Token,
                    Email: CurrentUser.Email
                })
                    .done(function (data) {
                        CurrentCase.Connections = data;
                        BindCaseConnections(CurrentCase.Connections);
                        HideLoaderCenter();
                        HandleAllLoadedFlag();
                    })
                    .fail(function (jqXHR, textStatus, errorThrown) {
                        if (jqXHR.status == 403)
                            AlertUserSessionError();
                        else
                            ShowAlert("danger", "Greška prilikom učitavanja veza. Probajte ponovo ili kontaktirajte administratora.");
                        HideLoaderCenter();
                        HandleAllLoadedFlag();
                    });

                $("#btnGenerateTemplateForCase").click(function () {
                    GenerateTemplateForCase(CurrentCase.Id);
                });

                $("#btnOpenModalEditCase").click();
                return false; // break loop
            }

            if (index == Predmeti.length - 1 && caseFound === false) {
                MenuCases_LoadDataOnly();
                LoadCases(id, function () { EditCase(id); });
            }
        });
    }
}

function GenerateTemplateForCase(id) {
    $(Predmeti).each(function (index, _case) {
        if (_case.Id == id) {
            $("#modalTemplate").attr("case_id", id);
            $("#modalTemplate").attr("case_nasBroj", _case.NasBroj);
            LoadTemplates(function () { $("#btnOpenModalGenerateTemplate").click(); })
            return false;
        }
    });
}

function GenerateTemplate() {

    ShowLoaderCenter();
    $.post(AppPath + "api/template", {
        TemplateName: $("#ddlTemplates").val(),
        CaseId: parseInt($("#modalTemplate").attr("case_id")),
        UserId: CurrentUser.Id,
        FilterNasBroj: parseInt($("#modalTemplate").attr("case_nasBroj")),
        Token: CurrentUser.Token,
        Email: CurrentUser.Email
    })
        .done(function (data) {
            if (data && data.length > 0) {
                window.location = AppPath + "/Temp/" + CurrentUser.Id.toString() + "/" + data;
                ShowAlert("success", "Uspješno generisan dokument.");
                HideLoaderCenter();
            }
            else {
                HideLoaderCenter();
                ShowAlert("danger", "Greška pri generisanju dokumenta.");
            }
        })
        .fail(function (jqXHR) {
            if (jqXHR.status == 403)
                AlertUserSessionError();
            else
                ShowAlert("danger", "Greška prilikom generisanja dokumenta. Probajte ponovo ili kontaktirajte administratora.");
            HideLoaderCenter();
        });
}

function LoadTemplates(callback) {
    ShowLoaderCenter();
    $.get(AppPath + "api/template", {
        UserId: CurrentUser.Id,
        Token: CurrentUser.Token,
        Email: CurrentUser.Email
    })
        .done(function (data) {
            if (data != null && data.length > 0) {
                Templates = data;
                $("#ddlTemplates").html('<option value="">-----</option>');
                $(Templates).each(function (index, _template) {
                    $("#ddlTemplates").append($("<option></option>").attr("value", _template.Name).text(_template.Name.replace(".docx", "")));
                    if (index == Templates.length - 1) {
                        if (callback != undefined && typeof (callback) == "function")
                            callback();
                    }
                });
            }
            HideLoaderCenter();
        })
        .fail(function (jqXHR, textStatus, errorThrown) {
            if (jqXHR.status == 403)
                AlertUserSessionError();
            else
                ShowAlert("danger", "Greška prilikom učitavanja predložaka. Probajte ponovo ili kontaktirajte administratora.");
            HideLoaderCenter();
        });
}

function ClearModalUser() {
    $("#modalUser").removeAttr("edit_id");
    $("#txtUser_Email").val("");
    $("#txtUser_FirstName").val("");
    $("#txtUser_LastName").val("");
    $("#txtUser_Phone").val("");
    //$("#txtUser_GoogleDriveLocalFolderPath").val("");
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
        //GoogleDriveLocalFolderPath: $("#txtUser_GoogleDriveLocalFolderPath").val(),
        UserGroupCodes: GetDataFromMultiselect("ddlUser_UserGroups"),
        Token: CurrentUser.Token,
        ValidationEmail: CurrentUser.Email
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
        .fail(function (jqXHR) {
            if (jqXHR.status == 403)
                AlertUserSessionError();
            else
                ShowAlert("danger", "Greška prilikom spašavanja korisnika. Probajte ponovo ili kontaktirajte administratora.");
            HideLoaderCenter();
        });
}

function ClearModalLabel() {
    $("#modalLabel").removeAttr("edit_id");
    $("#txtLabel_Name").val("");
    $("#txtLabel_BackgroundColor").val("#ffffff");
    $("#txtLabel_FontColor").val("#000000");

    $("#txtLabel_Name").css("background-color", "default");
    $("#txtLabel_Name").css("color", "default");

    $("#modalLabel").find(".modal-title").html("Nova oznaka");
}

function SaveLabel() {
    ShowLoaderCenter();

    var reqObj = {
        Name: $("#txtLabel_Name").val(),
        BackgroundColor: $("#txtLabel_BackgroundColor").val(),
        FontColor: $("#txtLabel_FontColor").val(),
        Token: CurrentUser.Token,
        Email: CurrentUser.Email
    };

    var tempId = $("#modalLabel").attr("edit_id");

    if (tempId != undefined)
        reqObj.Id = tempId;

    $.post(AppPath + "api/label", reqObj)
        .done(function (data) {
            if (data && data > 0) {
                ShowAlert("success", "Uspješno spašena oznaka.");
                HideLoaderCenter();
                LoadLabels(false);
            }
            else {
                HideLoaderCenter();
                ShowAlert("danger", "Greška pri spašavanju oznake.");
            }
        })
        .fail(function (jqXHR) {
            if (jqXHR.status == 403)
                AlertUserSessionError();
            else
                ShowAlert("danger", "Greška prilikom spašavanja oznake. Probajte ponovo ili kontaktirajte administratora.");
            HideLoaderCenter();
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
        RacunVjestacenja: $("#txtSud_RacunVjestacenja").val(),

        Token: CurrentUser.Token,
        Email: CurrentUser.Email
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
        .fail(function (jqXHR) {
            if (jqXHR.status == 403)
                AlertUserSessionError();
            else
                ShowAlert("danger", "Greška prilikom spašavanja suda. Probajte ponovo ili kontaktirajte administratora.");
            HideLoaderCenter();
        });
}

function LoadUserGroups() {
    ShowLoaderCenter();
    $.get(AppPath + "api/usergroup", {
        UserId: CurrentUser.Id,
        Token: CurrentUser.Token,
        Email: CurrentUser.Email
    })
        .done(function (data) {
            if (data) {
                $("#ddlUser_UserGroups").html("");
                $(data).each(function (index, obj) {
                    $("#ddlUser_UserGroups").append($("<option></option>").attr("value", obj.Code).text(obj.Name));
                    if (index == data.length - 1) {
                        $("#ddlUser_UserGroups").multiselect({
                            includeSelectAllOption: false,
                            allSelectedText: "Sve grupe",
                            //selectAllText: "Odaberi sve / ništa",
                            nonSelectedText: "Ništa nije odabrano",
                            maxHeight: 200
                        });
                    }
                });
                HideLoaderCenter();
            }
            else
                HideLoaderCenter();
        })
        .fail(function (jqXHR, textStatus, errorThrown) {
            if (jqXHR.status == 403)
                AlertUserSessionError();
            else
                ShowAlert("danger", "Greška prilikom učitavanja korisničkih grupa. Probajte ponovo ili kontaktirajte administratora.");
            HideLoaderCenter();
        });
}

function SetMultiSelect(element, _allSelectedText, _includeSelectAllOption) {
    if (_includeSelectAllOption == undefined)
        _includeSelectAllOption = true;
    element.multiselect({
        includeSelectAllOption: _includeSelectAllOption,
        allSelectedText: _allSelectedText,
        selectAllText: "Odaberi sve / ništa",
        nonSelectedText: "Ništa nije odabrano",
        maxHeight: 200
    });
}

function LoadCodeTableData(tableName, dropDown, columnName, callback) {
    if (columnName == undefined)
        columnName = "Name";

    ShowLoaderCenter();
    $.get(AppPath + "api/codetable", {
        Name: tableName,
        ColumnName: columnName,
        Filter: "",
        Token: CurrentUser.Token,
        Email: CurrentUser.Email
    })
        .done(function (data) {
            if (data) {
                $(data).each(function (index, obj) {
                    if (tableName == "VrsteRadnji")
                        dropDown.append($("<option></option>")
                            .attr("value", obj.Id)
                            .attr("has_star", (obj.Name.indexOf('*') > -1))
                            .text(obj.Name.replace('*', '')));
                    else
                        dropDown.append($("<option></option>")
                            .attr("value", obj.Id)
                            .text(obj.Name));
                    if (index == data.length - 1) {
                        if (callback != undefined && typeof (callback) == "function")
                            callback();
                    }
                });

                if (data.length == 0 && callback != undefined && typeof (callback) == "function")
                    callback();
                HideLoaderCenter();
            }
            else {
                if (callback != undefined && typeof (callback) == "function")
                    callback();
                HideLoaderCenter();
            }
        })
        .fail(function (jqXHR, textStatus, errorThrown) {
            if (jqXHR.status == 403)
                AlertUserSessionError();
            else
                ShowAlert("danger", "Greška prilikom učitavanja podataka kodne tabele. Probajte ponovo ili kontaktirajte administratora.");
            HideLoaderCenter();
            if (callback != undefined && typeof (callback) == "function")
                callback();
        });
}

function LoadCodeTableUI(element, title, tableName, columnName, remark) {
    CurrentModule = title;
    var location = document.location.href.split('?')[0] + "?module=" + CurrentModule;
    history.pushState({ foo: "bar" }, title, location);

    $(".menu-item").removeClass("active");
    $("#liMenuCodeTables").addClass("active");
    $(".menu-sub-item").css("background-color", "");
    $(element).parent().css("background-color", "#e7e7e7");
    $(".menu-div").hide();

    if (title === "Oznake") {
        $("#divLabels").show();
        return;
    }

    $("#divCodeTable").show();

    CurrentCodeTable = {
        Element: element,
        Title: title,
        TableName: tableName,
        ColumnName: columnName,
        Remark: remark
    };

    $("#divCodeTable").find(".panel-heading").html("<strong style='font-size:1.2em;'>" + title + "</strong>");

    if (remark != undefined && remark != null)
        $("#divCodeTable").find(".panel-heading").append("<br><span>(" + remark + ")</span>");

    ShowLoaderCenter();

    if (columnName == undefined)
        columnName = "Name";

    $("#tblCodeTableData").bootstrapTable("destroy");

    $.get(AppPath + "api/codetable", {
        Name: tableName,
        ColumnName: columnName,
        Token: CurrentUser.Token,
        Email: CurrentUser.Email
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
            if (jqXHR.status == 403)
                AlertUserSessionError();
            else
                ShowAlert("danger", "Greška prilikom učitavanja kodne tabele. Probajte ponovo ili kontaktirajte administratora.");
            HideLoaderCenter();
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
            buttonsHTML += "</div></td>";

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
                        url: AppPath + "api/codetabledelete?TableName=" + CurrentCodeTable.TableName + "&Id=" + id.toString()
                            + "&Token=" + CurrentUser.Token + "&Email=" + CurrentUser.Email,
                        type: "GET",
                        success: function () {
                            LoadCodeTableUI(CurrentCodeTable.Element, CurrentCodeTable.Title, CurrentCodeTable.TableName, CurrentCodeTable.ColumnName);
                            HideLoaderCenter();
                            ShowAlert("success", "Uspješno izbrisano.");
                        },
                        error: function (jqXHR) {
                            if (jqXHR.status == 403)
                                AlertUserSessionError();
                            else
                                ShowAlert("danger", "Greška prilikom brisanja podatka. Probajte ponovo ili kontaktirajte administratora.");
                            HideLoaderCenter();
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
        Name: $("#txtCodeTableRecord_Name").val(),

        Token: CurrentUser.Token,
        Email: CurrentUser.Email
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
        .fail(function (jqXHR) {
            if (jqXHR.status == 403)
                AlertUserSessionError();
            else
                ShowAlert("danger", "Greška prilikom spašavanja podatka. Probajte ponovo ili kontaktirajte administratora.");
            HideLoaderCenter();
        });
}

function ClearModalCase(isNewCase) {
    $("#modalCase").removeAttr("edit_id");

    $("#txtCase_NasBroj").val("");
    $("#ddlCase_Kategorija").val(-1).change();
    $("#ddlCase_Uloga").val(-1);
    $("#cbCase_PrivremeniZastupnici").prop("checked", false);
    $("#cbCase_PristupPredmetu").prop("checked", false);
    $("#txtCase_Iniciran").val("");
    $("#txtCase_BrojPredmeta").val("");
    $("#ddlCase_Sud").val(-1);
    $("#ddlCase_Sudija").val(-1);
    $("#txtCase_VrijednostSpora").val("");
    $("#txtCase_VrijednostSpora").removeAttr("number_value");
    $("#ddlCase_VrstaPredmeta").val(-1);
    $("#txtCase_DatumStanjaPredmeta").val("");
    //$("#ddlCase_StanjePredmeta").val(-1);
    $("#txtCase_StanjePredmeta").val("");

    $("#ddlCase_NacinOkoncanja").val(-1);
    $("#ddlCase_Uspjeh").val("");
    $("#txtCase_DatumArhiviranja").val("");
    $("#txtCase_BrojArhive").val("");
    $("#txtCase_BrojArhiveRegistrator").val("");
    $("#divCase_Labels").html("");

    $("#txtCase_PravniOsnov").val("");

    // LicePredmet
    $("#ddlCase_Lice").val(-1);
    $("#ddlCase_UlogaLica").val(-1);
    $("#ddlCase_UlogaOrdinalNo").val("");
    $("#ddlCase_GlavnaStranka").val("");
    $("#btnAppendPartyToCase").attr("disabled", "disabled");

    // Notes
    $("#txtCase_NoteDate").val("");
    $("#txtCase_NoteText").val("");
    $("#btnAppendNoteToCase").attr("disabled", "disabled");

    // Expenses
    $("#ddlCase_ExpenseVrstaTroska").val(-1);
    $("#txtCase_ExpenseAmount").val("");
    $("#txtCase_ExpenseAmount").removeAttr("number_value");
    $("#txtCase_ExpenseDate").val("");
    $("#ddlCase_ExpensePaidBy").val("");
    $("#btnAppendExpenseToCase").attr("disabled", "disabled");

    // Radnje
    $("#ddlCase_Radnja_VrstaRadnje").val(-1);
    $("#txtCase_Radnja_DatumRadnje").val("");
    //$("#ddlCase_Radnja_Troskovi").val("");
    $("#txtCase_Radnja_Biljeske").val("");
    $("#aCase_Radnja_DocumentLink").val("");
    $("#aCase_Radnja_DocumentLink").removeAttr("href");
    $("#aCase_Radnja_DocumentLink").removeAttr("google_drive_doc_id");
    $("#btnAppendRadnjaToCase").attr("disabled", "disabled");

    // Documents
    //$("#ddlCase_Document_TipDokumenta").val(-1);
    $("#txtCase_Document_TipDokumenta").val("");
    $("#txtCase_Document_PredatoUz").val("");
    $("#txtCase_Document_Note").val("");
    $("#btnAppendDocumentToCase").attr("disabled", "disabled");

    // Connections
    $("#txtCase_Connection_ConnectionCase").val("");
    $("#txtCase_Connection_ConnectionCase").attr("caseId", -1);
    $("#txtCase_Connection_Note").val("");
    $("#btnAppendConnectionToCase").attr("disabled", "disabled");

    $("#modalCase").find(".modal-title").html("Novi predmet");
    $("#tblCaseParties").bootstrapTable("destroy");

    // Pozivanje predmeta
    $("#cbCase_CaseActivity_SaveNew").prop("checked", false);
    $("#cbCase_CaseActivity_SaveNew").attr("disabled", "disabled");

    $("#txtCase_CaseActivity_ActivityDate").val("");
    $("#txtCase_CaseActivity_ActivityDaysOffset").val(0);
    $("#txtCase_CaseActivity_Note").val("");
    $("#cbCase_CaseActivity_ForAllUsers").prop("checked", "checked");
    $("#txtCase_CaseActivity_ActivityDate").attr("disabled", "disabled");
    $("#txtCase_CaseActivity_ActivityDaysOffset").attr("disabled", "disabled");
    $("#txtCase_CaseActivity_Note").attr("disabled", "disabled");
    $("#cbCase_CaseActivity_ForAllUsers").attr("disabled", "disabled");

    $("#btnGenerateTemplateForCase").off("click");

    if (isNewCase === true) {
        $("#btnSaveCase").show();
        $("#btnSaveAndCloseCase").show();
    }
    else {
        $("#btnSaveCase").hide();
        $("#btnSaveAndCloseCase").hide();
    }

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
    $("#tblPartyCases").bootstrapTable("destroy")
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
        Biljeske: $("#txtParty_Biljeske").val(),

        Token: CurrentUser.Token,
        ValidationEmail: CurrentUser.Email
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
                $("#ddlCase_Lice").html('<option value="-1">-----</option>');
                LoadCodeTableData("vLica_Id_Naziv", $("#ddlCase_Lice"), "Naziv");
                HideLoaderCenter();
                LoadParties();
            }
            else {
                HideLoaderCenter();
                ShowAlert("danger", "Greška pri spašavanju stranke.");
            }
        })
        .fail(function (jqXHR) {
            if (jqXHR.status == 403)
                AlertUserSessionError();
            else
                ShowAlert("danger", "Greška prilikom spašavanja stranke. Probajte ponovo ili kontaktirajte administratora.");
            HideLoaderCenter();
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

            LoadPartyCases(id);

            return false; // break loop
        }
    });
}

function LoadPartyCases(id) {
    ShowLoaderCenter();

    var _columns = [
        { field: 'Id' },
        { field: 'Naziv', title: 'Naziv', titleTooltip: 'Naziv', sortable: false }
    ];

    $("#tblPartyCases").bootstrapTable("destroy");

    $.get(AppPath + "api/partyCases", {
        UserId: CurrentUser.Id,
        PartyId: id,
        Token: CurrentUser.Token,
        Email: CurrentUser.Email
    })
        .done(function (data) {
            if (data != null && data.length > 0) {
                $("#tblPartyCases").bootstrapTable({
                    data: data,
                    striped: true,
                    columns: _columns,
                    onPostBody: function () {
                        AfterBindPartyCases();
                        return false;
                    }
                });
                HideLoaderCenter();
            }
            else {
                $("#tblPartyCases").bootstrapTable({
                    data: [],
                    striped: true,
                    columns: _columns,
                });
                HideLoaderCenter();
            }
        })
        .fail(function (jqXHR, textStatus, errorThrown) {
            if (jqXHR.status == 403)
                AlertUserSessionError();
            else
                ShowAlert("danger", "Greška prilikom učitavanja predmeta stranke. Probajte ponovo ili kontaktirajte administratora.");
            HideLoaderCenter();
        });
}

function AfterBindPartyCases() {
    $("#tblPartyCases").find("tr").each(function (index, element) {
        if (index == 0) {
            $(element).find("th:first-child").hide();
        }
        else {
            var tempId = parseInt($(element).find("td:first-child").html());
            $(element).find("td:first-child").hide();

            $(element).dblclick(function () {
                $("#modalParty").modal("toggle");
                ShowLoaderCenter();
                setTimeout(function () {
                    Predmeti = null;
                    EditCase(tempId);
                    HideLoaderCenter();
                }, 1000);
            });
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
                        url: AppPath + "api/licedelete?Id=" + id.toString()
                            + "&Token=" + CurrentUser.Token + "&ValidationEmail=" + CurrentUser.Email,
                        type: "GET",
                        success: function () {
                            LoadParties();
                            HideLoaderCenter();
                            ShowAlert("success", "Uspješno izbrisana stranka.");
                        },
                        error: function (jqXHR) {
                            if (jqXHR.status == 403)
                                AlertUserSessionError();
                            else
                                ShowAlert("danger", "Greška prilikom brisanja lica. Probajte ponovo ili kontaktirajte administratora.");
                            HideLoaderCenter();
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
    CurrentCase.DeletedRadnje = [];
    CurrentCase.Documents = [];
    CurrentCase.Connections = [];

    ClearModalCase(true);

    BindCaseParties([]);
    BindCaseNotes([]);
    BindCaseExpenses([]);
    BindCaseRadnje([]);
    BindCaseDocuments([]);
    BindCaseConnections([]);
}

function AppendPartyToCase() {
    if ($("#ddlCase_Lice").val() != -1 && $("#ddlCase_UlogaLica").val() != -1) {
        var editIndex = $("#btnAppendPartyToCase").attr("edit_index");
        if (editIndex != undefined && editIndex != null) {
            CurrentCase.Parties[editIndex] = {
                LiceId: $("#ddlCase_Lice").val(),
                Lice: $("#ddlCase_Lice option:selected").text(),
                UlogaId: $("#ddlCase_UlogaLica").val(),
                Uloga: $("#ddlCase_UlogaLica option:selected").text(),
                GlavnaStranka: $("#ddlCase_GlavnaStranka option:selected").text(),
                IsNasaStranka: $("#ddlCase_GlavnaStranka").val() == "ns",
                IsProtivnaStranka: $("#ddlCase_GlavnaStranka").val() == "ps",
                Broj: $("#ddlCase_UlogaOrdinalNo").val(),
                Id: CurrentCase.Parties[editIndex].Id
            };

            $("#btnAppendPartyToCase").removeAttr("edit_index");
            $("#btnAppendPartyToCase").html("Dodaj");
        }
        else {
            if (CurrentCase.Parties == undefined)
                CurrentCase.Parties = [];

            CurrentCase.Parties.push({
                LiceId: $("#ddlCase_Lice").val(),
                Lice: $("#ddlCase_Lice option:selected").text(),
                UlogaId: $("#ddlCase_UlogaLica").val(),
                Uloga: $("#ddlCase_UlogaLica option:selected").text(),
                GlavnaStranka: $("#ddlCase_GlavnaStranka option:selected").text(),
                IsNasaStranka: $("#ddlCase_GlavnaStranka").val() == "ns",
                IsProtivnaStranka: $("#ddlCase_GlavnaStranka").val() == "ps",
                Broj: $("#ddlCase_UlogaOrdinalNo").val()
            });
        }
        BindCaseParties(CurrentCase.Parties);

        $("#ddlCase_Lice").val(-1);
        $("#ddlCase_UlogaLica").val(-1);
        $("#ddlCase_UlogaOrdinalNo").val("");
        $("#ddlCase_GlavnaStranka").val("");
        $("#btnAppendPartyToCase").attr("disabled", "disabled");
    }
}

function BindCaseParties(_data) {
    var _columns = [
        { field: 'Lice', title: 'Stranka', titleTooltip: 'Stranka', sortable: true, "class": "bold" },
        { field: 'Broj', title: 'Broj', titleTooltip: 'Broj', sortable: true, width: "30px", align: "right" },
        { field: 'Uloga', title: 'Uloga', titleTooltip: 'Uloga', sortable: true, width: "200px" },
        { field: 'GlavnaStranka', title: 'Vrsta stranke', titleTooltip: 'Vrsta stranke', sortable: true, width: "120px" }
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
            var buttonsHTML = "<td style='width: 140px;'><div class='btn-group pull-right'>";
            buttonsHTML +=
                "<button class='btn btn-default btn-sm' data-toggle='tooltip' title='Otvori stranku' onclick='OpenCasePartyInNewTab(" + (index - 1) + "); return false;'>"
                + "<span class='glyphicon glyphicon-eye-open'></span>"
                + "</button>";
            if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0) {
                buttonsHTML +=
                    "<button class='btn btn-warning btn-sm' data-toggle='tooltip' title='Izmijeni stranku' onclick='EditCaseParty(" + (index - 1) + "); return false;'>"
                    + "<span class='glyphicon glyphicon-pencil'></span>"
                    + "</button>";
                buttonsHTML +=
                    "<button class='btn btn-default btn-sm custom-table-button-delete' data-toggle='tooltip' title='Izbriši stranku' onclick='DeleteCaseParty(" + (index - 1) + "); return false;'>"
                    + "<span class='glyphicon glyphicon-remove'></span>"
                    + "</button>";

            }
            buttonsHTML += "</div></td>";
            $(element).append(buttonsHTML);
        }
    });
}

function EditCaseParty(index) {
    var tempCaseParty = CurrentCase.Parties[index];
    BindInputDataForCaseParty(tempCaseParty);

    $("#btnAppendPartyToCase").attr("edit_index", index);
    $("#btnAppendPartyToCase").html("Spasi");
}

function BindInputDataForCaseParty(tempCaseParty) {
    $("#ddlCase_Lice").val(tempCaseParty.LiceId);
    $("#ddlCase_UlogaLica").val(tempCaseParty.UlogaId);
    $("#ddlCase_UlogaOrdinalNo").val(tempCaseParty.Broj);

    if (tempCaseParty.IsNasaStranka === true)
        $("#ddlCase_GlavnaStranka").val("ns");
    else if (tempCaseParty.IsProtivnaStranka === true)
        $("#ddlCase_GlavnaStranka").val("ps");
    else
        $("#ddlCase_GlavnaStranka").val("");

    $("#btnAppendPartyToCase").removeAttr("disabled");
}

function OpenCasePartyInNewTab(index) {
    var partyId = CurrentCase.Parties[index].LiceId;
    window.open(document.location.href.split('?')[0].toLowerCase() + "?module=parties&party_id=" + partyId.toString());
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

        ClearInputSectionNotes();
    }
}

function BindCaseNotes(_data) {
    var _columns = [
        { field: 'NoteDate', title: 'Datum', titleTooltip: 'Datum', sortable: true, sorter: DateSorterFunction, width: "150px" },
        { field: 'NoteText', title: 'Bilješka', titleTooltip: 'Bilješka', sortable: true },
        { field: 'CreatedByName', title: 'Izrađena od', titleTooltip: 'Izrađena od', sortable: true, width: "150px" }
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
                buttonsHTML += "</div></td>";

                $(element).append(buttonsHTML);
            }
        }
    });
}

function DeleteCaseNote(index) {
    CurrentCase.Notes.splice(index, 1);
    BindCaseNotes(CurrentCase.Notes);
}

function AppendConnectionToCase() {
    if ($("#txtCase_Connection_ConnectionCase").attr("caseId") != undefined && $("#txtCase_Connection_ConnectionCase").attr("caseId") != "") {

        if (CurrentCase.Connections == undefined)
            CurrentCase.Connections = [];

        CurrentCase.Connections.push({
            ConnectionCaseId: $("#txtCase_Connection_ConnectionCase").attr("caseId"),
            ConnectionCaseName: $("#txtCase_Connection_ConnectionCase").val(),
            Note: $("#txtCase_Connection_Note").val(),
            CaseId: CurrentCase.Id
        });

        BindCaseConnections(CurrentCase.Connections);

        ClearInputSectionConnections();
    }
}

function BindCaseConnections(_data) {
    var _columns = [
        { field: 'ConnectionCaseName', title: 'Veza prema predmetu', titleTooltip: 'Veza prema predmetu', sortable: true },
        { field: 'Note', title: 'Bilješke', titleTooltip: 'Bilješke', sortable: true }
    ];

    $("#tblCaseConnections").bootstrapTable("destroy");

    if (_data && _data.length > 0) {
        $("#tblCaseConnections").bootstrapTable({
            data: _data,
            striped: true,
            columns: _columns,
            escape: false,
            onPostBody: function () {
                AfterBindCaseConnections();
                return false;
            }
        });
    }
    else {
        $("#tblCaseConnections").bootstrapTable({
            data: [],
            striped: true,
            columns: _columns
        });
    }
}

function AfterBindCaseConnections() {
    $("#tblCaseConnections").find("tr").each(function (index, element) {
        if (index == 0) {
            if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0 && CurrentCase.Connections.length > 0)
                if ($("#caseConnectionsEmptyHeader").length == 0)
                    $(element).append("<th id='caseConnectionsEmptyHeader'></th>");
        }
        else if (CurrentCase.Connections.length > 0) {
            if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0) {
                var buttonsHTML = "<td style='width: 50px;'><div class='btn-group pull-right'>";
                buttonsHTML +=
                    "<button class='btn btn-default btn-sm custom-table-button-delete' data-toggle='tooltip' title='Izbriši vezu' onclick='DeleteCaseConnection(" + (index - 1) + "); return false;'>"
                    + "<span class='glyphicon glyphicon-remove'></span>"
                    + "</button>";
                buttonsHTML += "</div></td>";

                $(element).append(buttonsHTML);
            }
        }
    });
}

function DeleteCaseConnection(index) {
    CurrentCase.Connections.splice(index, 1);
    BindCaseConnections(CurrentCase.Connections);
}

function AppendDocumentToCase() {
    //if ($("#ddlCase_Document_TipDokumenta").val() != -1 && $("#aCase_Document_DocumentLink").html() != "") {
    if ($("#txtCase_Document_TipDokumenta").val() != "") {
        var editIndex = $("#btnAppendDocumentToCase").attr("edit_index");
        if (editIndex != undefined && editIndex != null) {
            CurrentCase.Documents[editIndex] = {
                //TipDokumentaId: $("#ddlCase_Document_TipDokumenta").val(),
                //TipDokumentaName: $("#ddlCase_Document_TipDokumenta option:selected").text(),
                TipDokumentaName: $("#txtCase_Document_TipDokumenta").val(),
                PredatoUzDokumentName: $("#txtCase_Document_PredatoUz").val(),
                Note: $("#txtCase_Document_Note").val(),
                DocumentName: $("#aCase_Document_DocumentLink").html(),
                GoogleDriveDocId: $("#aCase_Document_DocumentLink").attr("google_drive_doc_id"),
                CaseId: CurrentCase.Id,
                Id: CurrentCase.Documents[editIndex].Id
            };

            $("#btnAppendDocumentToCase").removeAttr("edit_index");
            $("#btnAppendDocumentToCase").html("Dodaj");
        }
        else {
            if (CurrentCase.Documents == undefined)
                CurrentCase.Documents = [];

            CurrentCase.Documents.push({
                //TipDokumentaId: $("#ddlCase_Document_TipDokumenta").val(),
                //TipDokumentaName: $("#ddlCase_Document_TipDokumenta option:selected").text(),
                TipDokumentaName: $("#txtCase_Document_TipDokumenta").val(),
                PredatoUzDokumentName: $("#txtCase_Document_PredatoUz").val(),
                Note: $("#txtCase_Document_Note").val(),
                DocumentName: $("#aCase_Document_DocumentLink").html(),
                GoogleDriveDocId: $("#aCase_Document_DocumentLink").attr("google_drive_doc_id"),
                CaseId: CurrentCase.Id
            });
        }

        BindCaseDocuments(CurrentCase.Documents);

        ClearInputSectionDocuments();
    }
}

function BindCaseDocuments(_data) {
    var _columns = [
        { field: 'TipDokumentaName', title: 'Tip dokumenta', titleTooltip: 'Tip dokumenta', sortable: true },
        { field: 'Note', title: 'Bilješke', titleTooltip: 'Bilješke', sortable: true },
        { field: 'PredatoUzDokumentName', title: 'Predato uz', titleTooltip: 'Predato uz', sortable: true },
        { field: 'GoogleDriveDocIdHTML', title: 'Dokument', titleTooltip: 'Dokument', sortable: false, align: "right", width: "150" }
    ];

    $("#tblCaseDocuments").bootstrapTable("destroy");

    if (_data && _data.length > 0) {
        $(_data).each(function (index, _document) {

            if (_document.GoogleDriveDocId != undefined && _document.GoogleDriveDocId != null && _document.GoogleDriveDocId != "none" && _document.GoogleDriveDocId != "")
                _document.GoogleDriveDocIdHTML = DownloadButtonMarkUp.replace("##TOOLTIP##", _document.DocumentName).replace("##ON_CLICK##", "DownloadFileFromGoogleDrive(\"" + _document.GoogleDriveDocId + "\", \"" + _document.DocumentName + "\");");
            else
                _document.GoogleDriveDocIdHTML = "";

            if (index == _data.length - 1) {
                $("#tblCaseDocuments").bootstrapTable({
                    data: _data,
                    striped: true,
                    columns: _columns,
                    escape: false,
                    onPostBody: function () {
                        AfterBindCaseDocuments();
                        return false;
                    }
                });
            }
        });
    }
    else {
        $("#tblCaseDocuments").bootstrapTable({
            data: [],
            striped: true,
            columns: _columns
        });
    }
}

function AfterBindCaseDocuments() {
    $("#tblCaseDocuments").find("tr").each(function (index, element) {
        if (index == 0) {
            if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0 && CurrentCase.Documents.length > 0)
                if ($("#caseDocumentsEmptyHeader").length == 0)
                    $(element).append("<th id='caseDocumentsEmptyHeader'></th>");
            $(element).find("th:nth-child(4)").hide();
        }
        else if (CurrentCase.Documents.length > 0) {
            var buttonsHTML = "<td style='width: 200px;'><div class='btn-group pull-right'>";
            var downloadButtonHTML = $(element).find("td:nth-child(4)").html();
            $(element).find("td:nth-child(4)").hide();
            buttonsHTML += downloadButtonHTML;

            if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0) {
                buttonsHTML +=
                    "<button class='btn btn-default btn-sm' data-toggle='tooltip' title='Kopiraj dokument (moguće ga je zalijepiti u drugi predmet)' onclick='CopyCaseDocument(" + (index - 1) + "); return false;'>"
                    + "<span class='glyphicon glyphicon-copy'></span>"
                    + "</button>";
                buttonsHTML +=
                    "<button class='btn btn-default btn-sm' data-toggle='tooltip' title='Iskoristi ponovo' onclick='ReuseCaseDocument(" + (index - 1) + "); return false;'>"
                    + "<span class='glyphicon glyphicon-repeat'></span>"
                    + "</button>";
                buttonsHTML +=
                    "<button class='btn btn-warning btn-sm' data-toggle='tooltip' title='Izmijeni dokument' onclick='EditCaseDocument(" + (index - 1) + "); return false;'>"
                    + "<span class='glyphicon glyphicon-pencil'></span>"
                    + "</button>";
                buttonsHTML +=
                    "<button class='btn btn-default btn-sm custom-table-button-delete' data-toggle='tooltip' title='Izbriši dokument' onclick='DeleteCaseDocument(" + (index - 1) + "); return false;'>"
                    + "<span class='glyphicon glyphicon-remove'></span>"
                    + "</button>";
            }

            buttonsHTML += "</div></td>";
            $(element).append(buttonsHTML);
        }
    });
}

function EditCaseDocument(index) {
    var tempCaseDocument = CurrentCase.Documents[index];
    BindInputDataForCaseDocument(tempCaseDocument);

    $("#btnAppendDocumentToCase").attr("edit_index", index);
    $("#btnAppendDocumentToCase").html("Spasi");
}

function DeleteCaseDocument(index) {
    CurrentCase.Documents.splice(index, 1);
    BindCaseDocuments(CurrentCase.Documents);
}

function ReuseCaseDocument(index) {
    var tempCaseDocument = CurrentCase.Documents[index];
    BindInputDataForCaseDocument(tempCaseDocument);
}

function CopyCaseDocument(index) {
    CaseDocumentClipboard = $.extend(true, [], CurrentCase.Documents[index]);
    $("#btnPasteCaseDocument").show();
}

function PasteCaseDocument(index) {
    if (CaseDocumentClipboard != null)
        BindInputDataForCaseDocument(CaseDocumentClipboard);
}

function BindInputDataForCaseDocument(tempCaseDocument) {
    $("#ddlCase_Document_TipDokumenta").val(tempCaseDocument.TipDokumentaId);
    $("#txtCase_Document_PredatoUz").val(tempCaseDocument.PredatoUzDokumentName);
    $("#txtCase_Document_Note").val(tempCaseDocument.Note);
    $("#aCase_Document_DocumentLink").html(tempCaseDocument.DocumentName);
    $("#aCase_Document_DocumentLink").attr("google_drive_doc_id", tempCaseDocument.GoogleDriveDocId);

    $("#btnCase_Document_RemoveGoogleDoc").show();
    $("#btnAppendDocumentToCase").removeAttr("disabled");
}

function AppendRadnjaToCase() {
    if ($("#ddlCase_Radnja_VrstaRadnje").val() != -1 && $("#txtCase_Radnja_DatumRadnje").val() != "") {
        var editIndex = $("#btnAppendRadnjaToCase").attr("edit_index");
        if (editIndex != undefined && editIndex != null) {
            CurrentCase.Radnje[editIndex] = {
                VrstaRadnjeId: $("#ddlCase_Radnja_VrstaRadnje").val(),
                VrstaRadnjeName: $("#ddlCase_Radnja_VrstaRadnje option:selected").text(),
                DatumRadnje: ConvertBSDateToUSDateString($("#txtCase_Radnja_DatumRadnje").val()),
                Troskovi: '', //$("#ddlCase_Radnja_Troskovi").val(),
                Biljeske: $("#txtCase_Radnja_Biljeske").val(),
                DocumentName: $("#aCase_Radnja_DocumentLink").html(),
                GoogleDriveDocId: $("#aCase_Radnja_DocumentLink").attr("google_drive_doc_id"),
                PredmetId: CurrentCase.Id,
                CaseFullName: CurrentCase.Naziv,
                UserId: CurrentUser.Id,
                CreateCalendarEvent: $("#ddlCase_Radnja_VrstaRadnje").find(":selected").attr("has_star") == "true"
            };

            $("#btnAppendRadnjaToCase").removeAttr("edit_index");
            $("#btnAppendRadnjaToCase").html("Dodaj");
        }
        else {
            if (CurrentCase.Radnje == undefined)
                CurrentCase.Radnje = [];

            CurrentCase.Radnje.push({
                VrstaRadnjeId: $("#ddlCase_Radnja_VrstaRadnje").val(),
                VrstaRadnjeName: $("#ddlCase_Radnja_VrstaRadnje option:selected").text(),
                DatumRadnje: ConvertBSDateToUSDateString($("#txtCase_Radnja_DatumRadnje").val()),
                Troskovi: '', //$("#ddlCase_Radnja_Troskovi").val(),
                Biljeske: $("#txtCase_Radnja_Biljeske").val(),
                DocumentName: $("#aCase_Radnja_DocumentLink").html(),
                GoogleDriveDocId: $("#aCase_Radnja_DocumentLink").attr("google_drive_doc_id"),
                PredmetId: CurrentCase.Id,
                CaseFullName: CurrentCase.Naziv,
                UserId: CurrentUser.Id,
                CreateCalendarEvent: $("#ddlCase_Radnja_VrstaRadnje").find(":selected").attr("has_star") == "true"
            });
        }

        BindCaseRadnje(CurrentCase.Radnje);

        ClearInputSectionRadnje();
    }
}

function BindCaseRadnje(_data) {
    var _columns = [
        { field: 'VrstaRadnjeNameString', title: 'Vrsta radnje', titleTooltip: 'Vrsta radnje', sortable: true, width: "600px" },
        { field: 'DatumRadnjeString', title: 'Datum', titleTooltip: 'Datum', sortable: true, sorter: DateSorterFunction, width: "150px" },
        //{ field: 'Troskovi', title: 'Troškovi', titleTooltip: 'Troškovi', sortable: true, align: "right" },
        { field: 'Biljeske', title: 'Bilješke', titleTooltip: 'Bilješke', sortable: true },
        { field: 'GoogleDriveDocIdHTML', title: 'Dokument', titleTooltip: 'Dokument', sortable: false, align: "right", width: "150" }
    ];

    $("#tblCaseRadnje").bootstrapTable("destroy");

    if (_data && _data.length > 0) {
        $(_data).each(function (index, _radnja) {
            if (Date.parse(_radnja.DatumRadnje)) {
                _radnja.DatumRadnjeString = moment(_radnja.DatumRadnje).format("DD.MM.YYYY HH:mm");
                _radnja.DatumRadnjeString = _radnja.DatumRadnjeString.replace(" 00:00", "");
            }

            if (_radnja.GoogleDriveDocId != undefined && _radnja.GoogleDriveDocId != null && _radnja.GoogleDriveDocId != "none" && _radnja.GoogleDriveDocId != "")
                _radnja.GoogleDriveDocIdHTML = DownloadButtonMarkUp.replace("##TOOLTIP##", _radnja.DocumentName).replace("##ON_CLICK##", "DownloadFileFromGoogleDrive(\"" + _radnja.GoogleDriveDocId + "\", \"" + _radnja.DocumentName + "\");");
            else
                _radnja.GoogleDriveDocIdHTML = "";

            _radnja.VrstaRadnjeNameString = _radnja.VrstaRadnjeName.replace('*', '');

            if (index == _data.length - 1) {
                $("#tblCaseRadnje").bootstrapTable({
                    data: _data,
                    striped: true,
                    columns: _columns,
                    escape: false,
                    onPostBody: function () {
                        AfterBindCaseRadnje();
                        return false;
                    }
                });

                //$(CurrentCase.Radnje).each(function (indexR, objR) {
                //    if (objR.DatumRadnje != null)
                //        objR.DatumRadnje = ConvertBSDateToUSDateString(objR.DatumRadnje);
                //});
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
            $(element).find("th:nth-child(4)").hide();
        }
        else if (CurrentCase.Radnje.length > 0) {
            var buttonsHTML = "<td style='width: 130px;'><div class='btn-group pull-right'>";
            var downloadButtonHTML = $(element).find("td:nth-child(4)").html();
            $(element).find("td:nth-child(4)").hide();
            buttonsHTML += downloadButtonHTML;

            if (CurrentUser.UserGroupCodes.indexOf("office_admin") >= 0) {

                buttonsHTML +=
                    "<button class='btn btn-warning btn-sm' data-toggle='tooltip' title='Izmijeni radnju' onclick='EditCaseRadnja(" + (index - 1) + "); return false;'>"
                    + "<span class='glyphicon glyphicon-pencil'></span>"
                    + "</button>";
                buttonsHTML +=
                    "<button class='btn btn-default btn-sm custom-table-button-delete' data-toggle='tooltip' title='Izbriši radnju' onclick='DeleteCaseRadnja(" + (index - 1) + "); return false;'>"
                    + "<span class='glyphicon glyphicon-remove'></span>"
                    + "</button>";
            }

            buttonsHTML += "</div></td>";
            $(element).append(buttonsHTML);
        }
    });
}

function EditCaseRadnja(index) {
    var tempCaseRadnja = CurrentCase.Radnje[index];
    BindInputDataForCaseRadnja(tempCaseRadnja);

    $("#btnAppendRadnjaToCase").attr("edit_index", index);
    $("#btnAppendRadnjaToCase").html("Spasi");
}

function DeleteCaseRadnja(index) {
    // Save deleted ones for deleting from Google
    if (CurrentCase.Radnje == undefined)
        CurrentCase.Radnje = [];
    CurrentCase.DeletedRadnje.push(CurrentCase.Radnje[index]);

    CurrentCase.Radnje.splice(index, 1);
    BindCaseRadnje(CurrentCase.Radnje);
}

function BindInputDataForCaseRadnja(tempCaseRadnja) {
    $("#ddlCase_Radnja_VrstaRadnje").val(tempCaseRadnja.VrstaRadnjeId);
    $("#ddlCase_Radnja_VrstaRadnje option:selected").text(tempCaseRadnja.VrstaRadnjeName);
    $("#txtCase_Radnja_DatumRadnje").val(moment(tempCaseRadnja.DatumRadnje).format("DD.MM.YYYY HH:mm"));
    $("#txtCase_Radnja_Biljeske").val(tempCaseRadnja.Biljeske);
    $("#aCase_Radnja_DocumentLink").html(tempCaseRadnja.DocumentName);
    $("#aCase_Radnja_DocumentLink").attr("google_drive_doc_id", tempCaseRadnja.GoogleDriveDocId);

    if (tempCaseRadnja.GoogleDriveDocId != undefined && tempCaseRadnja.GoogleDriveDocId != null && tempCaseRadnja.GoogleDriveDocId != "none" && tempCaseRadnja.GoogleDriveDocId != "")
        $("#btnCase_Radnja_RemoveGoogleDoc").show();

    $("#btnAppendRadnjaToCase").removeAttr("disabled");
}

function AppendExpenseToCase() {
    if ($("#ddlCase_ExpenseVrstaTroska").val() != -1 && $("#txtCase_ExpenseAmount").val() != "") {
        var editIndex = $("#btnAppendExpenseToCase").attr("edit_index");
        if (editIndex != undefined && editIndex != null) {
            CurrentCase.Expenses[editIndex] = {
                VrstaTroskaId: $("#ddlCase_ExpenseVrstaTroska").val(),
                VrstaTroskaName: $("#ddlCase_ExpenseVrstaTroska option:selected").text(),
                Amount: $("#txtCase_ExpenseAmount").attr("number_value"),
                ExpenseDate: ConvertBSDateToUSDateString($("#txtCase_ExpenseDate").val()),
                PaidBy: $("#ddlCase_ExpensePaidBy").val(),
                CaseId: CurrentCase.Id,
                Id: CurrentCase.Expenses[editIndex].Id
            };

            $("#btnAppendExpenseToCase").removeAttr("edit_index");
            $("#btnAppendExpenseToCase").html("Dodaj");
        }
        else {
            if (CurrentCase.Expenses == undefined)
                CurrentCase.Expenses = [];

            CurrentCase.Expenses.push({
                VrstaTroskaId: $("#ddlCase_ExpenseVrstaTroska").val(),
                VrstaTroskaName: $("#ddlCase_ExpenseVrstaTroska option:selected").text(),
                Amount: $("#txtCase_ExpenseAmount").attr("number_value"),
                ExpenseDate: ConvertBSDateToUSDateString($("#txtCase_ExpenseDate").val()),
                PaidBy: $("#ddlCase_ExpensePaidBy").val(),
                CaseId: CurrentCase.Id
            });
        }

        BindCaseExpenses(CurrentCase.Expenses);

        ClearInputSectionExpenses();
    }
}

function BindCaseExpenses(_data) {
    var _columns = [
        { field: 'VrstaTroskaName', title: 'Vrsta troška', titleTooltip: 'Vrsta troška', sortable: true },
        { field: 'AmountString', title: 'Iznos (BAM)', titleTooltip: 'Iznos (BAM)', sortable: true, align: "right", width: "150px" },
        { field: 'ExpenseDate', title: 'Datum plaćanja', titleTooltip: 'Datum plaćanja', sortable: true, sorter: DateSorterFunction, width: "120px" },
        { field: 'PaidBy', title: 'Plaćeno od', titleTooltip: 'Plaćeno od', sortable: true, width: "100px" }
    ];

    $("#tblCaseExpenses").bootstrapTable("destroy");

    if (_data && _data.length > 0) {
        $(_data).each(function (index, _expense) {
            if (Date.parse(_expense.ExpenseDate))
                _expense.ExpenseDate = moment(_expense.ExpenseDate).format("DD.MM.YYYY");

            _expense.AmountString = GetMoneyFormat(_expense.Amount);

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
                var buttonsHTML = "<td style='width: 90px;'><div class='btn-group pull-right'>";
                buttonsHTML +=
                    "<button class='btn btn-warning btn-sm' data-toggle='tooltip' title='Izmijeni trošak' onclick='EditCaseExpense(" + (index - 1) + "); return false;'>"
                    + "<span class='glyphicon glyphicon-pencil'></span>"
                    + "</button>";
                buttonsHTML +=
                    "<button class='btn btn-default btn-sm custom-table-button-delete' data-toggle='tooltip' title='Izbriši trošak' onclick='DeleteCaseExpense(" + (index - 1) + "); return false;'>"
                    + "<span class='glyphicon glyphicon-remove'></span>"
                    + "</button>";
                buttonsHTML += "</div></td>";

                $(element).append(buttonsHTML);
            }
        }
    });
}

function EditCaseExpense(index) {
    var tempCaseExpense = CurrentCase.Expenses[index];
    BindInputDataForCaseExpense(tempCaseExpense);

    $("#btnAppendExpenseToCase").attr("edit_index", index);
    $("#btnAppendExpenseToCase").html("Spasi");
}


function BindInputDataForCaseExpense(tempCaseExpense) {
    $("#ddlCase_ExpenseVrstaTroska").val(tempCaseExpense.VrstaTroskaId);
    $("#txtCase_ExpenseAmount").attr("number_value", tempCaseExpense.Amount).val(GetMoneyFormat(tempCaseExpense.Amount));
    $("#txtCase_ExpenseDate").val(moment(tempCaseExpense.ExpenseDate).format("DD.MM.YYYY"));
    $("#ddlCase_ExpensePaidBy").val(tempCaseExpense.PaidBy);

    $("#btnAppendExpenseToCase").removeAttr("disabled");
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

$("#txtCase_Radnja_DatumRadnje").on('change', function () {
    if ($("#ddlCase_Radnja_VrstaRadnje").val() != -1 && $("#txtCase_Radnja_DatumRadnje").val() != "")
        $("#btnAppendRadnjaToCase").removeAttr("disabled");
    else
        $("#btnAppendRadnjaToCase").attr("disabled", "disabled");
});


//$("#ddlCase_Document_TipDokumenta").change(function () {
//    //if ($("#ddlCase_Document_TipDokumenta").val() != -1 && $("#aCase_Document_DocumentLink").html() != "")
//    if ($("#txtCase_Document_TipDokumenta").val() != "")
//        $("#btnAppendDocumentToCase").removeAttr("disabled");
//    else
//        $("#btnAppendDocumentToCase").attr("disabled", "disabled");
//});

$("#txtCase_Document_TipDokumenta").keyup(function () {
    if ($("#txtCase_Document_TipDokumenta").val() != "")
        $("#btnAppendDocumentToCase").removeAttr("disabled");
    else
        $("#btnAppendDocumentToCase").attr("disabled", "disabled");
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
                Filter: $("#txtCase_StanjePredmeta").val(),
                Token: CurrentUser.Token,
                Email: CurrentUser.Email
            })
                .done(function (data) {
                    response($.map(data, function (item) {
                        return {
                            label: item.Name,
                            value: item.Name
                        };
                    }));
                    $("#spinner_txtCase_StanjePredmeta").hide();
                })
                .fail(function (jqXHR, textStatus, errorThrown) {
                    if (jqXHR.status == 403)
                        AlertUserSessionError();
                    else
                        ShowAlert("danger", "Greška prilikom učitavanja stanja predmeta za odabir. Probajte ponovo ili kontaktirajte administratora.");
                    HideLoaderCenter();
                });
        },
        delay: 500,
        appendTo: ".case-column-for-stanje"
    });
}

function SetUpTipDokumentaAutocomplete() {
    $("#txtCase_Document_TipDokumenta").autocomplete({
        source: function (request, response) {
            $("#spinner_txtCase_Document_TipDokumenta").show();

            $.get(AppPath + "api/codetable", {
                Name: "TipoviDokumenata",
                ColumnName: "Name",
                Filter: $("#txtCase_Document_TipDokumenta").val(),
                Token: CurrentUser.Token,
                Email: CurrentUser.Email
            })
                .done(function (data) {
                    response($.map(data, function (item) {
                        return {
                            label: item.Name,
                            value: item.Name
                        };
                    }));
                    $("#spinner_txtCase_Document_TipDokumenta").hide();
                })
                .fail(function (jqXHR, textStatus, errorThrown) {
                    if (jqXHR.status == 403)
                        AlertUserSessionError();
                    else
                        ShowAlert("danger", "Greška prilikom učitavanja tipova dokumenata za odabir. Probajte ponovo ili kontaktirajte administratora.");
                    HideLoaderCenter();
                });
        },
        delay: 500,
        appendTo: "#divDokumenti"
    });
}

function SetUpPredatoUzAutocomplete() {
    $("#txtCase_Document_PredatoUz").autocomplete({
        source: function (request, response) {
            $("#spinner_txtCase_Document_PredatoUz").show();

            $.get(AppPath + "api/codetable", {
                Name: "PredatoUzDokumenti",
                ColumnName: "Name",
                Filter: $("#txtCase_Document_PredatoUz").val(),
                Token: CurrentUser.Token,
                Email: CurrentUser.Email
            })
                .done(function (data) {
                    response($.map(data, function (item) {
                        return {
                            label: item.Name,
                            value: item.Name
                        };
                    }));
                    $("#spinner_txtCase_Document_PredatoUz").hide();
                })
                .fail(function (jqXHR, textStatus, errorThrown) {
                    if (jqXHR.status == 403)
                        AlertUserSessionError();
                    else
                        ShowAlert("danger", "Greška prilikom učitavanja 'predato uz' podataka za odabir. Probajte ponovo ili kontaktirajte administratora.");
                    HideLoaderCenter();
                });
        },
        delay: 500,
        appendTo: "#divDokumenti"
    });
}

function SetUpCaseConnectionAutocomplete() {
    $("#txtCase_Connection_ConnectionCase").autocomplete({
        source: function (request, response) {
            $("#spinner_txtCase_Connection_ConnectionCase").show();

            $.get(AppPath + "api/codetable", {
                Name: "vCases",
                ColumnName: "Name",
                Filter: $("#txtCase_Connection_ConnectionCase").val(),
                Token: CurrentUser.Token,
                Email: CurrentUser.Email
            })
                .done(function (data) {
                    response($.map(data, function (item) {
                        return {
                            label: item.Name,
                            value: item.Name,
                            caseId: item.Id
                        };
                    }));
                    $("#spinner_txtCase_Connection_ConnectionCase").hide();
                })
                .fail(function (jqXHR, textStatus, errorThrown) {
                    if (jqXHR.status == 403)
                        AlertUserSessionError();
                    else
                        ShowAlert("danger", "Greška prilikom učitavanja predmeta za dodavanje veza. Probajte ponovo ili kontaktirajte administratora.");
                    HideLoaderCenter();
                });
        },
        delay: 500,
        appendTo: "#divVeze",
        select: function (event, ui) {
            $("#txtCase_Connection_ConnectionCase").attr("caseId", ui.item.caseId);

            if ($("#txtCase_Connection_ConnectionCase").attr("caseId") != undefined && $("#txtCase_Connection_ConnectionCase").attr("caseId") != "")
                $("#btnAppendConnectionToCase").removeAttr("disabled");
            else
                $("#btnAppendConnectionToCase").attr("disabled", "disabled");
        },
    });
}

$("#txtLabel_BackgroundColor").change(function () {
    $("#txtLabel_Name").css("background-color", $("#txtLabel_BackgroundColor").val());
});

$("#txtLabel_FontColor").change(function () {
    $("#txtLabel_Name").css("color", $("#txtLabel_FontColor").val());
});


function BuildLabelsHTML(labelIds, contentType, contentId, skipBreakLines) {
    var resultHTML = "<span name='spanContentLabels_" + contentType + "_" + contentId.toString() + "'>";
    if (labelIds != undefined && labelIds != null && labelIds.length > 0) {
        var labelIdsArray = labelIds.split(',');
        for (var i = 0; i < labelIdsArray.length; i++) {
            for (var indexLabels = 0; indexLabels < Labels.length; indexLabels++) {
                if (Labels[indexLabels].Id == parseInt(labelIdsArray[i])) {
                    resultHTML += "<span class='label' style='font-size:0.8em; margin:2px; cursor:pointer; background-color:" + Labels[indexLabels].BackgroundColor + ";color:" + Labels[indexLabels].FontColor + "' onclick='LoadCases(undefined, undefined, \"oznaka:" + Labels[indexLabels].Name + "\"); return false;'>"
                        + Labels[indexLabels].Name
                        + "&nbsp;&nbsp;<span data-toggle='tooltip' title='Izbriši oznaku' onclick='(function(e, element) { e.preventDefault(); e.stopPropagation(); DeleteLabelConnection(element," + labelIdsArray[i].toString() + ",\"case\"," + contentId.toString() + "); return false; })(event, this)' style='cursor:pointer; border-left:2px solid " + Labels[indexLabels].FontColor + "; font-weight:bold;'>"
                        + "&nbsp;&nbsp;X"
                        + "</span>"
                        + "</span>" + (skipBreakLines === true ? "<span></span>" : "<br>");
                    break;
                }
            }
        }
    }
    resultHTML += "</span>";
    return resultHTML;
}

$("#ddlLabels").change(function () {
    if ($("#ddlLabels").val() != -1)
        $("#btnApplyLabel").removeAttr("disabled");
    else
        $("#btnApplyLabel").attr("disabled", "disabled");
});

$("#imgUserPicture").click(function () {
    $("#btnLogOut").toggle();
});

function LogOut() {
    CurrentModule = "home";
    CurrentUser = null;
    CurrentCodeTable = null;
    CurrentGoogleDocSelection = null;
    Sudovi = null;
    Labels = null;
    Lica = null;
    Predmeti = null;
    Users = null;
    CaseActivities = null;
    Radnje = null;
    CurrentCase = null;
    SelectedCases = [];
    CaseDocumentClipboard = null;
    menuCases_DataLoadingCounter = 0;

    DeactivateAllMenuItems();
    $(".menu-item").hide();
    $(".menu-div").hide();

    ClearModalUser();
    ClearModalLabel();
    ClearModalSud();
    ClearModalCase();
    ClearModalParty();

    $("#tblRadnje").bootstrapTable("destroy");
    $("#tblCaseActivities").bootstrapTable("destroy");
    $("#tblCases").bootstrapTable("destroy");
    $("#tblParties").bootstrapTable("destroy");
    $("#tblUsers").bootstrapTable("destroy");
    $("#tblLabels").bootstrapTable("destroy");
    $("#tblSudovi").bootstrapTable("destroy");
    $("#tblCodeTableData").bootstrapTable("destroy");
    $("#tblPartyCases").bootstrapTable("destroy");
    $("#tblCaseParties").bootstrapTable("destroy");
    $("#tblCaseNotes").bootstrapTable("destroy");
    $("#tblCaseConnections").bootstrapTable("destroy");
    $("#tblCaseDocuments").bootstrapTable("destroy");
    $("#tblCaseRadnje").bootstrapTable("destroy");
    $("#tblCaseExpenses").bootstrapTable("destroy");

    $("#tblCasesSearch").bootstrapTable("destroy");
    $("#divAdvancedSearchResults").hide();

    $("#imgUserPicture")
        .attr("title", "Slika korisnika")
        .attr("alt", "Slika korisnika")
        .attr("src", "");
    $("#imgUserPicture").hide();
    $("#btnLogOut").hide();

    $("#divAll").hide();
    $("#divGoogleSignIn").show();

    $("#btnAppendDocumentToCase").removeAttr("edit_index");
    $("#btnAppendDocumentToCase").html("Dodaj");
    $("#btnAppendRadnjaToCase").removeAttr("edit_index");
    $("#btnAppendRadnjaToCase").html("Dodaj");
}

function AlertUserSessionError() {
    ShowAlert("danger", "Greška - osvježite aplikaciju (F5) ili se ponovo prijavite.", true);
}

function ExecuteAdvancedSearch(exportToExcel) {
    ShowLoaderCenter();

    if (exportToExcel != true)
        exportToExcel = false;

    var _pristupPredmetu = null;
    switch ($("#ddlCase_Search_PristupPredmetu").val()) {
        case "yes":
            _pristupPredmetu = true;
            break;
        case "no":
            _pristupPredmetu = false;
            break;
    }

    var reqObj = {
        ExportToExcel: exportToExcel,

        UserId: CurrentUser.Id,
        UserFullName: CurrentUser.FirstName + " " + CurrentUser.LastName,
        Token: CurrentUser.Token,
        Email: CurrentUser.Email,

        NasBroj: $("#txtCase_Search_NasBroj").val(),
        Kategorije: GetDataFromMultiselect("ddlCase_Search_Kategorija"),
        UlogeUPostupku: GetDataFromMultiselect("ddlCase_Search_Uloga"),
        BrojPredmeta: $("#txtCase_Search_BrojPredmeta").val(),
        BezBrojaPredmeta: $("#cbCase_Search_BezBrojaPredmeta").prop("checked"),
        Sudovi: GetDataFromMultiselect("ddlCase_Search_Sud"),
        Sudije: GetDataFromMultiselect("ddlCase_Search_Sudija"),
        VrijednostSporaFrom: $("#txtCase_Search_VrijednostSporaFrom").attr("number_value"),
        VrijednostSporaTo: $("#txtCase_Search_VrijednostSporaTo").attr("number_value"),
        VrstePredmeta: GetDataFromMultiselect("ddlCase_Search_VrstaPredmeta"),
        DatumStanjaPredmeta: $("#txtCase_Search_DatumStanjaPredmeta").val() == "" ? null : ConvertBSDateToUSDateString($("#txtCase_Search_DatumStanjaPredmeta").val()),
        StanjePredmeta: $("#txtCase_Search_StanjePredmeta").val(),
        Labels: GetDataFromMultiselect("ddlCase_Search_Labels"),
        IniciranFrom: $("#txtCase_Search_IniciranFrom").val(),
        IniciranTo: $("#txtCase_Search_IniciranTo").val(),
        ArhiviranFrom: $("#txtCase_Search_ArhiviranFrom").val(),
        ArhiviranTo: $("#txtCase_Search_ArhiviranTo").val(),
        UspjehFrom: $("#ddlCase_Search_UspjehFrom").val(),
        UspjehTo: $("#ddlCase_Search_UspjehTo").val(),
        PristupPredmetu: _pristupPredmetu,
        PravniOsnov: $("#txtCase_Search_PravniOsnov").val(),

        RowCount: $("#ddlAdvancedSearchRowCount").val()
    };

    if (exportToExcel !== true) {
        $("#tblCasesSearch").bootstrapTable("destroy");
        $("#divAdvancedSearchResults").hide();
    }

    $.post(AppPath + "api/advancedSearch", reqObj)
        .done(function (data) {
            if (data != null && data.length > 0) {
                if (exportToExcel === true) {
                    document.getElementById('iframeDownload').src = document.location.href.split('?')[0].toLowerCase().replace("/desk.aspx", "") + "/Temp/" + CurrentUser.Id.toString() + "/" + data;
                    HideLoaderCenter();
                }
                else {
                    $(data).each(function (index, _case) {
                        if (Date.parse(_case.Iniciran))
                            _case.Iniciran = moment(_case.Iniciran).format("DD.MM.YYYY");

                        if (Date.parse(_case.DatumStanjaPredmeta))
                            _case.DatumStanjaPredmeta = moment(_case.DatumStanjaPredmeta).format("DD.MM.YYYY");

                        if (Date.parse(_case.DatumArhiviranja))
                            _case.DatumArhiviranja = moment(_case.DatumArhiviranja).format("DD.MM.YYYY");

                        if (_case.VrijednostSpora != null)
                            _case.VrijednostSporaString = GetMoneyFormat(_case.VrijednostSpora);

                        _case.PrivremeniZastupniciString = _case.PrivremeniZastupnici ? "Da" : "Ne";
                        _case.PristupPredmetuString = _case.PristupPredmetu ? "Da" : "Ne";

                        _case.NasBrojName = "<strong>" + _case.NasBroj + "</strong>";

                        if (Labels != null)
                            _case.Labels = BuildLabelsHTML(_case.LabelIds, "case", _case.Id);

                        switch (_case.KategorijaPredmetaId) {
                            case 5:
                                // OTVOREN
                                _case.KategorijaPredmetaName = "<span style='color: #00b6ee; font-weight: bold;'>" + _case.KategorijaPredmetaName + "</span>";
                                break;
                            case 7:
                                // ARHIVIRAN
                                _case.KategorijaPredmetaName = "<span style='color: #ff0000; font-weight: bold;'>" + _case.KategorijaPredmetaName + "</span>";
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
                            $("#tblCasesSearch").bootstrapTable({
                                data: data,
                                striped: true,
                                showColumns: true,
                                columns: $.extend(true, [], _columnsCases).splice(2, 18),
                                escape: false,
                                clickToSelect: false
                            });
                            $("#divAdvancedSearchResults").show();
                            HideLoaderCenter();
                        }
                    });
                }
            }
            else {
                if (exportToExcel !== true) {
                    $("#tblCasesSearch").bootstrapTable({
                        data: [],
                        striped: true,
                        showColumns: true,
                        columns: $.extend(true, [], _columnsCases).splice(2, 18),
                        escape: false
                    });
                    $("#divAdvancedSearchResults").show();
                }
                HideLoaderCenter();
            }
        })
        .fail(function (response) {
            if (jqXHR.status == 403)
                AlertUserSessionError();
            else if (exportToExcel === true)
                ShowAlert("danger", "Greška prilikom printanja u Excel tabelu. Probajte ponovo ili kontaktirajte administratora.");
            else
                ShowAlert("danger", "Greška prilikom napredne pretrage. Probajte ponovo ili kontaktirajte administratora.");
            HideLoaderCenter();
        });
}

function PrintAdvancedSearchResults() {
    var divToPrint = document.getElementById('divAdvancedSearchResults_Printable');
    var newWin = window.open('', 'Print-Window');
    newWin.document.open();

    var styles = '<link rel="stylesheet" href="Libraries/Bootstrap/css/bootstrap.min.css" />'
        + '<link rel="stylesheet" href="Libraries/Bootstrap/bootstrap-table/dist/bootstrap-table.min.css" />';

    newWin.document.write('<html><head>' + styles + '</head><body onload="window.print()">' + divToPrint.innerHTML + '</body></html>');
    newWin.document.close();
    setTimeout(function () { newWin.close(); }, 10);
}

function ExportAdvancedSearchResults() {
    ExecuteAdvancedSearch(true);
}

$("#cbCase_Search_BezBrojaPredmeta").click(function () {
    if ($("#cbCase_Search_BezBrojaPredmeta").prop("checked") == true) {
        $("#txtCase_Search_BrojPredmeta").val("");
        $("#txtCase_Search_BrojPredmeta").attr("disabled", "disabled");
    }
    else
        $("#txtCase_Search_BrojPredmeta").removeAttr("disabled");
});

function ChooseGoogleDoc(tip) {
    CurrentGoogleDocSelection = { Tip: tip };
    OpenPicker();
}

function RemoveGoogleDoc(tip) {
    CurrentGoogleDocSelection = null;

    switch (tip) {
        case "radnja":
            $("#aCase_Radnja_DocumentLink").html("");
            $("#aCase_Radnja_DocumentLink").removeAttr("href");
            $("#aCase_Radnja_DocumentLink").removeAttr("google_drive_doc_id");
            $("#btnCase_Radnja_RemoveGoogleDoc").hide();
            break;
        case "dokument":
            $("#aCase_Document_DocumentLink").html("");
            $("#aCase_Document_DocumentLink").removeAttr("href");
            $("#aCase_Document_DocumentLink").removeAttr("google_drive_doc_id");
            $("#btnCase_Document_RemoveGoogleDoc").hide();
            //$("#btnAppendDocumentToCase").attr("disabled", "disabled");
            break;
    }
}

$("#txtCase_VrijednostSpora,#txtCase_Search_VrijednostSporaFrom,#txtCase_Search_VrijednostSporaTo,#txtCase_ExpenseAmount")
    .blur(function () {
        $(this).attr("number_value", parseFloat($(this).val().toString().replace(/,/g, '.'))); // Only dot allowed as decimal symbol
        $(this).val(GetMoneyFormat($(this).val()));
    })
    .focus(function () {
        $(this).val($(this).attr("number_value"));
    });

function NasBrojSorterFunction(a, b) {
    if (a == undefined || a == null)
        a = 0;
    if (b == undefined || b == null)
        b = 0;

    a = parseFloat(a.replace("<strong>", "").replace("</strong>", ""));
    b = parseFloat(b.replace("<strong>", "").replace("</strong>", ""));

    if (a == b)
        return 0;
    else if (a > b)
        return 1;
    else
        return -1;
}


$("#cbCase_CaseActivity_SaveNew").change(function () {
    if ($(this).prop("checked")) {
        $("#txtCase_CaseActivity_ActivityDate").removeAttr("disabled");
        $("#txtCase_CaseActivity_Note").removeAttr("disabled");
        $("#cbCase_CaseActivity_ForAllUsers").removeAttr("disabled");
        $("#txtCase_CaseActivity_ActivityDaysOffset").removeAttr("disabled");
    }
    else {
        $("#txtCase_CaseActivity_ActivityDate").attr("disabled", "disabled");
        $("#txtCase_CaseActivity_Note").attr("disabled", "disabled");
        $("#cbCase_CaseActivity_ForAllUsers").attr("disabled", "disabled");
        $("#txtCase_CaseActivity_ActivityDaysOffset").attr("disabled", "disabled");
    }
});


$("#ddlCase_Kategorija").change(function () {
    switch (parseInt($(this).val())) {
        case 5:
            // OTVOREN
            $(this).css("background-color", "#00b6ee");
            break;
        case 8:
            // ARHIVIRAN
            $(this).css("background-color", "#ff0000");
            break;
        case 10:
            //PO ŽALBI/PRIGOVORU
            $(this).css("background-color", "#21b04b");
            break;
        default:
            $(this).css("background-color", "#ffffff");
            break;
    }
});

$('#modalTemplate').on('hidden.bs.modal', function () {
    // If in case edit mode, then keep the case modal open after closing template modal.
    var tempId = $("#modalCase").attr("edit_id");
    if (tempId != undefined) {
        $("#modalCase").css("overflow-y", "scroll");
        $("body").css("overflow", "hidden");
    }
});

$('#modalCase').on('hidden.bs.modal', function () {
    $("body").css("overflow", "auto");
});

function SetMenuLocation() {
    if (window.innerWidth > 1000) {
        var leftOffset = (window.innerWidth - $("#navBarMenuContainer").width()) / 2;
        $("#navBarMenuContainer").css("left", leftOffset.toString() + "px");
        $("#strongNavBarHeader").show();
    }
    else if (window.innerWidth >= 768) {
        $("#navBarMenuContainer").css("left", "0");
        $("#strongNavBarHeader").hide();
    }
    else
        $("#navBarMenuContainer").css("left", "0");
}

$(window).resize(function () {
    SetMenuLocation();
});