boolean up = false, down = false, w = false, s = false;
Leftpaddle left;
Rightpaddle right;
Ball newball;
int gameScreen = 2;
import ddf.minim.*;
Minim minim;
AudioPlayer gruntOne;
AudioPlayer gruntTwo;
PImage bg;
PImage otherbg;
PImage ecoli;
PImage playerleft;
PImage playerright;
int loseScreen;
String righttyping = "";
String rightsaved = "";
String lefttyping = "";
String leftsaved = "";
PFont f;

 

void setup() {
  size(700, 500);
  left= new Leftpaddle();
  right= new Rightpaddle();
  newball= new Ball();
  minim = new Minim(this);
  gruntOne = minim.loadFile("grunt1.wav");
  gruntTwo = minim.loadFile("grunt2.wav");
  bg = loadImage("background.jpg");
  otherbg = loadImage("otherbackground.png");
  ecoli = loadImage("ecoli.png");
  playerleft = loadImage("playerleft.png");
  playerright = loadImage("playerright.png");
  f = createFont("Arial",16);
  textFont(f); 
}


void draw() {
    background(0);
if (gameScreen == 0) {
    playScreen();
  } else if (gameScreen == 1) {
    overScreen();
  } else if (gameScreen == 2) {
    startScreen();
  }
  else if (gameScreen == 3) {
    rightScreen();
  }else if (gameScreen == 4) {
    leftScreen();
  }
}



void playScreen() {
  background(bg);
  newball.move();
  newball.bounce();
  newball.show();
  println(newball.xpos,newball.ypos);
  

  left.show();
  right.show();
    if (up==true)
    {
      right.moveup();
    }
    if (down==true)
    {
      right.movedown();
    }
    if (w==true)
    {
      left.moveup();
    }
    if (s==true)
    {
      left.movedown();
    }
    if (newball.xpos<140) {
      gameScreen = 1;
      loseScreen = 0;
      
    }
    if (newball.xpos>570){
      gameScreen = 1;
      loseScreen = 1;
    }
}

void overScreen() {
  background(otherbg);
  fill(255,255,255);
  text("Game Over loser", 200, 200);
  if (loseScreen == 0) {
    text("congratulations " + rightsaved + ", you have successfully saved your romaine lettuce farm!", 25,230);
  }
  else if (loseScreen == 1) {
    text("congratulations " + leftsaved + ", you have successfully saved your romaine lettuce farm!", 25,230);
  }
  if (mousePressed==true) {
    newball.xpos = width/2;
    newball.ypos = int(random(0,500));
    gameScreen = 2;
  }}
    
void startScreen(){
  background(otherbg);
  text("protect your lettuce from the e.coli outbreak!", 25, 40);
  text("click to continue" ,400,190);
  if (mousePressed==true) {
  gameScreen = 4;
  }

}

void leftScreen() {
  background(otherbg);
  text("If you are sitting on the left, please enter your name in the space below ", 25, 40);
  text("and then press the TAB button to continue.", 25, 60);

  text("Left player's name: " + lefttyping,200,190);
}

void rightScreen() {
  background(otherbg);
  text("If you are sitting on the right, please press backspace until the field is cleared,", 25, 40);
  text("type your name in and the press enter to begin the game.", 25, 60);
  text("Right player's name: " + righttyping,200,190);
}




void keyPressed()
{
  if (keyCode == DOWN)
  {
    down = true;
  }
  if (keyCode == UP)
  {
    up = true;
  }
  if (key == 'w')
  {
    w=true;
  }
  if (key == 's' )
  {
    s=true;
  }
  if (key == '\n' ) {
    rightsaved = righttyping;
    righttyping = "  "; 
    gameScreen = 0;
  }
  else {
    righttyping = righttyping + key; 
  }
  if (key == TAB ) {
    leftsaved = lefttyping;
    lefttyping = "  "; 
    gameScreen = 3;
    
  }
  else {
    lefttyping = lefttyping + key; 
  }
   if (key == BACKSPACE) {
      if (righttyping.length() > 0) {
        righttyping = righttyping.substring(0, max(0, righttyping.length()-1));
        ;
      }
      }
    
}
void keyReleased()
{
  if (keyCode == DOWN)
  {
    down = false;
  }
  if (keyCode==UP)
  {
    up = false;
  }
  if (key=='w')
  {
    w=false;
  }
  if (key=='s')
  {
    s=false;
  }
}


class Ball {   

  float xpos= 350;
  float ypos= 350;  
  float xspeed = 3;
  float yspeed = 2.5;
  int xdirection = 1;
  int ydirection = 1;
  int radius = 12;
  
  void move(){
  
     xpos = xpos + ( xspeed * xdirection );
     ypos = ypos + ( yspeed * ydirection );
  
     if (xpos > width - radius || xpos < radius) {
       xdirection = xdirection * -1;
      }
      
     if (ypos > height - radius || ypos < radius) {
       ydirection = ydirection * -1;
      }
  }
  
   void show(){   
    fill(255);
    image(ecoli, xpos, ypos, 24, 24);
   }
    

  void bounce() {  

   if (xpos > 150 && xpos < 160 && ypos > left.y && ypos < left.y + 100){
      xdirection *= -1;
      gruntOne.play();
      gruntOne.rewind();
    }
    if (xpos > 550 && xpos < 560 && ypos > right.y && ypos < right.y + 100){
      xdirection *= -1;
      gruntTwo.play();
      gruntTwo.rewind();
    }
  }
  
}



class Leftpaddle {   
  int x,y;
  
  Leftpaddle(){
    y=400;
    x=125;
  }
  
  void show() {
  fill(255, 0, 0);
    image(playerleft, x, y, 75, 100);

  }
  
  void moveup() {
    if (y>0){
      y-=5;
    }
  }
    
  void movedown() {
    if (y<400){
      y+=5;
    }
  }
}
   
class Rightpaddle {   
  int y, x;
  Rightpaddle(){
    y=400;
    x=525;
  }
  
  void show() {
  fill(255, 0, 0);
  image(playerright, x, y, 75, 100);
  }
  
  void moveup() {
    if (y>0){
      y-=5;
    }
  }
    
  void movedown() {
    if (y<400){
      y+=5;
    }
  }
} 
