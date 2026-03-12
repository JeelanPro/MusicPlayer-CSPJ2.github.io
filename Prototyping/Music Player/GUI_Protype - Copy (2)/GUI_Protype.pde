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
