// quick thingy, don't want to install processing, i don't know js so it's shitty code

// bg: #1f1f20 = 31,31,31
// c1: #dc322f = 220, 50, 47
// c2: #859900 = 133, 153, 0
// c3: #b58900 = 181, 137, 71
// c4: #268bd2 = 38, 139, 210
// c5: #d33682 = 211, 54, 130
// c6: #2aa198 = 42, 161, 152

function setup() {
  let w = 2560;
  let h = 1440;
  createCanvas(w, h);
  background(31, 31, 32);
  noStroke();
  // set up voronoi
  let size = 80;
  // also need cells border outside frame
  let xs = int(w / size) + 5;
  let ys = int(h / size) + 5;
  let pxs = twodar(xs, ys);
  let pys = twodar(xs, ys);
  let cols = twodar(xs, ys);
  for(let x = 0; x < xs; x++)
  for(let y = 0; y < ys; y++){
    pxs[x][y] = (x - 2) * size + random(float(size));
    pys[x][y] = (y - 2) * size + random(float(size));
    cols[x][y] = int(random(6));
  }
  // render voronoi
  for(let x = 0; x < w; x++){
  for(let y = 0; y < h; y++){
    // find out what cell
    let cx = int(x / size);
    let cy = int(y / size);
    // find col
    let closex = cx;
    let closey = cy;
    let closed = 10000;
    let diff = 1000;
    for(let i = -1; i < 2; i++){
    for(let j = -1; j < 2; j++){
      let difx = pxs[cx + i + 2][cy + j + 2] - x;
      let dify = pys[cx + i + 2][cy + j + 2] - y;
      let d = difx*difx + dify*dify;
      if (d < closed){
        diff = closed - d;
        closed = d;
        closex = cx + i;
        closey = cy + j;
      }
    }}
    // find edge
    let toedgex = x - closex * size;
    let toedgey = y - closey * size;
    let toedgel = sqrt(toedgex*toedgex + toedgey*toedgey);
    toedgex /= toedgel;
    toedgey /= toedgel;
    let samplex = x + toedgex * 30.0;
    let sampley = y + toedgey * 30.0;
    let bclosex = cx;
    let bclosey = cy;
    let bclosed = 10000;
    diff = 1000;
    for(let i = -1; i < 2; i++){
    for(let j = -1; j < 2; j++){
      let difx = pxs[cx + i + 2][cy + j + 2] - samplex;
      let dify = pys[cx + i + 2][cy + j + 2] - sampley;
      let d = difx*difx + dify*dify;
      if (d < bclosed){
        diff = bclosed - d;
        bclosed = d;
        bclosex = cx + i;
        bclosey = cy + j;
      }
    }}
    // draw
    let c = cols[closex + 2][closey + 2];
    if (c == 0){
      fill(220, 50, 47);
    } else if (c == 1){
      fill(133, 153, 0);
    } else if (c == 2){
      fill(181, 137, 72);
    } else if (c == 3){
      fill(38, 139, 210);
    } else if (c == 4){
      fill(211, 54, 130);
    } else {
      fill(42, 161, 152);
    }
    if(bclosex != closex || bclosey != closey){
      fill(31, 31, 32);
    }

    rect(x, y, 1, 1);
  }}
}

function twodar(w, h){
  let a = new Array(w);
  for(let i = 0; i < w; i++){
    a[i] = new Array(h);
  }
  return a;
}
