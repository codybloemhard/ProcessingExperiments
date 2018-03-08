public class TopDownRenderer{
  private int maxDepth;
  private int depth;
  private ArrayList<Square> set;
  private int totalSquares = 1;
  
  public TopDownRenderer(int max){
    maxDepth = max;
    set = new ArrayList<Square>();
    Square s = new Square(0, 0, width, height, 0);
    set.add(s);
    fill(255);
    rect(0, 0, width, height);
  }
  
  public void CalcTotal(){
     totalSquares += set.size();
  }
  
  public void Fractalize(){
    if(depth >= maxDepth) return;
    depth++;   
    ArrayList<Square> newlist = new ArrayList<Square>();
    for(int i = 0; i < set.size(); i++)
      set.get(i).Split(newlist, maxDepth, false);
    set = newlist;
    CalcTotal();
  }
  
  void Draw(boolean divide){
    Camera.Reset();
    if(divide) Fractalize();
    for(int i = 0; i < set.size(); i++)
      set.get(i).Draw();
    fill(0);
    rect(width/3, height/3, width/3, height/3);//clear screen in middle for text
    textSize(32);
    fill(255, 0, 0);
    String msg = "Holes: " + totalSquares;
    float tw = textWidth(msg);
    text(msg, width/2 - tw/2, height/2 + 16);
  }
}