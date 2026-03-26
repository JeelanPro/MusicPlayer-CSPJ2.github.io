
Buttons:
Play
Pause
Stop
FF
FR
Next
Previous
Mute
Shuffle/Loop
Loop: 1, Infinite



Prompt:
Here is my layout:
I have a project called GUI Protype and in that project this is what I have:
And I should have done the below things and the other other things:
Notes: develop DIVS[], ERROR-Checking, & Polynomials as Folumae
- Loading a simple array to be counted through using the rect() function
- Counting in groups of 4
Below are codes:
Also, add comments with some tiny mistake in spelling and it should be like very unconfident but it explain the code better. or follow my comments. and also add lots thing form my old code in this new project.
GUI Protype tab
```
// Libraries
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// Variable
int appWidth, appHeight;

void setup() {
  fullScreen();
  appWidth = displayWidth;
  appHeight = displayHeight;
  
  // Initialize States
  isMusicPlayerOpen = true;
  backgroundColor = #bcbcbc;
  
  catchError();
  setupAudio();
  mainDrive(); // Calculates the main UI layout arrays
}

void draw() {
  background(backgroundColor);
  
  // Draw top buttons
  mainGUIUpdate(); 
  
  // Draw music player if opened
  if (isMusicPlayerOpen) {
    float[] musicPlayerDriveDIV = mainDriveDIVGet(2); 
    musicPlayerDrive(
      musicPlayerDriveDIV[0],
      musicPlayerDriveDIV[1],
      musicPlayerDriveDIV[2],
      musicPlayerDriveDIV[3]
    );
  }
  
  // Revert buttons to default if 2 seconds have passed since last interaction
  checkUIReset(); 
}

void mousePressed() {
  mainGUIMousePressed();
  if (isMusicPlayerOpen) {
    musicPlayerMousePressed();
  }
}

void mouseDragged() {
  if (isMusicPlayerOpen && draggingMP) {
    dragOffsetX += mouseX - pmouseX;
    dragOffsetY += mouseY - pmouseY;
  }
}

void mouseReleased() {
  draggingMP = false;
}

void keyPressed() {
  handleAudioShortcuts();
}
```

AudioApp tab:
```
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

  // Grid system
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

  // Draw Main App Background with rounded corners
  fill(#333333); stroke(0); strokeWeight(2);
  rect(finalX, finalY, w, h, appCornerRadius);

  // Draw App Elements backgrounds and hover effects
  for (int i = 0; i < musicPlayerNumOfEl; i++) {
    fill(255);
    if (musicPlayerDriveDIVMatch(i, mouseX, mouseY)) fill(200);
    rect(musicPlayerDrive[i*4+0], musicPlayerDrive[i*4+1], musicPlayerDrive[i*4+2], musicPlayerDrive[i*4+3], buttonCornerRadius);
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
    uiStateResetTime = millis() + 2000; // Reset timer on ANY click
  } 
  else if (musicPlayerDriveDIVMatch(5, mouseX, mouseY)) {
    // Mid Button - Master Multi-Click Controller
    if (millis() - lastClickTime < 500) clickCount++;
    else clickCount = 1;

    lastClickTime = millis();
    uiStateResetTime = millis() + 2000; // Keep alive while clicking

    if (clickCount == 1) {
      uiState = 0;
      audioTogglePlay();
    } else if (clickCount == 2) {
      if (uiState == 2) { // 3 clicks then 2 clicks -> State 3
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
    uiStateResetTime = millis() + 2000; // Reset timer on ANY click
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
// EASY ICON DRAWER - Using the CS10 fractional logic!
// -------------------------------------------------------------
void drawCustomIcon(String type, float rectX, float rectY, float rectW, float rectH) {
  // 1. Calculate a perfect, centered square box so shapes don't stretch
  float boxSide = (rectW < rectH) ? rectW : rectH;
  boxSide = boxSide * 0.5; // Scale the icon to 50% of the button size
  
  float boxX = rectX + (rectW - boxSide) / 2.0;
  float boxY = rectY + (rectH - boxSide) / 2.0;

  fill(#2B2B2B); 
  noStroke();

  // 2. Draw using extremely simple fractions inside the box (1/4, 2/4, 3/4)
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

boolean musicPlayerDriveDIVMatch(int i, float mx, float my) {
  float[] cord = musicPlayerDriveDIVGet(i);
  return (mx >= cord[0] && mx <= cord[0]+cord[2] && my >= cord[1] && my <= cord[1]+cord[3]);
}
```

