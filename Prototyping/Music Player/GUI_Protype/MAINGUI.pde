// Variables
int mainNumOfEl;
int mainNumOfParm;
float[] mainDrive;
FloatList mainDriveCode;
int mainPaperWidth;
int mainPaperHeight;

// Function
void mainDrive() {
  mainNumOfEl = 0; 
  mainNumOfParm = 4; 
  mainDriveCode = new FloatList();

  mainPaperWidth = 16;
  mainPaperHeight = 9;

  mainDriveDIVAdd(0, 0, 1, 1);     // Top Left: Open/Close Toggle
  mainDriveDIVAdd(15, 0, 1, 1);    // Top Right: Exit Entire App
  mainDriveDIVAdd(6, 2, 4, 6);     // Middle Box: Initial bounds for Music Player App (Adjusted to look like a phone)

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
}

void mainGUIUpdate() {
  // Draw Top Left Button (Toggle Player)
  fill(isMusicPlayerOpen ? #66cc66 : #cc6666);
  rect(mainDrive[0], mainDrive[1], mainDrive[2], mainDrive[3]);
  drawText(mainDrive[0], mainDrive[1], mainDrive[2], mainDrive[3], "GUI");

  // Draw Top Right Button (Exit App)
  fill(#cc3333);
  rect(mainDrive[4], mainDrive[5], mainDrive[6], mainDrive[7]);
  drawText(mainDrive[4], mainDrive[5], mainDrive[6], mainDrive[7], "EXIT");
}

void mainGUIMousePressed() {
  // Top Left Open/Close
  if (mouseX >= mainDrive[0] && mouseX <= mainDrive[0]+mainDrive[2] && mouseY >= mainDrive[1] && mouseY <= mainDrive[1]+mainDrive[3]) {
    isMusicPlayerOpen = !isMusicPlayerOpen;
  }
  // Top Right Exit
  if (mouseX >= mainDrive[4] && mouseX <= mainDrive[4]+mainDrive[6] && mouseY >= mainDrive[5] && mouseY <= mainDrive[5]+mainDrive[7]) {
    exit();
  }
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
