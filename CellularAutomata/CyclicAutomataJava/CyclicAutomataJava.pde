int ww = 1600, wh = 900, uh = 200; 
int gs = 1;
int gw = (int)(ww / gs), gh = (int)(wh / gs);

int[][] colours;

Cell[][] field, nfield;
boolean realtime = false;

//String agentmodes = "ABC";
//String modes = "ZABC";
String agentmodes = "ABCDEF";
String modes = "ZABCDEF";
int drawmode = 0;
int[] lastpoint = new int[]{-1, -1};
int lives = 3;

public void setup(){
  randomSeed(666);
  frameRate(60);
  size(1600, 1100);//cannot use variables?? bleeehhh
  field = CreateField(gw, gh);
  nfield = CreateField(gw, gh);
  colours = new color[256][];
  colours['0'] = new int[]{0, 0, 0};
  colours['Z'] = new int[]{255, 255, 255};
  /*colours['A'] = new int[]{255, 0, 0};
  colours['B'] = new int[]{0, 255, 0};
  colours['C'] = new int[]{0, 0, 255};
  */
  colours['A'] = new int[]{255, 0, 0};
  colours['B'] = new int[]{255, 255, 0};
  colours['C'] = new int[]{0, 255, 0};
  colours['D'] = new int[]{0, 255, 255};
  colours['E'] = new int[]{0, 0, 255};
  colours['F'] = new int[]{255, 0, 255};
  
  background(0);
  RenderUI();
}

public void draw(){
  //drawing of colours in field
  if(mousePressed){
    int xx = (int)(mouseX / gs);
    int yy = (int)(mouseY / gs);
    if(lastpoint[0] == -1 && lastpoint[1] == -1)
      PlotField(xx, yy);
    else
      LineField(xx, yy, lastpoint[0], lastpoint[1]);
    lastpoint[0] = xx;
    lastpoint[1] = yy;
    if(!realtime){
      RenderField();
      RenderUI();
    }
  }
  else {
    lastpoint[0] = -1;
    lastpoint[1] = -1;
  }
  if(!realtime) return;
  //update field
  for(int x = 0; x < gw; x++)
  for(int y = 0; y < gh; y++)
    field[x][y].Update(x, y);
  Cell[][] temp = field;
  field = nfield;
  nfield = temp;
  //Draw field
  RenderField();
  RenderUI();
}

private void RenderField(){
  background(0);
  int ind = 0;
  int[] c = new int[] {0, 0, 0};
  loadPixels();
  if(gs == 1)
    for(int x = 0; x < gw; x++)
    for(int y = 0; y < gh; y++){
      ind = (y * gw + x);
      c = colours[field[x][y].mode];
      pixels[ind] = color(c[0], c[1], c[2]);
    }
  else
    for(int x = 0; x < gw; x++)
    for(int y = 0; y < gh; y++){
      c = colours[field[x][y].mode];
      for(int i = 0; i < gs; i++)
      for(int j = 0; j < gs; j++){
        ind = ((y * gs + j) * (gw * gs) + (x * gs + i));
        pixels[ind] = color(c[0], c[1], c[2]);
      }
    }
  updatePixels();
}

private void RenderUI(){
  //draw mode indicator
  int uih = uh - 40;
  FillMode(modes.charAt(drawmode));
  rect(40, wh + 20, uih, uih);
  //next draw colour select
  fill(255);
  rect(40 + uih + 40, wh + 20, uih, uih);
  stroke(0);
  line(40 + uih + 40, wh + 20, 80 + uih*2, wh + (uh/2));
  line(40 + uih + 40, wh + uh - 20, 80 + uih*2, wh + (uh/2));
  //play/pause button
  fill(255);
  rect(120 + 2*uih, wh + 20, uih, uih);
  fill(255, 0, 0);
  noStroke();
  if(realtime)
    triangle(120 + 2*uih + 20, wh + 40, 120 + 2*uih + uih - 20, wh + 20 + uih/2, 120 + 2*uih + 20, wh + uih);
  else{
    rect(120 + 2*uih + 20, wh + 40, 40, uih - 40);
    rect(120 + 2*uih + uih - 60, wh + 40, 40, uih - 40);
  }
}

public void mousePressed(){
  int uih = uh - 40;
  if(mousePressed && mouseX > 80 + uih && mouseX < 80 + 2*uih && mouseY > wh && mouseY < wh + uh){
    drawmode = (drawmode+1) % modes.length();
    RenderUI();
  }
  if(mousePressed && mouseX > 120 + 2*uih && mouseX < 120 + 2*uih + uih && mouseY > wh + 20 && mouseY < wh + 20 + uih){
    realtime = !realtime;
    RenderUI();
  }
}

