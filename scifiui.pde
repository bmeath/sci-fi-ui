void setup()
{
  size(1280, 720);
}
Gauge speedometer = new Gauge(750, 200, 300, "Velocity", "KM/H", 0, 300, 50, 5, #EEBFDF, #FF0000, #F0F00F);
Gauge speedometer2 = new Gauge();
Radar radar = new Radar(1000, 500, 200, "Radar", #777777, #FFFFFF, 1);
Radar radar2 = new Radar(500, 500, 400);
Radar radar3 = new Radar(700, 650, 74);
Button radarPower = new Button(150, 600, 100, "Radar", #00FFFF, #00FFFF, false);

void draw()
{
  background(0);
  
  speedometer.display(map(mouseY, 0, height, 0, 300));
  speedometer2.display(map(mouseX, 0, width, 0, 100));
  radar.display();
  radar2.display();
  radar3.display();
  radarPower.display();
}

void drawCockpit()
{
  float window;
}