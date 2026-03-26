/*
The Image Aspect ratio is in 2: Image Box with image with aspect Ratio. line number 73.
The Music Player ICON is line number 193
*/
// Variables for audio app
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

  // my virtual grid thingy
  musicPlayerPaperWidth = 10;
  musicPlayerPaperHeight = 20;

  // Grid system (groups of 4 for the DIVS[])
  musicPlayerDriveDIVAdd(1, 1, 6, 2);  // 0: Title Bar (Draggable Zone)
  musicPlayerDriveDIVAdd(7, 1, 2, 2);  // 1: Close Button (Inner App)
  musicPlayerDriveDIVAdd(1, 4, 8, 7);  // 2: Image Box
  musicPlayerDriveDIVAdd(1, 12, 8, 1); // 3: Progress Bar
  musicPlayerDriveDIVAdd(1, 14, 2, 2); // 4: Button 1 (Left)
  musicPlayerDriveDIVAdd(4, 14, 2, 2); // 5: Button 2 (Mid)
  musicPlayerDriveDIVAdd(7, 14, 2, 2); // 6: Button 3 (Right)
  musicPlayerDriveDIVAdd(3, 18, 4, 1); // 7: Bottom Bar

  musicPlayerNumOfEl = musicPlayerDriveCode.size() / 4;
  musicPlayerDrive = new float[musicPlayerNumOfEl * musicPlayerNumOfParm];

  // adding the drag offset so the whole thing moves together!
  float finalX = x + dragOffsetX;
  float finalY = y + dragOffsetY;

  // calcultions for positioning
  for (int i = 0; i < musicPlayerNumOfEl; i++) {
    musicPlayerDrive[i * 4 + 0] = w / musicPlayerPaperWidth  * musicPlayerDriveCode.get(i * 4 + 0) + finalX;
    musicPlayerDrive[i * 4 + 1] = h / musicPlayerPaperHeight * musicPlayerDriveCode.get(i * 4 + 1) + finalY;
    musicPlayerDrive[i * 4 + 2] = w / musicPlayerPaperWidth  * musicPlayerDriveCode.get(i * 4 + 2);
    musicPlayerDrive[i * 4 + 3] = h / musicPlayerPaperHeight * musicPlayerDriveCode.get(i * 4 + 3);
  }

  // Draw Main App Background with rounded corners
  fill(#333333); stroke(0); strokeWeight(2);
  rect(finalX, finalY, w, h, appCornerRadius);
  noStroke();

  // Draw App Elements backgrounds and check if hovered
  for (int i = 0; i < musicPlayerNumOfEl; i++) {
    fill(255);
    // kinda check if mouse is over to light up the button
    if (musicPlayerDriveDIVMatch(i, mouseX, mouseY)) {
      if (i != 2 && i != 3) { // dont highlight image or progress bar
        fill(200);
        isHoveringSomething = true; // tell main tab to show hand cursor!
      }
    }
    rect(musicPlayerDrive[i*4+0], musicPlayerDrive[i*4+1], musicPlayerDrive[i*4+2], musicPlayerDrive[i*4+3], buttonCornerRadius);
  }

  // 0: Title
  String titleText = (playListMetaData[currentAudio] != null) ? playListMetaData[currentAudio].title() : "Loading...";
  drawText(musicPlayerDrive[0], musicPlayerDrive[1], musicPlayerDrive[2], musicPlayerDrive[3], titleText);

  // 1: Close Button
  drawText(musicPlayerDrive[4], musicPlayerDrive[5], musicPlayerDrive[6], musicPlayerDrive[7], "X", #FF0000);

  // 2: Image Box with image with aspect Ratio.
  if (audioImageList[currentAudio] != null) {
    PImage img = audioImageList[currentAudio];
    float imgW = img.width;
    float imgH = img.height;
    float boxW = musicPlayerDrive[10];
    float boxH = musicPlayerDrive[11];
    
    // tring to calculate aspect ratio so it doesnt stretch
    float imgAspectRatio = (imgW >= imgH) ? imgW / imgH : imgH / imgW;
    boolean isLandscape = (imgW >= imgH) ? true : false;
    
    float finalImgW = 0;
    float finalImgH = 0;
    
    // figure out which side hits the box border first
    if (isLandscape) {
      finalImgW = boxW;
      finalImgH = (imgW >= boxW) ? finalImgW / imgAspectRatio : finalImgW * imgAspectRatio;
      if (finalImgH > boxH) { // if it still doesnt fit, swap logic
        finalImgH = boxH;
        finalImgW = finalImgH * imgAspectRatio;
      }
    } else {
      finalImgH = boxH;
      finalImgW = (imgH >= boxH) ? finalImgH / imgAspectRatio : finalImgH * imgAspectRatio;
      if (finalImgW > boxW) {
        finalImgW = boxW;
        finalImgH = finalImgW * imgAspectRatio;
      }
    }
    
    // center it in the rect
    float imgX = musicPlayerDrive[8] + (boxW - finalImgW) / 2.0;
    float imgY = musicPlayerDrive[9] + (boxH - finalImgH) / 2.0;
    
    image(img, imgX, imgY, finalImgW, finalImgH);
  }

  // 3: Progress Bar
  if (playList[currentAudio] != null) {
    float progress = (float)playList[currentAudio].position() / playList[currentAudio].length();
    fill(#007AFF); noStroke();
    rect(musicPlayerDrive[12], musicPlayerDrive[13], musicPlayerDrive[14] * progress, musicPlayerDrive[15], buttonCornerRadius);
  }

  // Determine Icons based on UI State Click Logic
  String leftIcon = "PREV", midIcon = "PLAY", rightIcon = "NEXT";
  if (playList[currentAudio] != null && playList[currentAudio].isPlaying()) midIcon = "PAUSE";

  if (uiState == 1) { leftIcon = "FR"; midIcon = "STOP"; rightIcon = "FF"; } 
  else if (uiState == 2) { leftIcon = "LOOP_ONCE"; midIcon = "PLAY"; rightIcon = "MUTE"; } 
  else if (uiState == 3) { leftIcon = "PREV"; midIcon = "SHUFFLE"; rightIcon = "NEXT"; }

  // Draw the custom geometry icons using the simplified CS10 approach!
  drawCustomIcon(leftIcon, musicPlayerDrive[16], musicPlayerDrive[17], musicPlayerDrive[18], musicPlayerDrive[19]);
  drawCustomIcon(midIcon, musicPlayerDrive[20], musicPlayerDrive[21], musicPlayerDrive[22], musicPlayerDrive[23]);
  drawCustomIcon(rightIcon, musicPlayerDrive[24], musicPlayerDrive[25], musicPlayerDrive[26], musicPlayerDrive[27]);
}

void musicPlayerMousePressed() {
  if (musicPlayerDriveDIVMatch(0, mouseX, mouseY)) {
    draggingMP = true; // Drag from Title Bar!
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
      if (uiState == 2) { 
         uiState = 3; 
      } else {
         uiState = 1;
         audioStop(); 
      }
    } else if (clickCount == 3) {
      uiState = 2; 
    } else if (clickCount >= 5) {
      uiState = 3;
      audioShuffle();
      clickCount = 5; 
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
  // Revert UI to default after 2 seconds of no clicking
  if (uiState != 0 && millis() > uiStateResetTime) {
    uiState = 0;
    clickCount = 0;
  }
}

// -------------------------------------------------------------
// Music Player ICON
// -------------------------------------------------------------
void drawCustomIcon(String type, float rectX, float rectY, float rectW, float rectH) {
  // 1. Calculate a perfect, centered square box so shapes don't stretch
  float boxSide = (rectW < rectH) ? rectW : rectH;
  boxSide = boxSide * 0.5; // Scale the icon to 50%
  
  float boxX = rectX + (rectW - boxSide) / 2.0;
  float boxY = rectY + (rectH - boxSide) / 2.0;

  fill(#2B2B2B); 
  noStroke();

  // drawing the cool math shapes... 
  if (type.equals("PLAY")) {
    triangle(
      boxX + (boxSide/4 * 1), boxY + (boxSide/4 * 1),
      boxX + (boxSide/4 * 1), boxY + (boxSide/4 * 3),
      boxX + (boxSide/4 * 3), boxY + (boxSide/4 * 2)
    );
  } 
  else if (type.equals("PAUSE")) {
    rect(boxX + (boxSide/8 * 2), boxY + (boxSide/8 * 2), boxSide/8 * 1.5, boxSide/8 * 4);
    rect(boxX + (boxSide/8 * 5), boxY + (boxSide/8 * 2), boxSide/8 * 1.5, boxSide/8 * 4);
  } 
  else if (type.equals("STOP")) {
    rect(boxX + (boxSide/4 * 1), boxY + (boxSide/4 * 1), boxSide/4 * 2, boxSide/4 * 2);
  } 
  else if (type.equals("NEXT")) {
    rect(boxX + (boxSide/8 * 5.5), boxY + (boxSide/4 * 1), boxSide/8 * 1, boxSide/4 * 2);
    triangle(
      boxX + (boxSide/8 * 1.5), boxY + (boxSide/4 * 1),
      boxX + (boxSide/8 * 1.5), boxY + (boxSide/4 * 3),
      boxX + (boxSide/8 * 5), boxY + (boxSide/4 * 2)
    );
  } 
  else if (type.equals("PREV")) {
    rect(boxX + (boxSide/8 * 1.5), boxY + (boxSide/4 * 1), boxSide/8 * 1, boxSide/4 * 2);
    triangle(
      boxX + (boxSide/8 * 6.5), boxY + (boxSide/4 * 1),
      boxX + (boxSide/8 * 6.5), boxY + (boxSide/4 * 3),
      boxX + (boxSide/8 * 3), boxY + (boxSide/4 * 2)
    );
  } 
  else if (type.equals("FF")) {
    triangle(
      boxX + (boxSide/8 * 1), boxY + (boxSide/4 * 1),
      boxX + (boxSide/8 * 1), boxY + (boxSide/4 * 3),
      boxX + (boxSide/8 * 4), boxY + (boxSide/4 * 2)
    );
    triangle(
      boxX + (boxSide/8 * 4), boxY + (boxSide/4 * 1),
      boxX + (boxSide/8 * 4), boxY + (boxSide/4 * 3),
      boxX + (boxSide/8 * 7), boxY + (boxSide/4 * 2)
    );
  } 
  else if (type.equals("FR")) {
    triangle(
      boxX + (boxSide/8 * 7), boxY + (boxSide/4 * 1),
      boxX + (boxSide/8 * 7), boxY + (boxSide/4 * 3),
      boxX + (boxSide/8 * 4), boxY + (boxSide/4 * 2)
    );
    triangle(
      boxX + (boxSide/8 * 4), boxY + (boxSide/4 * 1),
      boxX + (boxSide/8 * 4), boxY + (boxSide/4 * 3),
      boxX + (boxSide/8 * 1), boxY + (boxSide/4 * 2)
    );
  } 
  else if (type.equals("LOOP_ONCE")) {
    stroke(#2B2B2B); strokeWeight(max(1, boxSide/15)); noFill();
    arc(boxX + (boxSide/2), boxY + (boxSide/2), boxSide*0.8, boxSide*0.8, QUARTER_PI, TWO_PI - HALF_PI);
    fill(#2B2B2B); noStroke();
    triangle(boxX + boxSide*0.6, boxY + boxSide*0.1, boxX + boxSide*0.4, boxY + boxSide*0.1, boxX + boxSide*0.5, boxY - boxSide*0.1);
    textAlign(CENTER, CENTER); textSize(boxSide*0.4); 
    text("1", boxX + (boxSide/2), boxY + (boxSide/2));
  } 
  else if (type.equals("MUTE")) {
    rect(boxX + (boxSide/8 * 2), boxY + (boxSide/8 * 3), boxSide/8 * 2, boxSide/8 * 2);
    triangle(
      boxX + (boxSide/8 * 4), boxY + (boxSide/8 * 3),
      boxX + (boxSide/8 * 4), boxY + (boxSide/8 * 5),
      boxX + (boxSide/8 * 7), boxY + (boxSide/8 * 1)
    );
    stroke(255, 0, 0); strokeWeight(max(1, boxSide/10));
    line(boxX + (boxSide/8 * 1), boxY + (boxSide/8 * 1), boxX + (boxSide/8 * 7), boxY + (boxSide/8 * 7));
  } 
  else if (type.equals("SHUFFLE")) {
    stroke(#2B2B2B); strokeWeight(max(1, boxSide/15));
    line(boxX + (boxSide/4 * 1), boxY + (boxSide/4 * 1), boxX + (boxSide/4 * 3), boxY + (boxSide/4 * 3));
    line(boxX + (boxSide/4 * 1), boxY + (boxSide/4 * 3), boxX + (boxSide/4 * 3), boxY + (boxSide/4 * 1));
  }
}

// Helper arrays
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

// this checks if the mouse is inside the rect... I used >= just in case
boolean musicPlayerDriveDIVMatch(int i, float mx, float my) {
  float[] cord = musicPlayerDriveDIVGet(i);
  return (mx >= cord[0] && mx <= cord[0]+cord[2] && my >= cord[1] && my <= cord[1]+cord[3]);
}
