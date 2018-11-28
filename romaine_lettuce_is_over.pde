
int radius = 12;
float xpos;
float ypos;   
float xspeed = 3;
float yspeed = 2.5;
int xdirection = 1;
int ydirection = 1;


void setup() {
  size(700, 500);
  xpos = 0 + radius;
  ypos = 0 + radius;
}

void draw() {
  background(0);
  
  xpos = xpos + ( xspeed * xdirection );
  ypos = ypos + ( yspeed * ydirection );
  
  if (xpos > width - radius || xpos < radius) {
    xdirection = xdirection * -1;
  }
  if (ypos > height - radius || ypos < radius) {
    ydirection = ydirection * -1;
  }

  //ball
  fill(255);
  ellipse(xpos, ypos, radius*2, radius*2);
  
  
  //obstacle
  stroke(255, 255, 0);
  rect(550, mouseY, 10, 100);
  
  if (xpos > 550 && ypos - radius > mouseY && ypos < mouseY + 100) {
    xdirection *= -1;
  }

}
