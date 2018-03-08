import java.util.*;

public class PendulumNode{
  public float radius, cycleTime;
  
  public PendulumNode(float radius, float cycleTime){
    this.radius = radius;
    this.cycleTime = cycleTime;
  }
}

public class Vector2{
  public float x, y;
  
  public Vector2(float x, float y){
    this.x = x;
    this.y = y;
  }
}

public class Pendulum{
  private List<PendulumNode> nodes;
  private List<Vector2> positions;
  private float time;
  
  public Pendulum(){
     nodes = new ArrayList<PendulumNode>();
     positions = new ArrayList<Vector2>();
     time = 0f;
  }
  
  public void AddNode(float radius, float cycleTime){
    nodes.add(new PendulumNode(radius, cycleTime));
    positions.add(new Vector2(0, 0));
  }
  
  public void Update(float deltaTime){
    time += deltaTime;
    positions.get(0).x = sin(time * nodes.get(0).cycleTime) * nodes.get(0).radius;
    positions.get(0).y = cos(time * nodes.get(0).cycleTime) * nodes.get(0).radius;
    for(int i = 1; i < positions.size(); i++){
      positions.get(i).x = positions.get(i - 1).x + sin(time * nodes.get(i).cycleTime) * nodes.get(i).radius;
      positions.get(i).y = positions.get(i - 1).y + cos(time * nodes.get(i).cycleTime) * nodes.get(i).radius;
    }
  }
  
  public Vector2 GetPosition(int n){
    if(n < 0 || n > positions.size()) return new Vector2(0, 0);
    return positions.get(n);
  }
  
  public int GetLength(){
    return positions.size(); 
  }
}