//Global Variables
int numOfDIVs = 2;
int numberOfPermeters = 4;
float[] drive = new float[numOfDIVs*numberOfPermeters];

void drive() {
  float paperWidth = 100;
  float paperHeight = 100; 
  
  drive[0] = appWidth * 70 / paperWidth;
  drive[1] = appHeight * 54 / paperHeight;
  drive[2] = appWidth * 134 / paperWidth;
  drive[3] = appHeight * 182 / paperHeight;
  
  drive[4] = appWidth * 70 / paperWidth;
  drive[5] = appHeight * 54 / paperHeight;
  drive[6] = appWidth * 100 / paperWidth;
  drive[7] = appHeight * 100 / paperHeight;
  
  //printArray(drive);
  
  //rectDIV(drive[0], drive[1], drive[2], drive[3]);
  
  for(int i = 0; i < drive.length; i += 4) {
     rect(drive[i], drive[i+1], drive[i+2], drive[i+3]);
  }
}

void rectDIV(float x, float y, float w, float h) {
 rect(x, y, w, h); 
}
