import java.util.HashMap;

PImage img;
short[][] grid;
int x = 0, y = 0;
int dx = 0, dy = 1;
boolean run = false;
int current = 1;
float chance = 0.05;

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
    background(0);
    //image(img,0,0,width,height);
    set_random_start();
}

void draw() {
    noStroke();
    if(!run) return;
    for(int i = 0; i < 20; i++){
        if(get_from_grid(x,y) != current){
            set_random_start();
            current = get_from_grid(x, y);
            if(current == 0){
                fill(0,0,255);
                chance = 0.08f;
            }
            else{
                fill(255,0,0);
                chance = 0.04f;
            }
            continue;
        }
        rect(x, y, 1, 1);
        x = x + dx;
        y = y + dy;
        set_random_dir(chance);
    }
}

void keyPressed() {
    if ((key == ' ')) {
        run = !run;
    }
}

void set_random_dir(float chance){
    if(random(1) < chance){
        if(dx != 0){
            dx = 0;
            if(random(10) < 5.0f)
                dy = -1;
            else dy = 1;
        }else{
            dy = 0;
            if(random(10) < 5.0f)
                dx = -1;
            else dx = 1;
        }
    }
}

void set_random_start(){
    x = (int)random(width);
    y = (int)random(height);
    if(random(1) < 0.5){
        dy = 0;
        if(random(1) < 0.5) dx = 1;
        else dx = -1;
    }
    else{
        dx = 0;
        if(random(1) < 0.5) dy = 1;
        else dy = -1;
    }
}

short get_from_grid(int x, int y){
    if(x < 0 || x >= width || y < 0 || y >= height) return -1;
    return grid[(int)((float)x / width * img.width)][(int)((float)y / height * img.height)];
}
