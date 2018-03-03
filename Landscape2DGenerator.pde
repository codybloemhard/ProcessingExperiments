private float t, dir = 1;
private TerrainLayer back, front;
private color a, b, c, backCol, frontCol, skyCol;

void setup(){
  size(1600, 900);
  back = new TerrainLayer(320, 0.005f, 6, 0.5f, 4f, 1f);
  front = new TerrainLayer(320, 0.02f, 6, 0.5f, 4f, 0.3f);
  a = color(255, 0, 0);
  b = color(0, 0, 255);
  c = color(0, 255, 0);
}

void update(){  
  t += 0.001f * dir;
  if(t > 0.7f){
   t = 0.7f;
   dir *= -1;
  }
  else if(t < 0f){
   t = 0f;
   dir *= -1;
  }
  //print(t);
  backCol = ShiftColour(t, 0f);
  frontCol = ShiftColour(t, 0.333f);
  skyCol = ShiftColour(t, 0.666f);
  
  
  back.Update();
  front.Update();
}

color ShiftColour(float t, float off){
  float x = t + off;
  color k = lerpColor(a, b, x);
  color l = lerpColor(b, c, x);
  color m = lerpColor(c, a, x);
  color u = lerpColor(k, l, x);
  color v = lerpColor(l, m, x);
  return lerpColor(u, v, x);
}

void draw(){
  update();
  background(skyCol);
  fill(backCol);
  back.Render();
  fill(frontCol);
  front.Render();
  saveFrame("output/img_#####.png");
}