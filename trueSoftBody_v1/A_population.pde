class population {
  ball[] balls;
  
  population() {
    balls = new ball[AMOUNT];
    for (int i = 0; i<AMOUNT; i++) {
      float s = ballSize;
      PVector pos = new PVector(random(s/2, worldSize.x-s/2), random(s/2, worldSize.y-s/2), random(s/2, worldSize.z-s/2));
      PVector vel = PVector.random3D().mult(1);
      balls[i] = new ball(pos, vel, s, i);
    }
  }
  void Draw() {
    for (int i = 0; i<AMOUNT; i++) {
      balls[i].vel.add(WGRAVITY);
      balls[i].otherBalls(balls, i);
      balls[i].walls();
      balls[i].Draw();
      balls[i].cam();
      balls[i].show();
    }
    checkBonds();
  }
  void checkBonds() {
    int first = -1;
    int second = -1;
    for (int i = 0; i<AMOUNT; i++) {
      if (balls[i].chose) {
        if (first==-1) {
          first = i;
        } else {
          second = i;
          if (balls[first].bonds[second]) removeBond(first, second);
          else makeBond(first, second, 300);
          balls[first].chose = false;
          balls[second].chose = false;
          break;
        }
      }
    }
  }
  void makeBond(int first, int second, float length) {
    balls[first].bonds[second] = true;
    balls[first].bondLengths[second] = length;
    balls[second].bonds[first] = true;
    balls[second].bondLengths[first] = length;
  }
  void removeBond(int first, int second) {
    balls[first].bonds[second] = false;
    balls[first].bondLengths[second] = 0;
    balls[second].bonds[first] = false;
    balls[second].bondLengths[first] = 0;
  }
}
