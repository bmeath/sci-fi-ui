void setup()
{
  size(1280, 720);
}
Gauge speedometer = new Gauge(200, 200, 150, "Velocity", "KM/H", 0, 280, 50, 5, #FF0000, #FFFFFF, #0000FF);
float i = 0;
void draw()
{
  background(0);
  
  speedometer.display(map(mouseY, 0, height, 0, 280));

}