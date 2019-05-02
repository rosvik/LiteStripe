 
// Actual window size:
//     height = h/scale
//     width = w/scale

final int w = 1920;
final int h = 1080;
final int scale = 2;

final int fps = 30;

// Info text
final int textSize = 18;
final int textColor = 255;

// Arduino info
final String device = "/dev/cu.wchusbserial1410";
final int baudrate = 9600;
final int ledCount = 144;

// Color reading start position (ProPresenter scale)
final int ledStartX = 960;
final int ledStartY = 300;
final int ledStep = 2;