AudioSystem tab:
```
// Audio System File containing purely Minim Procedural Logic
Minim minim;
int numberOfAudio = 3;
int currentAudio = 0;

AudioPlayer[] playList;
AudioMetaData[] playListMetaData;
PImage[] audioImageList;

void setupAudio() {
  minim = new Minim(this);
  playList = new AudioPlayer[numberOfAudio];
  playListMetaData = new AudioMetaData[numberOfAudio];
  audioImageList = new PImage[numberOfAudio];
  
  String audioFolder = "Audio/";
  String imageFolder = "Images/";
  
  // Safe Loading
  playList[0] = minim.loadFile(audioFolder + "nuke-alarm.mp3");
  playList[1] = minim.loadFile(audioFolder + "skibidi-toilet.mp3");
  playList[2] = minim.loadFile(audioFolder + "Virus.mp3");

  audioImageList[0] = loadImage(imageFolder + "NuclearBomb.jpg");
  audioImageList[1] = loadImage(imageFolder + "Skibidi.jpg");
  audioImageList[2] = loadImage(imageFolder + "Virus.jpg");

  for (int i = 0; i < numberOfAudio; i++) {
    if (playList[i] != null) {
      playListMetaData[i] = playList[i].getMetaData();
    }
  }
}

// ---- Controller Commands ----
void audioTogglePlay() {
  if (playList[currentAudio] != null) {
    if (playList[currentAudio].isPlaying()) playList[currentAudio].pause();
    else playList[currentAudio].play();
  }
}

void audioStop() {
  if (playList[currentAudio] != null) {
    playList[currentAudio].pause();
    playList[currentAudio].rewind();
  }
}

void audioNext() {
  audioStop();
  currentAudio = (currentAudio + 1) % numberOfAudio;
  if (playList[currentAudio] != null) playList[currentAudio].play();
}

void audioPrev() {
  audioStop();
  currentAudio = (currentAudio - 1 + numberOfAudio) % numberOfAudio;
  if (playList[currentAudio] != null) playList[currentAudio].play();
}

void audioFF() { 
  if (playList[currentAudio] != null) playList[currentAudio].skip(1000); 
}

void audioFR() { 
  if (playList[currentAudio] != null) playList[currentAudio].skip(-1000); 
}

void audioMuteToggle() {
  if (playList[currentAudio] != null) {
    if (playList[currentAudio].isMuted()) playList[currentAudio].unmute();
    else playList[currentAudio].mute();
  }
}

void audioLoopToggle() { 
  if (playList[currentAudio] != null) playList[currentAudio].loop(0); 
}

void audioShuffle() {
  audioStop();
  currentAudio = int(random(numberOfAudio));
  if (playList[currentAudio] != null) playList[currentAudio].play();
}

// Handles physical Key presses using the exact shortcuts from CS10
void handleAudioShortcuts() {
  if (key == 'p' || key == 'P' || key == ' ') audioTogglePlay();
  if (key == 's' || key == 'S') audioStop();
  if (key == 'n' || key == 'N' || keyCode == DOWN) audioNext();
  if (key == 'b' || key == 'B' || keyCode == UP) audioPrev();
  if (key == 'f' || key == 'F' || keyCode == RIGHT) audioFF();
  if (key == 'r' || key == 'R' || keyCode == LEFT) audioFR();
  if (key == 'm' || key == 'M') audioMuteToggle();
  if (key == 'h' || key == 'H') audioShuffle();
  if (key == 'l' || key == 'L') audioLoopToggle();
  if (key == 'q' || key == 'Q' || key == ESC) exit();
}


// Now add border on the top right button as well
```

ErrorCheck tab:
```
// Variables


// Functions
void catchError() {
  println("Welcome to CatchError function");
  println("This function is design for testing and debuging code without ide");
  println("\n\n...\n");
  println("Error: No Variable or Value is provided");
  println("Please Include some Variables or Value to see the result");
  println("\n");
}

void catchError(String text) {
  println(text);
}

void catchError(String text, Boolean variable) {
  println(text);
  println("Value for second Parm is:");
  println(variable);
}

void catchError(String text, int variable) {
  println(text, variable);
  println("Value for second Parm is:");
  println(variable);
}

void catchError(String text, float variable) {
  println(text, variable);
  println("Value for second Parm is:");
  println(variable);
}

void catchError(String text, int var1, float var2) {
  println(text);
  println("Value for second Parm is:");
  println(var1);
  println("Value for third Parm is:");
  println(var2);
}

void catchError(String text, float var1, float var2) {
  println(text);
  println("Value for second Parm is:");
  println(var1);
  println("Value for third Parm is:");
  println(var2);
}

void catchError(String text, float var1, int var2) {
  println(text);
  println("Value for second Parm is:");
  println(var1);
  println("Value for third Parm is:");
  println(var2);
}

void catchError(String name, float[] array) {
  println("\nThe " + name + " are below: ");
  println("=============" + name + "=============");
  printArray(array);
  println("=============" + name + "=============");
}

void catchError(float[] array) {
  println("\nThe result are below: ");
  println("=============" + "list" + "=============");
  printArray(array);
  println("=============" + "list" + "=============");
}
```

MAINGUI tab:
```
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
```

Polynomials tab:
```
// Notes
/*
The poly function is being used in MAINGUI.
*/

// Variables


// Functions
float poly(float a, float x) {
  return (a*x);
}

float poly(float a, float x, float b, float y) {
  return (a*x) + (b*y);
}

float poly(float a, float x, float b, float y, float c, float z) {
  return (a*x) + (b*y) + (c*z);
}

float poly(float a, float b, float c, float d, float e, float f, float x, float y) {
  return (a*x) + (b*x) + (c*x) + (d*y) + (e*y) + (f*y);
}
```

System Variable tab:
```
boolean isMusicPlayerOpen;
color backgroundColor;

// Mult-click and State variables
int uiState = 0; 
int clickCount = 0;
int lastClickTime = 0;
int uiStateResetTime = 0;

// Dragging variables
float dragOffsetX = 0;
float dragOffsetY = 0;
boolean draggingMP = false;

// Universal UI settings
float buttonCornerRadius = 15.0;
float appCornerRadius = 25.0;
```

Text tab:
```
// Variables


// Functions
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

  rect(textX, textY, textWidth, textHeight);
  fill(textTextColor);
  text(text, textX, textY, textWidth, textHeight);
  fill(textTextWhiteColor);

  fill(0);
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
```