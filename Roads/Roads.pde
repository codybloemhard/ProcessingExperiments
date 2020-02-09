int size = 1200;
int thickness = 0;
int amount = 0;
int counter = 0;
boolean reset = true;

int[][] grid;

void setup() {
    size(1200,1200,P2D);
    frameRate(60);
    grid = new int[size][size];
    background(0);
}

void draw() {
        if(reset){
                reset = false;
                thickness = 16;
                amount = 5;
                counter = 0;
                background(0);
                for(int x = 0; x < size; x++)
                for(int y = 0; y < size; y++)
                        grid[x][y] = 0;
        }
        if(thickness <= 1) return;
        noStroke();
        if(counter == amount){
                counter = 0;
                amount *= 5;
                thickness /= 2;
        }
        float x = random(0, size);
        float y = random(0, size);
        if(grid[(int)x][(int)y] != 0) return;
        float dx = random(-1,1);
        float dy = random(-1,1);
        float len = pow(dx*dx + dy*dy, 0.5f);
        dx /= len;
        dy /= len;
        drawline(x, y, dx, dy, false);
        drawline(x, y, -dx, -dy, true);
        counter++;
}

void drawline(float x, float y, float dx, float dy, boolean second){
        int lx = (int)x, ly = (int)y;
        if(second){
                while((int)x == lx && (int)y == ly){
                        x += dx;
                        y += dy;
                }
                lx = (int)x;
                ly = (int)y;
        }
        while(true){
                if(x < 0 || x >= size || y < 0 || y >= size || grid[(int)x][(int)y] != 0){
                        break;
                }
                fill(255);
                circle(x, y, thickness);
                grid[(int)x][(int)y] = 1;
                while((int)x == lx && (int)y == ly){
                        x += dx;
                        y += dy;
                }
                lx = (int)x;
                ly = (int)y;
        }
}

void keyPressed() {
    if (key == ' ') {
        reset = true;
    }
}
