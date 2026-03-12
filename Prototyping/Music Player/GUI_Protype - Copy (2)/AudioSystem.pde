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
  playList[1] = minim.loadFile(audioFolder + "qaseda.mp3");
  playList[2] = minim.loadFile(audioFolder + "Virus.mp3");

  audioImageList[0] = loadImage(imageFolder + "NuclearBomb.jpg");
  audioImageList[1] = loadImage(imageFolder + "JeelanPro.jpg");
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
