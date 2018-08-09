var ww = 1600, wh = 900;
var gs = 8;
var gw = Math.floor(ww / gs), gh = Math.floor(wh / gs);
var energyColourStrength = 0.01;

var colours = [];

var field, nfield;
var realtime = false;

function setup() {
  randomSeed(666);
  frameRate(60);
  createCanvas(ww, wh);
  field = CreateField(gw, gh);
  nfield = CreateField(gw, gh);
  colours['Z'] = [255, 255, 255];
  colours['A'] = [255, 0, 0];
  colours['B'] = [0, 255, 0];
  colours['C'] = [0, 0, 255];
  
  field[20][20] = new Cell('A', 0);
  field[gw - 20][20] = new Cell('B', 0);
  field[gw/2][gh-20] = new Cell('C', 0);
}

function draw() {
  //make walls
  if(mouseIsPressed){
    var xx = Math.floor(mouseX / gs);
    var yy = Math.floor(mouseY / gs);
    field[xx][yy] = new Cell('Z', 0);
    if(!realtime) Render();
  }
  if(!realtime) return;
  //Updating
  for(var x = 0; x < gw; x++)
  for(var y = 0; y < gh; y++)
    field[x][y].Update(x, y);
  var temp = field;
  field = nfield;
  nfield = temp;
  ZeroField(nfield);
  //Drawing
  Render();
}

function Render(){
  background(0);
  noStroke();
  var m = '0';
  var str = 0;
  var col = [0,0,0]
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
     if(this.mode === 'Z'){
       nfield[x][y] = new Cell('Z', 0);
       return;
     }
     var surroundings = new Array(4);
     surroundings[0] = field[edgeX(x - 1)][y];
     surroundings[1] = field[edgeX(x + 1)][y];
     surroundings[2] = field[x][edgeY(y - 1)];
     surroundings[3] = field[x][edgeY(y + 1)];
     if(this.mode === '0'){
       for(var i = 0; i < 4; i++){
         if(surroundings[i].mode != '0' && surroundings[i].mode != 'Z')
           nfield[x][y] = new Cell(surroundings[i].mode, 0);
       }
       return; 
     }
     var eaten = false;
     var em = this.mode;
     for(var i = 0; i < 4; i++){
        var sm = surroundings[i].mode;
        var diff = sm - this.mode
        if((em == 'A' && sm == 'B') || (em == 'B' && sm == 'C') || (em == 'C' && sm == 'A')){//diff == 1 || diff == (3 - 1)
          eaten = true;
          em = sm;
          break;
        }
     }
     if(eaten)
       nfield[x][y] = new Cell(em, 0);
     else
       nfield[x][y] = new Cell(this.mode, 0);
  }
   
  this.Draw = function(x, y){
    if(this.mode === '0') return;
    var col = colours[this.mode]
    var alp = this.energy * 255 * energyColourStrength;
    //var str = Math.min(255, Math.max(alp, 120));
    //fill(col[0], col[1], col[2], str);
    fill(col[0], col[1], col[2], 255);
    rect(x * gs, y * gs, gs, gs);
  }
}

function ZeroField(f){
  for(var i = 0; i < f.length; i++)
  for(var j = 0; j < f[i].length; j++){
      f[i][j][0] = '0';
      f[i][j][0] = 0;
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
