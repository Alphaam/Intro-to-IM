/*
Puzzle Objective: Turn off all the lights.
*/

// Attaching pins to pushButton variables
const int pushButton = 4;
const int pushButton1 = 3;
const int pushButton2 = 5;

// the setup routine runs once when you press reset:
void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
  
  // make the pushbutton variable pins an inputs:
  pinMode(pushButton, INPUT);
  pinMode(pushButton1, INPUT);
  pinMode(pushButton2, INPUT);

  // initialize digital pin outputs.
  pinMode(8, OUTPUT);
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);
}


void loop() {
  // read the input pin:
  int redButton = digitalRead(pushButton);
  int yellowButton = digitalRead(pushButton1);
  int blueButton = digitalRead(pushButton2);
  
  // print out the state of the button:
  Serial.println(redButton);
  delay(1);        // delay in between reads for stability


//Setting up puzzle conditions
  if (redButton == LOW && yellowButton == LOW && blueButton == LOW) {
    digitalWrite(8, HIGH);
    digitalWrite(9, HIGH);
    digitalWrite(10, HIGH);
  } else  if (redButton == LOW && yellowButton == HIGH && blueButton == HIGH) {    //Winning Move
    digitalWrite(8, LOW);
    digitalWrite(9, LOW);
    digitalWrite(10, LOW);
  } else  if (redButton == LOW && yellowButton == LOW && blueButton == HIGH) {
    digitalWrite(8, HIGH);
    digitalWrite(9, LOW);
    digitalWrite(10, HIGH);
  } else  if (redButton == HIGH && yellowButton == LOW && blueButton == HIGH) {
    digitalWrite(8, HIGH);
    delay(100);
    digitalWrite(8, LOW);
    delay(100);
    digitalWrite(9, HIGH);
    delay(100);
    digitalWrite(9, LOW);
    delay(100);
    digitalWrite(10, HIGH);
    delay(100);
    digitalWrite(10, LOW);
    delay(100);
  }
  else  if (redButton == HIGH && yellowButton == HIGH && blueButton == HIGH) {
    digitalWrite(8, HIGH);
    delay(50);
    digitalWrite(8, LOW);
    delay(50);
    digitalWrite(9, HIGH);
    delay(100);
    digitalWrite(9, LOW);
    delay(100);
    digitalWrite(10, HIGH);
    delay(10);
    digitalWrite(10, LOW);
    delay(10);
  } else {
    digitalWrite(8, HIGH);
    digitalWrite(9, HIGH);
    digitalWrite(10, HIGH);
  }

}
