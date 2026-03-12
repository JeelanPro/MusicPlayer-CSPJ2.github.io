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
