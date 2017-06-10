/// <reference path="Scripts/Utilities.js" />

var appPath = window.location.protocol + "//" + window.location.host + "/";
var CurrentUser = null;
var CurrentCodeTable = null;

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

    $('#dateTimePicker_DatumStanjaPredmeta').datetimepicker({
        format: 'MM/DD/YYYY'
    });

    // Load code table data
    LoadCodeTableData("KategorijePredmeta", $("#ddlCase_Kategorija"));
    LoadCodeTableData("Sudovi", $("#ddlCase_Sud"), "Sud");
    LoadCodeTableData("Sudije", $("#ddlCase_Sudija"));
    LoadCodeTableData("VrstePredmeta", $("#ddlCase_VrstaPredmeta"));
    LoadCodeTableData("StanjaPredmeta", $("#ddlCase_StanjePredmeta"));
}

function MenuHome() {
    DeactivateAllMenuItems();
    $("#liMenuHome").addClass("active");
    $(".menu-div").hide();
    $("#divHome").show();
}

function MenuCases() {
    DeactivateAllMenuItems();
    $("#liMenuCases").addClass("active");
    $(".menu-div").hide();
    $("#divCases").show();

    LoadCases();
}

function LoadCases() {
    ShowLoaderCenter();
    $.get(appPath + "api/predmet", {
        UserId: CurrentUser.Id,
        Filter: $("#txtCasesFilter").val(),
        RowCount: $("#ddlCasesRowCount").val()
    })
    .done(function (data) {
        if (data != null && data.length > 0) {

            $(data).each(function (index, _case) {
                if (Date.parse(_case.Iniciran))
                    _case.Iniciran = moment(_case.Iniciran).format("ll");

                if (Date.parse(_case.DatumStanjaPredmeta))
                    _case.DatumStanjaPredmeta = moment(_case.DatumStanjaPredmeta).format("ll");

                if (Date.parse(_case.DatumArhiviranja))
                    _case.DatumArhiviranja = moment(_case.DatumArhiviranja).format("ll");

                if (_case.VrijednostSpora != null)
                    _case.VrijednostSporaString = _case.VrijednostSpora.toFixed(2);

                switch (_case.KategorijaPredmetaId) {
                    case 5:
                        // OTVOREN
                        _case.KategorijaPredmetaName = "<span style='color: blue; font-weight: bold;'>" + _case.KategorijaPredmetaName + "</span>";
                        break;
                    case 7:
                        // ARHIVIRAN
                        _case.KategorijaPredmetaName = "<span style='color: red; font-weight: bold;'>" + _case.KategorijaPredmetaName + "</span>";
                        break;
                    case 9:
                        //PO ŽALBI/PRIGOVORU
                        _case.KategorijaPredmetaName = "<span style='color: green; font-weight: bold;'>" + _case.KategorijaPredmetaName + "</span>";
                        break;
                    default:
                        _case.KategorijaPredmetaName = "<span style='color: black; font-weight: bold;'>" + _case.KategorijaPredmetaName + "</span>";
                        break;
                }

                if (index == data.length - 1) {
                    var _columns = [
                        { field: 'NasBroj', title: 'Naš broj', titleTooltip: 'Naš broj', sortable: true },
                        { field: 'BrojPredmeta', title: 'Broj predmeta', titleTooltip: 'Broj predmeta', sortable: true },
                        { field: 'SudijaName', title: 'Sudija', titleTooltip: 'Sudija', sortable: true },
                        { field: 'SudName', title: 'Sud', titleTooltip: 'Sud', sortable: true },
                        { field: 'Iniciran', title: 'Iniciran', titleTooltip: 'Iniciran', sortable: true, visible: false },
                        { field: 'VrijednostSporaString', title: 'Vrijednost spora', titleTooltip: 'Vrijednost spora', sortable: true, align: "right" },
                        { field: 'KategorijaPredmetaName', title: 'Kategorija', titleTooltip: 'Kategorija', sortable: true },
                        { field: 'UlogaName', title: 'Uloga', titleTooltip: 'Uloga', sortable: true },
                        { field: 'VrstaPredmetaName', title: 'Vrsta predmeta', titleTooltip: 'Vrsta predmeta', sortable: true },
                        { field: 'Uspjeh', title: 'Uspjeh', titleTooltip: 'Uspjeh', sortable: true, visible: false },
                        { field: 'PravniOsnov', title: 'Pravni osnov', titleTooltip: 'Pravni osnov', sortable: true, visible: false },
                        { field: 'DatumStanjaPredmeta', title: 'Datum stanja', titleTooltip: 'Datum stanja', sortable: true },
                        { field: 'StanjePredmetaName', title: 'Stanje predmeta', titleTooltip: 'Stanje predmeta', sortable: true },
                        { field: 'DatumArhiviranja', title: 'Datum arhiviranja', titleTooltip: 'Datum arhiviranja', sortable: true, visible: false }
                    ];

                    $("#tblCases").bootstrapTable("destroy");
                    $("#tblCases").bootstrapTable({
                        data: data,
                        striped: true,
                        showColumns: true,
                        showRefresh: false,
                        showToggle: true,
                        columns: _columns,
                        search: false,
                        escape: false
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
    DeactivateAllMenuItems();
    $("#liMenuParties").addClass("active");
    $(".menu-div").hide();
    $("#divParties").show();
}

function MenuUsers() {
    DeactivateAllMenuItems();
    $("#liMenuUsers").addClass("active");
    $(".menu-div").hide();
    $("#divUsers").show();
}

function MenuSudovi() {
    DeactivateAllMenuItems();
    $("#liMenuSudovi").addClass("active");
}

function DeactivateAllMenuItems() {
    $(".menu-item").removeClass("active");
    $(".menu-sub-item").css("background-color", "");
}

function SaveCase() {

}

function LoadCodeTableData(tableName, dropDown, columnName) {
    if (columnName == undefined)
        columnName = "Name";

    ShowLoaderCenter();
    $.get(appPath + "api/codetable", {
        Name: tableName,
        ColumnName: columnName
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

    $.get(appPath + "api/codetable", {
        Name: tableName,
        ColumnName: columnName
    })
    .done(function (data) {
        if (data) {
            var _columns = [
                { field: 'Name', sortable: true }
            ];

            $("#tblCodeTableData").bootstrapTable("destroy");
            $("#tblCodeTableData").bootstrapTable({
                data: data,
                striped: true,
                showColumns: true,
                showRefresh: false,
                showToggle: true,
                columns: _columns,
                search: false,
                showHeader: false
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

function SaveCodeTableRecord() {
    ShowLoaderCenter();
    $.post(appPath + "api/codetable", {
        TableName: CurrentCodeTable.TableName,
        Name: $("#txtCodeTableRecord_Name").val()
    })
    .done(function (data) {
        if (data && data > 0) {
            ShowAlert("success", "Uspješno unesen podatak.");
            HideLoaderCenter();
            LoadCodeTableUI(CurrentCodeTable.Element, CurrentCodeTable.Title, CurrentCodeTable.TableName, CurrentCodeTable.ColumnName);
        }
        else {
            HideLoaderCenter();
            ShowAlert("danger", "Greška pri spašavanju unesenog podatka.");
        }
    })
    .fail(function (response) {
        HideLoaderCenter();
        alert("error");
    });
}