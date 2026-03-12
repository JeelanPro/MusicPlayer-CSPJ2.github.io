// Variables
int musicPlayerNumOfEl;
int musicPlayerNumOfParm;
float[] musicPlayerDrive;
int musicPlayerPaperWidth;
int musicPlayerPaperHeight;

// Function
void musicPlayerDrive(float x, float y, float w, float h) {
  // Local Variables
  musicPlayerNumOfEl = 9;
  musicPlayerNumOfParm = 4;
  musicPlayerDrive = new float[musicPlayerNumOfEl * musicPlayerNumOfParm];
  musicPlayerPaperWidth = 10;
  musicPlayerPaperHeight = 20;
  float[] driveCode = {
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
  int txtDiv = 1;

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
  
  drawText(
    musicPlayerDrive[txtDiv * 4 + 0],
    musicPlayerDrive[txtDiv * 4 + 1],
    musicPlayerDrive[txtDiv * 4 + 2],
    musicPlayerDrive[txtDiv * 4 + 3],
    "J_PAP"
  );
}
