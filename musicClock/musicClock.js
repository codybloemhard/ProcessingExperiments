var ww = 1600, wh = 900;
var pBarH = wh / 40;
var sigBezel = wh / 40;

var measureLen = 4000;
var sigA = 19, sigB = 4;

function setup() {
  createCanvas(ww, wh);
  frameRate(60);
}

function draw() {
  background(0);
  var m = millis();
  var progress = (m % measureLen) / measureLen;
  
  fill(255);
  Rect(2*sigBezel, wh/2 - pBarH/2, 2*sigBezel + progress * (ww - 4*sigBezel), wh/2 + pBarH/2);
  fill(127);
  Rect(2*sigBezel + progress * (ww - 4*sigBezel), wh/2 - pBarH/2, ww - 2*sigBezel, wh/2 + pBarH/2);
  
  fill(64);
  rect(sigBezel, sigBezel, ww - 2*sigBezel, wh/2 - pBarH/2 - 2*sigBezel);
  var midSigRectH = (sigBezel + wh/2 - pBarH/2 - sigBezel) / 2;
  var c = 255;
  var bLen = (ww - 4*sigBezel) / sigA;
  for(var i = 0; i < sigA; i++){
    fill(c);
    rect(2*sigBezel + i * bLen, sigBezel*2, bLen, wh/2 - pBarH/2 - 4*sigBezel);
    if(c == 255) c = 127;
    else c = 255;
  }
}

function Rect(px, py, qx, qy){
  rect(px, py, qx - px, qy - py);
}
