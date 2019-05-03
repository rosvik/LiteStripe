#include <PololuLedStrip.h>
#define LED_COUNT 144
#define LED_PIN 11
#define BAUDRATE 250000

PololuLedStrip<LED_PIN> ledStrip;
rgb_color colors[LED_COUNT];

void setup() {
  Serial.begin(BAUDRATE);
}

void loop() {
  if (Serial.available() > 0) {
    byte serialdata[LED_COUNT*3];
    int len = Serial.readBytes(serialdata, LED_COUNT*3);

    for (int i = 0; i < LED_COUNT; i++) {
      colors[i] = rgb_color(serialdata[i*3], serialdata[i*3+1], serialdata[i*3+2]);
    }

    ledStrip.write(colors, LED_COUNT);

    delay(10);
  }
}
