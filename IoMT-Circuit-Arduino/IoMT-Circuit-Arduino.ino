// PIR Motion Sensor
#define PIR_PIN 2
int pinStateCurrent   = LOW;
int pinStatePrevious  = LOW;


void setup() {
  Serial.begin(9600);
   
  Serial.println(F("PIR test!"));
  pinMode(PIR_PIN, INPUT);
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop(){
  pirMotionDetection(pinStatePrevious, pinStateCurrent);
}

void pirMotionDetection(int pinStatePrevious, int pinStateCurrent) {
  pinStatePrevious = pinStateCurrent; // store old state
  pinStateCurrent = digitalRead(PIR_PIN);   // read new state

  if (pinStatePrevious == LOW && pinStateCurrent == HIGH) {   // pin state change: LOW -> HIGH
    digitalWrite(LED_BUILTIN, HIGH);   // turn the LED on (HIGH is the voltage level)
    Serial.println("Motion detected!");
    delay(2000);
  }
  else if (pinStatePrevious == HIGH && pinStateCurrent == LOW) {   // pin state change: HIGH -> LOW
    Serial.println("Motion stopped!");
    digitalWrite(LED_BUILTIN, LOW);    // turn the LED off by making the voltage LOW
  }
}
