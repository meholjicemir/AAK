<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Desk.aspx.cs" Inherits="AAK.Desk" %>

<!DOCTYPE html>

<html>
<head>
    <title>Advokatsko društvo Đonko</title>

    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="google-signin-client_id" content="304849379317-d7tvq3acv8ukdpi30ntgvinbcuekf9n2.apps.googleusercontent.com" />

    <link type="text/css" rel="stylesheet" href="Libraries/Bootstrap/css/bootstrap.min.css" />
    <link type="text/css" rel="stylesheet" href="Styles/NewStyle.css" />
</head>
<body>
    <script type="text/javascript" src="Libraries/jQuery/jquery-1.12.0.min.js"></script>
    <script type="text/javascript" src="Libraries/jQuery/jquery-ui.min.js"></script>
    <script src="Libraries/Bootstrap/js/bootstrap.min.js"></script>
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
                    <li class="menu-item" id="liMenuUsers" style="display: none;"><a href="#" onclick="MenuUsers(); return false;"><strong>Korisnici</strong></a></li>
                </ul>
            </div>
        </nav>

        <div id="divLoading" style="margin-left: 1%; margin-right: 1%; margin-bottom: 2px; display: none;">
            <button class="btn btn-warning btn-block disabled">
                <span class="glyphicon glyphicon-refresh spinning"></span>&nbsp;Please wait...
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
                <form class="form-inline" role="form">
                    <div class="form-group">
                        <label for="txtCasesFilter">Traži:</label>
                        <input type="text" class="form-control" id="txtCasesFilter" />
                    </div>
                    <div class="form-group">
                        <label for="txtFilterNoOfItems">Broj redova:</label>
                        <input type="number" min="10" max="1000000" step="10" value="50" class="form-control" id="txtFilterNoOfItems" />
                    </div>
                    <button id="btnRefreshCases" class="btn btn-default">
                        <span class="glyphicon glyphicon-refresh"></span>&nbsp;Refresh
                    </button>
                </form>
                <table id="tblCases" style="word-break: break-all;"></table>
            </div>
        </div>

        <div id="divParties" class="panel panel-default menu-div" style="display: none;">
            <div class="panel-body">
            </div>
        </div>

        <div id="divUsers" class="panel panel-default menu-div" style="display: none;">
            <div class="panel-body">
            </div>
        </div>
    </div>

</body>
</html>
