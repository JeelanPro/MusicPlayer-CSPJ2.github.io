// Variables


// Functions (this auto-scales text to fit in the rect perfectly)
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
  
  // shrink it if it overflows!
  while (textWidth < textWidth(text)) {
    textTextSize *= 0.99;
    textFont(textTextStyle, textTextSize);
  }

  // just to be safe we draw background transparently kinda
  // rect(textX, textY, textWidth, textHeight);
  fill(textTextColor);
  text(text, textX, textY, textWidth, textHeight);
  fill(textTextWhiteColor); // reset it

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
