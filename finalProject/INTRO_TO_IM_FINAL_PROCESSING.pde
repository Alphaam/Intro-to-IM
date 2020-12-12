/*Abdi Ambari Final Project*/

import processing.serial.*;//establishing communication with arduino via port
import processing.sound.*;//importing sound library


int x =0;//variable to control playing of audio tracks
String val;//Variable that stores string values from arduino

Serial myPort;// The serial port


PImage background1;//variable for background image
PFont font;//calling font library

int sonar;//variable for sonar sensor data
int page=1;//variable that controls movement through pages

SoundFile introMusic;//calling file containing sound for landing page
SoundFile instruction;//calling file containing sound for instruction page
SoundFile drive;//calling file containing sound sound for drive page
SoundFile lightsareOn;//calling file containing sound for when the robot comes into the light




void setup() {

  size(1200, 700);// set the window size:

  println(Serial.list());// List all the available serial ports

  background1 = loadImage("photos/Background.jpg");//calling background image

  font=loadFont("future.vlw");//loading font

  introMusic = new SoundFile(this, "Welcome.mp3");//loading sound file for intro sound
  instruction = new SoundFile(this, "Instructions.mp3");//loading sound file for instruction page sound
  drive = new SoundFile(this, "driving.mp3");//loading sound file for drive page sound
  lightsareOn = new SoundFile(this, "Lights.mp3");//loading sound file for lights are on sound

  // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[0], 9600);
}




void draw() {

  if (page==1) {//calling landing page 
    landingPage();
  }
  if (page==2) {//calling instruction page
    instructionPage();
  }

  if (page==3) {//calling drive page
    drive();
  }
}



//Setting up landing page
void landingPage() {

  image(background1, 0, 0, 1200, 700);//setting static background

  //Landing page text
  fill(255, 255, 255);
  textFont(font, 61);
  textAlign(CENTER);
  text("WELCOME TO DRIVE", 600, 350);

  fill(0, 0, 0);
  textFont(font, 60);
  textAlign(CENTER);
  text("WELCOME TO DRIVE", 600, 350);


  instructionButton();//button to instruction page
  DriveButton();//button to drive page

  //Code to play intro track only once
  if (!introMusic.isPlaying() && x==0) { 
    introMusic.play();

    int i = 0;
    while (true) {
      if (introMusic.isPlaying()) {
        i++;
        print("");
      } else {
        break;
      }
    }
    introMusic.stop();
    x=1;
  }
}



//setting up insruction page
void instructionPage() {

  image(background1, 0, 0, 1200, 700);//Setting up background image

  //Text for the instruction page
  fill(0, 0, 0);
  textFont(font, 32);
  textAlign(CENTER);
  text("SIMPLE!", 485, 205);

  text("USE NAVIGATION KEYS TO DRIVE", 485, 305);
  text("PRESS 'S' TO STOP", 485, 405);

  //Text shadow
  fill(255, 255, 255);
  textFont(font, 32);
  textAlign(CENTER);
  text("SIMPLE!", 490, 200);

  text("USE NAVIGATION KEYS TO DRIVE", 490, 300);
  text("PRESS 'S' TO STOP", 490, 400);


  DriveButton() ;//Button to drive page

  //Code to play instruction page track once
  if (!instruction.isPlaying() && x==0) { 
    instruction.play();

    int i = 0;
    while (true) {
      if (instruction.isPlaying()) {
        i++;
        print("");
      } else {
        break;
      }
    }
    instruction.stop();
    x=1;
  }
}



//Drive page
void drive() {
  image(background1, 0, 0, 1200, 700);
  homeButton();
  turnLeft();
  turnRight();
  Forward();
  Backwards();
  brakes();
}



//Command to move orward
void Forward() {
  if (key == CODED) {
    if (keyCode == UP) {
      myPort.write('F');
    }
  }
}




//Command to move backwards
void Backwards() {
  if (key == CODED) {
    if (keyCode == DOWN) {
      myPort.write('B');
    }
  }
}

//Command to turn left
void turnLeft() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      myPort.write('L');
    }
  }
}



//Command to turn right
void turnRight() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      myPort.write('R');
    }
  }
}



//Command to stop robot
void brakes() {
  if (keyPressed) {
    if (key == 's' || key == 'S') {
      myPort.write('S');
    }
  }
}




