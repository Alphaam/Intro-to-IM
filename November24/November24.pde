//maxX2220, maxY = 1080

import processing.serial.*;

int screenWidth = 1000; //set to your maxX
int screenHeight = 900; //set to your maxY
float inByte = 0;
// variables

int halfScreenWidth = 500; // maxX/2
int halfScreenHeight= 450; // maxY/2

boolean gameOn = false; 
boolean hasOverlappedLeftPaddle = false;
boolean hasOverlappedRightPaddle = false;

//ball variables
int xSpeed = 11; // ball speed
int ySpeed = 9; // ball speed
int ballX = 500; // ball X coordinates
int ballY = 400; // ball Y coordinates 
int ballWidth = 50; //ball width
int ballHeight = 50; //ball height
int radius = 50; //ball radius
int diameter = 100; //ball diameter

//left paddle variables
int leftPaddleX = 0; //left paddle X coordinate
int leftPaddleY = 0; //left paddle Y coordinate

//right paddle variables
int rightPaddleX = 910; //right paddle X coordinate
int rightPaddleY = 500; //right paddle Y coordinate

//paddle dimensions
int paddleWidth = 90; // width of paddles
int paddleHeight = 400; // height of paddles

//left player's scores variable
int leftScore = 0;
float leftScoreX = 400; // X coordinate of right player's scorw
float leftScoreY = 540; // Y coordinate of right player's scorw

//right player's score variable
int rightScore = 0;
float rightScoreX = 600; // X coordinate of right player's score
float rightScoreY = 540; // Y coordinate of right player's score


//text variable
float textSize = 60.5; //text size

int halfOfScreenWidth = 500; //maxX/2
int halfOfScreenHeight = 400; //maxY/2

Serial port;
String val;

void setup() //runs once
{
  size(1000, 800);
  println(Serial.list());

  // Open the port that the Arduino board is connected to (in this case #0)
  // Make sure to open the port at the same speed Arduino is using (9600bps)
  port = new Serial(this, Serial.list()[3], 9600);
}

void draw() //runs forever
{

  background(0); //background colour
  displayBall(); //displays ball on game
  displayPaddles(); // displays paddles on game
  displayScores(); // displays player scores on screen
  moveBall(); //moves ball in game
  movePaddles(); // moves paddles in game
  checkLeftPaddle(); // checks if ball overlaps with left paddle
  checkRightPaddle(); // checks if ball overlaps with right paddle
  checkWall(); // checks if ball hits any of the four walls
  setGameMode(); //checks if game is on or off

  // trim off any whitespace:
  //    inString = trim(inString);
}


void displayBall() { 
  //Ball 
  stroke(0, 0, 255);
  fill(0, 0, 255);
  ellipse(ballX, ballY, ballWidth, ballHeight);
}


void displayPaddles() {
  //Paddles 
  stroke(0, 0, 255);
  fill(130, 0, 0);
  rect(leftPaddleX, leftPaddleY, paddleWidth, paddleHeight); //left paddle
  rect(rightPaddleX, rightPaddleY, paddleWidth, paddleHeight); //right paddle
}


void displayScores() {
  //Scores
  textSize(textSize);
  text(leftScore, leftScoreX, leftScoreY);
  text(rightScore, rightScoreX, rightScoreY);
} 


void setGameMode() {
  // checks if game is pressed and turns it on
  if (mousePressed) {
    gameOn = true;  //if game is pressed, game is on
  }
}


void moveBall() {  
  // move ball
  if (gameOn) { // if game is on paddles can move
    movePaddles();
    turnLightsOff();
    ballX = ballX-xSpeed; //changes ball's speed and direction
    ballY = ballY+ySpeed; //changes ball's speed and direction
  }
}

void movePaddles() {
  //moves paddles
  if (mouseX < halfOfScreenWidth)
  {
    leftPaddleY = constrain(mouseY, 0, screenHeight-paddleHeight);
  }

  if (mouseX > halfOfScreenWidth) 
  {
    rightPaddleY = constrain(mouseY, 0, screenHeight-paddleHeight);
  }
}


