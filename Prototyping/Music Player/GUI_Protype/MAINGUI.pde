// Variables
int mainNumOfEl;
int mainNumOfParm;
float[] mainDrive;
FloatList mainDriveCode;
int mainPaperWidth;
int mainPaperHeight;

// Function
void mainDrive() {
  // Local Variable
  mainNumOfEl = 0; // Automated From Function
  mainNumOfParm = 4; // Permentatly Set to 4
  //mainDrive = new float[mainNumOfEl * mainNumOfParm]; // Automated
  mainDriveCode = new FloatList();
  //float[] driveCode = {
  //  0, 0, 1, 1,
  //  15, 0, 1, 1,
  //  7, 3, 3, 5
  //};
  //float[] driveCode;
  //int musicPlayerDivNum = 1;

  // DIV Code
  mainPaperWidth = 16;
  mainPaperHeight = 9;

  mainDriveDIVAdd(0, 0, 1, 1);
  mainDriveDIVAdd(15, 0, 1, 1);
  mainDriveDIVAdd(7, 3, 3, 5);
  //mainDriveDIVAdd(0.25, 0.25, 0.75, 8.75);


  // Calculution
  mainNumOfEl = mainDriveCode.size() / 4;
  mainDrive = new float[mainNumOfEl * mainNumOfParm];
  float[] driveCode = new float[mainNumOfEl * mainNumOfParm];
  for (int i = 0; i < mainDriveCode.size(); i += 1) {
    driveCode[i] = mainDriveCode.get(i);
  }

  for (int i = 0; i < (mainNumOfEl * mainNumOfParm); i += 4) {
    mainDrive[i + 0] = poly((float)appWidth  / (float)mainPaperWidth, driveCode[i + 0]);
    mainDrive[i + 1] = poly((float)appHeight / (float)mainPaperHeight, driveCode[i + 1]);
    mainDrive[i + 2] = poly((float)appWidth  / (float)mainPaperWidth, driveCode[i + 2]);
    mainDrive[i + 3] = poly((float)appHeight / (float)mainPaperHeight, driveCode[i + 3]);
  }

  // Action
  for (int i = 0; i < (mainNumOfEl * mainNumOfParm); i += 4) {
    rect(
      mainDrive[i + 0],
      mainDrive[i + 1],
      mainDrive[i + 2],
      mainDrive[i + 3]);
  }

  // Functions
  float[] musicPlayerDriveDIV = mainDriveDIVGet(2); // The mainDriveDIVGet(1) function will decide which DIV is best for musicPlayerApp
  musicPlayerDrive(
    musicPlayerDriveDIV[0],
    musicPlayerDriveDIV[1],
    musicPlayerDriveDIV[2],
    musicPlayerDriveDIV[3]);

  // This is for testing the mainDriveDIVGet
  //catchError("Test Var Fun", mainDriveDIVGet(1)[0]);
  //catchError("Test Var Fun", mainDriveDIVGet(1)[1]);
  //catchError("Test Var Fun", mainDriveDIVGet(1)[2]);
  //catchError("Test Var Fun", mainDriveDIVGet(1)[3]);

  // This is older Version which is switched by float [] something.
  //musicPlayerDrive(
  //  mainDrive[musicPlayerDivNum * 4 + 0],
  //  mainDrive[musicPlayerDivNum * 4 + 1],
  //  mainDrive[musicPlayerDivNum * 4 + 2],
  //  mainDrive[musicPlayerDivNum * 4 + 3]);
}

void mainDriveDIVAdd(float x, float y, float w, float h) {
  mainDriveCode.push(x);
  mainDriveCode.push(y);
  mainDriveCode.push(w);
  mainDriveCode.push(h);
}

float[] mainDriveDIVGet(int i) {
  float[] result = new float[4];
  result[0] = mainDrive[i * 4 + 0];
  result[1] = mainDrive[i * 4 + 1];
  result[2] = mainDrive[i * 4 + 2];
  result[3] = mainDrive[i * 4 + 3];
  return result;
}
