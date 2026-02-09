//Global Variables
int numOfDIVs = 8;
int numberOfPermeters = 4;
float[] drive = new float[numOfDIVs*numberOfPermeters];

void drive() {
  float paperWidth = 10;
  float paperHeight = 20;

  drive[0] = 1;
  drive[1] = 1;
  drive[2] = 5;
  drive[3] = 2;

  drive[4] = 7;
  drive[5] = 1;
  drive[6] = 2;
  drive[7] = 2;

  drive[8] = 1;
  drive[9] = 4;
  drive[10] = 8;
  drive[11] = 7;

  drive[12] = 1;
  drive[13] = 12;
  drive[14] = 2;
  drive[15] = 2;

  drive[16] = 4;
  drive[17] = 12;
  drive[18] = 2;
  drive[19] = 2;

  drive[20] = 7;
  drive[21] = 12;
  drive[22] = 2;
  drive[23] = 2;

  drive[24] = 1;
  drive[25] = 15;
  drive[26] = 8;
  drive[27] = 2;

  drive[28] = 3;
  drive[29] = 18;
  drive[30] = 4;
  drive[31] = 1;

  //printArray(drive);

  //rectDIV(drive[0], drive[1], drive[2], drive[3]);

  for (int i = 0; i < drive.length; i += 4) {
    rectDIV(
      appWidth * drive[i] / paperWidth,
      appHeight * drive[i+1] / paperHeight,
      appWidth * drive[i+2] / paperWidth,
      appHeight * drive[i+3] / paperHeight
      );
  }
}

void rectDIV(float x, float y, float w, float h) {
  rect(x, y, w, h);
}
