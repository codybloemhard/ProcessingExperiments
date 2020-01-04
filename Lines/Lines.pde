import java.util.HashMap;

PImage img;
short[][] grid;
int x = 0, y = 0;
int dx = 1, dy = 1;

void setup() {
    //size(1920,1080,P2D);
    size(1200,1200,P2D);
    //size(1200,900,P2D);
    frameRate(10000);
    img = loadImage("test0.bmp");
    grid = new short[img.width][img.height];
    HashMap<Integer, Integer> cmap = new HashMap<Integer, Integer>();
    cmap.put(new Integer(color(0,0,0)), new Integer(0));
    cmap.put(new Integer(color(255,255,255)), new Integer(1));
    for(int x = 0; x < img.width; x++){
        for(int y = 0; y < img.height; y++){
            Integer pix = new Integer(img.get(x, y));
            if(!cmap.containsKey(pix)){
                grid[x][y] = -1;
                continue;
            }
            grid[x][y] = cmap.get(pix).shortValue();
        }
    }
    image(img,0,0,width,height);
}

void draw() {
    noStroke();
    fill(255,0,0);
    rect(x, y, 1, 1);
    
}

short get_from_grid(int x, int y){
    if(x < 0 || x >= width || y < 0 || y >= height) return -1;
    return grid[(int)((float)x / width * img.width)][(int)((float)y / height * img.height)];
}

boolean ok_pix(int x, int y){
    return true;
}