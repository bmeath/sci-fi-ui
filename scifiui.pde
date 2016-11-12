void setup()
{
  size(1280, 720);
  
  for(int i = 0; i < stars.length; i++)
  {
    stars[i][0] = random(0, width);
    stars[i][1] = random(0.1 * height, 0.75 * height);
  }
    background(0);
  drawBackground();
  drawCockpit();
}

CircularGauge speedometer = new CircularGauge((0.5 * 1280) - 150/2, 0.63 * 720, 150, "Velocity", "x1000\nkm/h", 0, 25, 5, 1, #FF0000, #FFFFFF, #0000FF);
VerticalGauge thermometer = new VerticalGauge(0.04 * 1280, 0.75 * 720, 150, "Temperature", "Deg. C", 0, 1500, 250, #FF0000, #FFFFFF, #FFFFFF);
Radar radar = new Radar(0.7 * 1280, 0.63 * 720, 150);
Button radarPower = new Button(0.7 * 1280, 0.85 * 720, 48, "Radar", #303030, #FEA500, radar.power);
Button hyperdrive = new Button(0.35 * 1280, 0.93 * 720, 48, "Warp", #303030, #00FFFF, false);
float[][] stars = new float[500][2];

void draw()
{

  speedometer.display(map(mouseY, 0, height, 0, 25));
  radar.display();
  radarPower.display();
  hyperdrive.display();
  thermometer.display(map(mouseX, 0, width, 0, 1500));
  
}

void mouseClicked()
{
  if(radarPower.pressed())
  {
    radar.toggle();
  }
  if(hyperdrive.pressed())
  {
    enterHyperspace();
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

void enterHyperspace()
{
  float dx, dy;
  for (int i = 0; i <= 10; i++)
  {
    for(float[] coord: stars)
    {
      dx = coord[0] - width/2;
      dy = coord[1] - height/2;
      line(coord[0], coord[1], coord[0] + lerp(0, dx, i/10), coord[1] + lerp(0, dy, i/10));
    }
  }

}

void drawBackground()
{
  stroke(#87CEEB);
  strokeWeight(2);
  for(float[] coord: stars)
  {
    point(coord[0], coord[1]);
  }
}