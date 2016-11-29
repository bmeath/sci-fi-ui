class Enemy
{
  PVector pos;
  String name;
  /* size and speed are assumed to be on a scale of 1-10 */
  float speed;
  float size;
  float realSize;
  float realSpeed;
  
  Enemy(String name, float speed, float size, float radCentreX, float radCentreY, float radRadius)
  {
    pos = new PVector(radCentreX + random(radRadius) * sin(random(2 * PI)), radCentreY + random(radRadius) * -cos(random(2 * PI)));
    this.name = name;
    this.speed = speed;
    this.size = size;
    realSize = map(size, 5, 5000, 3, 20);
    realSpeed = map(this.speed, 0, 25, 0, 0.025);
  }
  
  void display()
  {
    
    pos.add(PVector.mult(PVector.fromAngle(map(noise(pos.x, pos.y), 0, 1, -1, 1) * 2 * PI), realSpeed));
    pos.y += (shipSpeed / speedometer.max) * 0.1;
    strokeWeight(realSize);
    stroke(#FFFF00);
    pushMatrix();
    translate(radar.xPos + radar.size/2, radar.yPos + radar.size/2);
    rotate(space.theta);
    PVector p = new PVector(pos.x - (radar.xPos + radar.size/2), (pos.y - (radar.yPos + radar.size/2)));
    point(p.x, p.y);
    popMatrix();
  }
  
  boolean checkPressed()
  {
    if((mouseX > pos.x - realSize/2) && (mouseX < pos.x + realSize/2) && (mouseY > pos.y - realSize/2) && (mouseY < pos.y + realSize/2))
    {
      return true;
    }
    return false;
  }
  
  String toString()
  {
    return pos.toString() + "\t" + name + "\t" + speed + "\t" + size + "\t" + realSize + "\t" + realSpeed;
  }
}