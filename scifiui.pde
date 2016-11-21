CircularGauge speedometer;
VerticalGauge thermometer;
Radar radar;
Button radarPower;
Button hyperdrive;
float hyperspeed;
float[][] stars;

void setup()
{
  size(1280, 720);
  
  speedometer = new CircularGauge(0.5 * width - 150/2, 0.63 * height, 150, "Velocity", "x1000\nkm/h", 0, 25, 5, 1, #FF0000, #FFFFFF, #0000FF);
  thermometer = new VerticalGauge(0.04 * width, 0.75 * height, 150, "Temperature", "Deg. C", 0, 1500, 250, #FF0000, #FFFFFF, #FFFFFF);
  radar = new Radar(0.7 * width, 0.63 * height, 150);
  radarPower = new Button(0.7 * width, 0.85 * height, 48, "Radar", #303030, #FEA500, radar.power);
  hyperdrive = new Button(0.35 * width, 0.93 * height, 48, "Warp", #303030, #00FFFF, false);
  hyperspeed = 0;
  stars = new float[1000][2];
  for(float[] s: stars)
  {
    s[0] = random(-width/2, width/2);
    s[1] = random((0.1 * height) - height/2, (0.75 * height) - height/2);
  }

}

void draw()
{
  background(0);
  if(hyperdrive.state)
  {
    if(hyperspeed < 45)
    {
      hyperspeed += 0.5;
    }
  }
  else
  {
    hyperspeed = 0;
  }
  drawStars(hyperspeed);
  drawCockpit();
  speedometer.display(5 + hyperspeed);
  radarPower.display();
  hyperdrive.display();
  thermometer.display(map(hyperspeed, 0, 45, 0, 1500));
  
}

void mouseClicked()
{
  if(radarPower.pressed())
  {
    radar.toggle();
  }
  if(hyperdrive.pressed())
  {
    if(hyperdrive.state == false)
    {
      // exited hyperspace, generate destination environment
      for(float[] s: stars)
      {
        s[0] = random(-width/2, width/2);
        s[1] = random((0.1 * height) - height/2, (0.75 * height) - height/2);
      }
    }
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

void drawStars(float len)
{
  stroke(#FFFFFF);
  strokeWeight(2);
  PVector v;
  pushMatrix();
  translate(width/2, height/2);
  for(float[] s: stars)
  {
    v = new PVector(s[0], s[1]);
    v.div(v.mag());
    line(s[0], s[1], s[0] + (pow(1.25, len) * v.x), s[1] + (pow(1.25, len) * v.y));
  }
  popMatrix();
}