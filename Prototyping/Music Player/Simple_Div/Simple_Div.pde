// Libraries

// Global Variable
int appWidth, appHeight;

//void settings() {
// println(displayWidth, displayHeight);
// int shorterSide = (displayWidth > displayHeight) ? displayHeight : displayWidth;
// shorterSide *= 0.9;
// size(shorterSide, shorterSide);
//}

void setup() {
  //int shorterSide = 1080;
  //size(shorterSide, shorterSide);

  println(displayWidth, displayHeight);
  //size(600, 400);
  fullScreen();
  appWidth = displayWidth;
  appHeight = displayHeight;
  drive();
}

void draw() {
}

void mousePressed() {
}

void keyPressed() {
}