private class Cell{
  private char mode;
  private int energy;
  
  public Cell(char m, int e){
    mode = m;
    energy = e;
  }
  
  public void Update(int x, int y){
   if(mode == 'Z'){
     nfield[x][y].mode = 'Z';
     nfield[x][y].energy = 0;
     return;
   }
   //var surroundings = VonNeumannHood(x, y);
   //var surroundings = MooreHood(x, y);
   //var surroundings = RandomInHood(VonNeumannHood(x, y));
   Cell[] surroundings = RandomInHood(MooreHood(x, y));
   if(mode == '0'){
     for(int i = 0; i < surroundings.length; i++){
       if(surroundings[i].mode != '0' && surroundings[i].mode != 'Z'){
         if(energy <= 1){
           nfield[x][y].mode = surroundings[i].mode;
           nfield[x][y].energy = lives;
         }
         else
           energy--;
       }
     }
     return;
   }
   boolean eaten = false;
   char em = mode;
   for(int i = 0; i < surroundings.length; i++){
      char sm = surroundings[i].mode;
      int diff = sm - em;
      if(diff == 1 || (-diff) == (agentmodes.length() - 1)){
        if(energy <= 1){
          eaten = true;
          em = sm;
          break;
        }
        else
          this.energy--;
      }
   }
   if(eaten){
     nfield[x][y].mode = em;
     nfield[x][y].energy = lives;
   }
   else{
     nfield[x][y].mode = mode;
     nfield[x][y].energy = energy;
   }
  }
  
  public void Draw(int x, int y){
    if(mode == '0') return;
    FillMode(mode);
    rect(x * gs, y * gs, gs, gs);
  }
}

private void FillMode(char m){
  int[] col = colours[m];
  fill(col[0], col[1], col[2], 255);
}

private Cell[][] CreateField(int w, int h){
  Cell[][] x = new Cell[w][];
  for(int i = 0; i < w; i++)
    x[i] = new Cell[h];
  for(int i = 0; i < w; i++)
  for(int j = 0; j < h; j++)
    x[i][j] = new Cell('0', 0);
  return x;
}

private int EdgeX(int x){
  if(x < 0) return gw - 1;
  if(x >= gw) return 0;
  return x;
}

private int EdgeY(int y){
  if(y < 0) return gh - 1;
  if(y >= gh) return 0;
  return y;
}

private Cell[] RandomInHood(Cell[] hood){
  Cell[] s = new Cell[1];
  s[0] = hood[(int)random(hood.length)];
  return s;
}

private Cell[] VonNeumannHood(int x, int y){
  Cell[] s = new Cell[4];
  s[0] = field[EdgeX(x - 1)][y];
  s[1] = field[EdgeX(x + 1)][y];
  s[2] = field[x][EdgeY(y - 1)];
  s[3] = field[x][EdgeY(y + 1)]; 
  return s;
}

private Cell[] MooreHood(int x, int y){
  Cell[] s = new Cell[8];
  s[0] = field[EdgeX(x - 1)][EdgeY(y - 1)];
  s[1] = field[x][EdgeY(y - 1)];
  s[2] = field[EdgeX(x + 1)][EdgeY(y - 1)];
  s[3] = field[EdgeX(x - 1)][y];
  s[4] = field[EdgeX(x + 1)][y];
  s[5] = field[EdgeX(x - 1)][EdgeY(y + 1)];
  s[6] = field[x][EdgeY(y + 1)];
  s[7] = field[EdgeX(x + 1)][EdgeY(y + 1)];
  return s;
}

private void PlotField(int x, int y){
  boolean outside = x < 0 || x >= gw || y < 0 || y >= gh;
  if(outside) return;
  field[x][y] = new Cell(modes.charAt(drawmode), 0);
}

//https://en.wikipedia.org/wiki/Digital_differential_analyzer_(graphics_algorithm)
private void LineField(int x1, int y1, int x2, int y2){
  float dx = x2 - x1;
  float dy = y2 - y1;
  float step;
  if(Math.abs(dx) >= Math.abs(dy))
    step = Math.abs(dx);
  else
    step = Math.abs(dy);
  dx = dx / step;
  dy = dy / step;
  float x = x1;
  float y = y1;
  int i = 1;
  while(i <= step){
    PlotField((int)x, (int)y);
    x += dx;
    y += dy;
    i++;
  }
}
