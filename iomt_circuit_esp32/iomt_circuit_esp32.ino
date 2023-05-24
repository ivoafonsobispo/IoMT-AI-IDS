// Libs
#include <DHT.h>
#include <PubSubClient.h>
#include <WiFi.h>

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
const char* ssid = "GLUTEOS";                
const char* wifi_password = "gluteosmaximus";

// MQTT
const char* mqtt_server = "10.10.10.249"; 
const char* h_topic = "h";
const char* t_topic = "t";
const char* hi_topic = "hi";
//const char* mqtt_username = "neo"; // MQTT username
//const char* mqtt_password = "eglabs"; // MQTT password
const char* clientID = "ESP32"; // MQTT client ID

WiFiClient wifiClient;
PubSubClient client(mqtt_server, 1883, wifiClient);

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

void connect_MQTT(){ 
  if (client.connect(clientID)) {
    Serial.println("Connected to MQTT Broker!");
  }
  else {
    Serial.println("Connection to MQTT Broker failed…");
  }
}

void setup() {
  Serial.begin(115200);
  
  Serial.println(F("DHT11 test!"));
  dht.begin();

  connect_wifi();
  connect_MQTT();
}

void loop() {
  Serial.setTimeout(2000);
  
  DHTSensor dht11 = dht11Readings();
  Serial.print(F("Humidity: "));
  Serial.print(dht11.h);
  Serial.print(F("%  Temperature: "));
  Serial.print(dht11.t);
  Serial.print(F("°C Heat Index: "));
  Serial.print(dht11.hi);
  Serial.println(F("°C"));

  publish_topic(h_topic, dht11.h);
  publish_topic(t_topic, dht11.t);
  publish_topic(hi_topic, dht11.hi);
    
  //client.disconnect();
  delay(5000);
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

void publish_topic(const char* topic, float data) {
  if (client.publish(topic, String(data).c_str())) {
    Serial.print("INFO\tData sent to topic: #");
    Serial.println(topic);
  }
  else {
    Serial.println("ERROR\tData failed to send. Reconnecting to MQTT Broker and trying again");
    client.connect(clientID);
    delay(10); // This delay ensures that client.publish doesn’t clash with the client.connect call
    client.publish(topic, String(data).c_str());
  }
}
