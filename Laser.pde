class Laser
{
  PVector pos;
  PVector forward;
  PVector dest;
  float size;
  float speed;
  int time_start;
  int ttl;
  float age;
  float theta;
  color colour;
  float dist;
  
  Laser(PVector source, float xDest, float yDest, color colour)
  {
    this.colour = colour;
    this.pos = source.copy();
    this.dest = new PVector(xDest, yDest);
    dist = dist(pos.x, pos.y, xDest, yDest);
    speed = dist/13;
    pushMatrix();
    translate(pos.x, pos.y);
    forward = new PVector(xDest - pos.x, yDest - pos.y);
    forward.div(forward.mag());
    popMatrix();
    size = 10;
  }
  
  void display()
  {
    pos.add(PVector.mult(forward, speed));
    stroke(colour);
    size = map(dist(pos.x, pos.y, dest.x, dest.y), dist, 0, 10, 0); // give depth effect
    strokeWeight(size);
    line(pos.x, pos.y, pos.x + (2 * speed * forward.x), pos.y + (2 * speed * forward.y));
  }
}