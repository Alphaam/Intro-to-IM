//SELF PORTRAIT


//setting canvas size
float canvasWidth = 600;
float canvasHeight = 600;
size (600, 600);

 
//Afro
fill(0,0,0);//Color of Afro
ellipse(canvasWidth/2, 175, 400, 350);//Afro outline


//face 
fill(144, 82, 82);//face color
ellipse(150, canvasHeight/2, 100, 100); //left ear
ellipse(450, canvasHeight/2, 100, 100); //right ear
ellipse(canvasWidth/2, canvasHeight/2, 300, 400); //face structure


//eyes outline
fill(255,255,255);
arc(225, canvasHeight/2, 80, 70,0,PI);//bottom part of left eye
arc(375, canvasHeight/2, 80, 70,0,PI);//bottom part of right eye

//eyeballs
fill(0,0,0);//eyeball color
ellipse(225, 310, 45, 40);//left eyeball
ellipse(375, 310, 45, 40);//right eyeball

//eyelid
fill(160, 98, 98);//color of eyelids
arc(225, canvasHeight/2, 80, 70,PI, TWO_PI);//left eyelid
arc(375, canvasHeight/2, 80, 70,PI, TWO_PI);//right eyelid
fill(0,0,0);//eyelid boundary color
line(185,canvasHeight/2,265,300);//left eyelid boundary
line(335,canvasHeight/2,415,300);//right eyelid boundary


//hairline
fill(0,0,0);//hairline color
rect(150, 100, canvasHeight/2, 120);//hairline shape


//mouth
noStroke();//removing lip boundaries
fill(160, 98, 98);//lip colour
ellipse(270,400,90, 40);//upper left lip
ellipse(330,400,90, 40);//upper right lip
arc(canvasHeight/2,400, 150, 110, 0, PI);//lower lip
stroke(0,0,0);//teeth outline
fill(255,255,255);//teeth color
arc(canvasHeight/2,400, 150, 60, 0, PI);//teeth


//nose
fill(160, 98, 98);//nose color
quad(canvasWidth/2,canvasHeight/2, 330, 355, 300, 370,270,355);//nose


//earring
strokeWeight(16);//earring size
stroke(250, 255, 111);//earring color
point(130, 340);//earing


//eyevrows
strokeWeight(10);//eyebrow size
stroke(0,0,0);//eyebrow color
line(265,250,185,250);//left eyebrow
line(335,250,415,250);//right eyebrow
