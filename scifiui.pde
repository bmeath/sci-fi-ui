void setup()
{
  size(1280, 720);
}
Gauge speedometer = new Gauge(0.5 * 1280, 0.73 * 720, 150, "Velocity", "KM/H", 0, 1000, 200, 20, #FF0000, #FFFFFF, #0000FF);
Radar radar = new Radar(0.78 * 1280, 0.73 * 720, 150);
Button radarPower = new Button(0.86 * 1280, 0.67 * 720, 48, "Radar", #505050, #00FF00, false);

void draw()
{
  background(0);
  drawCockpit();
  speedometer.display(map(mouseY, 0, height, 0, 1000));
  radar.display();
  radarPower.display();
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