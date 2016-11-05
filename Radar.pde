class Radar
{
  float xPos, yPos;
  float size;
  color colour;
  color textColour;
  float theta;
  float speed;
  
  Radar()
  {
    xPos = 100;
    yPos = 150;
    size = 100;
    colour = #00FF00;
    textColour = #00FF00;
    theta = 0;
    speed = 1;
  }
  
  Radar(float xPos, float yPos, float size, String title, color colour, color textColour, float speed)
  {
    this.xPos = xPos;
    this.yPos = yPos;
    this.size = size;
    this.colour = colour;
    this.textColour = textColour;
    this.speed = speed;
  }
  
  Radar(float xPos, float yPos, float size)
  {
    this();
    this.xPos = xPos;
    this.yPos = yPos;
    this.size = size;
  }
  
  void display()
  {
    fill(0);
    stroke(91);
    strokeWeight(3);
    rect(xPos - size/2, yPos - size/2, size, size);
    
    float xOuter, yOuter;
    
    noFill();
    strokeWeight(1);
    
    stroke(colour, 127);
    line(xPos, yPos + size/2.1, xPos, yPos - size/2.1);
    line(xPos - size/2.1, yPos, xPos + size/2.1, yPos);
    
    stroke(colour);
    ellipse(xPos, yPos, size * 0.95, size * 0.95);
    
    strokeWeight(2);
    for(float j = 0; j < 16; j += 0.5)
    {
      xOuter = xPos + ((size/2.1) * sin(theta - radians(j)));
      yOuter = yPos - ((size/2.1) * cos(theta - radians(j)));
      line(xPos, yPos, xOuter, yOuter);
      strokeWeight(1);
      if(j % 4 == 0)
      {
        stroke(colour, 127);
        ellipse(xPos, yPos, j * size/16, j * size/16);
      }
      stroke(colour, 127 - (8 * j));
    }
    theta += radians(speed);
  }
  
  String toString()
  {
    return xPos + "\t" + yPos + "\t" + size + "\t" + colour + "\t" + textColour + "\t" + theta + "\t" + speed;
  }
}