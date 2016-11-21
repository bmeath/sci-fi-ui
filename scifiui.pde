CircularGauge speedometer;
VerticalGauge thermometer;
Radar radar;
Button radarPower;
Button hyperdrive;
float hyperspeed = 0;
boolean inHyperspace = false;
PVector[] stars = new PVector[1000];

void setup()
{
  size(1280, 720);
  
  speedometer = new CircularGauge(0.5 * width - 150/2, 0.63 * height, 150, "Velocity", "x1000\nkm/h", 0, 25, 5, 1, #FF0000, #FFFFFF, #0000FF);
  thermometer = new VerticalGauge(0.04 * width, 0.75 * height, 150, "Temperature", "Deg. C", 0, 1500, 250, #FF0000, #FFFFFF, #FFFFFF);
  radar = new Radar(0.7 * width, 0.63 * height, 150);
  radarPower = new Button(0.7 * width, 0.85 * height, 48, "Radar", #303030, #FEA500, true);
  hyperdrive = new Button(0.35 * width, 0.93 * height, 48, "Warp", #303030, #00FFFF, false);
  
  for(int i = 0; i < 1000; i++)
  {
    stars[i] = new PVector(random(-width/2, width/2), random((0.1 * height) - height/2, (0.75 * height) - height/2));
  }

}

void draw()
{
  background(0);
  if(hyperdrive.state)
  {
    if(inHyperspace)
    {
      //drawHyperspace();
    }
    else
    {
      // hyperdrive is on but we aren't yet in hyperspace
      hyperspeed += 0.5; // increase speed
      inHyperspace = enterHyperspace(hyperspeed);
    }
  }
  else
  {    
    if(inHyperspace)
    {
      // hyperdrive is off but we are still in hyperspace
      hyperspeed -= 0.5; // reduce speed
      inHyperspace = leaveHyperspace(hyperspeed);
      
    }
    else
    {
      // back to normal
      drawStars();
    }
  }
  drawCockpit();
  speedometer.display(5 + hyperspeed);
  if(radarPower.state)
  {
    radar.display();
  }
  else
  {
    rect(radar.xPos, radar.yPos, radar.size, radar.size);
  }
  radarPower.display();
  hyperdrive.display();
  thermometer.display(map(hyperspeed, 0, 45, 0, 1500));
  
}

void mouseClicked()
{
  radarPower.pressed();
  hyperdrive.pressed();
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

void drawStars()
{
  stroke(#FFFFFF);
  strokeWeight(1);
  pushMatrix();
  translate(width/2, height/2);
  
  for(PVector s: stars)
  {
    point(s.x, s.y);
  } 
  popMatrix();
}

boolean enterHyperspace(float hyperspeed)
{
  boolean offscreen = true;
  stroke(#FFFFFF);
  strokeWeight(1);

  pushMatrix();
  translate(width/2, height/2);
  hyperspeed = pow(1.2, hyperspeed);
  PVector v;
  for(PVector s: stars)
  {
    v = new PVector(s.x, s.y);
    v.div(v.mag());
    line(s.x + (pow(1.15, hyperspeed) * v.x), s.y + (pow(1.15, hyperspeed) * v.y), s.x + (pow(1.25, hyperspeed) * v.x), s.y + (pow(1.25, hyperspeed) * v.y));
    if( s.x + (pow(1.2, hyperspeed) * v.x) < width && s.x + (pow(1.2, hyperspeed) * v.x) > 0 )
    {
      // there is at least one star still on screen, so hyperspace entry animination hasn't finished
      offscreen = false;
    }
  }
  popMatrix();
  
  return offscreen;
}

boolean leaveHyperspace(float hyperspeed)
{
  boolean offscreen = true;
  stroke(#FFFFFF);
  strokeWeight(1);

  pushMatrix();
  translate(width/2, height/2);
  hyperspeed = pow(1.2, hyperspeed);
  PVector v;
  for(PVector s: stars)
  {
    v = new PVector(s.x, s.y);
    v.div(v.mag());
    line(s.x + (pow(1.15, hyperspeed) * v.x), s.y + (pow(1.15, hyperspeed) * v.y), s.x + (pow(1.25, hyperspeed) * v.x), s.y + (pow(1.25, hyperspeed) * v.y));
    if( s.x + (pow(1.2, hyperspeed) * v.x) < width && s.x + (pow(1.2, hyperspeed) * v.x) > 0 )
    {
      // there is at least one star still on screen, so hyperspace entry animination hasn't finished
      offscreen = false;
    }
  }
  popMatrix();
  
  return offscreen;
}