class Enemy
{
  String name;
  /* size and speed are assumed to be on a scale of 1-10 */
  float speed;
  float size;
  
  Enemy(String name, float speed, float size)
  {
    this.name = name;
    this.speed = speed;
    this.size = size;
  }
}