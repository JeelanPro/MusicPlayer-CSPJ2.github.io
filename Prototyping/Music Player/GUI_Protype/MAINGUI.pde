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
  mainDriveDIVAdd(6, 1.5, 4, 6.5); // Middle Box: Music Player App initial bounds

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
  // Applying the 1/4, 1/4, 3/4, 3/4 layout math requested
  
  // 1. Top Left Button (Toggle Player)
  float tlX = mainDrive[0] + (mainDrive[2] * 0.25);
  float tlY = mainDrive[1] + (mainDrive[3] * 0.25);
  float tlW = mainDrive[2] * 0.75;
  float tlH = mainDrive[3] * 0.75;
  
  fill(isMusicPlayerOpen ? #66cc66 : #cc6666);
  rect(tlX, tlY, tlW, tlH, buttonCornerRadius);
  drawText(tlX, tlY, tlW, tlH, "GUI");

  // 2. Top Right Button (Exit App)
  float trX = mainDrive[4] + (mainDrive[6] * 0.25);
  float trY = mainDrive[5] + (mainDrive[7] * 0.25);
  float trW = mainDrive[6] * 0.75;
  float trH = mainDrive[7] * 0.75;
  
  fill(#cc3333);
  rect(trX, trY, trW, trH, buttonCornerRadius);
  drawText(trX, trY, trW, trH, "EXIT");
}

void mainGUIMousePressed() {
  // Check Top Left bounds based on new 1/4 layout
  float tlX = mainDrive[0] + (mainDrive[2] * 0.25);
  float tlY = mainDrive[1] + (mainDrive[3] * 0.25);
  float tlW = mainDrive[2] * 0.75;
  float tlH = mainDrive[3] * 0.75;
  if (mouseX >= tlX && mouseX <= tlX + tlW && mouseY >= tlY && mouseY <= tlY + tlH) {
    isMusicPlayerOpen = !isMusicPlayerOpen;
  }
  
  // Check Top Right bounds based on new 1/4 layout
  float trX = mainDrive[4] + (mainDrive[6] * 0.25);
  float trY = mainDrive[5] + (mainDrive[7] * 0.25);
  float trW = mainDrive[6] * 0.75;
  float trH = mainDrive[7] * 0.75;
  if (mouseX >= trX && mouseX <= trX + trW && mouseY >= trY && mouseY <= trY + trH) {
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
