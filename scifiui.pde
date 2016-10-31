void setup()
{
  size(1280, 720);
}

Gauge speedometer = new Gauge();

void draw()
{
  background(9);
  speedometer.display(map(mouseY, 0, height, 0, 100));
}