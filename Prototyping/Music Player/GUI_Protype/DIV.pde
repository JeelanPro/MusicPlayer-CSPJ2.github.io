// Global Variables
int mainNumOfEl = 3;
int mainNumOfParm = 4;
float[] mainDrive = new float[mainNumOfEl * mainNumOfParm];
int mainPaperWidth;
int mainPaperHeight;

int musicPlayerNumOfEl = 8;
int musicPlayerNumOfParm = 4;
float[] musicPlayerDrive = new float[musicPlayerNumOfEl * musicPlayerNumOfParm];
int musicPlayerPaperWidth;
int musicPlayerPaperHeight;

void mainDrive() {
  mainPaperWidth = 16;
  mainPaperHeight = 9;
  int[] driveCode = {
    0, 0, 1, 1,
    15, 0, 1, 1,
    7, 3, 3, 5
  };
  int musicPlayerDivNum = 2;

  for (int i = 0; i < driveCode.length; i += 4) {
    mainDrive[i + 0] = appWidth  / mainPaperWidth  * driveCode[i + 0];
    mainDrive[i + 1] = appHeight / mainPaperHeight * driveCode[i + 1];
    mainDrive[i + 2] = appWidth  / mainPaperWidth  * driveCode[i + 2];
    mainDrive[i + 3] = appHeight / mainPaperHeight * driveCode[i + 3];
  }

  for (int i = 0; i < mainDrive.length; i += 4) {
    rect(
      mainDrive[i + 0],
      mainDrive[i + 1],
      mainDrive[i + 2],
      mainDrive[i + 3]);
  }

  musicPlayerDrive(
    mainDrive[musicPlayerDivNum * 4 + 0],
    mainDrive[musicPlayerDivNum * 4 + 1],
    mainDrive[musicPlayerDivNum * 4 + 2],
    mainDrive[musicPlayerDivNum * 4 + 3]
    );
}

void musicPlayerDrive(float x, float y, float w, float h) {
  musicPlayerPaperWidth = 10;
  musicPlayerPaperHeight = 20;
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

  for (int i = 0; i < driveCode.length; i += 4) {
    musicPlayerDrive[i + 0] = w / musicPlayerPaperWidth  * driveCode[i + 0] + x;
    musicPlayerDrive[i + 1] = h / musicPlayerPaperHeight * driveCode[i + 1] + y;
    musicPlayerDrive[i + 2] = w / musicPlayerPaperWidth  * driveCode[i + 2];
    musicPlayerDrive[i + 3] = h / musicPlayerPaperHeight * driveCode[i + 3];
  }


  for (int i = 0; i < musicPlayerDrive.length; i += 4) {
    rect(
      musicPlayerDrive[i + 0],
      musicPlayerDrive[i + 1],
      musicPlayerDrive[i + 2],
      musicPlayerDrive[i + 3]);
  }
}
