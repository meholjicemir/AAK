<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Desk.aspx.cs" Inherits="AAK.Desk" %>

<!DOCTYPE html>

<html>
<head>
    <title>Advokatsko društvo Đonko</title>

    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="google-signin-client_id" content="304849379317-d7tvq3acv8ukdpi30ntgvinbcuekf9n2.apps.googleusercontent.com" />

    <link rel="stylesheet" href="Libraries/Bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="Libraries/Bootstrap/bootstrap-table/dist/bootstrap-table.min.css" />
    <link rel="stylesheet" href="Libraries/Bootstrap/bootstrap-multiselect/bootstrap-multbuiselect.css" />
    <link rel="stylesheet" href="Libraries/Bootstrap/bootstrap-datetimepicker/bootstrap-datetimepicker.min.css" />
    <link rel="stylesheet" href="Libraries/jQuery/jquery-ui.min.css" />
    <link rel="stylesheet" href="Styles/NewStyle.css" />
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
    <script src="Scripts/Utilities.js"></script>
    <script src="https://apis.google.com/js/platform.js" async defer="defer"></script>
    <script src="Desk.aspx.js?v=3" defer="defer"></script>

    <div>
        <div class="g-signin2" data-onsuccess="onSignIn"></div>
    </div>

    <div id="divAll" class="container" style="padding: 0px; width: 100%; display: none;">
        <nav class="navbar navbar-default navbar-static-top">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navBarMenuContainer">
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
                <ul class="nav navbar-nav collapse navbar-collapse" id="navBarMenuContainer">
                    <li class="menu-item" id="liMenuHome" style="display: none;"><a href="#" onclick="MenuHome(); return false;"><strong>Početna</strong></a></li>
                    <li class="menu-item" id="liMenuCases" style="display: none;"><a href="#" onclick="MenuCases(); return false;"><strong>Predmeti</strong></a></li>
                    <li class="menu-item" id="liMenuParties" style="display: none;"><a href="#" onclick="MenuParties(); return false;"><strong>Lica</strong></a></li>
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
                            <li class="menu-sub-item"><a href="#" onclick="LoadCodeTableUI(this, 'Vrste radnji', 'VrsteRadnji'); return false;">Vrste radnji</a></li>
                            <li class="menu-sub-item"><a href="#" onclick="LoadCodeTableUI(this, 'Načini obavljanja radnje', 'NaciniObavljanjaRadnje'); return false;">Načini obavljanja radnje</a></li>
                            <li class="menu-sub-item"><a href="#" onclick="LoadCodeTableUI(this, 'Države', 'Drzave'); return false;">Države</a></li>
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
        <div id="divAlertGeneral"></div>
        <!-- END: Alerts -->


        <div id="divHome" class="panel panel-default menu-div" style="display: none;">
            <div class="pull-right" style="margin-right: 5px;">
                <span class="label" style="background-color: #ff8888;">KAŠNJENJE</span>
                <span class="label" style="background-color: #21b04b;">DANAS</span>
                <span class="label" style="background-color: #00b6ee;">SUTRA</span>
            </div>
            <br />
            <div class="panel-body">
                <div class="row">
                    <div class="col-lg-7">
                        <div style="text-align: center;">
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
                        <table id="tblCaseActivities" class="table table-no-bordered" style="word-break: break-word;"></table>
                    </div>
                    <div class="col-lg-5">
                        <div style="text-align: center;">
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
                        <table id="tblRadnje" class="table table-no-bordered" style="word-break: break-word;"></table>
                    </div>
                </div>
            </div>
        </div>

        <div id="divCases" class="panel panel-default menu-div" style="display: none;">
            <div class="panel-body">
                <button id="btnNewCase" type="button" class="btn btn-primary only-office-admin" data-toggle="modal" data-target="#modalCase" onclick="StartBuildingNewCase(); return false;"><span class="glyphicon glyphicon-plus"></span>&nbsp;Dodaj novi predmet</button>
                <hr class="only-office-admin" />
                <form class="form-inline pull-left" role="form">
                    <div class="form-group">
                        <label for="txtCasesFilter">Traži:</label>
                        <input type="text" class="form-control" id="txtCasesFilter" />
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
                <button id="btnNewParty" type="button" class="btn btn-primary only-office-admin" data-toggle="modal" data-target="#modalParty" onclick="ClearModalParty(); return false;"><span class="glyphicon glyphicon-plus"></span>&nbsp;Dodaj novo lice</button>
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

        <div id="divSudovi" class="panel panel-default menu-div" style="display: none;">
            <div class="panel-body">
                <button id="btnNewSud" type="button" class="btn btn-primary pull-left only-office-admin" data-toggle="modal" data-target="#modalSud" onclick="ClearModalSud(); return false;"><span class="glyphicon glyphicon-plus"></span>&nbsp;Dodaj novi sud</button>
                <table id="tblSudovi" class="table table-condensed" style="word-break: break-word;"></table>
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
                <div class="modal-body">
                    <div id="divNewCaseModalBodyTop">
                    </div>
                    <div class="row">
                        <div class="col-lg-12" style="text-align: center;">
                            <div class="modal-in-title">
                                <h4><strong>Osnovni podaci o predmetu</strong></h4>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-4">
                            <label for="txtCase_NasBroj">Naš broj:</label>
                            <input type="text" class="form-control" id="txtCase_NasBroj" disabled="disabled" value="" />
                            <br />
                            <label for="ddlCase_Kategorija">Kategorija:</label>
                            <select class="form-control fixed-width-field" id="ddlCase_Kategorija">
                                <option>-----</option>
                            </select>
                            <br />
                            <label for="ddlCase_Uloga">Uloga u postupku:</label>
                            <select class="form-control fixed-width-field" id="ddlCase_Uloga">
                                <option value="-1">-----</option>
                            </select>
                            <br />
                            <label for="cbCase_PrivremeniZastupnici">Privremeni zastupnici</label>
                            <input id="cbCase_PrivremeniZastupnici" type="checkbox" />
                        </div>
                        <div class="col-lg-8">
                            <form class="form-inline pull-left" role="form">
                                <label for="txtCase_BrojPredmeta" class="fixed-width-label">Broj predmeta:</label>
                                <input type="text" class="form-control fixed-width-field" id="txtCase_BrojPredmeta" />
                                <br />
                                <label for="ddlCase_Sud" class="fixed-width-label">Sud:</label>
                                <select class="form-control fixed-width-field" id="ddlCase_Sud">
                                    <option value="-1">-----</option>
                                </select>
                                <br />
                                <label for="ddlCase_Sudija" class="fixed-width-label">Sudija:</label>
                                <select class="form-control fixed-width-field" id="ddlCase_Sudija">
                                    <option value="-1">-----</option>
                                </select>
                                <br />
                                <label for="txtCase_VrijednostSpora" class="fixed-width-label">Vrijednost spora:</label>
                                <input type="text" class="form-control fixed-width-field" id="txtCase_VrijednostSpora" />
                                <br />
                                <label for="ddlCase_VrstaPredmeta" class="fixed-width-label">Vrsta predmeta:</label>
                                <select class="form-control" id="ddlCase_VrstaPredmeta">
                                    <option value="-1">-----</option>
                                </select>
                                <hr />
                                <h4>Stanje predmeta</h4>
                                <label for="dateTimePicker_DatumStanjaPredmeta" class="fixed-width-label">Datum stanja:</label>
                                <div class="input-group date" id="dateTimePicker_DatumStanjaPredmeta">
                                    <input type="text" class="form-control" id="txtCase_DatumStanjaPredmeta" />
                                    <span class="input-group-addon btn">
                                        <span class="glyphicon glyphicon-calendar"></span>
                                    </span>
                                </div>
                                <br />
                                <label for="ddlCase_StanjePredmeta" class="fixed-width-label">Stanje:</label>
                                <select class="form-control fixed-width-field" id="ddlCase_StanjePredmeta">
                                    <option value="-1">-----</option>
                                </select>
                            </form>
                        </div>
                    </div>
                    <hr />
                    <div class="row only-office-admin">
                        <div class="col-lg-12" style="text-align: center;">
                            <div class="modal-in-title">
                                <h4><strong>Lica u postupku</strong></h4>
                            </div>
                        </div>
                    </div>
                    <div class="row only-office-admin">
                        <div class="col-lg-12">
                            <form class="form-inline" role="form">
                                <label for="ddlCase_Lice">Lice:</label>
                                <select class="form-control" id="ddlCase_Lice">
                                    <option value="-1">-----</option>
                                </select>
                                <label for="ddlCase_UlogaLica">Uloga:</label>
                                <select class="form-control" id="ddlCase_UlogaLica">
                                    <option value="-1">-----</option>
                                </select>
                                <label for="ddlCase_GlavnaStranka">Vrsta:</label>
                                <select class="form-control" id="ddlCase_GlavnaStranka">
                                    <option value="" selected="selected">-----</option>
                                    <option value="ns">Naša stranka</option>
                                    <option value="ps">Protivna stranka</option>
                                </select>
                                <button id="btnAppendPartyToCase" type="button" class="btn btn-success" disabled="disabled" onclick="AppendPartyToCase(); return false;">Dodaj</button>
                            </form>
                            <br />
                            <table id="tblCaseParties" class="table table-condensed" style="word-break: break-word;"></table>
                        </div>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="col-lg-12" style="text-align: center;">
                            <div class="row">
                                <div class="col-lg-6">
                                    <div class="modal-in-title">
                                        <h4><strong>Ishod postupka i arhiva</strong></h4>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="modal-in-title">
                                        <h4><strong>Pozivanje predmeta</strong></h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="row">
                                <div class="col-lg-6">
                                    <form class="form-inline" role="form">
                                        <label for="ddlCase_NacinOkoncanja" class="fixed-width-label">Način okončanja:</label>
                                        <select class="form-control" id="ddlCase_NacinOkoncanja">
                                            <option value="-1">-----</option>
                                        </select>
                                        <br />
                                        <label for="ddlCase_Uspjeh" class="fixed-width-label">Uspjeh:</label>
                                        <select class="form-control fixed-width-label" id="ddlCase_Uspjeh">
                                        </select>
                                        <br />
                                        <label for="dateTimePicker_DatumArhiviranja" class="fixed-width-label">Datum arhiviranja:</label>
                                        <div class="input-group date" id="dateTimePicker_DatumArhiviranja">
                                            <input type="text" class="form-control" id="txtCase_DatumArhiviranja" />
                                            <span class="input-group-addon btn">
                                                <span class="glyphicon glyphicon-calendar"></span>
                                            </span>
                                        </div>
                                        <br />
                                        <label for="txtCase_BrojArhive" class="fixed-width-label">Broj u arhivi / registrator:</label>
                                        <input type="text" id="txtCase_BrojArhive" class="form-control" /><input type="text" id="txtCase_BrojArhiveRegistrator" class="form-control" />
                                    </form>
                                </div>
                                <div class="col-lg-6">
                                    <form class="form-inline" role="form">
                                        <label for="dateTimePicker_CaseActivity_ActivityDate" class="fixed-width-label">Datum pozivanja predmeta:</label>
                                        <div class="input-group date" id="dateTimePicker_CaseActivity_ActivityDate">
                                            <input type="text" class="form-control" id="txtCase_CaseActivity_ActivityDate" />
                                            <span class="input-group-addon btn">
                                                <span class="glyphicon glyphicon-calendar"></span>
                                            </span>
                                        </div>
                                        <br />
                                        <label for="txtCase_CaseActivity_Note" class="fixed-width-label">Bilješka:</label>
                                        <textarea id="txtCase_CaseActivity_Note" class="form-control fixed-width-field" rows="4"></textarea>
                                        <br />
                                        <label for="cbCase_CaseActivity_ForAllUsers" class="fixed-width-label">Prikaži svim korisnicima</label>
                                        <input id="cbCase_CaseActivity_ForAllUsers" type="checkbox" checked="checked" disabled="disabled" />
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="col-lg-12" style="text-align: center;">
                            <div class="modal-in-title">
                                <h4><strong>Ostalo</strong></h4>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <ul id="ulOtherTabs" class="nav nav-tabs">
                                <li class="active"><a href="#" onclick="OpenOtherTab(this, 'divRadnje'); return false;">Radnje</a></li>
                                <li><a href="#" onclick="OpenOtherTab(this, 'divTroskovi'); return false;">Troškovi</a></li>
                                <li><a href="#" onclick="OpenOtherTab(this, 'divDokumenti'); return false;">Dokumenti</a></li>
                                <li><a href="#" onclick="OpenOtherTab(this, 'divPravniOsnov'); return false;">Pravni osnov</a></li>
                                <li><a href="#" onclick="OpenOtherTab(this, 'divBiljeske'); return false;">Bilješke</a></li>
                                <li><a href="#" onclick="OpenOtherTab(this, 'divVeze'); return false;">Veze</a></li>
                            </ul>
                            <div class="other-tab" id="divRadnje">
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
                                    <label for="ddlCase_Radnja_Troskovi">Troškovi:</label>
                                    <select id="ddlCase_Radnja_Troskovi" class="form-control">
                                        <option value="">-----</option>
                                        <option value="0%">0%</option>
                                        <option value="25%">25%</option>
                                        <option value="50%">50%</option>
                                        <option value="100%">100%</option>
                                    </select>
                                    <label for="txtCase_Radnja_Biljeske">Bilješke:</label>
                                    <input type="text" class="form-control" id="txtCase_Radnja_Biljeske" />

                                    <button id="btnAppendRadnjaToCase" type="button" class="btn btn-success" disabled="disabled" onclick="AppendRadnjaToCase(); return false;">Dodaj</button>
                                </form>
                                <br />
                                <table id="tblCaseRadnje" class="table table-condensed" style="word-break: break-word;"></table>
                            </div>
                            <div class="other-tab" style="display: none;" id="divTroskovi">
                                <form class="form-inline only-office-admin" role="form">
                                    <label for="ddlCase_ExpenseVrstaTroska">Vrsta troška:</label>
                                    <select id="ddlCase_ExpenseVrstaTroska" class="form-control">
                                        <option value="-1">-----</option>
                                    </select>
                                    <label for="txtCase_ExpenseAmount">Iznos:</label>
                                    <input type="number" class="form-control" id="txtCase_ExpenseAmount" />
                                    <label for="dateTimePicker_ExpenseDate">Datum:</label>
                                    <div class="input-group date" id="dateTimePicker_ExpenseDate">
                                        <input type="text" class="form-control" id="txtCase_ExpenseDate" />
                                        <span class="input-group-addon btn">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                    <label for="ddlCase_ExpensePaidBy">Plaćeno od:</label>
                                    <select id="ddlCase_ExpensePaidBy" class="form-control">
                                        <option value="">-----</option>
                                        <option value="Stranka">Stranka</option>
                                        <option value="Advokat">Advokat</option>
                                        <option value="Oslobođen">Oslobođen</option>
                                    </select>
                                    <button id="btnAppendExpenseToCase" type="button" class="btn btn-success" disabled="disabled" onclick="AppendExpenseToCase(); return false;">Dodaj</button>
                                </form>
                                <br />
                                <table id="tblCaseExpenses" class="table table-condensed" style="word-break: break-word;"></table>
                            </div>
                            <div class="other-tab" style="display: none;" id="divDokumenti">
                                Dokumenti
                            </div>
                            <div class="other-tab" style="display: none;" id="divPravniOsnov">
                                <label for="txtCase_PravniOsnov">Pravni osnov:</label>
                                <textarea class="form-control" rows="5" id="txtCase_PravniOsnov"></textarea>
                            </div>
                            <div class="other-tab" style="display: none;" id="divBiljeske">
                                <form class="form-inline only-office-admin" role="form">
                                    <label for="dateTimePicker_NoteDate">Datum:</label>
                                    <div class="input-group date" id="dateTimePicker_NoteDate">
                                        <input type="text" class="form-control" id="txtCase_NoteDate" />
                                        <span class="input-group-addon btn">
                                            <span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                    <label for="txtCase_NoteText">Bilješka:</label>
                                    <input type="text" class="form-control" id="txtCase_NoteText" style="min-width: 700px;" />
                                    <button id="btnAppendNoteToCase" type="button" class="btn btn-success" disabled="disabled" onclick="AppendNoteToCase(); return false;">Dodaj</button>
                                </form>
                                <br />
                                <table id="tblCaseNotes" class="table table-condensed" style="word-break: break-word;"></table>
                            </div>
                            <div class="other-tab" style="display: none;" id="divVeze">
                                Veze
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="btnSaveCase" type="button" class="btn btn-primary only-office-admin" onclick="SaveCase(); return false;">Spasi</button>
                    <button type="button" class="btn btn-primary only-office-admin" data-dismiss="modal" onclick="SaveCase(); return false;">Spasi i zatvori</button>
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
                    <h4 class="modal-title">Novo lice</h4>
                </div>
                <div class="modal-body row">
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
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="SaveParty(); return false;">Spasi</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="SaveParty(); return false;">Spasi i zatvori</button>
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
                        <label for="txtUser_Phone" class="fixed-width-label">Phone:</label>
                        <input type="text" class="form-control fixed-width-field" id="txtUser_Phone" />
                        <br />

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
        <button id="btnOpenModalEditParty" data-toggle='modal' data-target='#modalParty'></button>
        <button id="btnOpenModalEditCase" data-toggle='modal' data-target='#modalCase'></button>

        <button id="btnOpenModalPrompt" data-toggle='modal' data-target='#modalPrompt'></button>
        <button id="btnOpenModalEditUser" data-toggle='modal' data-target='#modalUser'></button>
    </div>

    <div class="pull-right" style="position: absolute; top: 0; right: 0; margin: 2px; font-size: xx-small; z-index: 1000;">
        v1.0 DEV
    </div>
</body>
</html>
