<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LogIn.aspx.cs" Inherits="AAK.LogIn" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Advokatsko društvo Đonko - prijava</title>

    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="google-signin-client_id" content="304849379317-d7tvq3acv8ukdpi30ntgvinbcuekf9n2.apps.googleusercontent.com" />

    <link type="text/css" rel="stylesheet" href="Libraries/Bootstrap/css/bootstrap.min.css" />
    <link type="text/css" rel="stylesheet" href="Styles/NewStyle.css" />
</head>
<body>
    <h1>Advokatsko društvo Đonko - baza podataka</h1>
    <script src="Libraries/jQuery/jquery-1.12.0.min.js"></script>
    <script src="Libraries/jQuery/jquery-ui.min.js"></script>
    <script src="Libraries/Bootstrap/js/bootstrap.min.js"></script>
    <script src="Scripts/Utilities.js"></script>
    <script src="https://apis.google.com/js/platform.js" async defer="defer"></script>
    <script src="LogIn.aspx.js" defer="defer"></script>

    <!-- BEGIN: Alerts -->
    <div id="divAlertGeneral"></div>
    <!-- END: Alerts -->

    <div>
        <div class="g-signin2" data-onsuccess="onSignIn"></div>
    </div>

</body>
</html>