//Button that leads to instruction page
void instructionButton() {
  fill(0, 0, 0);
  noStroke();
  rect(200, 480, 240, 60);

  fill(255, 255, 255);
  noStroke();
  rect(210, 470, 240, 60);

  fill(0, 0, 0);
  textFont(font, 26);
  textAlign(CENTER);
  text("INSTRUCTIONS", 330, 510);
}




//Button that leads to drive page
void DriveButton() {
  fill(0, 0, 0);
  noStroke();
  rect(740, 480, 240, 60);

  fill(255, 255, 255);
  noStroke();
  rect(750, 470, 240, 60);

  fill(0, 0, 0);
  textFont(font, 26);
  textAlign(CENTER);
  text("DRIVE", 865, 510);
}




//Home Button
void homeButton() {

  fill(0, 0, 0);
  noStroke();
  rect(500, 350, 240, 60);

  fill(255, 255, 255);
  noStroke();
  rect(510, 340, 240, 60);

  fill(0, 0, 0);
  textFont(font, 35);
  textAlign(CENTER);
  text("HOME", 625, 380);
}




////Recieves information from Arduino
void serialEvent (Serial port) {

  if ( myPort.available() > 0) {// If data is available,

    val = myPort.readStringUntil('\n');//read the data until there is a line break

    if (val != null && val != "") {//if the data isn't null or aan empty space do the following
      val = trim(val);// read it, trim it and store it in val

      if (!isStringValid(val)) {
        port.clear(); // discard everything else
        return; // don't do the rest of this function
      }

      String[] a = split(val, ',');//Split val string wherever there is a comma
      int state = Integer.valueOf(a[0]);//converting data into intergers from sonar sensor
      int lightss = Integer.valueOf(a[1]);//converting data into intergers from lights sensitive resistor
      
      
      if (state!=0) {//Eliminating zero readings from sonar readings
        sonar=state;
      }else{int discard=state;}
      
      
      println(sonar); //print it out in the console the sonar value
      println(" ");
      println(lightss); //print it out in the console value from light sensitive resistor
      
      
      if (sonar<=8) {//If distance reading from sonar is less that 8cm then stop the robot
        myPort.write('S');
      }
      
      int u=0;
      if (lightss>=1000 && page==3) {// if reading from lights sensitive resistor is greater that 1000 play sound
        u=1;
        if (!lightsareOn.isPlaying() && u==1) { 
          lightsareOn.play();
        }
      } else {
        u=0;
        lightsareOn.stop();
      }
    }
  }
}




//checking to see if the string of data from Arduino includes anything unwanted and removing it
boolean isStringValid(String s) {
  for (int i = 0; i < s.length(); i++ ) {
    char c = s.charAt(i);

    if (c < ',' || c > '9' || (c > ',' && c < '0')) {
      println("found a bad char at position = " + i + " value = " + hex(c));

      myPort.clear(); // discard everything else
      return false;
    }
  }
  return true;
}




void mousePressed() {

  if (page==1 && mouseX>=750 && mouseY>=470 && mouseX<=990 && mouseY <= 530) {//open drive page if drive button is clicked
    link("http://10.225.74.218:8080/?fbclid=IwAR3VbxpIUZNl8VwRMgGDr679M2ApjlcLsF6IO1kyy-FUVkRh_o68ej5oUik");//open webcam tab
    x=0;
    page=3;//go to drive page
  } else if (page==1 && mouseX>=210 && mouseY>=470 && mouseX<=450 && mouseY <= 530) {//open instruction page if instruction button is clicked
    page=2;//go to insrtuction page
    x=0;
  } else   if (page==2 && mouseX>=750 && mouseY>=470 && mouseX<=990 && mouseY <= 530) {//open drive page if drive button is clicked
    link("http://10.225.74.218:8080/?fbclid=IwAR1ulTS2TRgZkTey2MjQlWtscn_GsDx7sMNRMsgTy-vZBpDszw1x1D5mB-Y");
    x=0;
    page=3;//go to drive page
  }else if (page==3 && mouseX>=510 && mouseY>=340 && mouseX<=750 && mouseY <= 400) {//open landing page if instruction page is clicked
    page=1;//go to landing page
    x=0;
  }
}
