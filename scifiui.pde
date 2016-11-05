void setup()
{
  size(1280, 720);
}
Gauge speedometer = new Gauge(200, 200, 200, "Velocity", "KM/H", 0, 300, 50, 5, #FF0000, #FFFFFF, #0000FF);
Radar radar = new Radar(1000, 500, 200, "Radar", #00FF00, #00FF00);
float i = 0;
void draw()
{
  background(0);
  
  speedometer.display(map(mouseY, 0, height, 0, 300));
  radar.display();
}