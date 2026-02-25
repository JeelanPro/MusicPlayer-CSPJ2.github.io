// Global Variables
int mainNumOfEl;
int mainNumOfParm;
float[] mainDrive;
int mainPaperWidth;
int mainPaperHeight;

int musicPlayerNumOfEl;
int musicPlayerNumOfParm;
float[] musicPlayerDrive;
int musicPlayerPaperWidth;
int musicPlayerPaperHeight;

void mainDrive() {
  // Local Variable
  mainNumOfEl = 3;
  mainNumOfParm = 4;
  mainDrive = new float[mainNumOfEl * mainNumOfParm];
  mainPaperWidth = 16;
  mainPaperHeight = 9;
  int[] driveCode = {
    0, 0, 1, 1,
    15, 0, 1, 1,
    7, 3, 3, 5
  };
  int musicPlayerDivNum = 2;

  // Calculution
  for (int i = 0; i < (mainNumOfEl * mainNumOfParm); i += 4) {
    mainDrive[i + 0] = appWidth  / mainPaperWidth  * driveCode[i + 0];
    mainDrive[i + 1] = appHeight / mainPaperHeight * driveCode[i + 1];
    mainDrive[i + 2] = appWidth  / mainPaperWidth  * driveCode[i + 2];
    mainDrive[i + 3] = appHeight / mainPaperHeight * driveCode[i + 3];
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
  musicPlayerDrive(
    mainDrive[musicPlayerDivNum * 4 + 0],
    mainDrive[musicPlayerDivNum * 4 + 1],
    mainDrive[musicPlayerDivNum * 4 + 2],
    mainDrive[musicPlayerDivNum * 4 + 3]);
}

void musicPlayerDrive(float x, float y, float w, float h) {
  // Local Variables
  musicPlayerNumOfEl = 9;
  musicPlayerNumOfParm = 4;
  musicPlayerDrive = new float[musicPlayerNumOfEl * musicPlayerNumOfParm];
  musicPlayerPaperWidth = 10;
  musicPlayerPaperHeight = 20;
  int[] driveCode = {
    0, 0, 1, 1,
    1, 1, 5, 2,
    7, 1, 2, 2,
    1, 4, 8, 7,
    1, 12, 2, 2,
    4, 12, 2, 2,
    7, 12, 2, 2,
    1, 15, 8, 2,
    3, 18, 4, 1
  };

  // Calculution
  for (int i = 0; i < driveCode.length; i += 4) {
    musicPlayerDrive[i + 0] = w / musicPlayerPaperWidth  * driveCode[i + 0] + x;
    musicPlayerDrive[i + 1] = h / musicPlayerPaperHeight * driveCode[i + 1] + y;
    musicPlayerDrive[i + 2] = w / musicPlayerPaperWidth  * driveCode[i + 2];
    musicPlayerDrive[i + 3] = h / musicPlayerPaperHeight * driveCode[i + 3];
  }

  // Actions
  for (int i = 0; i < musicPlayerDrive.length; i += 4) {
    rect(
      musicPlayerDrive[i + 0],
      musicPlayerDrive[i + 1],
      musicPlayerDrive[i + 2],
      musicPlayerDrive[i + 3]);
  }
}
