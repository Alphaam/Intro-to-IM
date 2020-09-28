//maxX2220, maxY = 1080

int screenWidth = 2220; //set to your maxX
int screenHeight = 1080; //set to your maxY

// variables
 
int halfScreenWidth = 1110; // maxX/2
int halfScreenHeight= 540; // maxY/2

boolean gameOn = false; 
boolean hasOverlappedLeftPaddle = false;
boolean hasOverlappedRightPaddle = false;

 //ball variables
int xSpeed = 11; // ball speed
int ySpeed = 9; // ball speed
int ballX = 1110; // ball X coordinates
int ballY = 540; // ball Y coordinates 
int ballWidth = 100; //ball width
int ballHeight = 100; //ball height
int radius = 50; //ball radius
int diameter = 100; //ball diameter

 //left paddle variables
int leftPaddleX = 0; //left paddle X coordinate
int leftPaddleY = 0; //left paddle Y coordinate

 //right paddle variables
int rightPaddleX = 2130; //right paddle X coordinate
int rightPaddleY = 680; //right paddle Y coordinate

 //paddle dimensions
int paddleWidth = 90; // width of paddles
int paddleHeight = 400; // height of paddles

 //left player's scores variable
int leftScore = 0;
float leftScoreX = 795; // X coordinate of right player's scorw
float leftScoreY = 540; // Y coordinate of right player's scorw

 //right player's score variable
int rightScore = 0;
float rightScoreX = 1360; // X coordinate of right player's score
float rightScoreY = 540; // Y coordinate of right player's score


 //text variable
 float textSize = 110.5; //text size
 
 int halfOfScreenWidth = 1110; //maxX/2
 int halfOfScreenHeight = 540; //maxY/2
 


void setup() //runs once
{
  fullScreen(); //Sets the program to run in full screen mode
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
}
  
  
   void displayBall() { 
    //Ball 
  stroke(0,0,255);
  fill(0,0,255);
  ellipse(ballX,ballY,ballWidth,ballHeight);
}
 
 
   void displayPaddles() {
     //Paddles 
  stroke(0,0,255);
  fill(130,0,0);
  rect(leftPaddleX,leftPaddleY,paddleWidth,paddleHeight); //left paddle
  rect(rightPaddleX,rightPaddleY,paddleWidth,paddleHeight); //right paddle
}
  
  
   void displayScores() {
     //Scores
  textSize(textSize);
  text(leftScore,leftScoreX,leftScoreY);
  text(rightScore,rightScoreX,rightScoreY);     
} 

  
    void setGameMode() {
   // checks if game is pressed and turns it on
  if(mousePressed){
    gameOn = true;  //if game is pressed, game is on
  }
}

   
    void moveBall() {  
   // move ball
 if(gameOn){ // if game is on paddles can move
   movePaddles();
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
 if((ballY-radius<0) || (ballY+radius) >screenHeight){
   ySpeed = ySpeed * -1; // reverses ball direction
  }
   
    //checks if ball hits right wall
  if(ballX+radius> screenWidth){
    leftScore = leftScore+1; // increments left score
    ballX = halfScreenWidth; //returns ball to initial x coordinate position
    ballY = halfScreenHeight; //returns ball to initial y coordinate position
    gameOn = false; //turns game off
   }
    
     //checks if ball hit left wall
 if(ballX-radius<0){
   rightScore = rightScore+1; // increments right score
   ballX = halfScreenWidth; //returns ball to initial x coordinate position
   ballY = halfScreenHeight; //returns ball to initial y coordinate position
   gameOn = false; //turns game off
  }
} 
   


   void checkLeftPaddle() {
  //checks if there is an overlap between ball and left paddle
  hasOverlappedLeftPaddle = doesOverlap(leftPaddleX, leftPaddleY, paddleWidth, paddleHeight, ballX, ballY, radius);
  if (hasOverlappedLeftPaddle) {
    xSpeed = xSpeed * -1;
    
  }
}

  
  void checkRightPaddle() {
  //check if there is an overlap between ball and left paddle
  hasOverlappedRightPaddle = doesOverlap(rightPaddleX, rightPaddleY, paddleWidth, paddleHeight, ballX, ballY, radius);
  if (hasOverlappedRightPaddle) {
  xSpeed = xSpeed * -1;
  
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
 
