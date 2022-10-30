import flash.utils.getTimer;

var gameTimeInMS = 0;
var startTimeInMS = 0;
var splitTimes = [];

var isTimerActive = false;

timerBkg.visible = false;
lakeKey.visible = false;
mountainKey.visible = false;
forestKey.visible = false;


function StartTimer() {
	startTimeInMS = getTimer();
}
ExternalInterface.addCallback("StartTimer", StartTimer);


function ToggleTimer() {
    isTimerActive = !isTimerActive	
	
	if (isTimerActive) {
		timerText.text = "00:00:0000"
		timerBkg.parent.setChildIndex(timerBkg, 0)
		timerBkg.visible = true;
		SetDeathCount(0);
	} else {
		timerText.text = "";
		timerBkg.visible = false;
		deathsText.text = ""
	}
    
    return isTimerActive;
}
ExternalInterface.addCallback("ToggleTimer", ToggleTimer);

function SetDeathCount(count: Number) {
   if (!isTimerActive) return;
	
   var text = count === 1 ? " Death" : " Deaths";	
	
   deathsText.text = count + text;
}
ExternalInterface.addCallback("SetDeathCount", SetDeathCount);


function SetSplit(lvl: Number) {
	if (!splitTimes[lvl - 1]) {
		splitTimes[lvl - 1] = "#" + String(lvl - 1) + " | " + convertToHHMMSS(gameTimeInMS);	
	}
}
ExternalInterface.addCallback("SetSplit", SetSplit);



function SetKey(key) {
  if (key === "lake") {
     lakeKey.visible = true;
  }
  if (key === "forest") {
     forestKey.visible = true;
  }
  if (key === "mountain") {
     mountainKey.visible = true;
  }
}
ExternalInterface.addCallback("SetKey", SetKey);



// UTIL FUNCTIONS ===============================================

function convertToHHMMSS($ms:Number):String {
   var ms:Number = ($ms % 1000);   
	var s:Number = Math.floor($ms / 1000) % 60;
   var m:Number = Math.floor($ms / (60 * 1000)) % 60;
   var h:Number = Math.floor($ms / (60 * 60 * 1000)) % 60;
     
   var hourStr:String = (h == 0) ? "" : doubleDigitFormat(h) + ":";
   var minuteStr:String = doubleDigitFormat(m) + ":";
   var secondsStr:String = doubleDigitFormat(s) + ":";
	var msStr:String = quadDigitFormat(ms);
     
   return hourStr + minuteStr + secondsStr + msStr;
}

function quadDigitFormat(num) {
  if (num < 10) { 
    return "000" + num;
  }
   if (num < 100) {
	 return "00" + num;
   }
	if (num < 1000) {
	 return "0" + num;
   }
   return num;
}

function doubleDigitFormat($num:uint):String {
	if ($num < 10) {
        return ("0" + $num);
    }
    return String($num);
}