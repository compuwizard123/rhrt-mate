/*
  Rose-Hulman Institute of Technology Robotics Team - MATE ROV
  Kevin Risden 2011
  
  Purpose:
    Control topside electronics for underwater ROV.
    * Takes input from 2 Joysticks
    * Outputs axis and button states to serial at 9600 baud 
    * Takes bottom side output and displays on video signal
  
  Hardware:
    1 - Arduino
    2 - Joysticks
    1 - MAX7456
    
  Software:
    SPI Library
    MAX7456 Library
*/

#include <NewSoftSerial.h>
#include <SPI.h>
#include "MAX7456.h"

//define joystick axis pins
#define Joy1xPin 0
#define Joy1yPin 1
#define Joy2xPin 2
#define Joy2yPin 3

//define top and trigger buttons
#define xyTopPin 9
#define xyTriggerPin 8
#define zTTopPin 7
#define zTTriggerPin 6

NewSoftSerial mySerial(2, 3);
MAX7456 osd;

//declare input var for input
int input = 0;

//declare input pin arrays
int analogInputPins[4] = {Joy1xPin,Joy1yPin,Joy2xPin,Joy2yPin};
int digitalInputPins[4] = {xyTopPin,xyTriggerPin,zTTopPin,zTTriggerPin};

void setup() {
  //open the serial port at 9600 bps
  Serial.begin(9600);

  mySerial.begin(9600);
  
  osd.begin();
  
  //set digitalInputPins mode to Input
  for(int i=0; i<4; i++){
    pinMode(digitalInputPins[i], INPUT);
  }
}

int incomingByte = 0;

void loop() {
  /*if (Serial.available() > 0) {
    incomingByte = Serial.read();
    osd.println(incomingByte);
  }*/
  
  /*if (Serial.available()) {
      mySerial.print((char)Serial.read());
  }*/
  mySerial.println("test mySerial");
  
  //read the analog input on pins 0-3
  //analog pins 0-3 = inputs from joysticks
  for(int i=0;i<4;i++) {
    input = analogRead(analogInputPins[i]);
    Serial.print(input); //echo input received (debugging)
    Serial.print(" "); //echo space for readability (debugging)
  }
  //read the digital input on pins 0-3
  //analog pins 0-3 = inputs from joysticks
  for(int i=0;i<4;i++) {
    input = digitalRead(digitalInputPins[i]);
    Serial.print(input); //echo input received (debugging)
    Serial.print(" "); //echo space for readability (debugging)
  }
  Serial.println(); //echo new line for next serial (debugging)
  delay(100);
}
