boolean released = false;

RandomTopDownRenderer random;
TopDownRenderer basic;
InfiniteRenderer zoomer;

void setup(){
  size(1458, 1458, FX2D);//2 * 3^6, divisible by 3 and 2 to get pixel perfect rendering
  noStroke();
  frameRate(60);
  random = new RandomTopDownRenderer(7);
  basic = new TopDownRenderer(5);
  zoomer = new InfiniteRenderer(5);
}

void draw(){
  //random.Draw(released);
  //basic.Draw(released);
  zoomer.Draw();
  released = false;
}

void mouseReleased() {
  if(mouseButton == LEFT) released = true;
}