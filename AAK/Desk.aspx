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
    <script src="Libraries/Bootstrap/bootstrap-datetimepicker/bootstrap-datetimepicker.min.js"></script>
    <script src="Scripts/Utilities.js"></script>
    <script src="https://apis.google.com/js/platform.js" async defer="defer"></script>
    <script src="Desk.aspx.js" defer="defer"></script>

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
            <div class="panel-body">
            </div>
        </div>

        <div id="divCases" class="panel panel-default menu-div" style="display: none;">
            <div class="panel-body">
                <button id="btnNewCase" type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalCase"><span class="glyphicon glyphicon-plus"></span>&nbsp;Dodaj novi predmet</button>
                <hr />
                <form class="form-inline pull-left" role="form">
                    <div class="form-group">
                        <label for="txtCasesFilter">Traži:</label>
                        <input type="text" class="form-control" id="txtCasesFilter" />
                    </div>
                    <div class="form-group">
                        <label for="ddlCasesRowCount">Broj redova:</label>
                        <select class="form-control" id="ddlCasesRowCount">
                            <option value="10">10</option>
                            <option value="50" selected="selected">50</option>
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
                <button id="btnNewParty" type="button" class="btn btn-primary" data-toggle="modal" data-target="#modalParty"><span class="glyphicon glyphicon-plus"></span>&nbsp;Dodaj novo lice</button>
                <hr />
                <form class="form-inline pull-left" role="form">
                    <div class="form-group">
                        <label for="txtPartiesFilter">Traži:</label>
                        <input type="text" class="form-control" id="txtPartiesFilter" />
                    </div>
                    <div class="form-group">
                        <label for="ddlCasesRowCount">Broj redova:</label>
                        <select class="form-control" id="ddlPartiesRowCount">
                            <option value="10">10</option>
                            <option value="50" selected="selected">50</option>
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
                <button id="btnNewSud" type="button" class="btn btn-primary pull-left" data-toggle="modal" data-target="#modalSud" onclick="ClearModalSud(); return false;"><span class="glyphicon glyphicon-plus"></span>&nbsp;Dodaj novi sud</button>
                <table id="tblSudovi" class="table table-condensed" style="word-break: break-word;"></table>
            </div>
        </div>

        <div id="divUsers" class="panel panel-default menu-div" style="display: none;">
            <div class="panel-body">
            </div>
        </div>

        <div id="divCodeTable" class="panel panel-default menu-div" style="display: none;">
            <div class="panel-heading">
            </div>
            <div class="panel-body">
                <button id="btnNewCodeTableRecord" type="button" class="btn btn-primary pull-left" data-toggle="modal" data-target="#modalCodeTableRecord" onclick="NewCodeTableRecord(); return false;"><span class="glyphicon glyphicon-plus"></span>&nbsp;Dodaj</button>
                <table id="tblCodeTableData" class="table table-condensed" style="word-break: break-word;"></table>
            </div>
        </div>

    </div>


    <!-- Modals -->
    <div id="modalCase" class="modal fade" role="dialog">
        <div class="modal-admin">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Novi predmet</h4>
                </div>
                <div class="modal-body row">
                    <div class="col-lg-4">
                        <label for="txtCase_NasBroj">Naš broj:</label>
                        <input type="text" class="form-control" id="txtCase_NasBroj" disabled="disabled" />
                        <br />
                        <label for="ddlCase_Kategorija">Kategorija:</label>
                        <select class="form-control" id="ddlCase_Kategorija">
                            <option>-----</option>
                        </select>
                        <br />
                    </div>
                    <div class="col-lg-8">
                        <form class="form-inline pull-left" role="form">
                            <label for="txtCase_BrojPredmeta" class="fixed-width-label">Broj predmeta:</label>
                            <input type="text" class="form-control" id="txtCase_BrojPredmeta" />
                            <br />
                            <label for="ddlCase_Sud" class="fixed-width-label">Sud:</label>
                            <select class="form-control" id="ddlCase_Sud">
                                <option value="-1">-----</option>
                            </select>
                            <br />
                            <label for="ddlCase_Sudija" class="fixed-width-label">Sudija:</label>
                            <select class="form-control" id="ddlCase_Sudija">
                                <option value="-1">-----</option>
                            </select>
                            <br />
                            <label for="txtCase_VrijednostSpora" class="fixed-width-label">Vrijednost spora:</label>
                            <input type="text" class="form-control" id="txtCase_VrijednostSpora" />
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
                            <select class="form-control" id="ddlCase_StanjePredmeta">
                                <option value="-1">-----</option>
                            </select>
                        </form>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="SaveCase(); return false;">Spasi</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="SaveCase(); return false;">Spasi i zatvori</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Odustani</button>
                </div>
            </div>
        </div>
    </div>

    <div id="modalParty" class="modal fade" role="dialog">
        <div class="modal-admin">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Novo lice</h4>
                </div>
                <div class="modal-body row">
                    <div class="col-lg-6">
                    </div>
                    <div class="col-lg-6">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="SaveParty(); return false;">Spasi</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="SaveParty(); return false;">Spasi i zatvori</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Odustani</button>
                </div>
            </div>
        </div>
    </div>

    <div id="modalSud" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Novi sud</h4>
                </div>
                <div class="modal-body">
                    <form class="form-inline" role="form">
                        <label for="txtSud_Naziv" class="fixed-width-label">Naziv:</label>
                        <input type="text" class="form-control" id="txtSud_Naziv" />
                        <br />
                        <label for="txtSud_Adresa" class="fixed-width-label">Adresa:</label>
                        <input type="text" class="form-control" id="txtSud_Adresa" />
                        <br />
                        <label for="txtSud_PostanskiBroj" class="fixed-width-label">Poštanski broj:</label>
                        <input type="text" class="form-control" id="txtSud_PostanskiBroj" />
                        <br />
                        <label for="txtSud_Grad" class="fixed-width-label">Grad:</label>
                        <input type="text" class="form-control" id="txtSud_Grad" />
                        <br />
                        <label for="txtSud_Telefon" class="fixed-width-label">Telefon:</label>
                        <input type="text" class="form-control" id="txtSud_Telefon" />
                        <br />
                        <label for="txtSud_Fax" class="fixed-width-label">Fax:</label>
                        <input type="text" class="form-control" id="txtSud_Fax" />
                        <hr />
                        <h4>Računi za uplate</h4>
                        <label for="txtSud_RacunTakse" class="fixed-width-label">Sudske takse:</label>
                        <input type="text" class="form-control" id="txtSud_RacunTakse" />
                        <br />
                        <label for="txtSud_RacunVjestacenja" class="fixed-width-label">Vještačenja:</label>
                        <input type="text" class="form-control" id="txtSud_RacunVjestacenja" />
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="SaveSud(); return false;">Spasi i zatvori</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Odustani</button>
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
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Odustani</button>
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
                    <button id="btnPromptYes" type="button" class="btn btn-success" data-dismiss="modal">Yes</button>
                    <button id="btnPromptNo" type="button" class="btn btn-danger" data-dismiss="modal">No</button>
                </div>
            </div>
        </div>
    </div>

    <div id="divHidden" style="display: none;">
        <button id="btnOpenModalEditCodeTableRecord" data-toggle='modal' data-target='#modalCodeTableRecord'></button>
        <button id="btnOpenModalEditSud" data-toggle='modal' data-target='#modalSud'></button>

        <button id="btnOpenModalPrompt" data-toggle='modal' data-target='#modalPrompt'></button>
    </div>

    <div class="pull-right" style="position: absolute; top: 0; right: 0; margin: 2px; font-size: xx-small; z-index: 1000;">
        v1.0 DEV
    </div>
</body>
</html>
