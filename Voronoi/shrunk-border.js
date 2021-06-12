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
  let size = 160;
  // also need cells border outside frame
  let xs = int(w / size) + 2;
  let ys = int(h / size) + 2;
  let pxs = twodar(xs, ys);
  let pys = twodar(xs, ys);
  let cols = twodar(xs, ys);
  let buffer = twodar(w, h);
  let field = twodar(w + 2, h + 2);
  for(let x = 0; x < xs; x++)
  for(let y = 0; y < ys; y++){
    pxs[x][y] = (x - 1) * size + random(float(size));
    pys[x][y] = (y - 1) * size + random(float(size));
    cols[x][y] = int(random(6));
  }
  // render voronoi into buffer
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
      // euclidean dist
      let difx = pxs[cx + i + 1][cy + j + 1] - x;
      let dify = pys[cx + i + 1][cy + j + 1] - y;
      // euclidean
      let d = sqrt(difx*difx + dify*dify);
      // squared euclidean
      // let d = difx*difx + dify*dify;
      // manhattan dist
      // let d = abs(difx) + abs(dify);
      if (d < closed){
        diff = closed - d;
        closed = d;
        closex = cx + i;
        closey = cy + j;
      }
    }}
    // set
    let c = cols[closex + 1][closey + 1];
    buffer[x][y] = c;
    field[x + 1][y + 1] = closey * xs + closex;
  }}
  // make border
  let b = xs*ys + 1;
  for(let n = 0; n < 30; n++){
  for(let x = 0; x < w; x++){
  for(let y = 0; y < h; y++){
    let cur = field[x + 1][y + 1]
    if( field[x][y] != cur ||
        field[x + 1][y] != cur ||
        field[x][y + 1] != cur ||
        field[x + 1][y + 1] != cur){
      field[x][y] = b;
      buffer[x][y] = 9;
    }
  }}}
  // draw on canvas
  for(let x = 0; x < w; x++){
  for(let y = 0; y < h; y++){
    let c = buffer[x][y];
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
    } else if (c == 5){
      fill(42, 161, 152);
    } else {
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
