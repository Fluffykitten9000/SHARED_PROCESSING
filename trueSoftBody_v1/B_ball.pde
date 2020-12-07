class ball {
  int meI;
  color sto = color(0, 0, 255);
  boolean chose = false;
  PVector pos;
  PVector vel;
  float size;
  float radi;
  float vol;
  boolean[] bonds = new boolean[AMOUNT];
  float[] bondLengths = new float[AMOUNT];
  ball(PVector pos, PVector vel, float size, int me) { 
    this.pos = pos; 
    this.vel = vel; 
    this.size = size; 
    radi = size/2; 
    vol = (4/3)*PI*pow(radi, 3);
    meI = me;
    resetBonds();
  } 
  void Draw() { 
    pos.add(vel);
  } 
  void otherBalls(ball[] B, int me) { 
    for (int i = 0; i<me; i++) {
      float dist = PVector.dist(pos, B[i].pos);
      if (BONDS&&bonds[i]) {

        PVector p = PVector.sub(B[i].pos, pos);
        p.setMag(p.mag()-bondLengths[i]);
        p.mult(bondM);
        vel.add(PVector.div(p, vol/forceM));
        B[i].vel.sub(PVector.div(p, B[i].vol/forceM));
        strokeWeight(10);
        stroke(255);
        line(pos.x, pos.y, pos.z, B[i].pos.x, B[i].pos.y, B[i].pos.z);
        {
          PVector p1 = PVector.sub(pos, B[i].pos);
          p1.setMag(p1.mag()-bondLengths[i]);
          PVector p2 = new PVector(-p1.x, -p1.y, -p1.z);
          if (p1.mag()>0.0f&&p2.mag()>0.0f) {
            float d1 = p1.dot(vel);
            d1 /= p.mag();
            float d2 = p2.dot(B[i].vel);
            d2 /= p.mag();
            PVector f1 = PVector.mult(p1.normalize(), d1);
            PVector f2 = PVector.mult(p2.normalize(), d2);
            PVector temp = PVector.sub(f1, f2);
            vel.sub(PVector.lerp(new PVector(), temp, bondFriction));
            B[i].vel.sub(PVector.lerp(new PVector(), new PVector(-temp.x, -temp.y, -temp.z), bondFriction));
          }
        }
      } else {
        if (BALLCOL&&dist<(radi)+(B[i].radi)) { 
          PVector p = PVector.sub(B[i].pos, pos); 
          p.normalize().mult(ballM*pow(dist, ballP));
          B[i].vel.sub(PVector.div(p, B[i].vol/forceM));
          vel.add(PVector.div(p, vol/forceM));
          {
            PVector p1 = PVector.sub(pos, B[i].pos);
            p1.setMag(p1.mag()-bondLengths[i]);
            PVector p2 = new PVector(-p1.x, -p1.y, -p1.z);
            if (p1.mag()>0.0f&&p2.mag()>0.0f) {
              float d1 = p1.dot(vel);
              d1 /= p.mag();
              float d2 = p2.dot(B[i].vel);
              d2 /= p.mag();
              PVector f1 = PVector.mult(p1.normalize(), d1);
              PVector f2 = PVector.mult(p2.normalize(), d2);
              PVector temp = PVector.sub(f1, f2);
              vel.sub(PVector.lerp(new PVector(), temp, ballFriction));
              B[i].vel.sub(PVector.lerp(new PVector(), new PVector(-temp.x, -temp.y, -temp.z), ballFriction));
            }
          }
        }
        if (GRAVON) {
          PVector p = PVector.sub(B[i].pos, pos); 
          p.normalize().mult(gravM*pow(dist, gravP));
          B[i].vel.sub(PVector.div(p, B[i].vol/forceM));
          vel.add(PVector.div(p, vol/forceM));
        }
      }
    }
  } 
  void walls() { 
    if (WALLCOL) { 
      if (pos.x<radi) {
        vel.x += map(pos.x, 0, radi, wallPush, 0);
        vel.x = lerp(vel.x, 0, edgeFriction);
        vel.y = lerp(vel.y, 0, sideFriction);
        vel.z = lerp(vel.z, 0, sideFriction);
      } else if (pos.x>worldSize.x-radi) {
        vel.x -= map(worldSize.x-pos.x, 0, radi, wallPush, 0);
        vel.x = lerp(vel.x, 0, edgeFriction);
        vel.y = lerp(vel.y, 0, sideFriction);
        vel.z = lerp(vel.z, 0, sideFriction);
      }
      if (pos.y<radi) {
        vel.y += map(pos.y, 0, radi, wallPush, 0);
        vel.y = lerp(vel.y, 0, edgeFriction);
        vel.x = lerp(vel.x, 0, sideFriction);
        vel.z = lerp(vel.z, 0, sideFriction);
      } else if (pos.y>worldSize.y-radi) {
        vel.y -= map(worldSize.y-pos.y, 0, radi, wallPush, 0);
        vel.y = lerp(vel.y, 0, edgeFriction);
        vel.x = lerp(vel.x, 0, sideFriction);
        vel.z = lerp(vel.z, 0, sideFriction);
      }
      if (pos.z<radi) {
        vel.z += map(pos.z, 0, radi, wallPush, 0);
        vel.z = lerp(vel.z, 0, edgeFriction);
        vel.x = lerp(vel.x, 0, sideFriction);
        vel.y = lerp(vel.y, 0, sideFriction);
      } else if (pos.z>worldSize.z-radi) {
        vel.z -= map(worldSize.z-pos.z, 0, radi, wallPush, 0);
        vel.z = lerp(vel.z, 0, edgeFriction);
        vel.x = lerp(vel.x, 0, sideFriction);
        vel.y = lerp(vel.y, 0, sideFriction);
      }
    }
  }
  void cam() {
    PVector p = PVector.add(c.camP, pos); 
    float dist = p.mag();
    if (dist<camEffectRadi) {
      p.normalize().mult(camPush*pow(dist, -1)/(vol/forceM));
      vel.add(p);
    }
  }
  void resetBonds() {
    for (int i = 0; i<bonds.length; i++) {
      bonds[i] = false;
    }
    for (int i = 0; i<bondLengths.length; i++) {
      bondLengths[i] = 0;
    }
  }
  void show() {
    pushMatrix();
    if (chose) stroke(0, 255, 0);
    else stroke(sto);
    strokeWeight(0.5);
    noFill();
    //fill(255);
    translate(pos.x, pos.y, pos.z);
    sphere(radi);
    popMatrix();
  }
}
