public class Tracer{
  private PGraphics graph;
  private int w, h;
  private Pendulum pendulum;
  private int px, py, cx, cy;
  
  public Tracer(int w, int h, Pendulum fractal){
    this.w = w;
    this.h = h;
    this.pendulum = fractal;
    cx = -1;
    cy = -1;
    graph = createGraphics(w, h);
    graph.beginDraw();
    graph.background(0);
    graph.endDraw();
    if(pendulum == null) return;
    pendulum.Update(0f);
    Vector2 c = pendulum.GetPosition(pendulum.GetLength() - 1);
    cx = (int)(c.x * h/2);
    cy = (int)(c.y * h/2);
  }
  
  public void Update(float deltaTime){
    if(pendulum == null) return;
    pendulum.Update(deltaTime);
    Vector2 c = pendulum.GetPosition(pendulum.GetLength() - 1);
    px = cx;
    py = cy;
    cx = (int)(c.x * h/2);
    cy = (int)(c.y * h/2);
  }
  
  public void Draw(boolean drawMachine){
    graph.beginDraw();
    graph.stroke(255);
    graph.strokeWeight(2);
    graph.translate(w/2, h/2);
    graph.line(px, py, cx, cy);
    graph.endDraw();
    image(graph, 0, 0);
    
    if(!drawMachine) return;
    translate(w/2, h/2);
    stroke(255, 0, 0);
    strokeWeight(5);
    float rr = 20;
    for(int i = 0; i < pendulum.GetLength(); i++){
      Vector2 z = pendulum.GetPosition(i);
      int zx = (int)(z.x * h/2);
      int zy = (int)(z.y * h/2);
      Vector2 w;
      if(i > 0) w = pendulum.GetPosition(i - 1);
      else w = new Vector2(0, 0);
      int wx = (int)(w.x * h/2);
      int wy = (int)(w.y * h/2);    
      line(wx, wy, zx, zy);
    }
    fill(0, 255, 0);
    strokeWeight(0);
    ellipse(0, 0, rr, rr);
    for(int i = 0; i < pendulum.GetLength(); i++){
      Vector2 z = pendulum.GetPosition(i);
      int zx = (int)(z.x * h/2);
      int zy = (int)(z.y * h/2);
      fill(0, 255, 0);
      ellipse(zx, zy, rr, rr);
    }
  }
}