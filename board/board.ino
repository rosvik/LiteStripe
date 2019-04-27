/* LedStripGradient: Example Arduino sketch that shows
 * how to control an Addressable RGB LED Strip from Pololu.
 *
 * To use this, you will need to plug an Addressable RGB LED
 * strip from Pololu into pin 12.  After uploading the sketch,
 * you should see a pattern on the LED strip that fades from
 * green to pink and also moves along the strip.
 */

#include <PololuLedStrip.h>

boolean active = true;

// Create an ledStrip object and specify the pin it will use.
PololuLedStrip<11> ledStrip;

// Create a buffer for holding the colors (3 bytes per color).
#define LED_COUNT 144
rgb_color colors[LED_COUNT];
byte incomingByte;

void setup() {
  Serial.begin(9600);
}

void loop()
{
  if (Serial.available() > 0) {

    // Update the colors.
    byte time = millis() >> 2;
    for (uint16_t i = 0; i < LED_COUNT; i++)
    {
      byte x = time%256+i;
      colors[i] = rgb_color(10, 10, 10);
    }
  
  
    // Write the colors to the LED strip.
    incomingByte = Serial.read();

    if (incomingByte == 'L') {
      active = false;
    }
    if (incomingByte == 'H') {
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
