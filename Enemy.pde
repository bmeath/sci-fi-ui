class Enemy
{
  PVector pos;
  String name;
  /* size and speed are assumed to be on a scale of 1-10 */
  float speed;
  float size;
  
  Enemy(String name, float speed, float size, float radCentreX, float radCentreY, float radRadius)
  {
    pos = new PVector(random(radCentreX - radRadius, radCentreX + radRadius), random(radCentreY - radRadius, radCentreY + radRadius));
    this.name = name;
    this.speed = speed;
    this.size = size;
    
  }
  
  void display()
  {
    strokeWeight(map(size, 1, 10, 2, 8));
    stroke(#FFFF00);
    point(pos.x, pos.y);
  }
  
  String toString()
  {
    return pos.toString() + "\t" + name + "\t" + speed + "\t" + size;
  }
}