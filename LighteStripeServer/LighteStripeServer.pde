import codeanticode.syphon.*;
import processing.serial.*;

PImage img;
SyphonClient client;
String hexval;
Serial serial;

void setup() {
  size(480, 340, P3D);
  // Create syhpon client to receive frames 
  // from the first available running server: 
  client = new SyphonClient(this);
  serial = new Serial(this, "/dev/cu.usbmodemHIDPC1", 4800);
}

void draw() {
  background(0);
  if (client.newFrame()) {
    // The first time getImage() is called with 
    // a null argument, it will initialize the PImage
    // object with the correct size.
    img = client.getImage(img); // load the pixels array with the updated image info (slow)
    //img = client.getImage(img, false); // does not load the pixels array (faster)    

    hexval = hex(img.get(0, 0));

    String result = hexval.substring(2, 4);
    if(result.equals("FF")) {
      serial.write('H');
    } else {
      serial.write('L');
    }
  }
  if (img != null) {
    image(img, 0, 0, width, height);  
  }
}

void keyPressed() {
  if (key == ' ') {
    client.stop();
  } else if (key == 'd') {
    println(client.getServerName());
  } else if (key == 'c') {
    String result = hexval.substring(2, 4);
    println(hexval + " " + result);        
    if(result == "FF") {
      serial.write('H');
    } else {
      serial.write('L');
    }
  } else if (key == 'l') {
    serial.write('L');
  } else if (key == 'h') {
    serial.write('H');
  }

}