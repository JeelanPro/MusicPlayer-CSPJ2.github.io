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
    0, 0, 1, 1,       // 0: Corner
    1, 1, 5, 2,       // 1: Title
    7, 1, 2, 2,       // 2: Corner
    1, 4, 8, 7,       // 3: Album Art Area (Used for Next)
    1, 12, 2, 2,      // 4: Left Button (Used for Pause)
    4, 12, 2, 2,      // 5: Center Button (Used for Prev)
    7, 12, 2, 2,      // 6: Right Button
    1, 15, 8, 2,      // 7: Bar
    3, 18, 4, 1       // 8: Bottom
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
    fill(255); // White background for buttons
    rect(
      musicPlayerDrive[i + 0],
      musicPlayerDrive[i + 1],
      musicPlayerDrive[i + 2],
      musicPlayerDrive[i + 3]);
  }
  
  // Draw Text Title
  drawText(
    musicPlayerDrive[txtDiv * 4 + 0],
    musicPlayerDrive[txtDiv * 4 + 1],
    musicPlayerDrive[txtDiv * 4 + 2],
    musicPlayerDrive[txtDiv * 4 + 3],
    "J_PAP"
  );
  
  // Draw Shapes (Buttons)
  // Index 4: Pause
  // Index 3: Next
  // Index 5: Previous
  drawMusicControlShapes(musicPlayerDrive, 5, 6, 4);
}

void drawMusicControlShapes(float[] drive, int pauseIdx, int nextIdx, int prevIdx) {
  fill(0); // Black color for icons
  
  // 1. Pause Shape (Block 4)
  float pX = drive[pauseIdx * 4 + 0];
  float pY = drive[pauseIdx * 4 + 1];
  float pW = drive[pauseIdx * 4 + 2];
  float pH = drive[pauseIdx * 4 + 3];
  
  rect(pX + pW*0.25, pY + pH*0.25, pW*0.15, pH*0.5); // Left bar
  rect(pX + pW*0.60, pY + pH*0.25, pW*0.15, pH*0.5); // Right bar
  
  // 2. Next Shape (Block 3) - Triangle pointing Right
  float nX = drive[nextIdx * 4 + 0];
  float nY = drive[nextIdx * 4 + 1];
  float nW = drive[nextIdx * 4 + 2];
  float nH = drive[nextIdx * 4 + 3];
  
  triangle(
    nX + nW*0.4, nY + nH*0.35,  // Top Left
    nX + nW*0.4, nY + nH*0.65,  // Bottom Left
    nX + nW*0.7, nY + nH*0.5    // Right Point
  );

  // 3. Previous Shape (Block 5) - Triangle pointing Left
  float vX = drive[prevIdx * 4 + 0];
  float vY = drive[prevIdx * 4 + 1];
  float vW = drive[prevIdx * 4 + 2];
  float vH = drive[prevIdx * 4 + 3];
  
  triangle(
    vX + vW*0.7, vY + vH*0.25,  // Top Right
    vX + vW*0.7, vY + vH*0.75,  // Bottom Right
    vX + vW*0.3, vY + vH*0.5    // Left Point
  );
  
  fill(255); // Reset fill to white
}

void drawText(float x, float y, float w, float h, String txt) {
  drawText(x, y, w, h, txt, #000000, #FFFFFF, "Arial");
}

void drawText(float x, float y, float w, float h, String txt, color txtC) {
  drawText(x, y, w, h, txt, txtC, #FFFFFF, "Arial");
}

void drawText(float x, float y, float w, float h, String txt, color txtC, String fontStyle) {
  drawText(x, y, w, h, txt, txtC, #FFFFFF, fontStyle);
}

void drawText(float x, float y, float w, float h, String txt, String fontStyle) {
  drawText(x, y, w, h, txt, #000000, #FFFFFF, fontStyle);
}

void drawText(float x, float y, float w, float h, String txt, color txtC, color whiteC, String fontStyle) {
  float textX = x;
  float textY = y;
  float textWidth = w;
  float textHeight = h;
  
  String text = txt;
  if (text == null || text.isEmpty()) {
    text = "Error: text Not Found";
    println("Error: text Not Found");
  }
  color textTextColor = txtC;
  PFont textTextStyle = createFont (fontStyle, 55);
  
  color textTextWhiteColor = whiteC;
  float textTextSize = textHeight;
  float textTextAspectRatio = textTextSize / textHeight;
  textTextSize = textHeight * textTextAspectRatio;
  
  textAlign(CENTER, CENTER);
  textFont(textTextStyle, textTextSize);
  while (textWidth < textWidth(text)) {
    textTextSize *= 0.99;
    textFont(textTextStyle, textTextSize);
  }

  // Draw background rect again to ensure clean text background if needed, 
  // or just rely on the main loop's rect.
  // fill(whiteC); 
  // rect(textX, textY, textWidth, textHeight);
  
  fill(textTextColor);
  text(text, textX, textY, textWidth, textHeight);
  fill(textTextWhiteColor); // Reset fill
  
  fill(0); // Reset to black for lines
}
