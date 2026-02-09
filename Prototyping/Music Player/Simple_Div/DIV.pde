//Global Variables
int numOfDIVs = 8;
int numberOfPermeters = 4;
float[] drive = new float[numOfDIVs*numberOfPermeters];

void drive() {
  float paperWidth = 10;
  float paperHeight = 20;

  int[] driveCode = {
    1, 1,  5, 2,
    7, 1,  2, 2,
    1, 4,  8, 7,
    1, 12, 2, 2,
    4, 12, 2, 2,
    7, 12, 2, 2,
    1, 15, 8, 2,
    3, 18, 4, 1
  };
  
  // For looping Calculation
  for (int i = 0; i < driveCode.length; i += 4) {
    drive[i + 0] = appWidth  * driveCode[i + 0] / paperWidth;
    drive[i + 1] = appHeight * driveCode[i + 1] / paperHeight;
    drive[i + 2] = appWidth  * driveCode[i + 2] / paperWidth;
    drive[i + 3] = appHeight * driveCode[i + 3] / paperHeight;
  }

  // Draw
  for (int i = 0; i < drive.length; i += 4) {
    rectDIV(drive[i], drive[i + 1], drive[i + 2], drive[i + 3]);
  }
}

void rectDIV(float x, float y, float w, float h) {
  rect(x, y, w, h);
}
