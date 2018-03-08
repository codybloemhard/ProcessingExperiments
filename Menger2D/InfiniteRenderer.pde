public class InfiniteRenderer{
  private ArrayList<Square> set;
  private float bound;
  private float speed = 1.005f;
  private int maxDepth;
  private float rr = 0, gg = 34, bb = 189, rs = 1, gs = 1, bs = 1;
  
  public InfiniteRenderer(int max){
    maxDepth = max;
    set = new ArrayList<Square>();
    Square s = new Square(0, 0, width, height, 0);
    set.add(s);
    fill(255);
    rect(0, 0, width, height);
    for(int i = 0; i < max; i++)
      Fractalize();
    bound = width/3;
  }
  
  public void Fractalize(){ 
    ArrayList<Square> newlist = new ArrayList<Square>();
    for(int i = 0; i < set.size(); i++)
      set.get(i).Split(newlist, maxDepth, false);
    for(int i = 0; i < newlist.size(); i++)
      set.add(newlist.get(i));
  }
  
  private void Update(){
     bound *= speed;
     rr = (rr + 0.3 * rs);
     gg = (gg + 0.4 * gs);
     bb = (bb + 0.1 * bs);
     if(rr < 0 || rr > 255) rs *= -1;
     if(gg < 0 || gg > 255) gs *= -1;
     if(bb < 0 || bb > 255) bs *= -1;
     
     if(bound > width){
       set.clear();
       Square s = new Square(0, 0, width, height, 0);
       set.add(s);
       for(int i = 0; i < maxDepth; i++)
         Fractalize(); 
       Camera.sx = 1 + (Camera.px / width);
       Camera.sy = 1 + (Camera.py / height);
       bound = width/3;
     }
  }
  
  public void Draw(){
    Update();
    background(rr, gg, bb);
    Camera.sx *= speed;
    Camera.sy *= speed;
    for(int i = 0; i < set.size(); i++){
      set.get(i).Draw();
    }
    //println(set.size());
  }
}