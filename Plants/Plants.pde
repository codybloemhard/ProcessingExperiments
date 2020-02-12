int wsize = 1200;
int z = 4;
int size = 0;
boolean reset = false;

int EMPTY = 0;
int SOLID = -1;
int START = -2;

int[][] grid;

void setup() {
    size(1200,1200,P2D);
    frameRate(10000);
    size = wsize / z;
    println("size: " + size);
    grid = new int[size][size];
    background(0);
    reset_grid();
}

void reset_grid(){
    noStroke();
    fill(255);
    for(int x = 0; x < size; x++)
    for(int y = 0; y < size; y++)
        grid[x][y] = 0;
    for(int i = 0; i < size; i++){
        int s = size - 1;
        grid[i][0] = -1;
        grid[i][s] = -1;
        grid[0][i] = -1;
        grid[0][s] = -1;
        int k = z;
        rect(i*z,0,k,k);
        rect(i*z,s*z,k,k);
        rect(0,i*z,k,k);
        rect(s*z,i*z,k,k);
    }
    for(int i = 0; i < size; i++)
        grid[i][0] = -2;
}

boolean check_neigh(int x, int y, int target){
    for(int i = max(0,x - 1); i < min(size - 1,x + 1); i++)
    for(int j = max(0,y - 1); j < min(size - 1,y + 1); j++)
        if(grid[i][j] == target)
            return true;
    return false;
}

int get_neigh(int x, int y){
    for(int i = max(0,x - 1); i <= min(size - 1,x + 1); i++)
    for(int j = max(0,y - 1); j <= min(size - 1,y + 1); j++)
        if(grid[i][j] > 0)
            return grid[i][j];
    return 0;
}

void draw() {
    noStroke();
    if(reset){
        background(0);
        reset_grid();
        reset = false;
    }
    int x = (int)random(0,size);
    int y = size - 2;
    if(grid[x][y] != EMPTY) return;
    while(true){
        if(check_neigh(x,y,-2)){
            grid[x][y] = 1;
            fill(0,64,0);
            rect(x*z,y*z,z,z);
            return;
        }
        int n = get_neigh(x,y);
        if(n != 0){
            grid[x][y] = n + 1;
            fill(min(255,n/3),min(255,n/2 + 64),min(255,n/3));
            rect(x*z,y*z,z,z);
            return;
        }
        float dx = random(0,1);
        float dy = random(0,1);
        x += dx >= 0.5f ? -1 : 1;
        y += dy > 0.3f ? -1 : 1;
        if(x < 1) x = 1;
        if(x > size - 2) x = size - 2;
        if(y < 1) y = 1;
        if(y > size - 2) y = size - 2;
    }
}

void keyPressed() {
    if (key == ' ') {
        reset = true;
    }
}
