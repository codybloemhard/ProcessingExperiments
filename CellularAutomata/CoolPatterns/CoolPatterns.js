//Read README.txt for an explanation on what this
var ww = 1600, wh = 900;
var gs = 8;
var gw = Math.floor(ww / gs), gh = Math.floor(wh / gs);

var field;
var realtime = true;
var lastpoint = [0, 0];

function setup() {
  frameRate(1);
  createCanvas(ww, wh);
  field = CreateField(gw, gh);
  
  field[gw/2][gh/2] = new Cell('Z', 1000);
}

function draw() {
  if(!realtime) return;
  //Updating
  for(var x = 0; x < gw; x++)
  for(var y = 0; y < gh; y++)
    field[x][y].Update(x, y);
  //Drawing
  background(0);
  noStroke();
  var m = '0';
  var str = 0;
  var col = [0,0,0];
  for(var x = 0; x < gw; x++)
  for(var y = 0; y < gh; y++)
    field[x][y].Draw(x, y);
}

function keyPressed() {
  if(keyCode === 32)//space
    realtime = !realtime;
}

function Cell(m, e){
  this.mode = m;
  this.energy = e;
  
  this.Update = function(x, y){
     if(this.mode === '0') return;
     if(this.energy <= 3){
       this.mode = '0';
       return;
     }
     var enA = this.energy / 4;
     var enB = this.energy - (3*enA);
     
     var neigh = new Array(4);
     neigh[0] = field[edgeX(x - 1)][y];
     neigh[1] = field[edgeX(x + 1)][y];
     neigh[2] = field[x][edgeY(y - 1)];
     neigh[3] = field[x][edgeY(y + 1)];
     
     neigh[0].mode = this.mode;
     neigh[0].energy += enB;
     for(var i = 1; i < 4; i++){
       neigh[i].mode = this.mode;
       neigh[i].energy += enA;
     }
     
     this.energy = 0;
  }
  
  this.Draw = function(x, y){
    if(this.mode === '0') return;
    fill(255);
    rect(x * gs, y * gs, gs, gs);
  }
}

function CreateField(w, h){
  w = Math.floor(w);
  h = Math.floor(h);
  x = new Array(w);
  for (var k = 0; k < w; k++) 
    x[k] = new Array(h);
  for(var i = 0; i < w; i++)
  for(var j = 0; j < h; j++)
   x[i][j] = new Cell('0', 0);
  
  return x;
}

function edgeX(x){
  if(x < 0) return gw - 1;
  if(x >= gw) return 0;
  return x;
}

function edgeY(y){
  if(y < 0) return gh - 1;
  if(y >= gh) return 0;
  return y;
}
