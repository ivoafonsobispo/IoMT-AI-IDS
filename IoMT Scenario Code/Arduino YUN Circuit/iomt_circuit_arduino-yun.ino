#include <BridgeClient.h>
#include <PubSubClient.h>

// PIR Motion Sensor
#define PIR_PIN 2
int pinStateCurrent   = LOW;
int pinStatePrevious  = LOW;

// MQTT
const char* mqtt_server = "10.10.10.249"; 
const char* m_topic = "m";
//const char* mqtt_username = "neo"; // MQTT username
//const char* mqtt_password = "eglabs"; // MQTT password
const char* clientID = "ARDUINO_YUN"; // MQTT client ID

BridgeClient yun;
PubSubClient client(mqtt_server, 1883, yun);

void connect_MQTT(){ 
  if (client.connect(clientID)) {
    Serial.println("Connected to MQTT Broker!");
  }
  else {
    Serial.println("Connection to MQTT Broker failed…");
  }
}

void setup() {
  Serial.begin(9600);
  Bridge.begin();
  Serial.println(F("PIR test!"));
  pinMode(PIR_PIN, INPUT);
  pinMode(LED_BUILTIN, OUTPUT);

  connect_MQTT();
}

void loop(){
   Serial.setTimeout(2000);

  int m = pirMotionDetection(pinStatePrevious, pinStateCurrent);
  
  publish_topic(m_topic, m);

  delay(1000);
}

int pirMotionDetection(int pinStatePrevious, int pinStateCurrent) {
  pinStatePrevious = pinStateCurrent; // store old state
  pinStateCurrent = digitalRead(PIR_PIN);   // read new state

  if (pinStatePrevious == LOW && pinStateCurrent == HIGH) {   // pin state change: LOW -> HIGH
    digitalWrite(LED_BUILTIN, HIGH);   // turn the LED on (HIGH is the voltage level)
    Serial.println("Motion detected!");
    return 1;
  }
  else if (pinStatePrevious == HIGH && pinStateCurrent == LOW) {   // pin state change: HIGH -> LOW
    digitalWrite(LED_BUILTIN, LOW);    // turn the LED off by making the voltage LOW
    Serial.println("Motion stopped!");
  }
  return 0;
}

void publish_topic(const char* topic, int data) {
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
