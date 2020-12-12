## PROJECT IDEA

I am planning on building a minuature car complete with the ability to turn around corners, reverse, change speed, blink indicator lights, remote navigation, and honk with it's primary controls being executed by means of processing.


A simple sketch of what I intend for the car to look like can be seen below.

## SKETCH OF THE CAR

![](20201124_130029.jpg)
![](20201124_125835.jpg)

## INTENDED PROCESS
As it stands now,I am planning to use a series of boxes for the body, LED lights for the blinkers, the larger motors for the wheels, to use the smalller motor to turn corners, and my cellphone camera as the car's camera that I will use for remote navigation.

I will link different controls for the car to different keyboard buttons. The enter button being the start and stop button, and the arrow keys controlling the direction of the car.

The trickiest parts, I expect, will be execution of the turning of the car and balancing everything ontop of the car seeing as I only have two wheels. I expect to find a way around this by providing the car with extra supports on either ends by means of glued on cardboard strips or sticks. The turning of the car using the smaller motor I expect to accomplish by attaching the smaller motor with its longer rotor to the bottom of the car in such a way that when a turn is comanded, the rotor will turn, come into contact with the ground in such a way that it lifts the car off the ground and orients it in a slightly different direction as intended.


## DAY 1

Started building the car. Used two wheels attached to motors. I glued the two motors on either side of them to a double layered cardboard box. I am thinking of how to balance the cardboard box. Leading thoughts are either to get two more wheels or create support system out of cardboard beams on each edge of the cardboard box.

Ditched the idea of turning using the smaller motor. Instead I will use selective running of motor from each side to turn the car.

# CAR SO FAR

![]()

## DAY 2

Decided to add two more wheels for balance. Coded the Aduino and Processing portions to be able to move backward, forward, left, and right. Encountered a problem when coding a function that commands the car to stop. Whenever I had the code on arduino the car wouldn't work at all. 

## DAY 3
Solved the problem with the brake feature. Turns out I had the stop function on the loop part of the arduino code so the default is to have the car not moving. Added sonar sensor to the back of the car that stops the car when it is in reverse and is 20cm away from an obstacle. Also added indicator lights that blink on turning the car left or right.

I had a problem with using millis when controlling the blinking of the lights as well as programming the sonar sensor. I was not very comfortable with the concept but watched tutorials and was able to figure it out.

# VIDEO OF THE CAR WORKING YAY
![]()

## DAY 4
LOST ALL MY CODE AAAA

## DAY 5
Recreated all my code that I had by Day 3. Can't figure out how to use millis again.

## DAY 6
Built a carrier for my phone infront of the car used metal hangers, cardboard box pieces and duct tape. Intending to use my phone as a webcam for the remote navigation of the car. Found an app that turns my phone into a webcam. 

# PIC OF CAR WITH HANGER

![]()

## DAY 7
Feeling like my project is too trivial. Looking to encorporate a goal or task that it does.

Decided to make my car into a robot that tells a user if there is a light on in a room in the house by use of a light sesnsitive resistor. Thinking of adding a  sound feature into the robot that makes the experience with the robot more interractive. 

Added the light sensitive resistor to the robot. Programmed it so that it sent information to Processing. It was difficult to do this since I was sending two signals from Arduino to processing at once (sonar and now the light sensitive resistor) and I wasn't completely comfortable with how to do this but I revisited the lecture we had on this and was able to do it.

Recorded sounds for when the user turned on the robot, when the user asked for instructions, when the user started driving the robot, and when the robot found the lights were on. Attempted to make my voice sound robotic. Failed miserably but will still use this audio footage.

# VIDEO OF PROGRAM WITH THE SOUNDS
[Video]()

## DAY 8
Everything is running smoothly. Robot is passing all the driving tests. Created the front end of the robot's program. Went with a neon background for a futuristic theme. Also added text that was similar to the text font from my midterm project because I like how it looks with the neon background. Attachd a link to the webcam in the drive button that I encorporated into the program.

Added the landing page, instruction page and driving page to the program.

Encountered a problem when linking the audios for each corresponding section. I can't play two audios at once. Decided to change the design so there wouldn't need to be two audios playing at once. I removed honking feature.

Sometimes data would not get transmitted form arduino to processing. I don't know why this happens but it gets fixed when I upload the arduino code again.

Want to make a top cover for the arduino board but I don't think I will have enough time.

Everything seems to work. Tested the robot. I had to change the amount of power I fed to the motors because the 255 input moved the wheels too fast that dropped my phone from the carrier. Brought the value down to 150.

Tested the robot twice. Everything works fine. Ready to present in class tomorrow.
