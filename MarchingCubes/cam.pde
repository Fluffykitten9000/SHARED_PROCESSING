class cam {
  
  
  
  float movSens = 0.05;
  float rotSens = 0.003;
  
  
  
  PVector camP = new PVector(0, 0, 0);
  PVector camR = new PVector(0, 0, 0);
  float cameraZ = ((height/2) / tan(PI*60.0/360.0));
  PVector[] Ptouches = new PVector[0];
  cam() {
    perspective(PI/2, float(width)/float(height), cameraZ/100, cameraZ*1000000000);
  }
  void Draw() {
    lighting();
    r.offSet = new PVector(camP.x, camP.y, camP.z);
    if (touches.length!=0&&Ptouches.length!=0&&touches.length==Ptouches.length) {
      if (touches.length<=2) {
        for (int i = touches.length-1; i>=0; i--) {
          if (touches[i].x>width/3) {
            camR.x += (touches[i].x-Ptouches[i].x)*rotSens;
            camR.y += (touches[i].y-Ptouches[i].y)*rotSens;
            if (camR.x>PI) camR.x-=TWO_PI;
            if (camR.x<PI) camR.x+=TWO_PI;
            if (camR.y>=HALF_PI) camR.y=HALF_PI;
            if (camR.y<=-HALF_PI) camR.y=-HALF_PI;
          }
          if (touches[i].x<width/3) {
            PVector pv = new PVector(
              (-(touches[i].y-height/2)*movSens*cos(camR.x-HALF_PI)*sin(camR.y-HALF_PI)),
              -(touches[i].y-height/2)*movSens*cos(camR.y+HALF_PI),
              (-(touches[i].y-height/2)*movSens*sin(camR.x-HALF_PI)*sin(camR.y-HALF_PI)));
            pv.add(new PVector(
              (-(touches[i].x-(width/3)*0.5)*movSens*2*cos(camR.x)),
              0,
              (-(touches[i].x-(width/3)*0.5)*movSens*2*sin(camR.x))));
            camP.add(pv);
          }
        }
      }
    }
    Ptouches = (PVector[]) expand(Ptouches, touches.length);
    for (int i = touches.length-1; i>=0; i--) {
      Ptouches[i] = new PVector(touches[i].x, touches[i].y);
    }
    beginCamera();
    camera();
    translate(width/2, height/2, cameraZ);
    rotateX(-camR.y);
    rotateY(camR.x);
    translate(camP.x, camP.y, camP.z);
    translate(-r.landVals.length/2*r.scale.x, -r.landVals[0].length/2*r.scale.y, 0);//-r.landVals[0][0].length/2*r.scale.z);
    endCamera();
  }
  void lighting() {
    ambientLight(50, 50, 0);
    directionalLight(200, 200, 200, -0.5, 0.5, 0.5);
  }
}
