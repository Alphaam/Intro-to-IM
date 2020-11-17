//importing servo library
#include <Servo.h>

// create servo object to control a servo
Servo myservo;  

// variables that store pin objects
const int yellowButton=6;
const int greenButton=A4;
const int photoResistor=A2;

// variable to store the servo position
int pos = 0;    

void setup() {
  Serial.begin(9600);
  myservo.attach(A5);  // attaches the servo on pin 9 to the servo object

  //declaring which pins are input
  pinMode(yellowButton, INPUT);
  pinMode(greenButton, INPUT);
  pinMode(photoResistor, INPUT);
  
}

void loop() {

  //reading analog signal from photo resistor
  int sensorValue = analogRead(photoResistor);

  // read the input on digital pins:
  int digitalSensor1=digitalRead(yellowButton);
  int digitalSensor2=digitalRead(greenButton);
  
 // Mapping values from analog read
  int determiningValue = map(sensorValue, 950, 999, 0 ,255);

  //Print both analog and digital read values
  Serial.println(sensorValue);
  delay(1);        // delay in between reads for stability
  Serial.println(digitalSensor1);
  delay(1);
  Serial.println(digitalSensor2);
  delay(1);


//setting up speed of motor movement
  if(determiningValue>=100 && digitalSensor2==HIGH ){
    
      for (pos = 0; pos <= 180; pos += 50) { // goes from 0 degrees to 180 degrees
    // in steps of 1 degree
       myservo.write(pos);              // tell servo to go to position in variable 'pos'
        delay(15);                       // waits 15ms for the servo to reach the position
        }
        for (pos = 180; pos >= 0; pos -= 50) { // goes from 180 degrees to 0 degrees
        myservo.write(pos);              // tell servo to go to position in variable 'pos'
        delay(15);                       // waits 15ms for the servo to reach the position
        }
} else if(determiningValue<=100 && digitalSensor2==HIGH  ){
  
      for (pos = 0; pos <= 180; pos += 30) { // goes from 0 degrees to 180 degrees
    // in steps of 1 degree
       myservo.write(pos);              // tell servo to go to position in variable 'pos'
        delay(15);                       // waits 15ms for the servo to reach the position
        }
        for (pos = 180; pos >= 0; pos -= 50) { // goes from 180 degrees to 0 degrees
        myservo.write(pos);              // tell servo to go to position in variable 'pos'
        delay(15);                       // waits 15ms for the servo to reach the position
        }  
  } else if(determiningValue<=100 && digitalSensor1==HIGH  ){
  
      for (pos = 0; pos <= 180; pos += 30) { // goes from 0 degrees to 180 degrees
    // in steps of 1 degree
       myservo.write(pos);              // tell servo to go to position in variable 'pos'
        delay(15);                       // waits 15ms for the servo to reach the position
        }
        for (pos = 180; pos >= 0; pos -= 30) { // goes from 180 degrees to 0 degrees
        myservo.write(pos);              // tell servo to go to position in variable 'pos'
        delay(15);                       // waits 15ms for the servo to reach the position
        }  
  }else if(determiningValue>=100 && digitalSensor1==HIGH ){
    
      for (pos = 0; pos <= 180; pos += 20) { // goes from 0 degrees to 180 degrees
    // in steps of 1 degree
       myservo.write(pos);              // tell servo to go to position in variable 'pos'
        delay(15);                       // waits 15ms for the servo to reach the position
        }
        for (pos = 180; pos >= 0; pos -= 20) { // goes from 180 degrees to 0 degrees
        myservo.write(pos);              // tell servo to go to position in variable 'pos'
        delay(15);                       // waits 15ms for the servo to reach the position
        }
  }else if(determiningValue>=100 && digitalSensor1==HIGH && digitalSensor2==HIGH ){
    
      for (pos = 0; pos <= 180; pos += 20) { // goes from 0 degrees to 180 degrees
    // in steps of 1 degree
       myservo.write(pos);              // tell servo to go to position in variable 'pos'
        delay(15);                       // waits 15ms for the servo to reach the position
        }
        for (pos = 180; pos >= 0; pos -= 20) { // goes from 180 degrees to 0 degrees
        myservo.write(pos);              // tell servo to go to position in variable 'pos'
        delay(15);                       // waits 15ms for the servo to reach the position
        }
  }


}
