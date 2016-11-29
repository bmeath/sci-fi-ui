class Compass
{
  float theta;
  PVector pos;
  PVector centre;
  float size;
  
  Compass(float xPos, float yPos, float size, float theta)
  {
    pos = new PVector(xPos, yPos);
    this.size = size;
    this.theta = theta;
    centre = new PVector(xPos + size/2, yPos + size/2);
  }
  
  void display(float theta)
  {
    this.theta = theta;
    display();
  }
  
  void display()
  {
    stroke(91);
    fill(0);
    strokeWeight(1);
    ellipse(centre.x, centre.y, size, size);
    ellipse(centre.x, centre.y, size, size);
    
    stroke(#FF0000);
    //triangle(centre.x - size/15, centre.y, centre.x + size/15, centre.y, centre.x + size/2 * sin(theta), centre.y + size/2 * -cos(theta));
    line(centre.x, centre.y, centre.x + size/3 * sin(theta), centre.y + size/3 * -cos(theta));
    
    stroke(#0000FF);
    //triangle(centre.x - size/15, centre.y, centre.x + size/15, centre.y, centre.x + size/2 * sin(theta + radians(180)), centre.y + size/2 * -cos(theta + radians(180)));
    line(centre.x, centre.y, centre.x + size/3 * sin(theta + radians(180)), centre.y + size/3 * -cos(theta + radians(180)));
    
    fill(255);
    textSize(10);
    textAlign(CENTER, TOP);
    text("N", centre.x, centre.y - size/2);
    textAlign(RIGHT, CENTER);
    text("E", centre.x  + size/2, centre.y);
    textAlign(LEFT, CENTER);
    text("W", centre.x  - size/2, centre.y);
    textAlign(CENTER, BOTTOM);
    text("S", centre.x, centre.y  + size/2);
  }
}