import java.util.HashMap;

boolean run = true;
Area ar;

void setup() {
    size(1200,1200,P2D);
    frameRate(60);
    ar = new Area(20, 0, 0, 1200, 1200);
}

void draw() {
    noStroke();
    if(!run) return;
        ar.Draw();
}

void keyPressed() {
    if (key == ' ') {
        run = !run;
    }
}

class Area{
        private int border;
        private int x, y, w, h;
        private Area a, b;

        public Area(int border, int x, int y,
                int w, int h){
                this.border = border;
                this.x = x;
                this.y = y;
                this.w = w;
                this.h = h;
                int b2 = border * 2;
                if(b2 >= w || b2 >= h){
                        a = null;
                        b = null;
                        return;
                }
                int w0 = (int)random(0, w - b2);
                int w1 = (w - b2) - w0;
                int nh = h - b2;
                a = new Area(border, x + border, y + border, w0, nh);
                b = new Area(border, x + border + w0, y + border, w1, nh);
        }

        public void Draw(){
                int rr = (x * y + w + h) % 255;
                int gg = (w * x + y * h) % 255;
                int bb = (h * x * y + w) % 255;
                fill(rr,gg,bb);
                rect(x,y,w,h);
                if(a != null)
                        a.Draw();
                if(b != null)
                        b.Draw();
        }
}
