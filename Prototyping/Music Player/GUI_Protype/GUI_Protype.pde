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
  
  // Initialize States for the app... hopefully this is right
  isMusicPlayerOpen = true;
  backgroundColor = #bcbcbc;
  
  catchError(); // testing error checker
  setupAudio();
  mainDrive(); // Calculates the main UI layout arrays using my poly functions
}

void draw() {
  background(backgroundColor);
  
  // reset hover state every frame so the cursor doesnt get stuck as a hand
  isHoveringSomething = false; 
  
  // Draw top buttons
  mainGUIUpdate(); 
  
  // Draw music player if opened
  if (isMusicPlayerOpen) {
    float[] musicPlayerDriveDIV = mainDriveDIVGet(2); 
    // umm passing the container cords to the music app
    musicPlayerDrive(
      musicPlayerDriveDIV[0],
      musicPlayerDriveDIV[1],
      musicPlayerDriveDIV[2],
      musicPlayerDriveDIV[3]
    );
  }
  
  // change the curser if we are hovering over any button!
  if (isHoveringSomething) {
    cursor(HAND);
  } else {
    cursor(ARROW);
  }
  
  // Revert buttons to default if 2 seconds have passed since last interaction
  checkUIReset(); 
}

void mousePressed() {
  mainGUIMousePressed(); // check main buttons
  if (isMusicPlayerOpen) {
    musicPlayerMousePressed(); // check inside app buttons
  }
}

void mouseDragged() {
  // if we clicked the title bar we can move it!
  if (isMusicPlayerOpen && draggingMP) {
    dragOffsetX += mouseX - pmouseX;
    dragOffsetY += mouseY - pmouseY;
  }
}

void mouseReleased() {
  draggingMP = false; // stop draging when let go
}

void keyPressed() {
  handleAudioShortcuts(); // my old CS10 keyboard shortcuts
}
