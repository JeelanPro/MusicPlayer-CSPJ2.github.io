// Variables
int musicPlayerNumOfEl;
int musicPlayerNumOfParm;
float[] musicPlayerDrive;
FloatList musicPlayerDriveCode;
int musicPlayerPaperWidth;
int musicPlayerPaperHeight;

// Function
void musicPlayerDrive(float x, float y, float w, float h) {
  musicPlayerNumOfEl = 0;
  musicPlayerNumOfParm = 4;
  musicPlayerDriveCode = new FloatList();

  musicPlayerPaperWidth = 10;
  musicPlayerPaperHeight = 20;

  musicPlayerDriveDIVAdd(1, 1, 6, 2); // 0: Title Bar (Draggable Zone)
  musicPlayerDriveDIVAdd(7, 1, 2, 2); // 1: Close Button (Inner App)
  musicPlayerDriveDIVAdd(1, 4, 8, 7); // 2: Image Box
  musicPlayerDriveDIVAdd(1, 12, 8, 1); // 3: Progress Bar
  musicPlayerDriveDIVAdd(1, 14, 2, 2); // 4: Button 1 (Left)
  musicPlayerDriveDIVAdd(4, 14, 2, 2); // 5: Button 2 (Mid)
  musicPlayerDriveDIVAdd(7, 14, 2, 2); // 6: Button 3 (Right)
  musicPlayerDriveDIVAdd(3, 18, 4, 1); // 7: Bottom Bar

  musicPlayerNumOfEl = musicPlayerDriveCode.size() / 4;
  musicPlayerDrive = new float[musicPlayerNumOfEl * musicPlayerNumOfParm];

  float finalX = x + dragOffsetX;
  float finalY = y + dragOffsetY;

  for (int i = 0; i < musicPlayerNumOfEl; i++) {
    musicPlayerDrive[i * 4 + 0] = w / musicPlayerPaperWidth  * musicPlayerDriveCode.get(i * 4 + 0) + finalX;
    musicPlayerDrive[i * 4 + 1] = h / musicPlayerPaperHeight * musicPlayerDriveCode.get(i * 4 + 1) + finalY;
    musicPlayerDrive[i * 4 + 2] = w / musicPlayerPaperWidth  * musicPlayerDriveCode.get(i * 4 + 2);
    musicPlayerDrive[i * 4 + 3] = h / musicPlayerPaperHeight * musicPlayerDriveCode.get(i * 4 + 3);
  }

  // Draw Background Window
  fill(#333333); stroke(0); strokeWeight(2);
  rect(finalX, finalY, w, h);

  // Draw App Elements backgrounds and hover effects
  for (int i = 0; i < musicPlayerNumOfEl; i++) {
    fill(255);
    if (musicPlayerDriveDIVMatch(i, mouseX, mouseY)) fill(200);
    rect(musicPlayerDrive[i*4+0], musicPlayerDrive[i*4+1], musicPlayerDrive[i*4+2], musicPlayerDrive[i*4+3]);
  }

  // 0: Title
  String titleText = (playListMetaData[currentAudio] != null) ? playListMetaData[currentAudio].title() : "Loading...";
  drawText(musicPlayerDrive[0], musicPlayerDrive[1], musicPlayerDrive[2], musicPlayerDrive[3], titleText);

  // 1: Close Button
  drawText(musicPlayerDrive[4], musicPlayerDrive[5], musicPlayerDrive[6], musicPlayerDrive[7], "X", #FF0000);

  // 2: Image Box
  if (audioImageList[currentAudio] != null) {
    image(audioImageList[currentAudio], musicPlayerDrive[8], musicPlayerDrive[9], musicPlayerDrive[10], musicPlayerDrive[11]);
  }

  // 3: Progress Bar
  if (playList[currentAudio] != null) {
    float progress = (float)playList[currentAudio].position() / playList[currentAudio].length();
    fill(#007AFF); noStroke();
    rect(musicPlayerDrive[12], musicPlayerDrive[13], musicPlayerDrive[14] * progress, musicPlayerDrive[15]);
  }

  // Determine Icons based on UI State Click Logic
  String leftIcon = "PREV", midIcon = "PLAY", rightIcon = "NEXT";
  if (playList[currentAudio] != null && playList[currentAudio].isPlaying()) midIcon = "PAUSE";

  if (uiState == 1) { leftIcon = "FR"; midIcon = "STOP"; rightIcon = "FF"; } 
  else if (uiState == 2) { leftIcon = "LOOP_ONCE"; midIcon = "PLAY"; rightIcon = "MUTE"; } 
  else if (uiState == 3) { leftIcon = "PREV"; midIcon = "SHUFFLE"; rightIcon = "NEXT"; }

  // Draw the custom geometry icons!
  drawCustomIcon(leftIcon, musicPlayerDrive[16], musicPlayerDrive[17], musicPlayerDrive[18], musicPlayerDrive[19]);
  drawCustomIcon(midIcon, musicPlayerDrive[20], musicPlayerDrive[21], musicPlayerDrive[22], musicPlayerDrive[23]);
  drawCustomIcon(rightIcon, musicPlayerDrive[24], musicPlayerDrive[25], musicPlayerDrive[26], musicPlayerDrive[27]);
}

void musicPlayerMousePressed() {
  if (musicPlayerDriveDIVMatch(0, mouseX, mouseY)) {
    draggingMP = true; // Drag from Title Bar
  } 
  else if (musicPlayerDriveDIVMatch(1, mouseX, mouseY)) {
    isMusicPlayerOpen = false; // Close button pressed
  } 
  else if (musicPlayerDriveDIVMatch(4, mouseX, mouseY)) {
    // Left Button
    if (uiState == 0) audioPrev();
    else if (uiState == 1) audioFR();
    else if (uiState == 2) audioLoopToggle();
    else if (uiState == 3) audioPrev();
    uiStateResetTime = millis() + 2000;
  } 
  else if (musicPlayerDriveDIVMatch(5, mouseX, mouseY)) {
    // Mid Button - Master Multi-Click Controller
    if (millis() - lastClickTime < 500) clickCount++;
    else clickCount = 1;

    lastClickTime = millis();
    uiStateResetTime = millis() + 2000;

    if (clickCount == 1) {
      uiState = 0;
      audioTogglePlay();
    } else if (clickCount == 2) {
      uiState = 1;
      audioStop(); // Double click acts as stop
    } else if (clickCount == 3) {
      uiState = 2; // Sets Layout, center doesn't fire immediately
    } else if (clickCount >= 5) {
      uiState = 3;
      audioShuffle();
      clickCount = 5; // Cap it
    }
  } 
  else if (musicPlayerDriveDIVMatch(6, mouseX, mouseY)) {
    // Right Button
    if (uiState == 0) audioNext();
    else if (uiState == 1) audioFF();
    else if (uiState == 2) audioMuteToggle();
    else if (uiState == 3) audioNext();
    uiStateResetTime = millis() + 2000;
  }
}

void checkUIReset() {
  if (uiState != 0 && millis() > uiStateResetTime) {
    uiState = 0;
    clickCount = 0;
  }
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
  return (mx >= cord[0] && mx <= cord[0]+cord[2] && my >= cord[1] && my <= cord[1]+cord[3]);
}

// Procedural Shape Drawer representing your old static coordinates!
void drawCustomIcon(String type, float bx, float by, float bw, float bh) {
  pushMatrix();
  translate(bx, by);
  fill(#2B2B2B); stroke(#2B2B2B); strokeWeight(2);
  
  float side = min(bw, bh) * 0.8;
  float ox = (bw - side) / 2;
  float oy = (bh - side) / 2;
  
  if (type.equals("PLAY")) {
    triangle(ox + side*0.25, oy + side*0.25, ox + side*0.25, oy + side*0.75, ox + side*0.75, oy + side*0.5);
  } else if (type.equals("PAUSE")) {
    rect(ox + side*0.25, oy + side*0.25, side*0.15, side*0.5);
    rect(ox + side*0.6, oy + side*0.25, side*0.15, side*0.5);
  } else if (type.equals("STOP")) {
    rect(ox + side*0.25, oy + side*0.25, side*0.5, side*0.5);
  } else if (type.equals("NEXT")) {
    rect(ox + side*0.65, oy + side*0.25, side*0.15, side*0.5);
    triangle(ox + side*0.25, oy + side*0.25, ox + side*0.6, oy + side*0.5, ox + side*0.25, oy + side*0.75);
  } else if (type.equals("PREV")) {
    rect(ox + side*0.2, oy + side*0.25, side*0.15, side*0.5);
    triangle(ox + side*0.75, oy + side*0.25, ox + side*0.75, oy + side*0.75, ox + side*0.4, oy + side*0.5);
  } else if (type.equals("FF")) {
    triangle(ox + side*0.15, oy + side*0.25, ox + side*0.5, oy + side*0.5, ox + side*0.15, oy + side*0.75);
    triangle(ox + side*0.5, oy + side*0.25, ox + side*0.85, oy + side*0.5, ox + side*0.5, oy + side*0.75);
  } else if (type.equals("FR")) {
    triangle(ox + side*0.85, oy + side*0.25, ox + side*0.85, oy + side*0.75, ox + side*0.5, oy + side*0.5);
    triangle(ox + side*0.5, oy + side*0.25, ox + side*0.5, oy + side*0.75, ox + side*0.15, oy + side*0.5);
  } else if (type.equals("LOOP_ONCE")) {
    noFill(); stroke(#2B2B2B); strokeWeight(max(1, side*0.05));
    arc(ox + side*0.5, oy + side*0.5, side*0.6, side*0.6, QUARTER_PI, TWO_PI - HALF_PI);
    fill(#2B2B2B); noStroke();
    float tx = ox + side*0.5 + cos(TWO_PI - HALF_PI)*side*0.3;
    float ty = oy + side*0.5 + sin(TWO_PI - HALF_PI)*side*0.3;
    triangle(tx, ty, tx-side*0.1, ty+side*0.1, tx+side*0.1, ty+side*0.1);
    textAlign(CENTER, CENTER); textSize(side*0.4); text("1", ox+side*0.5, oy+side*0.5);
  } else if (type.equals("MUTE")) {
    fill(#2B2B2B); noStroke();
    rect(ox + side*0.2, oy + side*0.35, side*0.2, side*0.3);
    triangle(ox + side*0.4, oy + side*0.35, ox + side*0.4, oy + side*0.65, ox + side*0.7, oy + side*0.5);
    stroke(255, 0, 0); strokeWeight(max(1, side*0.1));
    line(ox + side*0.2, oy + side*0.2, ox + side*0.8, oy + side*0.8);
  } else if (type.equals("SHUFFLE")) {
    stroke(#2B2B2B); strokeWeight(max(1, side*0.05));
    line(ox + side*0.2, oy + side*0.2, ox + side*0.8, oy + side*0.8);
    line(ox + side*0.2, oy + side*0.8, ox + side*0.8, oy + side*0.2);
    line(ox + side*0.8, oy + side*0.8, ox + side*0.6, oy + side*0.8);
    line(ox + side*0.8, oy + side*0.8, ox + side*0.8, oy + side*0.6);
    line(ox + side*0.8, oy + side*0.2, ox + side*0.6, oy + side*0.2);
    line(ox + side*0.8, oy + side*0.2, ox + side*0.8, oy + side*0.4);
  }
  popMatrix();
}
