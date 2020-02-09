int size = 1200;
int thickness = 16;
int amount = 4;
int counter = 1;

int[][] grid;

void setup() {
    size(1200,1200,P2D);
    frameRate(60);
    grid = new int[size][size];
    for(int x = 0; x < size; x++)
    for(int y = 0; y < size; y++)
        grid[x][y] = 0;
    background(0);
}

void draw() {
        if(thickness <= 0) return;
        noStroke();
        if(counter == amount){
                counter = 0;
                amount *= 3;
                thickness /= 2;
        }
        float x = random(0, size);
        float y = random(0, size);
        if(grid[(int)x][(int)y] != 0) return;
        float dx = random(-1,1);
        float dy = random(-1,1);
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
    }
}
