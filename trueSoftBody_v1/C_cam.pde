class cam {
  float movSens = 5;
  float rotSens = 0.003;
  float fov = PI/2;
  PVector camP = new PVector(0, 0, 0);
  PVector camR = new PVector(0, 0, 0);
  float cameraZ = ((height/2) / tan(PI*60.0/360.0));
  float aspect;
  cam() {
    aspect = (float)width/(float)height;
    perspective(fov, aspect, cameraZ/100, cameraZ*1000000000);
  }
  void Draw() {
    screen();
    PVector wasd = new PVector();
    for (int i = 0; i<keys.length; i++) {
      if (keys[i]=='w') wasd.z += 1;
      if (keys[i]=='s') wasd.z -= 1;
      if (keys[i]=='a') wasd.x += 1;
      if (keys[i]=='d') wasd.x -= 1;
      if (keys[i]=='e') wasd.y += 1;
      if (keys[i]=='q') wasd.y -= 1;
      if (keys[i]==' ') wasd.mult(2);
    }
    camP.add(new PVector(
      wasd.x*movSens*cos(camR.x), 
      0, 
      wasd.x*movSens*sin(camR.x)
      ));
    camP.add(new PVector(
      wasd.z*movSens*sin(-camR.x)*cos(camR.y), 
      wasd.z*movSens*sin(camR.y), 
      wasd.z*movSens*cos(camR.x)*cos(camR.y)
      ));
    camP.add(new PVector(
      wasd.y*movSens*sin(-camR.x)*sin(-camR.y), 
      wasd.y*movSens*cos(camR.y), 
      wasd.y*movSens*cos(camR.x)*sin(-camR.y)
      ));
    beginCamera();
    camera();
    translate(width/2, height/2, cameraZ);
    rotateX(camR.y);
    rotateY(camR.x);
    translate(camP.x, camP.y, camP.z);
    endCamera();
    ambientLight(102, 102, 102);
    lightSpecular(204, 204, 204);
    directionalLight(102, 102, 102, 0, 0, -1);
  }
  void screenMouseRel() {
    if (mouseButton==LEFT) {
      float maxS = mouseRadi;
      int oneS = -1;
      for (int i = 0; i<AMOUNT; i++) {
        float distS = dist(mouseX, mouseY, screenX(pop.balls[i].pos.x, pop.balls[i].pos.y, pop.balls[i].pos.z), screenY(pop.balls[i].pos.x, pop.balls[i].pos.y, pop.balls[i].pos.z));
        if (distS<maxS) {
          oneS = i;
          maxS = distS;
        }
      }
      if (oneS!=-1) pop.balls[oneS].chose = !pop.balls[oneS].chose;
    }
  }
  void screen() {
    if (mouseButton==RIGHT) {
      camR.x += (mouseX-pmouseX)*rotSens;
      camR.y -= (mouseY-pmouseY)*rotSens;
      if (camR.x>PI) camR.x-=TWO_PI;
      if (camR.x<PI) camR.x+=TWO_PI;
      if (camR.y>=HALF_PI) camR.y=HALF_PI;
      if (camR.y<=-HALF_PI) camR.y=-HALF_PI;
    }
  }
  void drag3D(float Xscreen, float Yscreen, float dist) {
    //map(Xscreen, 0, width, camR.x-
    //map(Yscreen, 0, height, camR.y-
  }
}
