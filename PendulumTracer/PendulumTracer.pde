private Tracer tracer;

public void setup(){
  size(1600, 900);
  frameRate(-1);
  Pendulum fractal = new Pendulum();
  fractal.AddNode(0.6f, 0.1f);
  fractal.AddNode(0.4f, 12f);
  tracer = new Tracer(width, height, fractal);
}

private void update(){
  tracer.Update(1f/60f);
}

public void draw(){
  update();
  tracer.Draw(true);
  //saveFrame("output/shape2/img_#####.png");
}