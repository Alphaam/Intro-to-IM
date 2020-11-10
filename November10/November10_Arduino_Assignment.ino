/*Find a  way to turn all the lights on*/


//Assigning pins to variables
int GreenYellowLight = 10;
int BlueRedLight = 5;
int BlueGreenLight = 6;
int RedYellowLight = 3;
int button= 9;


void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);

  //button's pin an input
  pinMode(button, INPUT);

  //making all the led light pins output
  pinMode(GreenYellowLight, OUTPUT);
  pinMode(BlueRedLight, OUTPUT);
  pinMode(BlueGreenLight, OUTPUT);
  pinMode(RedYellowLight, OUTPUT);
}


void loop() {
  // read the input on analog pin A1:
  int sensorValue = analogRead(A1);

  // read the input on digital pin 9:
  int digitalSensor=digitalRead(button);
  
  // Mapping values from analog read
  int determiningValue = map(sensorValue, 720, 1023, 0 ,255);

  //Print both analog and digital read values
  Serial.println(sensorValue);
  delay(1);        // delay in between reads for stability
  Serial.println(digitalSensor);
  delay(1);


  //Setting up light controls
  if(digitalSensor==LOW && determiningValue>=100){

    analogWrite(BlueGreenLight,determiningValue);
    digitalWrite(RedYellowLight,LOW);
    delay(50);
    analogWrite(RedYellowLight,determiningValue);
    digitalWrite(BlueGreenLight,LOW);
    delay(60);
    digitalWrite(GreenYellowLight,HIGH);
    digitalWrite(BlueRedLight,LOW);
    delay(70);
    digitalWrite(GreenYellowLight,LOW);
    digitalWrite(BlueRedLight,HIGH);

  } else if(digitalSensor==HIGH && determiningValue>=100){
    
    analogWrite(BlueGreenLight,determiningValue);
    digitalWrite(RedYellowLight,LOW);
    delay(100);
    analogWrite(RedYellowLight,determiningValue);
    digitalWrite(BlueGreenLight,LOW);
    delay(100);
    digitalWrite(GreenYellowLight,HIGH);
    digitalWrite(BlueRedLight,LOW);
    delay(100);
    digitalWrite(GreenYellowLight,LOW);
    digitalWrite(BlueRedLight,HIGH);
    } else if(digitalSensor==HIGH && determiningValue<=50){
      digitalWrite(BlueRedLight,HIGH);
      digitalWrite(GreenYellowLight,HIGH);
      digitalWrite(BlueGreenLight,HIGH);
      digitalWrite(RedYellowLight,HIGH);
      }
  

}
