#include <PololuLedStrip.h>
#define LED_COUNT 144

// Create an ledStrip object and specify the pin it will use.
PololuLedStrip<11> ledStrip;
rgb_color colors[LED_COUNT];

long r;
long g;
long b;

void setup() {
  Serial.begin(9600);
  r = 10;
  g = 10;
  b = 10;
}

void loop() {
  if (Serial.available() > 0) {
    String incomingString = Serial.readStringUntil('X');
    const char* incomingChars = incomingString.c_str();

//    Serial.println("Incoming String: " + incomingString);

    char* pch;
    // Split string
    pch = strtok(incomingChars, 'N');

    int i = 0;
    while (pch != NULL) {

      Serial.write(pch);

      long number = strtol(pch, NULL, 16);

      r = number >> 16;
      g = number >> 8 & 0xFF;
      b = number & 0xFF;
      colors[i] = rgb_color(r, g, b);

      Serial.println(String(r) + ", " + String(g) + ", " + String(b));
      
      pch = strtok(NULL, 'N');
      i++;
    }

//    if (incomingString.length() == 6) {
//      Serial.println(String(number) + ": " + String(r) + ", " + String(b) + ", " + String(g));
//    }
  
    ledStrip.write(colors, LED_COUNT);
  
    delay(10);
  }
}
