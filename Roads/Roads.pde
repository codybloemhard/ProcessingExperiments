int size = 1200;
int thickness = 32;
int amount = 3;
int counter = 0;

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
                amount *= 2;
                thickness /= 2;
        }
        float x = random(0, size);
        float y = random(0, size);
        if(grid[(int)x][(int)y] != 0) return;
        float dx = random(-1,1);
        float dy = random(-1,1);
        int lx = (int)x, ly = (int)y;
        fill(255);
        while(true){
                if(x < 0 || x >= size || y < 0 || y >= size) break;
                if(grid[(int)x][(int)y] != 0) break;
                circle(x, y, thickness);
                grid[(int)x][(int)y] = 1;
                while((int)x == lx && (int)y == ly){
                        x += dx;
                        y += dy;
                }
                lx = (int)x;
                ly = (int)y;
        }
        counter++;
}

void keyPressed() {
    if (key == ' ') {
    }
}
