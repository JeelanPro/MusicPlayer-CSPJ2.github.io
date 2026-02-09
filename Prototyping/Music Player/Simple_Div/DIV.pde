//Global Variables
int numOfDIVs = 8;
int numberOfPermeters = 4;
float[] drive = new float[numOfDIVs*numberOfPermeters];

void drive() {
  float paperWidth = 10;
  float paperHeight = 20;

  drive[0] = appWidth * 1 / paperWidth;
  drive[1] = appHeight * 1 / paperHeight;
  drive[2] = appWidth * 5 / paperWidth;
  drive[3] = appHeight * 2 / paperHeight;

  drive[4] = appWidth * 7 / paperWidth;
  drive[5] = appHeight * 1 / paperHeight;
  drive[6] = appWidth * 2 / paperWidth;
  drive[7] = appHeight * 2 / paperHeight;

  drive[8] = appWidth * 1 / paperWidth;
  drive[9] = appHeight * 4 / paperHeight;
  drive[10] = appWidth * 8 / paperWidth;
  drive[11] = appHeight * 7 / paperHeight;

  drive[12] = appWidth * 1 / paperWidth;
  drive[13] = appHeight * 12 / paperHeight;
  drive[14] = appWidth * 2 / paperWidth;
  drive[15] = appHeight * 2 / paperHeight;

  drive[16] = appWidth * 4 / paperWidth;
  drive[17] = appHeight * 12 / paperHeight;
  drive[18] = appWidth * 2 / paperWidth;
  drive[19] = appHeight * 2 / paperHeight;

  drive[20] = appWidth * 7 / paperWidth;
  drive[21] = appHeight * 12 / paperHeight;
  drive[22] = appWidth * 2 / paperWidth;
  drive[23] = appHeight * 2 / paperHeight;

  drive[24] = appWidth * 1 / paperWidth;
  drive[25] = appHeight * 15 / paperHeight;
  drive[26] = appWidth * 8 / paperWidth;
  drive[27] = appHeight * 2 / paperHeight;

  drive[28] = appWidth * 3 / paperWidth;
  drive[29] = appHeight * 18 / paperHeight;
  drive[30] = appWidth * 4 / paperWidth;
  drive[31] = appHeight * 1 / paperHeight;

  //printArray(drive);

  //rectDIV(drive[0], drive[1], drive[2], drive[3]);

  for (int i = 0; i < drive.length; i += 4) {
    rect(drive[i], drive[i+1], drive[i+2], drive[i+3]);
  }
}

void rectDIV(float x, float y, float w, float h) {
  rect(x, y, w, h);
}
