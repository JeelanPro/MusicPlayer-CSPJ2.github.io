//Global Variables
int numOfDIVs = 8;
int numberOfPermeters = 4;
float[] drive = new float[numOfDIVs*numberOfPermeters];
int numOfPixelSizeX;
int numOfPixelSizeY;
int numOfPixelX;
int numOfPixelY;
int numOfPixelW;
int numOfPixelH;

void drive() {
  numOfPixelSizeX = 16;
  numOfPixelSizeY = 9;
  numOfPixelX = appWidth  / numOfPixelSizeX * 7;
  numOfPixelY = appHeight / numOfPixelSizeY * 3;
  numOfPixelW = appWidth  / numOfPixelSizeX * 3;
  numOfPixelH = appHeight / numOfPixelSizeY * 5;

  //rect(0, 0, appWidth  / numOfPixelSizeX, appHeight / numOfPixelSizeY);

  rect(
    appWidth  / numOfPixelSizeX * 0,
    appHeight  / numOfPixelSizeY * 0,
    appWidth  / numOfPixelSizeX * 1,
    appHeight / numOfPixelSizeY * 1);
  
  rect(
    appWidth  / numOfPixelSizeX * 15,
    appHeight  / numOfPixelSizeY * 0,
    appWidth  / numOfPixelSizeX * 1,
    appHeight / numOfPixelSizeY * 1);

  float paperWidth = 10;
  float paperHeight = 20;

  int[] driveCode = {
    1, 1, 5, 2,
    7, 1, 2, 2,
    1, 4, 8, 7,
    1, 12, 2, 2,
    4, 12, 2, 2,
    7, 12, 2, 2,
    1, 15, 8, 2,
    3, 18, 4, 1
  };

  // For looping Calculation
  for (int i = 0; i < driveCode.length; i += 4) {
    drive[i + 0] = numOfPixelW * driveCode[i + 0] / paperWidth + numOfPixelX;
    drive[i + 1] = numOfPixelH * driveCode[i + 1] / paperHeight + numOfPixelY;
    drive[i + 2] = numOfPixelW * driveCode[i + 2] / paperWidth;
    drive[i + 3] = numOfPixelH * driveCode[i + 3] / paperHeight;
  }

  // Draw
  rectDIV(numOfPixelX, numOfPixelY, numOfPixelW, numOfPixelH);
  for (int i = 0; i < drive.length; i += 4) {
    rectDIV(drive[i], drive[i + 1], drive[i + 2], drive[i + 3]);
  }
}

void rectDIV(float x, float y, float w, float h) {
  rect(x, y, w, h);
}
