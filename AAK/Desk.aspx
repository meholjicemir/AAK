<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Desk.aspx.cs" Inherits="AAK.Desk" %>

<!DOCTYPE html>

<html>
<head>
    <title>Advokatsko društvo Đonko</title>

    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />

    <link rel="stylesheet" href="Libraries/Bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="Libraries/Bootstrap/bootstrap-table/dist/bootstrap-table.min.css" />
    <link rel="stylesheet" href="Libraries/Bootstrap/bootstrap-multiselect/bootstrap-multiselect.css" />
    <link rel="stylesheet" href="Libraries/Bootstrap/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css" />
    <link rel="stylesheet" href="Libraries/jQuery/jquery-ui.min.css" />
    <link rel="stylesheet" href="Styles/NewStyle.min.css?v=201" />
</head>
<body>
    <script src="Libraries/jQuery/jquery-1.12.0.min.js"></script>
    <script src="Libraries/jQuery/jquery-ui.min.js"></script>
    <script src="Libraries/Moment/moment.js"></script>
    <script src="Libraries/Bootstrap/js/bootstrap.min.js"></script>
    <script src="Libraries/Bootstrap/bootstrap-table/dist/bootstrap-table.min.js"></script>
    <script src="Libraries/Bootstrap/bootstrap-table/dist/locale/bootstrap-table-hr-HR.min.js"></script>
    <script src="Libraries/Bootstrap/bootstrap-multiselect/bootstrap-multiselect.js"></script>
    <script src="Libraries/Bootstrap/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"></script>
    <script src="Scripts/Utilities.min.js"></script>

    <script>
        var Google_ClientId = "<%=ConfigurationManager.AppSettings["Google_ClientId"].ToString()%>";
        var Google_ClientSecret = "<%=ConfigurationManager.AppSettings["Google_ClientSecret"].ToString()%>";
        var GoogleCalendarId = "<%=ConfigurationManager.AppSettings["GoogleCalendarId"].ToString()%>";
        var GoogleDriveRootFolderId = "<%=ConfigurationManager.AppSettings["GoogleDriveRootFolderId"].ToString()%>";
    </script>

    <script src="Desk.aspx.min.js?v=210" defer="defer"></script>

    <iframe id="iframeDownload" style="position: absolute; left: -1000px;"></iframe>

    <div id="divGoogleSignIn">
        <img src="Images/logocms.png" alt="Logo" />
        <h1></h1>
        <hr />
        <!--Add buttons to initiate auth sequence and sign out-->
        <center>
        <button id="authorize-button"class="btn btn-default" style="display: none;">Prijavi se (Google)</button>
        <button id="signout-button" class="btn btn-default" style="display: none;">Odjavi se</button>
        </center>

        <script src="Scripts/google.min.js?v=15"></script>
        <script async defer src="https://apis.google.com/js/api.js"
            onload="this.onload=function(){};handleClientLoad()"
            onreadystatechange="if (this.readyState === 'complete') this.onload()">
        </script>
        <br />
        <div id="divGoogleSignInAlert"></div>
        <br />
    </div>

    <div id="divAll" class="container" style="padding: 0px; width: 100%; display: none;">
        <nav class="navbar navbar-default navbar-static-top">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle pull-left" data-toggle="collapse" data-target="#navBarMenuContainer" style="margin-left: 10px;">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
            </div>
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand" href="#">
                        <strong style="font-size: 1.1em;" id="strongNavBarHeader">Advokatsko društvo Đonko</strong>
                    </a>
                </div>
                <ul class="nav navbar-nav collapse navbar-collapse" id="navBarMenuContainer" style="width: 700px; position: fixed; background-color: #f8f8f8;">
                    <li class="menu-item" id="liMenuHome" style="display: none;"><a href="#" onclick="MenuHome(); return false;"><strong>Početna</strong></a></li>
                    <li class="menu-item" id="liMenuCases" style="display: none;"><a href="#" onclick="MenuCases(); return false;"><strong>Predmeti</strong></a></li>
                    <li class="menu-item" id="liMenuParties" style="display: none;"><a href="#" onclick="MenuParties(); return false;"><strong>Stranke</strong></a></li>
                    <li class="menu-item" id="liMenuReports" style="display: none;"><a href="#" onclick="MenuReports(); return false;"><strong>Napredna pretraga</strong></a></li>
                    <li class="menu-item" id="liMenuSudovi" style="display: none;"><a href="#" onclick="MenuSudovi(); return false;"><strong>Sudovi</strong></a></li>
                    <li class="menu-item dropdown" id="liMenuCodeTables">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><strong>Kodne tabele</strong><span class="caret"></span></a>
                        <ul class="dropdown-menu forAnimate" role="menu">
                            <li class="menu-sub-item"><a href="#" onclick="LoadCodeTableUI(this, 'Sudije', 'Sudije'); return false;">Sudije</a></li>
                            <li class="menu-sub-item"><a href="#" onclick="LoadCodeTableUI(this, 'Kategorije predmeta', 'KategorijePredmeta'); return false;">Kategorije predmeta</a></li>
                            <li class="menu-sub-item"><a href="#" onclick="LoadCodeTableUI(this, 'Vrste predmeta', 'VrstePredmeta'); return false;">Vrste predmeta</a></li>
                            <li class="menu-sub-item"><a href="#" onclick="LoadCodeTableUI(this, 'Stanja predmeta', 'StanjaPredmeta'); return false;">Stanja predmeta</a></li>
                            <li class="menu-sub-item"><a href="#" onclick="LoadCodeTableUI(this, 'Načini okončanja', 'NaciniOkoncanja'); return false;">Načini okončanja</a></li>
                            <li class="menu-sub-item"><a href="#" onclick="LoadCodeTableUI(this, 'Vrste troškova', 'VrsteTroskova'); return false;">Vrste troškova</a></li>
                            <li class="menu-sub-item"><a href="#" onclick="LoadCodeTableUI(this, 'Vrste radnji', 'VrsteRadnji', undefined, 'Zvjezdica na kraju naziva vrste radnje znači da se vrsta radnje prikazuje na početnoj stranici.'); return false;">Vrste radnji</a></li>
                            <li class="menu-sub-item"><a href="#" onclick="LoadCodeTableUI(this, 'Tipovi dokumenata', 'TipoviDokumenata'); return false;">Tipovi dokumenata</a></li>
                            <%--<li class="menu-sub-item"><a href="#" onclick="LoadCodeTableUI(this, 'Načini obavljanja radnje', 'NaciniObavljanjaRadnje'); return false;">Načini obavljanja radnje</a></li>--%>
                            <li class="menu-sub-item"><a href="#" onclick="LoadCodeTableUI(this, 'Države', 'Drzave'); return false;">Države</a></li>
                            <li class="menu-sub-item"><a href="#" onclick="MenuLabels(); LoadCodeTableUI(this, 'Oznake'); return false;">Oznake</a></li>
                        </ul>
                    </li>
                    <li class="menu-item" id="liMenuUsers" style="display: none;"><a href="#" onclick="MenuUsers(); return false;"><strong>Korisnici</strong></a></li>
                </ul>
            </div>
        </nav>

        <div id="divLoading" style="margin-left: 1%; margin-right: 1%; margin-bottom: 2px; display: none;">
            <button class="btn btn-warning btn-block disabled">
                <span class="glyphicon glyphicon-refresh spinning"></span>&nbsp;Molimo sačekajte...
            </button>
        </div>

        <!-- BEGIN: Alerts -->
        <div id="divAlertGeneral" style="width: 600px; margin: 0 auto;"></div>
        <!-- END: Alerts -->


        <div id="divHome" class="panel panel-default menu-div" style="display: none;">
            <div class="pull-right" style="margin-right: 5px;">
                <span class="label" style="background-color: #ff0000;">KAŠNJENJE</span>
                <span class="label" style="background-color: #21b04b;">DANAS</span>
                <span class="label" style="background-color: #00b6ee;">SUTRA</span>
            </div>
            <br />
            <div class="panel-body">
                <div class="row">
                    <div class="col-lg-12">
                        <div>
                            <h4><strong>Pozvani predmeti</strong></h4>
                            <hr />
                        </div>
                        <form class="form-inline pull-left" role="form">
                            <div class="form-group">
                                <label for="txtCaseActivitiesFilter">Traži:</label>
                                <input type="text" class="form-control" id="txtCaseActivitiesFilter" />
                            </div>
                            <div class="form-group">
                                <label for="ddlCaseActivitiesRowCount">Broj redova:</label>
                                <select class="form-control" id="ddlCaseActivitiesRowCount">
                                    <option value="10">10</option>
                                    <option value="20" selected="selected">20</option>
                                    <option value="50">50</option>
                                    <option value="100">100</option>
                                    <option value="1000">1000</option>
                                    <option value="5000">5000</option>
                                    <option value="2147483647">Sve</option>
                                </select>
                            </div>
                            <button id="btnRefreshCaseActivities" class="btn btn-default" onclick="LoadCaseActivities(); return false;">
                                <span class="glyphicon glyphicon-refresh"></span>&nbsp;Osvježi
                            </button>
                        </form>
                        <table id="tblCaseActivities" class="table table-no-bordered"></table>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <br />
                        <br />
                        <div>
                            <h4><strong>Raspored suđenja i odluka</strong></h4>
                            <hr />
                        </div>
                        <form class="form-inline pull-left" role="form" style="margin-bottom: 20px;">
                            <div class="form-group">
                                <label for="txtRadnjeFilter">Traži:</label>
                                <input type="text" class="form-control" id="txtRadnjeFilter" />
                            </div>
                            <div class="form-group">
                                <label for="ddlRadnjeRowCount">Broj redova:</label>
                                <select class="form-control" id="ddlRadnjeRowCount">
                                    <option value="10">10</option>
                                    <option value="20" selected="selected">20</option>
                                    <option value="50">50</option>
                                    <option value="100">100</option>
                                    <option value="1000">1000</option>
                                    <option value="5000">5000</option>
                                    <option value="2147483647">Sve</option>
                                </select>
                            </div>
                            <button id="btnRefreshRadnje" class="btn btn-default" onclick="LoadRadnje(); return false;">
                                <span class="glyphicon glyphicon-refresh"></span>&nbsp;Osvježi
                            </button>
                        </form>
                        <table id="tblRadnje" class="table table-no-bordered"></table>
                    </div>
                </div>
            </div>
        </div>

        <div id="divCases" class="panel panel-default menu-div" style="display: none;">
            <div class="panel-body">
                <button id="btnNewCase" type="button" class="btn btn-primary only-office-admin" data-toggle="modal" data-target="#modalCase" onclick="StartBuildingNewCase(); return false;"><span class="glyphicon glyphicon-plus"></span>&nbsp;Dodaj novi predmet</button>
                <div id="divOznake" class="pull-right" style="display: none;">
                    <form class="form-inline " role="form">
                        <label for="ddlLabels">Oznake:</label>
                        <select id="ddlLabels" class="form-control">
                            <option value="" selected="selected">----</option>
                        </select>
                        <button id="btnApplyLabel" class="btn btn-success" onclick="ApplyLabel('case'); return false;" disabled="disabled">
                            <span class="glyphicon glyphicon-ok"></span>
                        </button>
                    </form>
                </div>
                <hr class="only-office-admin" />

                <form class="form-inline pull-left" role="form">
                    <div class="form-group">
                        <label for="txtCasesFilter">Traži:</label>
                        <input type="text" class="form-control" id="txtCasesFilter" placeholder="Sve kolone" />
                        <input type="text" class="form-control nas-broj-text" id="txtCasesFilterNasBroj" placeholder="Naš broj" />
                    </div>
                    <div class="form-group">
                        <label for="ddlCasesRowCount">Broj redova:</label>
                        <select class="form-control" id="ddlCasesRowCount">
                            <option value="10">10</option>
                            <option value="20" selected="selected">20</option>
                            <option value="50">50</option>
                            <option value="100">100</option>
                            <option value="1000">1000</option>
                            <option value="5000">5000</option>
                            <option value="2147483647">Sve</option>
                        </select>
                    </div>
                    <button id="btnRefreshCases" class="btn btn-default" onclick="LoadCases(); return false;">
                        <span class="glyphicon glyphicon-refresh"></span>&nbsp;Osvježi
                    </button>
                </form>
                <table id="tblCases" class="table table-condensed" style="word-break: break-word;"></table>
            </div>
        </div>

        <div id="divParties" class="panel panel-default menu-div" style="display: none;">
            <div class="panel-body">
                <button id="btnNewParty" type="button" class="btn btn-primary only-office-admin" data-toggle="modal" data-target="#modalParty" onclick="ClearModalParty(); return false;"><span class="glyphicon glyphicon-plus"></span>&nbsp;Dodaj novu stranku</button>
                <hr class="only-office-admin" />
                <form class="form-inline pull-left" role="form">
                    <div class="form-group">
                        <label for="txtPartiesFilter">Traži:</label>
                        <input type="text" class="form-control" id="txtPartiesFilter" />
                    </div>
                    <div class="form-group">
                        <label for="ddlCasesRowCount">Broj redova:</label>
                        <select class="form-control" id="ddlPartiesRowCount">
                            <option value="10">10</option>
                            <option value="20" selected="selected">20</option>
                            <option value="50">50</option>
                            <option value="100">100</option>
                            <option value="1000">1000</option>
                            <option value="5000">5000</option>
                            <option value="2147483647">Sve</option>
                        </select>
                    </div>
                    <button id="btnRefreshParties" class="btn btn-default" onclick="LoadParties(); return false;">
                        <span class="glyphicon glyphicon-refresh"></span>&nbsp;Osvježi
                    </button>
                </form>
                <table id="tblParties" class="table table-condensed" style="word-break: break-word;"></table>
            </div>
        </div>

        <div id="divReports" class="panel panel-default menu-div" style="display: none;">
            <div class="panel-heading">
                <div class="row" style="padding-bottom: 15px;">
                    <div class="col-lg-6">
                        <form class="form-inline pull-left" role="form">
                            <label for="txtCase_Search_NasBroj" class="fixed-width-label-narrow">Naš broj:</label>
                            <input type="text" class="form-control dynamic-width-field" id="txtCase_Search_NasBroj" value="" />
                            <br />
                            <label for="ddlCase_Search_Kategorija" class="fixed-width-label-narrow">Kategorija:</label>
                            <select class="form-control dynamic-width-field" id="ddlCase_Search_Kategorija" multiple="multiple">
                            </select>
                            <br />
                            <label for="ddlCase_Search_Uloga" class="fixed-width-label-narrow">Uloga u postupku:</label>
                            <select class="form-control dynamic-width-field" id="ddlCase_Search_Uloga" multiple="multiple">
                            </select>
                            <%--<br />
                            <label for="cbCase_Search_PrivremeniZastupnici" class="fixed-width-label">Privremeni zastupnici</label>
                            <input id="cbCase_Search_PrivremeniZastupnici" type="checkbox" />--%>
                            <br />
                            <label for="dateTimePicker_Search_IniciranFrom" class="fixed-width-label-narrow">Iniciran:</label>
                            <span class="input-group date" id="dateTimePicker_Search_IniciranFrom" style="width: 150px;">
                                <input type="text" class="form-control" id="txtCase_Search_IniciranFrom" />
                                <span class="input-group-addon btn">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </span>
                            -
                            <span class="input-group date" id="dateTimePicker_Search_IniciranTo" style="width: 150px;">
                                <input type="text" class="form-control" id="txtCase_Search_IniciranTo" />
                                <span class="input-group-addon btn">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </span>
                            <br />
                            <label for="dateTimePicker_Search_ArhiviranFrom" class="fixed-width-label-narrow">Datum arhiviranja:</label>
                            <span class="input-group date" id="dateTimePicker_Search_ArhiviranFrom" style="width: 150px;">
                                <input type="text" class="form-control" id="txtCase_Search_ArhiviranFrom" />
                                <span class="input-group-addon btn">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </span>
                            -
                            <span class="input-group date" id="dateTimePicker_Search_ArhiviranTo" style="width: 150px;">
                                <input type="text" class="form-control" id="txtCase_Search_ArhiviranTo" />
                                <span class="input-group-addon btn">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </span>
                            <br />
                            <label for="ddlCase_Search_UspjehFrom" class="fixed-width-label-narrow">Uspjeh:</label>
                            <select class="form-control dynamic-width-field" id="ddlCase_Search_UspjehFrom">
                            </select>
                            -
                            <select class="form-control dynamic-width-field" id="ddlCase_Search_UspjehTo">
                            </select>
                            <br />
                            <label for="txtCase_Search_PravniOsnov" class="fixed-width-label-narrow">Pravni osnov:</label>
                            <textarea class="form-control dynamic-width-field" rows="3" cols="60" id="txtCase_Search_PravniOsnov"></textarea>
                        </form>
                    </div>
                    <div class="col-lg-6">
                        <form class="form-inline pull-left" role="form">
                            <label for="ddlCase_Search_PristupPredmetu" class="fixed-width-label-narrow">Pristup putem Interneta:</label>
                            <select class="form-control" id="ddlCase_Search_PristupPredmetu">
                                <option value="null">-----</option>
                                <option value="yes">Da</option>
                                <option value="no">Ne</option>
                            </select>
                            <br />
                            <label for="txtCase_Search_BrojPredmeta" class="fixed-width-label-narrow">Broj predmeta:</label>
                            <input type="text" class="form-control fixed-width-field" id="txtCase_Search_BrojPredmeta" />
                            <label for="cbCase_Search_BezBrojaPredmeta">Bez broja</label>
                            <input id="cbCase_Search_BezBrojaPredmeta" type="checkbox" />
                            <br />
                            <label for="ddlCase_Search_Sud" class="fixed-width-label-narrow">Sud:</label>
                            <select class="form-control fixed-width-field" id="ddlCase_Search_Sud" multiple="multiple">
                            </select>
                            <br />
                            <label for="ddlCase_Search_Sudija" class="fixed-width-label-narrow">Sudija:</label>
                            <select class="form-control fixed-width-field" id="ddlCase_Search_Sudija" multiple="multiple">
                            </select>
                            <br />
                            <label for="txtCase_Search_VrijednostSporaFrom" class="fixed-width-label-narrow">Vrijednost spora:</label>
                            <input type="text" class="form-control fixed-width-field-narrow" id="txtCase_Search_VrijednostSporaFrom" />
                            -
                            <input type="text" class="form-control fixed-width-field-narrow" id="txtCase_Search_VrijednostSporaTo" />
                            <br />
                            <label for="ddlCase_Search_VrstaPredmeta" class="fixed-width-label-narrow">Vrsta predmeta:</label>
                            <select class="form-control fixed-width-field" id="ddlCase_Search_VrstaPredmeta" multiple="multiple">
                            </select>
                            <br />
                            <label for="dateTimePicker_Search_DatumStanjaPredmeta" class="fixed-width-label-narrow">Stanje predmeta:</label>
                            <span class="input-group date" id="dateTimePicker_Search_DatumStanjaPredmeta" style="width: 150px;">
                                <input type="text" class="form-control" id="txtCase_Search_DatumStanjaPredmeta" />
                                <span class="input-group-addon btn">
                                    <span class="glyphicon glyphicon-calendar"></span>
                                </span>
                            </span>
                            <span class="form-group has-feedback">
                                <input type="text" class="form-control" id="txtCase_Search_StanjePredmeta" style="width: 250px;" />
                                <i id="spinner_txtCase_Search_StanjePredmeta" class="glyphicon glyphicon-refresh spinning form-control-feedback" style="display: none;"></i>
                            </span>
                            <br />
                            <label for="ddlCase_Search_Labels" class="fixed-width-label-narrow">Oznake:</label>
                            <select class="form-control fixed-width-field" id="ddlCase_Search_Labels" multiple="multiple">
                            </select>
                        </form>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <form class="form-inline pull-left" role="form">
                            <div class="form-group">
                                <label for="ddlAdvancedSearchRowCount">Broj redova:</label>
                                <select class="form-control" id="ddlAdvancedSearchRowCount">
                                    <option value="10">10</option>
                                    <option value="20" selected="selected">20</option>
                                    <option value="50">50</option>
                                    <option value="100">100</option>
                                    <option value="1000">1000</option>
                                    <option value="5000">5000</option>
                                    <option value="2147483647">Sve</option>
                                </select>
                            </div>
                        </form>
                    </div>
                </div>
                <button id="btnExecuteAdvancedSearch" class="btn btn-primary pull-right" onclick="ExecuteAdvancedSearch(); return false;">
                    <span class="glyphicon glyphicon-list"></span>&nbsp;Pretraži
                </button>
                <br />
                <br />
            </div>
            <div id="divAdvancedSearchResults" class="panel-body" style="display: none;">
                <div class="btn-group">
                    <button id="btnPrintAdvancedSearchResults" class="btn btn-default pull-left" onclick="PrintAdvancedSearchResults(); return false;">
                        <span class="glyphicon glyphicon-print"></span>&nbsp;Printaj
                    </button>
                    <button id="btnExportAdvancedSearchResults" class="btn btn-success pull-left" onclick="ExportAdvancedSearchResults(); return false;">
                        <span class="glyphicon glyphicon-th-large"></span>&nbsp;Printaj u Excel tabelu
                    </button>
                </div>
                <div id="divAdvancedSearchResults_Printable">
                    <table id="tblCasesSearch" class="table table-condensed" style="word-break: break-word;"></table>
                </div>
            </div>
        </div>

        <div id="divSudovi" class="panel panel-default menu-div" style="display: none;">
            <div class="panel-body">
                <button id="btnNewSud" type="button" class="btn btn-primary pull-left only-office-admin" data-toggle="modal" data-target="#modalSud" onclick="ClearModalSud(); return false;"><span class="glyphicon glyphicon-plus"></span>&nbsp;Dodaj novi sud</button>
                <table id="tblSudovi" class="table table-condensed" style="word-break: break-word;"></table>
            </div>
        </div>

        <div id="divLabels" class="panel panel-default menu-div" style="display: none;">
            <div class="panel-body">
                <button id="btnNewLabel" type="button" class="btn btn-primary pull-left only-office-admin" data-toggle="modal" data-target="#modalLabel" onclick="ClearModalLabel(); return false;"><span class="glyphicon glyphicon-plus"></span>&nbsp;Dodaj novu oznaku</button>
                <table id="tblLabels" class="table table-condensed" style="word-break: break-word;"></table>
            </div>
        </div>

        <div id="divUsers" class="panel panel-default menu-div" style="display: none;">
            <div class="panel-body">
                <button id="btnNewUser" type="button" class="btn btn-primary pull-left" data-toggle="modal" data-target="#modalUser" onclick="ClearModalUser(); return false;"><span class="glyphicon glyphicon-plus"></span>&nbsp;Dodaj novog korisnika</button>
                <table id="tblUsers" class="table table-condensed" style="word-break: break-word;"></table>
            </div>
        </div>

        <div id="divCodeTable" class="panel panel-default menu-div" style="display: none;">
            <div class="panel-heading">
            </div>
            <div class="panel-body">
                <button id="btnNewCodeTableRecord" type="button" class="btn btn-primary pull-left only-office-admin" data-toggle="modal" data-target="#modalCodeTableRecord" onclick="NewCodeTableRecord(); return false;"><span class="glyphicon glyphicon-plus"></span>&nbsp;Dodaj</button>
                <table id="tblCodeTableData" class="table table-condensed" style="word-break: break-word;"></table>
            </div>
        </div>

    </div>


    <!-- Modals -->
    <div id="modalCase" class="modal fade" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-admin">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Novi predmet</h4>
                </div>
                <div class="modal-body yellowish-background" style="padding-top: 5px; padding-bottom: 0;">
                    <div class="row yellowish-background">
                        <div class="col-lg-12">
                            <div class="modal-in-title">
                                <h4><strong>Osnovni podaci o predmetu</strong></h4>
                            </div>
                        </div>
                    </div>
                    <div class="row yellowish-background" style="padding-bottom: 10px;">
                        <div class="col-lg-5">
                            <form class="form-inline pull-left" role="form">
                                <label for="txtCase_NasBroj" class="fixed-width-label-narrow">Naš broj:</label>
                                <input type="text" class="form-control dynamic-width-field" id="txtCase_NasBroj" disabled="disabled" value="" />
                                <br />
                                <label for="ddlCase_Kategorija" class="fixed-width-label-narrow">Kategorija:</label>
                                <select class="form-control dynamic-width-field" id="ddlCase_Kategorija">
                                    <option>-----</option>
                                </select>
                                <br />
                                <label for="ddlCase_Uloga" class="fixed-width-label-narrow">Uloga u postupku:</label>
                                <select class="form-control dynamic-width-field" id="ddlCase_Uloga">
                                    <option value="-1">-----</option>
                                </select>
                                <br />
                                <label for="cbCase_PrivremeniZastupnici" class="fixed-width-label-narrow">Privremeni zastupnici</label>
                                <input id="cbCase_PrivremeniZastupnici" type="checkbox" />
                                <br />
                                <label for="cbCase_PristupPredmetu" class="fixed-width-label-narrow">Pristup predmetu putem interneta</label>
                                <input id="cbCase_PristupPredmetu" type="checkbox" />
                            </form>
                        </div>
                        <div class="col-lg-7">
                            <form class="form-inline pull-left" role="form">
                                <label for="txtCase_BrojPredmeta" class="fixed-width-label-narrow">Iniciran:</label>
                                <span class="input-group date" id="dateTimePicker_Iniciran">
                                    <input type="text" class="form-control" id="txtCase_Iniciran" />
                                    <span class="input-group-addon btn">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </span>
                                <br />
                                <label for="txtCase_BrojPredmeta" class="fixed-width-label-narrow">Broj predmeta:</label>
                                <input type="text" class="form-control fixed-width-field" id="txtCase_BrojPredmeta" />
                                <br />
                                <label for="ddlCase_Sud" class="fixed-width-label-narrow">Sud:</label>
                                <select class="form-control fixed-width-field" id="ddlCase_Sud">
                                    <option value="-1">-----</option>
                                </select>
                                <br />
                                <label for="ddlCase_Sudija" class="fixed-width-label-narrow">Sudija:</label>
                                <select class="form-control fixed-width-field" id="ddlCase_Sudija">
                                    <option value="-1">-----</option>
                                </select>
                                <br />
                                <label for="txtCase_VrijednostSpora" class="fixed-width-label-narrow">Vrijednost spora:</label>
                                <input type="text" class="form-control fixed-width-field" id="txtCase_VrijednostSpora" />
                                <br />
                                <label for="ddlCase_VrstaPredmeta" class="fixed-width-label-narrow">Vrsta predmeta:</label>
                                <select class="form-control fixed-width-field" id="ddlCase_VrstaPredmeta">
                                    <option value="-1">-----</option>
                                </select>
                            </form>
                        </div>
                    </div>
                    <div class="row yellowish-background" style="padding-bottom: 15px;">
                        <div class="col-lg-12 case-column-for-stanje">
                            <form class="form-inline pull-left" role="form">
                                <label for="dateTimePicker_DatumStanjaPredmeta" class="fixed-width-label-narrow">Stanje predmeta:</label>
                                <span class="input-group date" id="dateTimePicker_DatumStanjaPredmeta">
                                    <input type="text" class="form-control" id="txtCase_DatumStanjaPredmeta" />
                                    <span class="input-group-addon btn">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </span>
                                <span class="form-group has-feedback" style="display: inline-block; width: 500px;">
                                    <input type="text" class="form-control" id="txtCase_StanjePredmeta" style="width: 100%;" />
                                    <i id="spinner_txtCase_StanjePredmeta" class="glyphicon glyphicon-refresh spinning form-control-feedback" style="display: none;"></i>
                                </span>
                            </form>
                            <button class='btn btn-default btn-sm custom-table-button-template pull-right' data-toggle='tooltip' title='Generiši dokument iz predloška' id="btnGenerateTemplateForCase">
                                <span class='glyphicon glyphicon-file'></span>&nbsp; Generiši dokument
                            </button>
                        </div>
                    </div>
                    <div class="row gray-background">
                        <div class="col-lg-12">
                            <div class="modal-in-title">
                                <h4><strong>Stranke u postupku</strong></h4>
                            </div>
                        </div>
                    </div>
                    <div class="row gray-background" style="padding-bottom: 15px;">
                        <div class="col-lg-12">
                            <form class="form-inline only-office-admin" role="form">
                                <label for="ddlCase_Lice">Stranka:</label>
                                <select class="form-control" id="ddlCase_Lice" style="max-width: 400px;">
                                    <option value="-1">-----</option>
                                </select>
                                <label for="ddlCase_UlogaLica">Uloga:</label>
                                <select class="form-control" id="ddlCase_UlogaOrdinalNo">
                                    <option value="" selected="selected"></option>
                                    <option value="1">1.</option>
                                    <option value="2">2.</option>
                                    <option value="3">3.</option>
                                    <option value="4">4.</option>
                                    <option value="5">5.</option>
                                    <option value="6">6.</option>
                                    <option value="7">7.</option>
                                    <option value="8">8.</option>
                                    <option value="9">9.</option>
                                    <option value="10">10.</option>
                                    <option value="11">11.</option>
                                    <option value="12">12.</option>
                                    <option value="13">13.</option>
                                    <option value="14">14.</option>
                                    <option value="15">15.</option>
                                    <option value="16">16.</option>
                                    <option value="17">17.</option>
                                    <option value="18">18.</option>
                                    <option value="19">19.</option>
                                    <option value="20">20.</option>
                                    <option value="21">21.</option>
                                    <option value="22">22.</option>
                                    <option value="23">23.</option>
                                    <option value="24">24.</option>
                                    <option value="25">25.</option>
                                </select>
                                <select class="form-control" id="ddlCase_UlogaLica">
                                    <option value="-1">-----</option>
                                </select>
                                <label for="ddlCase_GlavnaStranka">Vrsta:</label>
                                <select class="form-control" id="ddlCase_GlavnaStranka">
                                    <option value="" selected="selected"></option>
                                    <option value="ns">Naša stranka</option>
                                    <option value="ps">Protivna stranka</option>
                                </select>
                                <button id="btnAppendPartyToCase" type="button" class="btn btn-success" disabled="disabled" onclick="AppendPartyToCase(); return false;">Dodaj</button>
                            </form>
                            <br />
                            <table id="tblCaseParties" class="table table-condensed" style="word-break: break-word; background-color: #ffffff;"></table>
                        </div>
                    </div>
                    <%--<div class="row white-background">
                        <div class="col-lg-12">
                            <div class="modal-in-title">
                                <h4><strong>Ostalo</strong></h4>
                            </div>
                        </div>
                    </div>--%>
                    <div class="row white-background" style="padding-bottom: 15px; padding-top: 10px;">
                        <div class="col-lg-12">
                            <ul id="ulOtherTabs" class="nav nav-tabs">
                                <li class="active"><a href="#" id="aRadnjeOtherTab" class="a-case-tab" onclick="OpenOtherTab(this, 'divRadnje'); return false;">Radnje</a></li>
                                <li><a href="#" class="a-case-tab" onclick="OpenOtherTab(this, 'divTroskovi'); return false;">Troškovi</a></li>
                                <li><a href="#" class="a-case-tab" onclick="OpenOtherTab(this, 'divDokumenti'); return false;">Dokumenti</a></li>
                                <li><a href="#" class="a-case-tab" onclick="OpenOtherTab(this, 'divPravniOsnov'); return false;">Pravni osnov</a></li>
                                <li><a href="#" class="a-case-tab" onclick="OpenOtherTab(this, 'divBiljeske'); return false;">Bilješke</a></li>
                                <li><a href="#" class="a-case-tab" onclick="OpenOtherTab(this, 'divVeze'); return false;">Veze</a></li>
                            </ul>
                            <div class="other-tab" id="divRadnje">
                                <div id="divRadnjeAlert"></div>
                                <form class="form-inline only-office-admin" role="form">
                                    <label for="ddlCase_Radnja_VrstaRadnje">Vrsta Radnje:</label>
                                    <select id="ddlCase_Radnja_VrstaRadnje" class="form-control">
                                        <option value="-1">-----</option>
                                    </select>
                                    <label for="dateTimePicker_Radnja_DatumRadnje">Datum:</label>
                                    <div class="input-group date" id="dateTimePicker_Radnja_DatumRadnje">
                                        <input type="text" class="form-control" id="txtCase_Radnja_DatumRadnje" />
                                        <span class="input-group-addon btn">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                    <%--<label for="ddlCase_Radnja_Troskovi">Troškovi:</label>
                                    <select id="ddlCase_Radnja_Troskovi" class="form-control">
                                        <option value="">-----</option>
                                        <option value="0%">0%</option>
                                        <option value="25%">25%</option>
                                        <option value="50%">50%</option>
                                        <option value="100%">100%</option>
                                    </select>--%>
                                    <br />
                                    <label for="txtCase_Radnja_Biljeske">Bilješke:</label>
                                    <input type="text" class="form-control fixed-width-field" id="txtCase_Radnja_Biljeske" />
                                    <label for="txtCase_Radnja_DocumentLink">Dokument:</label>
                                    <button class="btn btn-sm btn-default" onclick="ChooseGoogleDoc('radnja'); return false;">Odaberi dokument</button>
                                    <button id="btnCase_Radnja_RemoveGoogleDoc" class="btn btn-sm btn-default" style="display: none; color: red;" onclick="RemoveGoogleDoc('radnja'); return false;">X</button>
                                    <a id="aCase_Radnja_DocumentLink" target="_blank"></a>
                                    <button id="btnAppendRadnjaToCase" type="button" class="btn btn-success" disabled="disabled" onclick="AppendRadnjaToCase(); return false;">Dodaj</button>
                                </form>
                                <br />
                                <table id="tblCaseRadnje" class="table table-condensed" style="word-break: break-word;"></table>
                            </div>
                            <div class="other-tab" style="display: none;" id="divTroskovi">
                                <form class="form-inline only-office-admin" role="form">
                                    <label for="ddlCase_ExpenseVrstaTroska">Vrsta troška:</label>
                                    <select id="ddlCase_ExpenseVrstaTroska" class="form-control" style="max-width: 250px;">
                                        <option value="-1">-----</option>
                                    </select>
                                    <label for="txtCase_ExpenseAmount">Iznos:</label>
                                    <input type="text" class="form-control" id="txtCase_ExpenseAmount" style="width: 150px;" />
                                    <label for="dateTimePicker_ExpenseDate">Datum:</label>
                                    <div class="input-group date" id="dateTimePicker_ExpenseDate" style="width: 150px;">
                                        <input type="text" class="form-control" id="txtCase_ExpenseDate" />
                                        <span class="input-group-addon btn">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                    <label for="ddlCase_ExpensePaidBy">Plaćeno od:</label>
                                    <select id="ddlCase_ExpensePaidBy" class="form-control">
                                        <option value="">-----</option>
                                        <option value="STRANKA">STRANKA</option>
                                        <option value="ADVOKAT">ADVOKAT</option>
                                        <option value="OSLOBOĐEN">OSLOBOĐEN</option>
                                    </select>
                                    <button id="btnAppendExpenseToCase" type="button" class="btn btn-success" disabled="disabled" onclick="AppendExpenseToCase(); return false;">Dodaj</button>
                                </form>
                                <br />
                                <table id="tblCaseExpenses" class="table table-condensed" style="word-break: break-word;"></table>
                            </div>
                            <div class="other-tab" style="display: none;" id="divDokumenti">
                                <div id="divDocumentsAlert"></div>
                                <form class="form-inline only-office-admin" role="form">

                                    <span class="form-group has-feedback">
                                        <label for="txtCase_Document_TipDokumenta">Tip dokumenta:</label>
                                        <input type="text" class="form-control fixed-width-field" id="txtCase_Document_TipDokumenta" />
                                        <i id="spinner_txtCase_Document_TipDokumenta" class="glyphicon glyphicon-refresh spinning form-control-feedback" style="display: none;"></i>
                                    </span>
                                    <%--<label for="ddlCase_Document_TipDokumenta">Tip dokumenta:</label>--%>
                                    <%--<select id="ddlCase_Document_TipDokumenta" class="form-control">
                                        <option value="-1">-----</option>
                                    </select>--%>
                                    <span class="form-group has-feedback">
                                        <label for="txtCase_Document_PredatoUz">Predato uz:</label>
                                        <input type="text" class="form-control fixed-width-field" id="txtCase_Document_PredatoUz" />
                                        <i id="spinner_txtCase_Document_PredatoUz" class="glyphicon glyphicon-refresh spinning form-control-feedback" style="display: none;"></i>
                                    </span>
                                    <br />
                                    <label for="txtCase_Document_Note">Bilješke:</label>
                                    <input type="text" class="form-control fixed-width-field" id="txtCase_Document_Note" />
                                    <label for="txtCase_Document_DocumentLink">Dokument:</label>
                                    <button class="btn btn-sm btn-default" onclick="ChooseGoogleDoc('dokument'); return false;">Odaberi dokument</button>
                                    <button id="btnCase_Document_RemoveGoogleDoc" class="btn btn-sm btn-default" style="display: none; color: red;" onclick="RemoveGoogleDoc('dokument'); return false;">X</button>
                                    <a id="aCase_Document_DocumentLink" target="_blank"></a>
                                    <%--<input type="file" class="form-control" id="txtCase_Document_DocumentLink" />--%>
                                    <button id="btnAppendDocumentToCase" type="button" class="btn btn-success" disabled="disabled" onclick="AppendDocumentToCase(); return false;">Dodaj</button>
                                    <button id="btnPasteCaseDocument" type="button" class="btn btn-default pull-right" style="display: none;" onclick="PasteCaseDocument(); return false;" data-toggle="tooltip" title="Zalijepi kopirani dokument">
                                        <span class='glyphicon glyphicon-paste'></span>
                                    </button>
                                </form>
                                <br />
                                <table id="tblCaseDocuments" class="table table-condensed" style="word-break: break-word;"></table>
                            </div>
                            <div class="other-tab row" style="display: none;" id="divPravniOsnov">
                                <div class="col-md-6">
                                    <label for="txtCase_PravniOsnov">Pravni osnov:</label>
                                    <textarea class="form-control" rows="5" id="txtCase_PravniOsnov"></textarea>
                                </div>
                                <div class="col-md-6">
                                    <label>Oznake:</label>
                                    <br />
                                    <span>(Za dodavanje i brisanje oznaka nije potrebno spašavati predmet. Promjene se odmah primjenjuju.)</span>
                                    <div id="divCase_Labels" style="margin-top: 10px;"></div>
                                    <form class="form-inline only-office-admin" role="form">
                                        <select id="ddlCase_Labels" class="form-control fixed-width-field"></select>
                                        <button id="btnApplyLabelInCase" class="btn btn-success" onclick="ApplyLabel('case', true); return false;">
                                            <span class="glyphicon glyphicon-ok"></span>
                                        </button>
                                    </form>
                                </div>
                            </div>
                            <div class="other-tab" style="display: none;" id="divBiljeske">
                                <form class="form-inline only-office-admin" role="form">
                                    <label for="dateTimePicker_NoteDate">Datum:</label>
                                    <div class="input-group date" id="dateTimePicker_NoteDate" style="width: 150px;">
                                        <input type="text" class="form-control" id="txtCase_NoteDate" />
                                        <span class="input-group-addon btn">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                    <label for="txtCase_NoteText">Bilješka:</label>
                                    <input type="text" class="form-control" id="txtCase_NoteText" style="min-width: 600px;" />
                                    <button id="btnAppendNoteToCase" type="button" class="btn btn-success" disabled="disabled" onclick="AppendNoteToCase(); return false;">Dodaj</button>
                                </form>
                                <br />
                                <table id="tblCaseNotes" class="table table-condensed" style="word-break: break-word;"></table>
                            </div>
                            <div class="other-tab" style="display: none;" id="divVeze">
                                <form class="form-inline only-office-admin" role="form">
                                    <span class="form-group has-feedback">
                                        <label for="txtCase_Connection_ConnectionCase">Veza prema predmetu:</label>
                                        <input type="text" class="form-control fixed-width-field" id="txtCase_Connection_ConnectionCase" />
                                        <i id="spinner_txtCase_Connection_ConnectionCase" class="glyphicon glyphicon-refresh spinning form-control-feedback" style="display: none;"></i>
                                    </span>
                                    <label for="txtCase_Connection_Note">Bilješke:</label>
                                    <input type="text" class="form-control fixed-width-field" id="txtCase_Connection_Note" />
                                    <button id="btnAppendConnectionToCase" type="button" class="btn btn-success" disabled="disabled" onclick="AppendConnectionToCase(); return false;">Dodaj</button>
                                </form>
                                <br />
                                <table id="tblCaseConnections" class="table table-condensed" style="word-break: break-word;"></table>
                            </div>
                        </div>
                    </div>
                    <div class="row yellowish-background">
                        <div class="col-lg-12">
                            <div class="modal-in-title">
                                <h4><strong>Pozivanje predmeta</strong></h4>
                            </div>
                        </div>
                    </div>
                    <div class="row yellowish-background" style="padding-bottom: 15px;">
                        <div class="col-lg-12">
                            <form class="form-inline" role="form">
                                <label for="cbCase_CaseActivity_SaveNew" class="dynamic-width-field">Snimi novo pozivanje predmeta</label>
                                <input id="cbCase_CaseActivity_SaveNew" class="dynamic-width-field" type="checkbox" disabled="disabled" />
                                <hr />
                                <label for="dateTimePicker_CaseActivity_ActivityDate" class="fixed-width-label-narrow">Od:</label>
                                <span class="input-group date" id="dateTimePicker_CaseActivity_ActivityDate">
                                    <input type="text" class="form-control" id="txtCase_CaseActivity_ActivityDate" />
                                    <span class="input-group-addon btn">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </span>
                                <label>za</label>
                                <input type="number" class="form-control" style="width: 100px; margin-top: 3px;" id="txtCase_CaseActivity_ActivityDaysOffset" value="0" />
                                <label>dana.</label>
                                <br />
                                <label for="txtCase_CaseActivity_Note" class="dynamic-width-field fixed-width-label-narrow">Bilješka:</label>
                                <input type="text" id="txtCase_CaseActivity_Note" class="form-control dynamic-width-field" style="min-width: 500px;" />
                                <label for="cbCase_CaseActivity_ForAllUsers" class="dynamic-width-field">Prikaži svim korisnicima</label>
                                <input id="cbCase_CaseActivity_ForAllUsers" class="dynamic-width-field" type="checkbox" checked="checked" disabled="disabled" />
                            </form>
                        </div>
                    </div>
                    <div class="row gray-background">
                        <div class="col-lg-12">
                            <div class="modal-in-title">
                                <h4><strong>Ishod postupka i arhiva</strong></h4>
                            </div>
                        </div>
                    </div>
                    <div class="row gray-background" style="padding-bottom: 15px;">
                        <div class="col-lg-12">
                            <form class="form-inline" role="form">
                                <label for="ddlCase_NacinOkoncanja" class="fixed-width-label-narrow">Način okončanja:</label>
                                <select class="form-control dynamic-width-field" id="ddlCase_NacinOkoncanja">
                                    <option value="-1">-----</option>
                                </select>
                                <label for="ddlCase_Uspjeh">Uspjeh:</label>
                                <select class="form-control dynamic-width-field" id="ddlCase_Uspjeh">
                                    <option value="" selected="selected"></option>
                                </select>
                                <label for="dateTimePicker_DatumArhiviranja">Datum arhiviranja:</label>
                                <span class="input-group date" id="dateTimePicker_DatumArhiviranja">
                                    <input type="text" class="form-control" id="txtCase_DatumArhiviranja" />
                                    <span class="input-group-addon btn">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </span>
                                <br />
                                <label for="txtCase_BrojArhive" class="fixed-width-label-narrow">Broj u arhivi:</label>
                                <input type="text" id="txtCase_BrojArhive" class="form-control dynamic-width-field" />
                                <label for="txtCase_BrojArhiveRegistrator">Registrator:</label>
                                <input type="text" id="txtCase_BrojArhiveRegistrator" class="form-control dynamic-width-field" />
                            </form>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="btnSaveCase" type="button" class="btn btn-primary only-office-admin" onclick="SaveCase(); return false;">Spasi</button>
                    <button id="btnSaveAndCloseCase" type="button" class="btn btn-primary only-office-admin" data-dismiss="modal" onclick="SaveCase(); return false;">Spasi i zatvori</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Zatvori</button>
                </div>
            </div>
        </div>
    </div>

    <div id="modalParty" class="modal fade" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-admin">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Nova stranka</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <form class="form-inline pull-left" role="form">
                                <label for="txtParty_Prezime" class="fixed-width-label">Prezime:</label>
                                <input type="text" class="form-control fixed-width-field" id="txtParty_Prezime" />
                                <br />
                                <label for="txtParty_Ime" class="fixed-width-label">Ime:</label>
                                <input type="text" class="form-control fixed-width-field" id="txtParty_Ime" />
                                <br />
                                <label for="cbParty_IsMinor" class="fixed-width-label">Malodobno lice</label>
                                <input id="cbParty_IsMinor" type="checkbox" />
                                <br />
                                <label for="txtParty_ZakonskiZastupnik" class="fixed-width-label">Zakonski zastupnik:</label>
                                <input type="text" class="form-control fixed-width-field" id="txtParty_ZakonskiZastupnik" />
                                <br />
                                <label for="txtParty_PravnoLice" class="fixed-width-label">Pravno Lice ili Institucija:</label>
                                <input type="text" class="form-control fixed-width-field" id="txtParty_PravnoLice" />
                                <br />
                                <br />
                                <label for="txtParty_Adresa" class="fixed-width-label">Adresa:</label>
                                <input type="text" class="form-control fixed-width-field" id="txtParty_Adresa" />
                                <br />
                                <label for="txtParty_PostanskiBroj" class="fixed-width-label">Poštanski broj:</label>
                                <input type="text" class="form-control fixed-width-field" id="txtParty_PostanskiBroj" />
                                <br />
                                <label for="txtParty_Grad" class="fixed-width-label">Grad:</label>
                                <input type="text" class="form-control fixed-width-field" id="txtParty_Grad" />
                                <br />
                                <label for="ddlParty_Drzava" class="fixed-width-label">Država:</label>
                                <select class="form-control fixed-width-field" id="ddlParty_Drzava">
                                    <option value="-1">-----</option>
                                </select>
                                <br />
                                <label for="txtParty_Email" class="fixed-width-label">Email:</label>
                                <input type="text" class="form-control fixed-width-field" id="txtParty_Email" />
                                <br />
                            </form>
                        </div>
                        <div class="col-lg-6">
                            <form class="form-inline pull-left" role="form">
                                <label for="txtParty_Biljeske" class="fixed-width-label">Bilješke:</label>
                                <textarea class="form-control fixed-width-field" rows="8" id="txtParty_Biljeske"></textarea>
                                <br />
                                <label for="txtParty_Telefon" class="fixed-width-label">Telefon:</label>
                                <textarea class="form-control fixed-width-field" rows="2" id="txtParty_Telefon"></textarea>
                                <br />
                                <label for="txtParty_Fax" class="fixed-width-label">Fax:</label>
                                <input type="text" class="form-control fixed-width-field" id="txtParty_Fax" />
                                <br />
                                <label for="txtParty_JMBG_IDBroj" class="fixed-width-label">JMBG / ID broj:</label>
                                <input type="text" class="form-control fixed-width-field" id="txtParty_JMBG_IDBroj" />
                                <br />
                            </form>
                        </div>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="col-lg-12">
                            <h4>Predmeti</h4>
                            <table id="tblPartyCases" class="table table-condensed" style="word-break: break-word;"></table>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="SaveParty(); return false;">Spasi</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="SaveParty(); return false;">Spasi i zatvori</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Zatvori</button>
                </div>
            </div>
        </div>
    </div>

    <div id="modalLabel" class="modal fade" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Nova oznaka</h4>
                </div>
                <div class="modal-body">
                    <form class="form-inline" role="form">
                        <label for="txtLabel_Name" class="fixed-width-label">Naziv:</label>
                        <input type="text" class="form-control fixed-width-field" id="txtLabel_Name" />
                        <br />
                        <label for="txtLabel_BackgroundColor" class="fixed-width-label">Boja pozadine:</label>
                        <input type="color" class="form-control fixed-width-field" id="txtLabel_BackgroundColor" />
                        <br />
                        <label for="txtLabel_FontColor" class="fixed-width-label">Boja fonta:</label>
                        <input type="color" class="form-control fixed-width-field" id="txtLabel_FontColor" />
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="SaveLabel(); return false;">Spasi i zatvori</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Zatvori</button>
                </div>
            </div>
        </div>
    </div>

    <div id="modalSud" class="modal fade" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Novi sud</h4>
                </div>
                <div class="modal-body">
                    <form class="form-inline" role="form">
                        <label for="txtSud_Naziv" class="fixed-width-label">Naziv:</label>
                        <input type="text" class="form-control fixed-width-field" id="txtSud_Naziv" />
                        <br />
                        <label for="txtSud_Adresa" class="fixed-width-label">Adresa:</label>
                        <input type="text" class="form-control fixed-width-field" id="txtSud_Adresa" />
                        <br />
                        <label for="txtSud_PostanskiBroj" class="fixed-width-label">Poštanski broj:</label>
                        <input type="text" class="form-control fixed-width-field" id="txtSud_PostanskiBroj" />
                        <br />
                        <label for="txtSud_Grad" class="fixed-width-label">Grad:</label>
                        <input type="text" class="form-control fixed-width-field" id="txtSud_Grad" />
                        <br />
                        <label for="txtSud_Telefon" class="fixed-width-label">Telefon:</label>
                        <input type="text" class="form-control fixed-width-field" id="txtSud_Telefon" />
                        <br />
                        <label for="txtSud_Fax" class="fixed-width-label">Fax:</label>
                        <input type="text" class="form-control fixed-width-field" id="txtSud_Fax" />
                        <hr />
                        <h4>Računi za uplate</h4>
                        <label for="txtSud_RacunTakse" class="fixed-width-label">Sudske takse:</label>
                        <input type="text" class="form-control fixed-width-field" id="txtSud_RacunTakse" />
                        <br />
                        <label for="txtSud_RacunVjestacenja" class="fixed-width-label">Vještačenja:</label>
                        <input type="text" class="form-control fixed-width-field" id="txtSud_RacunVjestacenja" />
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="SaveSud(); return false;">Spasi i zatvori</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Zatvori</button>
                </div>
            </div>
        </div>
    </div>

    <div id="modalTemplate" class="modal fade" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Odaberite predložak</h4>
                </div>
                <div class="modal-body">
                    <select id="ddlTemplates" class="form-control" style="width: 100%;">
                        <option value="">-----</option>
                    </select>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="GenerateTemplate(); return false;">Generiši dokument</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Odustani</button>
                </div>
            </div>
        </div>
    </div>

    <div id="modalUser" class="modal fade" role="dialog" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Novi korisnik</h4>
                </div>
                <div class="modal-body">
                    <form class="form-inline" role="form">
                        <label for="txtUser_Email" class="fixed-width-label">Email:</label>
                        <input type="text" class="form-control fixed-width-field" id="txtUser_Email" />
                        <br />
                        <label for="txtUser_FirstName" class="fixed-width-label">Ime:</label>
                        <input type="text" class="form-control fixed-width-field" id="txtUser_FirstName" />
                        <br />
                        <label for="txtUser_LastName" class="fixed-width-label">Prezime:</label>
                        <input type="text" class="form-control fixed-width-field" id="txtUser_LastName" />
                        <br />
                        <label for="txtUser_Phone" class="fixed-width-label">Telefon:</label>
                        <input type="text" class="form-control fixed-width-field" id="txtUser_Phone" />
                        <br />
                        <%--<label for="txtUser_GoogleDriveLocalFolderPath" class="fixed-width-label">Google Drive direktorij (lokalna putanja):</label>
                        <input type="text" class="form-control fixed-width-field" id="txtUser_GoogleDriveLocalFolderPath" />
                        <br />--%>
                        <label for="ddlUser_UserGroups" class="fixed-width-label">Korisničke grupe:</label>
                        <select id="ddlUser_UserGroups" multiple="multiple" class="form-control fixed-width-field">
                        </select>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="SaveUser(); return false;">Spasi i zatvori</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Zatvori</button>
                </div>
            </div>
        </div>
    </div>

    <div id="modalCodeTableRecord" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title"></h4>
                </div>
                <div class="modal-body">
                    <label for="txtCodeTableRecord_Name" class="fixed-width-label">Naziv:</label>
                    <input type="text" class="form-control" id="txtCodeTableRecord_Name" />
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="SaveCodeTableRecord(); return false;">Spasi i zatvori</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Zatvori</button>
                </div>
            </div>

        </div>
    </div>

    <div id="modalPrompt" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title" id="promptTitle"></h4>
                </div>
                <div class="modal-body">
                    <label id="promptMessage"></label>
                </div>
                <div class="modal-footer">
                    <button id="btnPromptYes" type="button" class="btn btn-success" data-dismiss="modal">Da</button>
                    <button id="btnPromptNo" type="button" class="btn btn-danger" data-dismiss="modal">Ne</button>
                </div>
            </div>
        </div>
    </div>

    <div id="divHidden" style="display: none;">
        <button id="btnOpenModalEditCodeTableRecord" data-toggle='modal' data-target='#modalCodeTableRecord'></button>
        <button id="btnOpenModalEditSud" data-toggle='modal' data-target='#modalSud'></button>
        <button id="btnOpenModalEditLabel" data-toggle='modal' data-target='#modalLabel'></button>
        <button id="btnOpenModalEditParty" data-toggle='modal' data-target='#modalParty'></button>
        <button id="btnOpenModalEditCase" data-toggle='modal' data-target='#modalCase'></button>
        <button id="btnOpenModalGenerateTemplate" data-toggle='modal' data-target='#modalTemplate'></button>

        <button id="btnOpenModalPrompt" data-toggle='modal' data-target='#modalPrompt'></button>
        <button id="btnOpenModalEditUser" data-toggle='modal' data-target='#modalUser'></button>
    </div>

    <div class="pull-right" style="position: absolute; top: 0; right: 0; margin: 2px; font-size: xx-small; z-index: 1000;">
        <button id="btnLogOut" class="btn btn-sm btn-default" data-toggle="tooltip" title="Odjava" style="display: none;" onclick="LogOut(); return false;">
            <span class="glyphicon glyphicon-log-out"></span>&nbsp;Odjava
        </button>
        <img id="imgUserPicture" height="50" width="50" alt="Slika korisnika" src="" data-toggle="tooltip" title="Slika korisnika" />
    </div>
    <div class="pull-right" style="position: fixed; bottom: 0; right: 0; margin: 2px; font-size: xx-small; z-index: 1000;">
        <span class="pull-right">v2.1.12</span>
    </div>
</body>
</html>
