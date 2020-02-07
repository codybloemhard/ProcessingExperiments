import java.util.HashMap;

boolean run = true;
int borders = 1;
Area ar;

void setup() {
    size(1200,1200,P2D);
    frameRate(60);
    ar = Root(borders, 1200, 1200);
}

void draw() {
    noStroke();
        ar.Draw();
}

void keyPressed() {
    if (key == ' ') {
        ar = Root(borders, 1200, 1200);
    }
}

public Area Root(int border, int ww, int hh){
        Area ar = new Area(border, 0, 0, 0, ww, hh);
        int md = ar.MaxDepth();
        ar.SetMaxDepth(md);
        return ar;
}

class Area{
        private int border;
        private int x, y, w, h;
        private int depth;
        private int maxDepth;
        private Area a, b;

        public Area(int border, int depth, int x, int y, int w, int h){
                this.border = border;
                this.depth = depth;
                this.x = x;
                this.y = y;
                this.w = w;
                this.h = h;
                int b3 = border * 3;
                if(border * 4 >= w || border * 4 >= h){
                        a = null;
                        b = null;
                        return;
                }
                if(random(0,1) + ((float)(w - h) / max(w,h)) > 0.5f){
                        int w0 = (int)random(border, w - b3 - border);
                        int w1 = (w - b3) - w0;
                        int nh = h - border * 2;
                        a = new Area(border, depth + 1, x + border, y + border, w0, nh);
                        b = new Area(border, depth + 1, x + w0 + border*2, y + border, w1, nh);
                }else{
                        int h0 = (int)random(border, h - b3 - border);
                        int h1 = (h - b3) - h0;
                        int nw = w - border * 2;
                        a = new Area(border, depth + 1, x + border, y + border, nw, h0);
                        b = new Area(border, depth + 1, x + border, y + h0 + border*2, nw, h1);
                }
        }

        public int MaxDepth(){
                int da = 0, db = 0;
                if(a != null)
                        da = a.MaxDepth();
                if(b != null)
                        db = b.MaxDepth();
                return 1 + max(da, db);
        }

        public void SetMaxDepth(int md){
                maxDepth = md;
                if(a != null)
                        a.SetMaxDepth(md);
                if(b != null)
                        b.SetMaxDepth(md);
        }

        public void Draw(){
                int d = (int)(pow((float)depth / (float)maxDepth, 1.8f) * 255.0f);
                fill(d);
                rect(x,y,w,h);
                if(a != null)
                        a.Draw();
                if(b != null)
                        b.Draw();
        }
}
