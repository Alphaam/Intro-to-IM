//Night Sky Portrait
void setup() {
  size(800, 800);
  background(0, 0, 0);
}


int x = 0;//variable to control number of stars
int y = 0;//variable to control number of trees
int frameThickness = 30;//Thickness of frame


void draw() {

  moon();//calling moon function
  drawLandscape();//calling landscape function

  //drawing frames for canvas
  drawFrame(0, width-frameThickness, width, frameThickness);
  drawFrame(0, 0, frameThickness, height);
  drawFrame(0, 0, width, frameThickness);
  drawFrame(width-frameThickness, 0, frameThickness, height);

  //loop to draw stars
  while (x<width) { 
    x=x+5;
    drawStars();
  }

  //loop to draw trees
  while (y < width ) {
    y=y+20;
    drawTrees();
  }
}


//function to draw stars
void drawStars() {
  int randomXcoordinate = int(random(1, 800));//random x position of star
  float randomYcoordinate= random(1, 800);//random y position of star
  float starThickness = random(1, 3);//thickness of star
  int starColour = int(random( 0, 2));//controlling colour of star

  //if statement to decide colour of stats
  if (starColour==0) {
    //white star
    fill(255, 255, 255);
    stroke(255, 255, 255);
    ellipse(randomXcoordinate, randomYcoordinate, starThickness, starThickness);
  } else {
    //gold star
    fill(242, 191, 2);
    stroke(242, 191, 2);
    ellipse(randomXcoordinate, randomYcoordinate, starThickness, starThickness);
  }
}


//function that draws frame
void drawFrame(float xCoordinate, float yCoordinate, float rectWidth, float rectHeight) {
  fill(232, 144, 2);
  stroke(255, 255, 255);
  rect(xCoordinate, yCoordinate, rectWidth, rectHeight);
}


//Function that draws landscape
void drawLandscape() {
  fill(255, 255, 255);
  stroke(255, 255, 255);
  rect(0, 740, 800, 30);
}


//Function that draws trees
void drawTrees() {
  float treeTipY = random(600, 700);//tree tip Y coordinate
  float treeTipX = random(0, 800);//tree tip X coordinate
  float treeRoots1 = random(0, 10);//Base of Trees
  fill(255, 255, 255);
  stroke(255, 255, 255);
  triangle(treeTipX, treeTipY, treeTipX+treeRoots1, 770, treeTipX-treeRoots1, 770);
}


//Function thst draws the moon
void moon() {
  fill(255, 255, 255);
  stroke(255, 255, 255);
  ellipse(800, 0, 300, 300);
}
