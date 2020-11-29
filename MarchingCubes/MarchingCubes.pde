char[] keys = new char[0]; 

cam c;
render r;


void setup() {
  fullScreen(P3D, 1);
  frameRate(120);
  stroke(0);
  c = new cam();
  r = new render();
}
void draw() {
  background(0);
  c.Draw();
  r.Draw();
  axis();
  if (!keyPressed) keys = new char[0];
}
void keyPressed() {
  char[] in = keys.clone();
  char[] out = new char[0];
  for (int i = 0; i<in.length; i++) {
    if (key!=in[i]) out = (char[]) append(out, in[i]);
  }
  out = (char[]) append(out, key);
  keys = out;
}
void keyReleased() {
  char[] in = keys.clone();
  char[] out = new char[0];
  for (int i = 0; i<in.length; i++) {
    if (key!=in[i]) out = (char[]) append(out, in[i]);
  }
  keys = out;
}



float revLerp(float low, float heigh, float mid) {
  return map(mid, low, heigh, 0, 1);
}



void axis() {
  pushMatrix();
  stroke(255, 0, 0);
  line(0, 0, 0, 1000, 0, 0);
  popMatrix();
  pushMatrix();
  stroke(0, 255, 0);
  line(0, 0, 0, 0, 1000, 0);
  popMatrix();
  pushMatrix();
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 1000);
  popMatrix();
}
