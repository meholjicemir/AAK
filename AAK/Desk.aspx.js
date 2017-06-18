/// <reference path="Scripts/Utilities.js" />

var AppPath = window.location.protocol + "//" + window.location.host + "/";
var CurrentUser = null;
var CurrentCodeTable = null;
var Sudovi = null;
var Lica = null;

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
                UserGroupCodes: data.UserGroupCodes
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
    LoadCodeTableData("Drzave", $("#ddlParty_Drzava"));
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

    var _columns = [
        { field: 'NasBroj', title: 'Naš broj', titleTooltip: 'Naš broj', sortable: true },
        { field: 'BrojPredmeta', title: 'Broj predmeta', titleTooltip: 'Broj predmeta', sortable: true },
        { field: 'SudijaName', title: 'Sudija', titleTooltip: 'Sudija', sortable: true },
        { field: 'SudName', title: 'Sud', titleTooltip: 'Sud', sortable: true },
        { field: 'Iniciran', title: 'Iniciran', titleTooltip: 'Iniciran', sortable: true, visible: false, sorter: DateSorterFunction },
        { field: 'VrijednostSporaString', title: 'Vrijednost spora', titleTooltip: 'Vrijednost spora', sortable: true, align: "right" },
        { field: 'KategorijaPredmetaName', title: 'Kategorija', titleTooltip: 'Kategorija', sortable: true },
        { field: 'UlogaName', title: 'Uloga', titleTooltip: 'Uloga', sortable: true },
        { field: 'VrstaPredmetaName', title: 'Vrsta predmeta', titleTooltip: 'Vrsta predmeta', sortable: true },
        { field: 'Uspjeh', title: 'Uspjeh', titleTooltip: 'Uspjeh', sortable: true, visible: false },
        { field: 'PravniOsnov', title: 'Pravni osnov', titleTooltip: 'Pravni osnov', sortable: true, visible: false },
        { field: 'DatumStanjaPredmeta', title: 'Datum stanja', titleTooltip: 'Datum stanja', sortable: true, sorter: DateSorterFunction },
        { field: 'StanjePredmetaName', title: 'Stanje predmeta', titleTooltip: 'Stanje predmeta', sortable: true },
        { field: 'DatumArhiviranja', title: 'Datum arhiviranja', titleTooltip: 'Datum arhiviranja', sortable: true, visible: false, sorter: DateSorterFunction }
    ];

    $("#tblCases").bootstrapTable("destroy");

    $.get(AppPath + "api/predmet", {
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
                    $("#tblCases").bootstrapTable({
                        data: data,
                        striped: true,
                        showColumns: true,
                        columns: _columns,
                        escape: false
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

function MenuParties() {
    DeactivateAllMenuItems();
    $("#liMenuParties").addClass("active");
    $(".menu-div").hide();
    $("#divParties").show();

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
        { field: 'IsMinorString', title: 'Mldb', titleTooltip: 'Malodobno lice', sortable: true },
        { field: 'ZakonskiZastupnik', title: 'Z. zastupnik', titleTooltip: 'Zakonski zastupnik', sortable: true },
        { field: 'Adresa', title: 'Adresa', titleTooltip: 'Adresa', sortable: true, visible: false },
        { field: 'PostanskiBroj', title: 'Poštanski broj', titleTooltip: 'Poštanski broj', sortable: true, align: "right", visible: false },
        { field: 'Grad', title: 'Grad', titleTooltip: 'Grad', sortable: true },
        { field: 'DrzavaName', title: 'Država', titleTooltip: 'Država', sortable: true, visible: false },
        { field: 'Telefon', title: 'Telefon', titleTooltip: 'Telefon', sortable: true },
        { field: 'Fax', title: 'Fax', titleTooltip: 'Fax', sortable: true },
        { field: 'Email', title: 'Email', titleTooltip: 'Email', sortable: true },
        { field: 'JMBG_IDBroj', title: 'JMBG / ID broj', titleTooltip: 'JMBG / ID broj', sortable: true },
        { field: 'CreatedByName', title: 'Kreirao/la', titleTooltip: 'Kreirao/la', sortable: true, visible: false },
        { field: 'Created', title: 'Datum kreiranja', titleTooltip: 'Datum kreiranja', sortable: true, visible: false, sorter: DateSorterFunction },
        { field: 'ModifiedByName', title: 'Izmijenio/la', titleTooltip: 'Izmijenio/la', sortable: true, visible: false },
        { field: 'Modified', title: 'Datum zadnje izmjene', titleTooltip: 'Datum zadnje izmjene', sortable: true, visible: false, sorter: DateSorterFunction }
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
                    _party.Created = moment(_party.Created).format("lll");

                if (Date.parse(_party.Modified))
                    _party.Modified = moment(_party.Modified).format("lll");

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
                            "<button class='btn btn-default btn-sm custom-table-button-edit' data-toggle='tooltip' title='Izmijeni podatke o licu' onclick='EditParty(" + tempId.toString() + "); return false;'>"
                            + "<span class='glyphicon glyphicon-pencil'></span>"
                            + "</button>";

                buttonsHTML +=
                            "<button class='btn btn-default btn-sm custom-table-button-delete' data-toggle='tooltip' title='Izbriši lice' onclick='DeleteParty(" + tempId.toString() + "); return false;'>"
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
                    _sud.Created = moment(_sud.Created).format("lll");

                if (Date.parse(_sud.Modified))
                    _sud.Modified = moment(_sud.Modified).format("lll");

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
        }
    });
}

function DeactivateAllMenuItems() {
    $(".menu-item").removeClass("active");
    $(".menu-sub-item").css("background-color", "");
}

function SaveCase() {

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

function LoadCodeTableData(tableName, dropDown, columnName) {
    if (columnName == undefined)
        columnName = "Name";

    ShowLoaderCenter();
    $.get(AppPath + "api/codetable", {
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
    $("#modalParty").find(".modal-title").html("Novo lice");
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
            ShowAlert("success", "Uspješno spašeno lice.");
            HideLoaderCenter();
            LoadParties();
        }
        else {
            HideLoaderCenter();
            ShowAlert("danger", "Greška pri spašavanju lica.");
        }
    })
    .fail(function (response) {
        HideLoaderCenter();
        ShowAlert("danger", "Greška pri spašavanju lica.");
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

            $("#modalParty").find(".modal-title").html("Izmijeni lice: <span style='font-style: italic; color: gray;'>" + obj.Naziv + "</span>");
            $("#btnOpenModalEditParty").click();
        }
    });
}

function DeleteParty(id) {
    $(Lica).each(function (index, obj) {
        if (obj.Id == id) {
            ShowPrompt(
                "Da li ste sigurni da želite izbrisati lice?",
                "<span style='font-style: italic; color: gray;'>" + obj.Naziv + "</span>",
                function () {
                    ShowLoaderCenter();
                    $.ajax({
                        url: AppPath + "api/lice?Id=" + id.toString(),
                        type: "DELETE",
                        success: function () {
                            LoadParties();
                            HideLoaderCenter();
                            ShowAlert("success", "Uspješno izbrisano lice.");
                        },
                        error: function () {
                            HideLoaderCenter();
                            ShowAlert("danger", "Greška pri brisanju lica.");
                        }
                    });
                },
                function () { }
            );
        }
    });
}