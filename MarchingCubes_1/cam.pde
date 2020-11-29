class cam {
  float movSens = 5;
  float rotSens = 0.003;

  PVector camP = new PVector(0, 0, 0);
  PVector camR = new PVector(0, 0, 0);
  float cameraZ = ((height/2) / tan(PI*60.0/360.0));
  cam() {
    perspective(PI/2, (float)width/(float)height, cameraZ/100, cameraZ*1000000000);
  }
  void Draw() {
    if (mouseButton==RIGHT) {
      camR.x += (mouseX-pmouseX)*rotSens;
      camR.y += (mouseY-pmouseY)*rotSens;
      if (camR.x>PI) camR.x-=TWO_PI;
      if (camR.x<PI) camR.x+=TWO_PI;
      if (camR.y>=HALF_PI) camR.y=HALF_PI;
      if (camR.y<=-HALF_PI) camR.y=-HALF_PI;
    }
    float ws = 0;
    float ad = 0;
    for (int i = 0; i<keys.length; i++) {
      if (keys[i]=='w'||keys[i]=='W') ws += 1;
      if (keys[i]=='s'||keys[i]=='S') ws -= 1;
      if (keys[i]=='a'||keys[i]=='A') ad += 1;
      if (keys[i]=='d'||keys[i]=='D') ad -= 1;
    }
    PVector pv = new PVector(
      (ws*movSens*cos(camR.x-HALF_PI)*sin(camR.y-HALF_PI)), 
      ws*movSens*cos(camR.y+HALF_PI), 
      (ws*movSens*sin(camR.x-HALF_PI)*sin(camR.y-HALF_PI)));
    pv.add(new PVector(
      (ad*movSens*2*cos(camR.x)), 
      0, 
      (ad*movSens*2*sin(camR.x))));
    camP.add(pv);
    beginCamera();
    camera();
    translate(width/2, height/2, cameraZ);
    rotateX(-camR.y);
    rotateY(camR.x);
    translate(camP.x, camP.y, camP.z);
    endCamera();
  }
}
