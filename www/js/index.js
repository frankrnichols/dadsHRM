// (c) 2015 Don Coleman
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/* global ble, statusDiv, beatsPerMinute */
/* jshint browser: true , devel: true*/

// See BLE heart rate service http://goo.gl/wKH3X7
var heartRate = {
    service: '180d',
    measurement: '2a37'
};

var app = {
    initialize: function() {
        this.bindEvents();
        this.setBackgroundImage();
    },
    bindEvents: function() {
        document.addEventListener('deviceready', this.onDeviceReady, false);
    },
    onDeviceReady: function() {
        app.scan();
    },
    scan: function() {
        app.status("Scanning for HackyTap");

        var foundHeartRateMonitor = false;

        function onScan(peripheral) {
            // this is demo code, assume there is only one heart rate monitor
            // console.log("Found " + JSON.stringify(peripheral));
            console.log("Found HackyTap");
            foundHeartRateMonitor = true;
            ble.connect(peripheral.id, app.onConnect, app.onDisconnect);
        }

        function scanFailure(reason) {
            alert("BLE Scan Failed");
        }

        ble.scan([heartRate.service], 5, onScan, scanFailure);

        setTimeout(function() {
            if (!foundHeartRateMonitor) {
                app.status("Did not find HackyTap.");
            }
        }, 15000);
    },
    onConnect: function(peripheral) {
        app.status("Connected to " + peripheral.id);
        ble.notify(peripheral.id, heartRate.service, heartRate.measurement, app.onData, app.onError);
    	var imageName = "css/Screen0.png";
		document.body.style.backgroundImage = "url('"+imageName+"')";
    },
    onDisconnect: function(reason) {
        alert("Disconnected " + reason);
        beatsPerMinute.innerHTML = "...";
        app.status("Disconnected");
    },
    onData: function(buffer) {
        // assuming heart rate measurement is Uint8 format, real code should check the flags
        // See the characteristic specs http://goo.gl/N7S5ZS
        var data = new Uint8Array(buffer);
        beatsPerMinute.innerHTML = data[1];
		if(data[1] == 188)
		{
			var imageName = "css/Shake.png";
			document.body.style.backgroundImage = "url('"+imageName+"')";
		}
		else
		{
			var imageName = "css/Screen" + beatsPerMinute.innerHTML + ".png";
			document.body.style.backgroundImage = "url('"+imageName+"')";
		}
    },
    onError: function(reason) {
        alert("There was an error " + reason);
    },
    status: function(message) {
        console.log(message);
        statusDiv.innerHTML = message;
    },
    setBackgroundImage: function(){
    	var imageName = "css/Connect.png";
    	document.body.style.backgroundImage = "url('"+imageName+"')";
    }
};

app.initialize();
