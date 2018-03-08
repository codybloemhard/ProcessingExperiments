public class TerrainLayer{
 private int n, lod;
 private float time, timeSpeed, falloff, freq, ampl, depth;
 private float[] points;
 
 public TerrainLayer(int res, float timeSpeed, int lod, float falloff, float freq, float ampl){
   n = res;
   this.timeSpeed = timeSpeed;
   time = 0f;
   this.lod = lod;
   this.falloff = falloff;
   this.freq = freq;
   this.ampl = ampl;
   depth = random(1f);
   points = new float[n];
 }
 
 public void Update(){
  noiseDetail(lod, falloff);
  for(int i = 0; i < n; i++){
    float x = noise(time + (float)i / n * freq, depth);
    points[i] = x * ampl;
  }
  time += timeSpeed;
 }
 
 public void Render(){
  noStroke();
  PShape s = createShape();
  s.beginShape();
  for(int i = 0; i < n; i++)
    s.vertex((float)i / (n - 1) * width, (1f - points[i]) * height);
  s.vertex(width, points[n - 1] * height);
  s.vertex(width, height);
  s.vertex(0f, height);
  s.endShape(CLOSE);
  shape(s);
 }
}