#include <Wire.h>
#include "DHT.h"

#define PIR_SENSOR     2
#define GAS_SENSOR     A1
#define LIGHT_SENSOR   A2
#define PULSE_SENSOR   A0
#define DHTPIN         3
#define DHTTYPE        DHT11

DHT dht(DHTPIN, DHTTYPE);

unsigned long lastPulseTime = 0;
unsigned long currentTime = 0;
float bpm = 0;
int lastPulseValue = 0;

// Limite pentru scalare gaz și lumină
#define GAS_MIN      100
#define GAS_MAX      900
#define LIGHT_MIN    0
#define LIGHT_MAX    1023

// Funcție pentru scalare între 1 și 10
int scaleToRange(int value, int minVal, int maxVal) {
  value = constrain(value, minVal, maxVal);
  return map(value, minVal, maxVal, 1, 10);
}

void setup() {
  Serial.begin(115200); // Trimite datele prin pinul TX (1) și USB
  pinMode(PIR_SENSOR, INPUT);
  pinMode(GAS_SENSOR, INPUT);
  pinMode(LIGHT_SENSOR, INPUT);
  pinMode(PULSE_SENSOR, INPUT);

  dht.begin();
  Serial.println("Senzorii sunt gata!");
}

void loop() {
  int pirValue = digitalRead(PIR_SENSOR);

  // Citire brută și scalare pentru gaz și lumină
  int rawGasValue = analogRead(GAS_SENSOR);
  int gasValue = scaleToRange(rawGasValue, GAS_MIN, GAS_MAX);

  int rawLightValue = analogRead(LIGHT_SENSOR);
  int lightValue = scaleToRange(rawLightValue, LIGHT_MIN, LIGHT_MAX);

  int pulseValue = analogRead(PULSE_SENSOR);
  float tempValue = dht.readTemperature();
  float humidityValue = dht.readHumidity();

  currentTime = millis();

  if (pulseValue > 600 && lastPulseValue <= 600) {
    if (lastPulseTime != 0) {
      unsigned long pulseInterval = currentTime - lastPulseTime;
      bpm = 60000.0 / pulseInterval;
    }
    lastPulseTime = currentTime;
  }

  lastPulseValue = pulseValue;

  // Transmite prin Bluetooth (TX pin 1) sau prin Monitor Serial
  Serial.print("PIR: "); Serial.print(pirValue);
  Serial.print(" | Gaz: "); Serial.print(gasValue);         // Valoare scalată
  Serial.print(" | Lumina: "); Serial.print(lightValue);    // Valoare scalată
  Serial.print(" | Puls: "); Serial.print(pulseValue);
  Serial.print(" | BPM: "); Serial.print(bpm);
  Serial.print(" | Temp: "); Serial.print(tempValue);
  Serial.print(" | Umiditate: "); Serial.println(humidityValue);

  delay(1000); // o citire pe secundă
}
