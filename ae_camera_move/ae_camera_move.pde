#include <Servo.h>

Servo s;
int t = 42; // frameDuration 

void setup(){
  s.attach(12);
  digitalWrite(13, HIGH);
  s.write(0);
  delay(1000);
  Serial.begin(9600);
}

void loop(){
  if(Serial.available()){
    int val = Serial.read();
    s.write(val);
    delay(t);
  }
}
