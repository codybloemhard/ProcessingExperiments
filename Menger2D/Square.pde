public class Square{
  private float x, y, w, h;
  private boolean active, useactive;
  private int depth;
  
  public Square(float x, float y, float w, float h, boolean active, int depth){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.useactive = true;
    this.active = active;
    this.depth = depth;
  }
  
  public Square(float x, float y, float w, float h, int depth){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.useactive = false;
    this.active = false;
    this.depth = depth;
  }
  
  public int Count(){
    if(active) return 1;
    return 0;
  }
  
  public boolean Split(ArrayList<Square> list, int maxDepth, boolean draw){
    if(depth > maxDepth) return false;
    for(int x = 0; x < 3; x++)
      for(int y = 0; y < 3; y++){
        if(!(x == 1 && y == 1)){
          if(useactive) list.add(new Square(this.x + x * w/3f, this.y + y * h/3f, w/3f, h/3f, false, depth + 1));
          else list.add(new Square(this.x + x * w/3f, this.y + y * h/3f, w/3f, h/3f, depth + 1));
        }  
    }
    active = true;
    if(draw) Draw();
    return true;
  }
  
  public void Draw(){
    if(useactive && !active) return;
    float xx = (x + w/3) * Camera.sx - Camera.px;
    float yy = (y + h/3) * Camera.sy - Camera.py;
    fill(0);
    rect(xx, yy, w/3 * Camera.sx, h/3 * Camera.sy);
  }
}