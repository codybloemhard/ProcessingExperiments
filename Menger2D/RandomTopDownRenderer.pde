public class RandomTopDownRenderer{
  private int maxDepth;
  private int depth;
  private ArrayList<ArrayList<Square>> sets;
  private int totalSquares = 0;
  private boolean start = false;
  
  public RandomTopDownRenderer(int max){
    maxDepth = max;
    sets = new ArrayList<ArrayList<Square>>();
    for(int i = 0; i < maxDepth; i++){
      sets.add(new ArrayList<Square>());
    }
    Square s = new Square(0, 0, width, height, true, 0);
    sets.get(0).add(s);
    fill(255);
    rect(0, 0, width, height);
    Camera.px = 0;
    Camera.py = 0;
    Camera.sx = 1;
    Camera.sy = 1;
  }
  
  public void Update(){
    PartiallyFractalize(); 
  }
  
  void UpdateDepth(){
    if(sets.get(depth).size() == 0)
      depth++;
  }
  
  boolean InDomain(){ //returns if we are still under maxDepth and can divide further
    if(depth + 1 < maxDepth) return true;
      return false;
  }
  
  void PartiallyFractalize(){//use a list for each depthlayer
    if(!InDomain()) return;
    int speed = (int)max(1, pow(depth, 8) / 5000);
    for(int i = 0; i < speed; i++){
      int j = (int)random(sets.get(depth).size());
      Square s = sets.get(depth).get(j);
      boolean success = s.Split(sets.get(depth + 1), maxDepth, true);
      if(success){
        sets.get(depth).remove(s);
        totalSquares++;
      }
      UpdateDepth();
      if(!InDomain()) return;
    }
  }
  
  void Draw(boolean start){
    if(start) this.start = true;
    if(!this.start){
      background(255);
      return;
    }
    Update();
    for(int i = 0; i < sets.size(); i++)
      for(int j = 0; j < sets.get(i).size(); j++)
        sets.get(i).get(j).Draw();
    fill(0);
    rect(width/3, height/3, width/3, height/3);//clear screen in middle for text
    textSize(32);
    fill(255, 0, 0);
    String msg = "Holes: " + totalSquares;
    float tw = textWidth(msg);
    text(msg, width/2 - tw/2, height/2 + 16);
  }
}