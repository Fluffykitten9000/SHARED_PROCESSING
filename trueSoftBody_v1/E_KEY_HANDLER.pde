char[] keys = new char[0];
int[] keyCodes = new int[0];
void keyPressed() {
  if (key==CODED) { //keyCodes
    int[] in = keyCodes.clone();
    int[] out = new int[0];
    for (int i = 0; i<in.length; i++) {
      if (keyCode!=in[i]) out = (int[]) append(out, in[i]);
    }
    out = (int[]) append(out, keyCode);
    keyCodes = out;
  } else { //regular keys
    char[] in = keys.clone();
    char[] out = new char[0];
    for (int i = 0; i<in.length; i++) {
      if (key!=in[i]) out = (char[]) append(out, in[i]);
    }
    out = (char[]) append(out, key);
    keys = out;
  }
}
void keyReleased() {
  if (key==CODED) { //keyCodes
    int[] in = keyCodes.clone();
    int[] out = new int[0];
    for (int i = 0; i<in.length; i++) {
      if (keyCode!=in[i]) out = (int[]) append(out, in[i]);
    }
    keyCodes = out;
  } else { //regular keys
    char[] in = keys.clone();
    char[] out = new char[0];
    for (int i = 0; i<in.length; i++) {
      if (key!=in[i]) out = (char[]) append(out, in[i]);
    }
    keys = out;
  }
}
void KEYS() {
  if (!keyPressed) {
    keys = new char[0];
    keyCodes = new int[0];
  }
}
        //stroke(255, 0, 0);
        //line(pos.x, pos.y, pos.z, pos.x+f1.x, pos.y+f1.y, pos.z+f1.z);
        //stroke(0, 0, 255);
        //line(B[i].pos.x, B[i].pos.y, B[i].pos.z, B[i].pos.x+f2.x, B[i].pos.y+f2.y, B[i].pos.z+f2.z);
