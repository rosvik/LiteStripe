import codeanticode.syphon.*;

PImage img;
SyphonClient client;
boolean active = true;

final int w = 1920;
final int h = 1080;

final int fps = 30;

void settings() {
  size(w/2, h/2, P3D);
}

void setup() {
  frameRate(fps);
  fullScreen();
  // Create syhpon client to receive frames 
  // from the first available running server: 
  client = new SyphonClient(this);
  surface.setResizable(true);
}

void draw() {
  background(255);

  if (client.newFrame()) {
    // The first time getImage() is called with 
    // a null argument, it will initialize the PImage
    // object with the correct size. Doesn't load 
	  // pixels arrays, which is faster.
    img = client.getImage(img, false);
    image(img, 0, 0, width, height);
  }
}