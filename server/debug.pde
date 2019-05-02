void syphonInfo() {
  if (info == "") {
    print("\n");
    info = "";
  
    HashMap<String, String>[] allServers = SyphonClient.listServers();
    String appName = allServers[0].get("AppName");
    String serverName = allServers[0].get("ServerName");
  
    info+="Siphon:\t " 
      + appName + ", " + serverName + " " 
      + img.width + "x" + img.height 
      + " (Found " + allServers.length + ")";
      
    info+="\nDevice:\t " + device + ", " + baudrate + " baud";
    info+="\nFPS:\t " + "Target " + fps + ", observed " + frameRate;
    info+="\nActive:\t " + active;
    info+="\n" + ledStartX + "," + ledStartY + " value:\t #" + hexval;
    if(!trySerialConnect()) {
      info+="\nSerial unavaliable (r to retry)";
    }
      
    println(info);
    
    print(getColorsForStrip(ledStartX, ledStartY, ledStep));
    
  } else {
    info = "";
  }
}

void helpInfo() {
  if (info=="") {
    info = helpKey + "    Show/hide this help menu\n" +
    infoKey + "    Show/hide debug menu\n" + 
    refreshKey + "    Update debug menu\n" + 
    activeKey + "    Enable/disable stream\n";
  } else {
    info = "";
  }
}

void refreshInfo() {
  if (info=="") {
    info = " ";
    syphonInfo();
  } else {
    info = "";
    syphonInfo();
  }
}

void toggleActive() {
  active = !active;
  if (active) {
    client = new SyphonClient(this);
  } else {
    client.stop();
  }
  refreshInfo();
}

boolean trySerialConnect() {
  try {
    serial = new Serial(this, device, baudrate);
  } catch(Exception e) {
    return false;
  }
  return true;
}