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
  
  void display()
  {
    stroke(91);
    fill(0);
    ellipse(centre.x, centre.y, size, size);
  }
}