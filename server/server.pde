import codeanticode.syphon.*;
import processing.serial.*;

PImage img;
SyphonClient client;
String hexval;
String info = "";
Serial serial;
boolean active = true;
byte[] buf = new byte[144];

void settings() {
  size(w/scale, h/scale + infopadding, P3D);
//  pixelDensity(2);
}

void setup() {
  frameRate(fps);
  textSize(textSize);
  textMode(SHAPE);
  // Create syhpon client to receive frames 
  // from the first available running server: 
  client = new SyphonClient(this);

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
    //img = client.getImage(img, false); // does not load the pixels array (faster)    

    hexval = hex(img.get(0, 0));

    String result = hexval.substring(2, 8); //FF4F348E
    if (serial != null) {
      serial.write(result + 'X');
    }
  }
  if (img != null) {
    image(img, 0, 0, width, height);
  }
  stroke(0);
  text(info, 4, textSize+4); 
  fill(textColor);
}