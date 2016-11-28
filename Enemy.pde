class Enemy
{
  PVector pos;
  String name;
  /* size and speed are assumed to be on a scale of 1-10 */
  float speed;
  float size;
  float radCentre;
  float radRadius;
  
  Enemy(String name, float speed, float size, float radCentreX, float radCentreY, float radRadius)
  {
    pos = new PVector(random(radCentreX - radRadius, radCentreX + radRadius), random(radCentreY - radRadius, radCentreY + radRadius));
    this.name = name;
    this.speed = speed;
    this.size = size;
    
  }
  
  void display()
  {
    strokeWeight(map(size, 1, 10, 1, 4));
    stroke(#00FFFF);
    point(pos.x, pos.y);
  }
}