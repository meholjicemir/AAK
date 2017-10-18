/// <reference path="../Desk.aspx.js" />

// Array of API discovery doc URLs for APIs used by the quickstart
var DISCOVERY_DOCS = ["https://www.googleapis.com/discovery/v1/apis/calendar/v3/rest"];

// Authorization scopes required by the API; multiple scopes can be
// included, separated by spaces.
var SCOPES = "profile email https://www.googleapis.com/auth/calendar https://www.googleapis.com/auth/drive";

var authorizeButton = document.getElementById('authorize-button');
var signoutButton = document.getElementById('signout-button');

/**
 *  On load, called to load the auth2 library and API client library.
 */
function handleClientLoad() {
    gapi.load('client:auth2', initClient);
}

/**
 *  Initializes the API client library and sets up sign-in state
 *  listeners.
 */
function initClient() {
    gapi.client.init({
        discoveryDocs: DISCOVERY_DOCS,
        clientId: Google_ClientId,
        scope: SCOPES
    }).then(function () {
        // Listen for sign-in state changes.
        gapi.auth2.getAuthInstance().isSignedIn.listen(updateSigninStatus);

        // Handle the initial sign-in state.
        updateSigninStatus(gapi.auth2.getAuthInstance().isSignedIn.get());
        authorizeButton.onclick = handleAuthClick;
        signoutButton.onclick = handleSignoutClick;
    });
}

/**
 *  Called when the signed in status changes, to update the UI
 *  appropriately. After a sign-in, the API is called.
 */
function updateSigninStatus(isSignedIn) {
    if (isSignedIn) {
        authorizeButton.style.display = 'none';
        signoutButton.style.display = 'block';

        var email = gapi.auth2.getAuthInstance().currentUser.Ab.w3.U3;
        var token = gapi.auth2.getAuthInstance().currentUser.Ab.Zi.id_token;
        ValidateUser(email, token, gapi.auth2.getAuthInstance().currentUser.Ab.Zi.access_token);
    } else {
        authorizeButton.style.display = 'block';
        signoutButton.style.display = 'none';
    }
}

/**
 *  Sign in the user upon button click.
 */
function handleAuthClick(event) {
    gapi.auth2.getAuthInstance().signIn();
}

/**
 *  Sign out the user upon button click.
 */
function handleSignoutClick(event) {
    gapi.auth2.getAuthInstance().signOut();
}

function CreateGoogleCalendarEvent(radnja, callback) {
    //(summary, description, _start, calendarId, _location, timezone) {
    var summary = radnja.VrstaRadnjeName + " (" + CurrentCase.Naziv + ")";
    var description = radnja.Biljeske;

    var _start = new Date(radnja.DatumRadnje);
    var _end = new Date(radnja.DatumRadnje);
    _end.setHours(new Date(radnja.DatumRadnje).getHours() + 1);

    var resource = {
        "summary": summary,
        "description": description,
        "location": "",
        "start": {
            "dateTime": _start.toISOString(),
            "timeZone": "Europe/Sarajevo"
        },
        "end": {
            "dateTime": _end.toISOString(),
            "timeZone": "Europe/Sarajevo"
        }
    };
    var request = gapi.client.calendar.events.insert({
        'calendarId': GoogleCalendarId,
        'resource': resource
    });
    request.execute(function (resp) {
        radnja.GoogleEventId = resp.id;
        callback(radnja);
    });
}

function DeleteGoogleCalendarEvent(eventId) {
    var request = gapi.client.calendar.events.delete({
        "calendarId": GoogleCalendarId,
        "eventId": eventId
    });

    request.execute();
}

function DownloadFileFromGoogleDrive(fileId, fileName) {
    //$.ajax({
    //    type: "GET",
    //    headers: {
    //        "Authorization": "Bearer " + CurrentUser.AccessToken
    //    },
    //    url: "https://www.googleapis.com/drive/v3/files/" + fileId + "?alt=media",
    //    processData: false,
    //    dataType: "binary",
    //    success: function (msg) {

    //    },
    //    failure: function (msg) {
    //        alert("failed");
    //    }
    //});


    var oReq = new XMLHttpRequest();
    oReq.open("GET", "https://www.googleapis.com/drive/v3/files/" + fileId + "?alt=media", true);
    oReq.setRequestHeader("Authorization", "Bearer " + CurrentUser.AccessToken);
    oReq.responseType = "arraybuffer";

    oReq.onload = function (oEvent) {
        var arrayBuffer = oReq.response;
        var a = document.createElement("a");
        document.body.appendChild(a);
        a.style = "display: none";
        var blob = new Blob([arrayBuffer], { type: "octet/stream" });
        url = window.URL.createObjectURL(blob);
        a.href = url;
        a.download = fileName;
        a.click();
        window.URL.revokeObjectURL(url);
    };

    oReq.send();
}