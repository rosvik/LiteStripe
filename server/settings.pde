 
// Actual window size:
//     height = h/scale
//     width = w/scale

int w = 1920;
int h = 1080;
int scale = 2;

int fps = 30;

// Info text
int textSize = 18;
int textColor = 255;

// Arduino info
String device = "/dev/cu.wchusbserial1410";
int baudrate = 9600;
int ledCount = 144;

// Color reading start position (ProPresenter scale)
int ledStartX = 960;
int ledStartY = 300;
int ledStep = 2;