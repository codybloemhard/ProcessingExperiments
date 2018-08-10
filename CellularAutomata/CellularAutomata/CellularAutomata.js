var ww = 1600, wh = 900, uh = 200;
var gs = 8;
var gw = Math.floor(ww / gs), gh = Math.floor(wh / gs);
var energyColourStrength = 0.01;

var colours = [];

var field, nfield;
var realtime = false;

var modes = ['Z', 'A', 'B', 'C'];
var drawmode = 0;

function setup() {
  randomSeed(666);
  frameRate(60);
  createCanvas(ww, wh + uh);
  field = CreateField(gw, gh);
  nfield = CreateField(gw, gh);
  colours['Z'] = [255, 255, 255];
  colours['A'] = [255, 0, 0];
  colours['B'] = [0, 255, 0];
  colours['C'] = [0, 0, 255];
  
  background(0);
  RenderUI();
}

function draw() {
  //make walls
  if(mouseIsPressed){
    var xx = Math.floor(mouseX / gs);
    var yy = Math.floor(mouseY / gs);
    var outside = xx < 0 || xx >= gw || yy < 0 || yy > gh;
    if(!outside){
      field[xx][yy] = new Cell(modes[drawmode], 0);
      if(!realtime){
        RenderField();
        RenderUI();
      }
    }
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
  RenderField();
  RenderUI();
}

function RenderField(){
  background(0);
  noStroke();
  var m = '0';
  var str = 0;
  var col = [0,0,0]
  for(var x = 0; x < gw; x++)
  for(var y = 0; y < gh; y++)
    field[x][y].Draw(x, y);
}

function RenderUI(){
  //draw mode indicator
  var uih = uh - 40;
  FillMode(modes[drawmode]);
  rect(40, wh + 20, uih, uih);
  //next draw colour select
  fill(255);
  rect(40 + uih + 40, wh + 20, uih, uih);
  stroke(0);
  line(40 + uih + 40, wh + 20, 80 + uih*2, wh + (uh/2));
  line(40 + uih + 40, wh + uh - 20, 80 + uih*2, wh + (uh/2));
}

function keyPressed() {
  if(keyCode === 32)//space
    realtime = !realtime;
}

function mousePressed(){
  var uih = uh - 40;
  if(mouseIsPressed && mouseX > 80 + uih && mouseX < 80 + 2*uih && mouseY > wh && mouseY < wh + uh){
    drawmode = (drawmode+1) % modes.length;
    RenderUI();
  } 
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
    FillMode(this.mode);
    rect(x * gs, y * gs, gs, gs);
  }
}

function FillMode(mode){
   var col = colours[mode];
   fill(col[0], col[1], col[2], 255);
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
