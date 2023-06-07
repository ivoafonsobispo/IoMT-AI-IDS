#include "Arduino.h"

#include <DHT.h>
#include <WiFi.h>
#include <WiFiUdp.h>
#include <coap-simple.h>

// DHT11 Sensor
#define DHTPIN 4
#define DHTTYPE DHT11
DHT dht(DHTPIN, DHTTYPE);

// Data
struct DHTSensor {
  float h;
  float t;
  float hi;
};

// WiFi
const char* ssid = "SIIC Noticias 2.4GHz";                
const char* wifi_password = "gluteosmaximus";

WiFiClient Wificlient;
WiFiUDP udp;
Coap coap(udp);

void connect_wifi() {
  Serial.print("Connecting to ");
  Serial.println(ssid);

  // Connect to the WiFi
  WiFi.begin(ssid, wifi_password);

  // Wait until the connection is confirmed
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("WiFi connected");
  Serial.print("IP address: ");
  Serial.println(WiFi.localIP());
}

DHTSensor dht11Readings() {
  DHTSensor data;
  data.h = dht.readHumidity();
  data.t = dht.readTemperature();

  if (isnan(data.h) || isnan(data.t)) {
    Serial.println(F("Failed to read from DHT sensor!"));
    exit(0);
  }

  data.hi = dht.computeHeatIndex(data.t, data.h, false);
  
  return data;
}

void send_coap_message(DHTSensor dht11) {
  String t = String(dht11.t);
  String h = String(dht11.h);
  String hi = String(dht11.hi);

  char t_char[t.length() + 1];
  char h_char[h.length() + 1];
  char hi_char[hi.length() + 1];
  
  t.toCharArray(t_char, sizeof(t_char));
  h.toCharArray(h_char, sizeof(h_char));
  hi.toCharArray(hi_char, sizeof(hi_char));

  
  Serial.println("Sending Humidity");
  coap.put(IPAddress(0x0A,0x0A,0x0A,0xF9), 5683, "humidity", h_char);

  Serial.println("Sending Temperature");
  coap.put(IPAddress(0x0A,0x0A,0x0A,0xF9), 5683, "temperature", t_char);
  
  Serial.println("Sending Heat Index");
  coap.put(IPAddress(0x0A,0x0A,0x0A,0xF9), 5683, "heatindex", hi_char);
  delay(5000);
}

void setup() {
  Serial.begin(115200);
  
  Serial.println(F("DHT11 test!"));
  dht.begin();

  connect_wifi();
  
  Serial.println("COAP Start");
  coap.start();
}

void loop() {
  DHTSensor dht11 = dht11Readings();
  displayDHT11Readings(dht11);

  send_coap_message(dht11);
}

void displayDHT11Readings(DHTSensor dht11) {
  Serial.print(F("Humidity: "));
  Serial.print(dht11.h);
  Serial.print(F("%  Temperature: "));
  Serial.print(dht11.t);
  Serial.print(F("°C Heat Index: "));
  Serial.print(dht11.hi);
  Serial.println(F("°C"));
}
