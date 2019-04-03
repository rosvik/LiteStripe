import codeanticode.syphon.*;
import processing.serial.*;

int scale = 2;
int infopadding = 0;
int textSize = 18;
int textColor = 255;

int w = 1920;
int h = 1080;

int fps = 30;

int baudrate = 4800;
String device = "/dev/cu.usbmodemHIDPC1";


PImage img;
SyphonClient client;
String hexval;
String info = "";
Serial serial;
boolean active = true;

void settings() {
  size(w/scale, h/scale + infopadding, P3D);
}

void setup() {
  frameRate(fps);
  textSize(textSize);
  // Create syhpon client to receive frames 
  // from the first available running server: 
  client = new SyphonClient(this);

  serial = new Serial(this, device, baudrate);
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
  stroke(0);
  text(info, 4, textSize+4); 
  fill(textColor);
}

void keyPressed() {
  if (key == ' ') {
    toggleActive();
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
  print("\n");
  info = "";

  HashMap<String, String>[] allServers = SyphonClient.listServers();
  String appName = allServers[0].get("AppName");
  String serverName = allServers[0].get("ServerName");

  info+="Siphon: \t" 
    + appName + ", " + serverName + " " 
    + img.width + "x" + img.height 
    + " (Found " + allServers.length + " server)";
    
  info+="\nDevice: \t" + device + ", " + baudrate + " baud";
  info+="\nFPS: \t" + "Target " + fps + ", \tobserved " + frameRate;
  info+="\nActive: \t" + active;
  
  println(info);
}

void infoUpdate() {
  if(info!=""){
    syphonInfo();
  }
}

void toggleActive() {
  active = !active;
  if(active) {
    client = new SyphonClient(this);
  } else {
    client.stop();
  }
  infoUpdate();
}