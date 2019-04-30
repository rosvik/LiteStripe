/* LedStripGradient: Example Arduino sketch that shows
 * how to control an Addressable RGB LED Strip from Pololu.
 *
 * To use this, you will need to plug an Addressable RGB LED
 * strip from Pololu into pin 12.  After uploading the sketch,
 * you should see a pattern on the LED strip that fades from
 * green to pink and also moves along the strip.
 */

#include <PololuLedStrip.h>

// Create an ledStrip object and specify the pin it will use.
PololuLedStrip<11> ledStrip;

#define LED_COUNT 144

rgb_color colors[LED_COUNT];
boolean active = true;
long r;
long g;
long b;

void setup() {
  Serial.begin(4800);
  long r = 10;
  long g = 10;
  long b = 10;
}

void loop() {
  if (Serial.available() > 0) {

    String incomingString = Serial.readStringUntil('X');

    const char* v2 = incomingString.c_str();
    
    Serial.println("Incoming String: " + incomingString);

    if (incomingString.length() == 6) {
      long number = strtol(v2, NULL, 16);
      r = number >> 16;
      g = number >> 8 & 0xFF;
      b = number & 0xFF;
      Serial.println(String(number) + ": " + String(r) + ", " + String(b) + ", " + String(g));
    }
        
    // Update the colors.
    byte time = millis() >> 2;

    for (uint16_t i = 0; i < LED_COUNT; i++) {
      colors[i] = rgb_color(r, g, b);
    }
  
    if (incomingString == "HEY") {
      active = false;
    }
    if (incomingString == "ABC") {
      active = true;
    }

    if (active) {
      ledStrip.write(colors, LED_COUNT);
    } else {
      for (uint16_t i = 0; i < LED_COUNT; i++) {
        colors[i] = rgb_color(0, 0, 0);
      }
      ledStrip.write(colors, LED_COUNT);
    }
  
    delay(10);
  }
}
