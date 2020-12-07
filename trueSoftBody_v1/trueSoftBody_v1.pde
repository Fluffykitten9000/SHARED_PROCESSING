cam c;
population pop;

int AMOUNT = 20;
float ballSize = 200;

boolean BALLCOL = true;
float ballM = -3000;
float ballP = -2;

boolean GRAVON = false;
float gravM = 0.00000001;
float gravP = -0.9;

boolean BONDS = true;
float bondM = 0.05;

boolean WALLCOL = true;
float wallPush = 20;

float ballFriction = 0.0001;
float edgeFriction = 0.1;
float sideFriction = 0.01;
float bondFriction = 0.001;

PVector WGRAVITY = new PVector(0, 0.1, 0);
PVector worldSize = new PVector(2000, 2000, 2000);
float forceM = 1000000;

float camEffectRadi = 200;
float camPush = 300;

float mouseRadi = 50;

void setup() {
  fullScreen(P3D, 1);
  frameRate(120);
  noStroke();
  sphereDetail(6);
  c = new cam();
  pop = new population();
}
void draw() {
  background(0);
  c.Draw();
  axis();
  pop.Draw();
  KEYS();
}
void axis() {
  strokeWeight(5);
  pushMatrix();
  stroke(255, 0, 0);
  line(0, 0, 0, worldSize.x, 0, 0);
  popMatrix();
  pushMatrix();
  stroke(0, 255, 0);
  line(0, 0, 0, 0, worldSize.y, 0);
  popMatrix();
  pushMatrix();
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, worldSize.z);
  popMatrix();
  pushMatrix();
  stroke(255);
  line(worldSize.x, 0, 0, worldSize.x, worldSize.y, 0);
  line(worldSize.x, 0, 0, worldSize.x, 0, worldSize.z);
  line(0, worldSize.y, 0, worldSize.x, worldSize.y, 0);
  line(0, worldSize.y, 0, 0, worldSize.y, worldSize.z);
  line(0, 0, worldSize.z, worldSize.x, 0, worldSize.z);
  line(0, 0, worldSize.z, 0, worldSize.y, worldSize.z);
  line(worldSize.x, worldSize.y, worldSize.z, 0, worldSize.y, worldSize.z);
  line(worldSize.x, worldSize.y, worldSize.z, worldSize.x, 0, worldSize.z);
  line(worldSize.x, worldSize.y, worldSize.z, worldSize.x, worldSize.y, 0);
  popMatrix();
}
void mouseReleased() {
  c.screenMouseRel();
}
void mousePressed() {
}
