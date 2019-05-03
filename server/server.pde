import codeanticode.syphon.*;
import processing.serial.*;

PImage img;
SyphonClient client;
String hexval;
String info = "";
Serial serial;
boolean active = true;
byte[] buf;

void settings() {
  size(w/scale, h/scale, P3D);
//  pixelDensity(2);
}

void setup() {
  frameRate(fps);
  textSize(textSize);
  textMode(SHAPE);
  // Create syhpon client to receive frames 
  // from the first available running server: 
  client = new SyphonClient(this);
  buf = new byte[ledCount];

  try {
    serial = new Serial(this, device, baudrate);
  } catch(Exception e) {
    print(e);
  }
  
  buf[0] = byte(255);
  
  print(buf[0]);
}

void draw() {
  background(255);

  if (client.newFrame()) {

    // The first time getImage() is called with 
    // a null argument, it will initialize the PImage
    // object with the correct size.
    img = client.getImage(img); // load the pixels array with the updated image info (slow)
    //imig = client.getImage(img, false); // does not load the pixels array (faster)    

//    hexval = hex(img.get(ledStartX, ledStartY)).substring(2, 8);
    
    // Update LED strip
    if (serial != null) {
      byte[] msg = getColors(ledStartX, ledStartY, ledStep);

      serial.write(msg);
    }
  }
  
  // Render visualizer
  if (img != null) {
    image(img, 0, 0, width, height);
  }
  stroke(0);
  displayLedStrips(ledStartX, ledStartY, ledStep);
  text(info, 4, textSize+4); 
  fill(textColor);

  delay(1000/30);
}

String getColorsForStrip(int startX, int startY, int step) {
  String msg = "";
  for (int i = startY; i < startY + ledCount*step; i = i + step) {
    msg += hex(img.get(startX, i)).substring(2, 8) + 'N';
  }
  msg += 'X';
  return msg;
}

byte[] getColors(int startX, int startY, int step) {
  int n = 0;
  byte[] out = new byte[ledCount*3];

  for (int i = startY; i < startY + ledCount*step; i += step) {

    int val = img.get(startX, i);

    int r = (val>>16)&0xFF;
    int g = (val>>8)&0xFF;
    int b = (val)&0xFF;
    
    out[n] = byte(r/4);
    out[n+1] = byte(g/4);
    out[n+2] = byte(b/4);
    n += 3;
  }
  
  return out;
}


void displayLedStrips(int startX, int startY, int step) {
  strokeWeight(3);
  stroke(0, 255, 0, 80);
  color(255);
  rect(startX/scale, startY/scale, 1, ledCount*step/scale);
}