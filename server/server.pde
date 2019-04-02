import codeanticode.syphon.*;
import processing.serial.*;

PImage img;
SyphonClient client;
String hexval;
String info = "";
Serial serial;
boolean active = true;

int scale = 2;
int infopadding = 0;
int textSize = 18;
int textColor = 255;

int w = 1920;
int h = 1080;

int fps = 30;


void settings() {
  size(w/scale, h/scale + infopadding, P3D);
}

void setup() {
  frameRate(fps);
  textSize(textSize);
  // Create syhpon client to receive frames 
  // from the first available running server: 
  client = new SyphonClient(this);
  
  serial = new Serial(this, "/dev/cu.usbmodemHIDPC1", 4800);
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
  text(info, 4, textSize+4); 
  fill(textColor);
}

void keyPressed() {
  if (key == ' ') {
    toggleActive();
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
  
  if (key=='i') {
    if(info=="") {
      syphonInfo();
    } else {
      info = "";
    }
  }
}

void syphonInfo() {

  HashMap<String, String>[] allServers = SyphonClient.listServers();

  int nServers = allServers.length;
  
  info = "";

  info+="Found " + nServers + " syphon server(s):";

  for (int i = 0; i < nServers; i++) {
    
    String appName = allServers[i].get("AppName");
    String serverName = allServers[i].get("ServerName");
    
    info+="\n" + i + ": \t" + appName + ", " + serverName;
  }
  
  info+="\nCurrent image info:";
  info+="\nActive: \t" + active;
  info+="\nSize: \t" + img.width + "x" + img.height;
  info+="\nFPS:" + " \tObserved " + frameRate + ", \ttarget " + fps;
  
  println(info);
  
  //println(img.textureName());
  
}

void toggleActive() {
  active = !active;
  if(active) {
    client = new SyphonClient(this);
  } else {
    client.stop();
  }
}