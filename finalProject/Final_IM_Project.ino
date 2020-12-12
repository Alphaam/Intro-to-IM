
int interval = 20; // interval in milliseconds at which trigPin turns on
int interval3 = 1; // interval in milliseconds at which trigPin turns on
int interval2 = 50; //time in milliseconds at which the distance is printed in serial monitors


int trigState = LOW; //state of trigPin
const int rightBlinker = 6; // the number of the LED pin
const int leftBlinker = 5; // the number of the LED pin

const int lightSensor = A0;//Pin number for light sensitive resistor

int ledState = LOW;// ledState used to set the LED

const int trigPin = 4; // Trigger Pin of Ultrasonic Sensor
const int echoPin = 2; // Echo Pin of Ultrasonic Sensor


//variables used for distance measurement in sonar sensor
long duration, cm, inches;
int distance;


unsigned long previousMillis = 0;// will store last time LED was updated
unsigned long previousMillis1 = 0;//Will store last time printing of light stat and echo was updated

//const long interval = 1000;// interval at which to blink (milliseconds)

//pins connecting motors on left side of the robot
const int ain1Pin = 13;
const int ain2Pin = 12;
const int pwmAPin = 11;

//pins connected to motors on right side of robot
const int bin1Pin = 8;
const int bin2Pin = 9;
const int pwmBPin = 10;


char val;

void setup() {
  //Output pins
  pinMode(ain1Pin, OUTPUT);
  pinMode(ain2Pin, OUTPUT);
  pinMode(pwmAPin, OUTPUT); // not needed really
  pinMode(bin1Pin, OUTPUT);
  pinMode(bin2Pin, OUTPUT);
  pinMode(pwmBPin, OUTPUT); // not needed really
  pinMode(rightBlinker, OUTPUT);
  pinMode(leftBlinker, OUTPUT);
  pinMode(trigPin, OUTPUT); // Sets the trigPin as an Output

  //Input pins
  pinMode(echoPin, INPUT); // Sets the echoPin as an Input
  pinMode(lightSensor, INPUT);

  Serial.begin(9600);
}

void loop() {

  //Calling all functions
  Front();
  Back();
  Left();
  Right();
  brakes();
  lightOn();


delay(50);//delay to reduce la between arduino and processing
}


//Moving forward
void Front() {
  if (Serial.available())
  { // If data is available to read,
    val = Serial.read(); // read it and store it in val
  }
  if (val == 'F')//if data transmitted is 'F' move wheels in same direction forward
  {
    analogWrite(pwmAPin, 100);
    digitalWrite(ain1Pin, HIGH);
    digitalWrite(ain2Pin, LOW);

    analogWrite(pwmBPin, 100);
    digitalWrite(bin1Pin, HIGH);
    digitalWrite(bin2Pin, LOW);
    digitalWrite(leftBlinker, LOW);
    digitalWrite(rightBlinker, LOW);
  }
}



//moving backwards
void Back() {
  if (Serial.available())
  { // If data is available to read,
    val = Serial.read(); // read it and store it in val
  }
  if (val == 'B')//if data transmitted is 'B' move wheels in same direction backwards
  {
    analogWrite(pwmAPin, 100);
    digitalWrite(ain1Pin, LOW);
    digitalWrite(ain2Pin, HIGH);

    analogWrite(pwmBPin, 100);
    digitalWrite(bin1Pin, LOW);
    digitalWrite(bin2Pin, HIGH);

    digitalWrite(leftBlinker, LOW);
    digitalWrite(rightBlinker, LOW);
  }
}



//Turning Left
void Left() {

  if (Serial.available())
  { // If data is available to read,
    val = Serial.read(); // read it and store it in val
  }
  if (val == 'L')//if data transmitted is 'L' move right wheels in same direction forward
  {
    analogWrite(pwmAPin, 150);
    digitalWrite(ain1Pin, HIGH);
    digitalWrite(ain2Pin, LOW);

    analogWrite(pwmBPin, 150);
    digitalWrite(bin1Pin, LOW);
    digitalWrite(bin2Pin, LOW);
    lBlinker();//turn on left blinker
  }

}



