// Variables
int musicPlayerNumOfEl;
int musicPlayerNumOfParm;
float[] musicPlayerDrive;
FloatList musicPlayerDriveCode;
int musicPlayerPaperWidth;
int musicPlayerPaperHeight;

// Function
void musicPlayerDrive(float x, float y, float w, float h) {
  // Local Variables
  musicPlayerNumOfEl = 0; // Automated
  musicPlayerNumOfParm = 4;
  //musicPlayerDrive = new float[musicPlayerNumOfEl * musicPlayerNumOfParm];
  musicPlayerDriveCode = new FloatList();
  //float[] driveCode = {
  //  0, 0, 1, 1,
  //  1, 1, 5, 2,
  //  7, 1, 2, 2,
  //  1, 4, 8, 7,
  //  1, 12, 2, 2,
  //  4, 12, 2, 2,
  //  7, 12, 2, 2,
  //  1, 15, 8, 2,
  //  3, 18, 4, 1
  //};
  //int txtDiv = 1;

  // DIV Code
  musicPlayerPaperWidth = 10;
  musicPlayerPaperHeight = 20;

  musicPlayerDriveDIVAdd(0, 0, 1, 1);
  musicPlayerDriveDIVAdd(1, 1, 5, 2);
  musicPlayerDriveDIVAdd(7, 1, 2, 2);
  musicPlayerDriveDIVAdd(1, 4, 8, 7);
  musicPlayerDriveDIVAdd(1, 12, 2, 2);
  musicPlayerDriveDIVAdd(4, 12, 2, 2);
  musicPlayerDriveDIVAdd(7, 12, 2, 2);
  musicPlayerDriveDIVAdd(1, 15, 8, 2);
  musicPlayerDriveDIVAdd(3, 18, 4, 1);

  // Calculution
  musicPlayerNumOfEl = musicPlayerDriveCode.size() / 4;
  musicPlayerDrive = new float[musicPlayerNumOfEl * musicPlayerNumOfParm];
  float[] driveCode = new float[musicPlayerNumOfEl * musicPlayerNumOfParm];
  for (int i = 0; i < musicPlayerDriveCode.size(); i += 1) {
    driveCode[i] = musicPlayerDriveCode.get(i);
  }

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
    musicPlayerDriveDIVGet(1)[0],
    musicPlayerDriveDIVGet(1)[1],
    musicPlayerDriveDIVGet(1)[2],
    musicPlayerDriveDIVGet(1)[3],
    "J_PAP");

  //drawText(
  //  musicPlayerDrive[txtDiv * 4 + 0],
  //  musicPlayerDrive[txtDiv * 4 + 1],
  //  musicPlayerDrive[txtDiv * 4 + 2],
  //  musicPlayerDrive[txtDiv * 4 + 3],
  //  "J_PAP"
  //  );
}

void musicPlayerDriveDIVAdd(float x, float y, float w, float h) {
  musicPlayerDriveCode.push(x);
  musicPlayerDriveCode.push(y);
  musicPlayerDriveCode.push(w);
  musicPlayerDriveCode.push(h);
}

float[] musicPlayerDriveDIVGet(int i) {
  float[] result = new float[4];
  result[0] = musicPlayerDrive[i * 4 + 0];
  result[1] = musicPlayerDrive[i * 4 + 1];
  result[2] = musicPlayerDrive[i * 4 + 2];
  result[3] = musicPlayerDrive[i * 4 + 3];
  return result;
}

boolean musicPlayerDriveDIVMatch(int i, float mx, float my) {
  float[] cord = musicPlayerDriveDIVGet(i);
  return (
    cord[0] <= mx &&
    cord[1] <= my &&
    cord[2] >= mx &&
    cord[3] >= my
  );
}
