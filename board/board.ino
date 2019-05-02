#include <PololuLedStrip.h>
#define LED_COUNT 144

// Create an ledStrip object and specify the pin it will use.
PololuLedStrip<11> ledStrip;
rgb_color colors[LED_COUNT];

void setup() {
  Serial.begin(115200);
}

void loop() {
  if (Serial.available() > 0) {

    byte serialdata[432];

    int len = Serial.readBytes(serialdata, 432);

    for (int i = 0; i < LED_COUNT; i++) {
      colors[i] = rgb_color(serialdata[i*3], serialdata[i*3+1], serialdata[i*3+2]);
    }
  
    ledStrip.write(colors, LED_COUNT);
  
    delay(10);
  }
}
