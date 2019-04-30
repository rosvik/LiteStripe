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

    if (incomingString.length() == 6) {
      long number = strtol(incomingChars, NULL, 16);
      r = number >> 16;
      g = number >> 8 & 0xFF;
      b = number & 0xFF;
//      Serial.println(String(number) + ": " + String(r) + ", " + String(b) + ", " + String(g));
    }

    for (uint16_t i = 0; i < LED_COUNT; i++) {
      colors[i] = rgb_color(r, g, b);
    }
  
    ledStrip.write(colors, LED_COUNT);
  
    delay(10);
  }
}
