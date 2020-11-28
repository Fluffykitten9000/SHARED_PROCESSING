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
  background(10);
  axis();
  c.Draw();
  r.Draw();
}




void axis() {
  pushMatrix();
  stroke(255,0,0);
  line(0,0,0,1000,0,0);
  popMatrix();
  pushMatrix();
  stroke(0,255,0);
  line(0,0,0,0,1000,0);
  popMatrix();
  pushMatrix();
  stroke(0,0,255);
  line(0,0,0,0,0,1000);
  popMatrix();
}