PImage img;
float f;
boolean start = false;
int mode = 2;

void setup() {
    size(1920,1080,P2D);
    //size(1600,1200,P2D);
    //size(1200,900,P2D);
    img = loadImage("test.jpg");
    //image(img,0,0);
    if(mode == 1){
        f = 100;
    }else if(mode == 2){
        f = 200;
    }
}

void draw() {
    if (keyPressed && key == ' ')
        start = true;
    if(mode == 0){
        CirclesGrey(img, 13);
    }else if(mode == 1){
        if(!start) return;
        f *= 0.997f;
        f = max(1,f);
        CirclesColour(img, (int)f);
    }else if(mode == 2){
        if(!start){
            background(0);
            return;
        }
        f *= 0.995f;
        f = max(1,f);
        int size = (int)max(10,f);
        int times = (int)(0.05f * img.width * img.height) / size;
        for(int i = 0; i < times; i++)
            RandomCircles(img, size);
    }
}

//effects

void CirclesGrey(PImage img, int size){
    background(0);
    fill(255);
    noStroke();
    img.loadPixels(); 
    float hsize = (float)size / 2.0f;
    for (int i = 0; i < img.width/size; i++)
    for (int j = 0; j < img.height/size; j++){
        int bx = i*size, by = j*size;
        float str = 0;
        for (int x = 0; x < size; x++)
        for (int y = 0; y < size; y++){ 
            int xp = bx + x;
            int yp = by + y;
            int loc = xp + yp*img.width;
            color col = img.pixels[loc];
            str += red(col);
            str += green(col);
            str += blue(col);
        }
        str /= size*size;
        str /= 255 * 3;
        str *= size;
        ellipse(bx + hsize, by + hsize, str, str);
    }
}

void CirclesColour(PImage img, int size){
    background(0);
    fill(255);
    noStroke();
    img.loadPixels(); 
    for (int i = 0; i < img.width/size; i++)
    for (int j = 0; j < img.height/size; j++){
        int sx = i*size, sy = j*size;
        DrawAvgColCircle(sx,sy,size,255);
    }
}

void RandomCircles(PImage img, int size){
    noStroke();
    int sx = (int)random(0, img.width - size);
    int sy = (int)random(0, img.height - size);
    DrawAvgColCircle(sx, sy, size, 20);
}

//helpers

void DrawAvgColCircle(int sx, int sy, int size, int alpha){
    int max = min(img.width, img.height);
    if(size > max)
        size = max;
    float r = 0, g= 0, b = 0;
    for (int x = 0; x < size; x++)
    for (int y = 0; y < size; y++){ 
        int xp = sx + x;
        int yp = sy + y;
        int loc = xp + yp*img.width;
        color col = img.pixels[loc];
        r += red(col);
        g += green(col);
        b += blue(col);
    }
    r /= size*size;
    g /= size*size;
    b /= size*size;
    float str = r + g + b;
    str /= 255 * 3;
    str *= size;
    fill(r, g, b, alpha);
    float hsize = (float)size / 2.0f;
    circle(sx + hsize, sy + hsize, str);
}
