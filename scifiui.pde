void setup()
{
  size(1280, 720);
}

CircularGauge speedometer = new CircularGauge((0.5 * 1280) - 150/2, 0.63 * 720, 150, "Velocity", "KM/H", 0, 1000, 200, 20, #FF0000, #FFFFFF, #0000FF);
VerticalGauge thermometer = new VerticalGauge(0.04 * 1280, 0.75 * 720, 150, "Temperature", "C", 0, 800, 100, #FF0000, #FFFFFF, #FFFFFF);
Radar radar = new Radar(0.7 * 1280, 0.63 * 720, 150);
Button radarPower = new Button(0.7 * 1280, 0.85 * 720, 48, "Radar", #303030, #FEA500, radar.power);

void draw()
{
  background(0);
  drawCockpit();
  
  speedometer.display(map(mouseY, 0, height, 0, 1000));
  radar.display();
  radarPower.display();
  thermometer.display(map(mouseX, 0, width, 0, 800));
  
}

void mouseClicked()
{
  if(radarPower.pressed())
  {
    radar.toggle();
  }
}

void drawCockpit()
{
  fill(127);
  stroke(91);
  
  beginShape();
  vertex(0,0);
  vertex(0, 0.15 * height);
  vertex(0.1 * width, 0.15 * height);
  vertex(0.2 * width, 0.1 * height);
  vertex(0.8 * width, 0.1 * height);
  vertex(0.9 * width, 0.15 * height);
  vertex(width, 0.15 * height);
  vertex(width, 0);
  endShape();
  
  beginShape();
  vertex(0,height);
  vertex(0, 0.75 * height);
  vertex(0.15 * width, 0.6 * height);
  vertex(0.85 * width, 0.6 * height);
  vertex(width, 0.75 * height);
  vertex(width, height);
  endShape();
  
  
}