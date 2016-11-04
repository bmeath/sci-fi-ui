class Radar
{
  float xPos, yPos;
  float size;
  String title;
  color colour;
  color textColour;
  float theta;
  
  Radar()
  {
    xPos = 100;
    yPos = 150;
    size = 100;
    title = "measurement";
    colour = #FFFFFF;
    textColour = #FFFFFF;
    theta = 0;
  }
  
  Radar(float xPos, float yPos, float size, String title, color colour, color textColour)
  {
    this.xPos = xPos;
    this.yPos = yPos;
    this.size = size;
    this.title = title;
    this.colour = colour;
    this.textColour = textColour;
  }
  
  void display()
  {
    float xOuter, yOuter;
    stroke(255);
    noFill();
    strokeWeight(1);
    ellipse(xPos, yPos, size, size);
    for(float j = 1; j < 15; j += 0.5)
    {
      stroke(255 - (16 * j));
      xOuter = xPos + ((size/2) * sin(radians(theta - j)));
      yOuter = yPos - ((size/2) * cos(radians(theta - j)));
      line(xPos, yPos, xOuter, yOuter);
    }
    theta++;
  }
  
  String toString()
  {
    return xPos + "\t" + yPos + "\t" + size + "\t" + title + "\t" + colour + "\t" + textColour + "\t" + theta;
  }
}