void checkWall() {
  //checks if ball hits top or bottom walls 
  if ((ballY-radius<0) || (ballY+radius) >screenHeight) {
    ySpeed = ySpeed * -1; // reverses ball direction
  }

  //checks if ball hits right wall
  if (ballX+radius> screenWidth) {
    leftScore = leftScore+1; // increments left score
    ballX = halfScreenWidth; //returns ball to initial x coordinate position
    ballY = halfScreenHeight; //returns ball to initial y coordinate position
    for (int x=0; x<=1000; x++) {
      if (x<1000) {
        port.write('H');
      } else {
        turnLightsOff();
      }
    }
    gameOn = false; //turns game off
  }

  //checks if ball hit left wall
  if (ballX-radius<0) {
    rightScore = rightScore+1; // increments right score
    ballX = halfScreenWidth; //returns ball to initial x coordinate position
    ballY = halfScreenHeight; //returns ball to initial y coordinate position
    for (int x=0; x<=1000; x++) {
      if (x<1000) {
        port.write('H');//turn on red light
      } else {
        turnLightsOff();
      }
    }
    gameOn = false; //turns game off
  }
} 



void checkLeftPaddle() {
  //checks if there is an overlap between ball and left paddle
  hasOverlappedLeftPaddle = doesOverlap(leftPaddleX, leftPaddleY, paddleWidth, paddleHeight, ballX, ballY, radius);
  if (hasOverlappedLeftPaddle) {
    xSpeed = xSpeed * -1;
    for (int x=0; x<=500; x++) {
      if (x<1000) {
        port.write('L');//turn on green light
      } else {
        turnLightsOff();
      }//turn off the lights
    }
  }
}


void checkRightPaddle() {
  //check if there is an overlap between ball and left paddle
  hasOverlappedRightPaddle = doesOverlap(rightPaddleX, rightPaddleY, paddleWidth, paddleHeight, ballX, ballY, radius); 
  if (hasOverlappedRightPaddle) {
    xSpeed = xSpeed * -1;
    for (int x=0; x<=500; x++) {
      if (x<1000) {
        port.write('L');//turn on green light
      } else {
        turnLightsOff();//turn off the lights
      }
    }
  }
}


//check if ball overlaps paddle
boolean doesOverlap(float xPaddle, float yPaddle, float widthPaddle, float
  heightPaddle, float xBall, float yBall, float radius) {

  float ballLeftEdge = xBall-radius; //left edge of ball
  float ballBottomEdge = yBall+radius; //bottom edge of ball
  float ballRightEdge = xBall+radius; //right edge of ball
  float ballTopEdge = yBall-radius; //top edge of ball

  float paddleLeftEdge = xPaddle; //left edge of paddle
  float paddleBottomEdge = yPaddle+heightPaddle; //bottom edge of paddle
  float paddleRightEdge = xPaddle+widthPaddle; //right edge of paddle
  float paddleTopEdge = yPaddle; //top edge of paddle

  if (ballBottomEdge >= paddleTopEdge //Check if bottom edge of ball and top edge ofpaddle overlap
    && ballTopEdge <= paddleBottomEdge //Check if top edge of ball and bottom edge 
    && ballLeftEdge <= paddleRightEdge //Check if left edge of ball and right edge ofpaddle overlap
    && ballRightEdge >= paddleLeftEdge) //Check if right edge of ball and left edgeof paddle overlap
  {
    return true;
  } else {
    return false;
  }
}

//Function that turns lights off
void turnLightsOff() {

  port.write('h');
}

void restart() {

  rightScore = 0;
  leftScore = 0;
  ballX = 500; // ball X coordinates
  ballY = 400; // ball Y coordinates
}


//Recieves information from Arduino
void serialEvent (Serial port) {

  if ( port.available() > 0) {// If data is available,
  
    val = port.readStringUntil('\n');//read the data until there is a line break
    
    if (val != null && val != "") {//if the data isn't null or aan empty space do the following
      val = trim(val);// read it, trim it and store it in val

      if (!isStringValid(val)) {
        port.clear(); // discard everything else
        return; // don't do the rest of this function
      }
      int state = Integer.valueOf(val);//converting data into intergers
      println(state); //print it out in the console
      
      if (state!=0) { //if the button state is not low then restart the game
        leftScore = 0;//reset the left score to 0
        rightScore=0;//reset the right score to 0
        ballX = 500; // ball X coordinates
        ballY = 400; // ball Y coordinates
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

      port.clear(); // discard everything else
      return false;
    }
  }
  return true;
}