//Turning Right
void Right() {

  if (Serial.available())
  { // If data is available to read,
    val = Serial.read(); // read it and store it in val
  }
  if (val == 'R')//if data transmitted is 'R' move left wheels in same direction forward
  {
    analogWrite(pwmAPin, 150);
    digitalWrite(ain1Pin, LOW);
    digitalWrite(ain2Pin, LOW);

    analogWrite(pwmBPin, 150);
    digitalWrite(bin1Pin, HIGH);
    digitalWrite(bin2Pin, LOW);
    rBlinker();//turn on right blinker
  }

}



//Stopping robot
void brakes() {

  if (Serial.available())
  { // If data is available to read,
    val = Serial.read(); // read it and store it in val
  }
  if (val == 'S')//if data transmitted is 'S' turn off all wheels
  {
    analogWrite(pwmAPin, 100);
    digitalWrite(ain1Pin, LOW);
    digitalWrite(ain2Pin, LOW);

    analogWrite(pwmBPin, 100);
    digitalWrite(bin1Pin, LOW);
    digitalWrite(bin2Pin, LOW);

    digitalWrite(leftBlinker, LOW);
    digitalWrite(rightBlinker, LOW);

    digitalWrite(leftBlinker, LOW);
    digitalWrite(rightBlinker, LOW);
  }

}



//left blinker
void lBlinker() {

  //replacing delay() with millis
  unsigned long currentMillis = millis();

  if (currentMillis - previousMillis >= interval) {
    // save the last time you blinked the LED
    previousMillis = currentMillis;

    // if the LED is off turn it on and vice-versa:
    if (ledState == LOW) {
      ledState = HIGH;
    } else {
      ledState = LOW;
    }
  }
  digitalWrite(leftBlinker, ledState);
}


//right blinker
void rBlinker() {
  //replacing delay() with millis
  unsigned long currentMillis2 = millis();

  if (currentMillis2 - previousMillis >= interval) {
    // save the last time you blinked the LED
    previousMillis = currentMillis2;

    // if the LED is off turn it on and vice-versa:
    if (ledState == LOW) {
      ledState = HIGH;
    } else {
      ledState = LOW;
    }
  }
  digitalWrite(rightBlinker, ledState);
}


//reading from sonar sensor and light dependent resistor
void lightOn () {
  
  int lightState = analogRead(lightSensor);//read light dependent resistor values and store them in lighState variable


  unsigned long currentMillis = millis(); //time in milliseconds from which the code was started
  if (currentMillis - previousMillis >= 1) { 
    previousMillis = currentMillis;
    if (trigState == LOW) {//switching between high and low states to create echo
      (trigState = HIGH);
    }
    else {
      (trigState = LOW);
    }
  }


  digitalWrite(trigPin, trigState);
  int duration, distance; //variables
  duration=read_pulse(echoPin);//read echoPin state
  //duration = pulseIn(echoPin, HIGH);
  distance = (duration / 2) / 29.1;//setting up value of distance.

  unsigned long currentMillis1 = millis();
  if (currentMillis1 - previousMillis1 >= 50) { //printing out distance and lighState values to be read by processing.
    previousMillis1 = currentMillis1;
    Serial.print(distance);
    Serial.print(",");
    Serial.print(lightState);
    Serial.println();
  }
}


//replacing pulseIn because it causes lag
unsigned long read_pulse(int pin)
{
    static unsigned long rising_time;  // time of the rising edge
    static int last_state;             // previous pin state
    int state = digitalRead(pin);      // current pin state
    unsigned long pulse_length = 0;    // default return value

    // On rising edge: record current time.
    if (last_state == LOW && state == HIGH) {
        rising_time = micros();
    }

    // On falling edge: report pulse length.
    if (last_state == HIGH && state == LOW) {
        unsigned long falling_time = micros();
        pulse_length = falling_time - rising_time;
    }

    last_state = state;
    return pulse_length;
}
