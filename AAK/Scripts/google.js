﻿/// <reference path="../Desk.aspx.js" />

// Client ID and API key from the Developer Console
var CLIENT_ID = '304849379317-766dl8pe6i0m78o35c9hmiuoou1rn14h.apps.googleusercontent.com';

// Array of API discovery doc URLs for APIs used by the quickstart
var DISCOVERY_DOCS = ["https://www.googleapis.com/discovery/v1/apis/calendar/v3/rest"];

// Authorization scopes required by the API; multiple scopes can be
// included, separated by spaces.
var SCOPES = "profile email https://www.googleapis.com/auth/calendar";

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
        clientId: CLIENT_ID,
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
        ValidateUser(email, token);
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
    var calendarId = "4k976meo8f0ps85kpqe04m2thc@group.calendar.google.com";

    var _end = _start;
    _end.setHours(new Date(_end).getHours() + 1);

    var resource = {
        "summary": summary,
        "description": description,
        "location": "",
        "start": {
            "dateTime": _start.toISOString(),
            "timezone": "Europe/Sarajevo"
        },
        "end": {
            "dateTime": _end.toISOString(),
            "timezone": "Europe/Sarajevo"
        }
    };
    var request = gapi.client.calendar.events.insert({
        'calendarId': calendarId,
        'resource': resource
    });
    request.execute(function (resp) {
        radnja.GoogleEventId = resp.id;
        callback(radnja);
    });
}

function DeleteGoogleCalendarEvent() {

}