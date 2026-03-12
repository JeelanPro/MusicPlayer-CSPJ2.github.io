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
