CircularGauge speedometer;
VerticalGauge thermometer;
Radar radar;
Button radarPower;
Button hyperdrive;
float hyperspeed = 0;
boolean inHyperspace = false;
PVector[] stars = new PVector[1000];
float windowBottom, windowTop;
float theta = 0;

void setup()
{
  size(1280, 720);
  
  speedometer = new CircularGauge(0.5 * width - 150/2, 0.63 * height, 150, "Velocity", "x1000\nkm/h", 0, 25, 5, 1, #FF0000, #FFFFFF, #0000FF);
  thermometer = new VerticalGauge(0.04 * width, 0.75 * height, 150, "Temperature", "Deg. C", 0, 1500, 250, #FF0000, #FFFFFF, #FFFFFF);
  radar = new Radar(0.7 * width, 0.63 * height, 150);
  radarPower = new Button(0.7 * width, 0.85 * height, 48, "Radar", #303030, #FEA500, true);
  hyperdrive = new Button(0.35 * width, 0.93 * height, 48, "Warp", #303030, #00FFFF, false);
  
  // height of space above and below window
  windowBottom = 0.75 * height;
  windowTop = 0.1 * height;
  
  for(int i = 0; i < 1000; i++)
  {
    // limit area to that of the window
    stars[i] = new PVector(random(-width/2, width/2), random(windowTop - height/2, windowBottom - height/2));
  }

}

void draw()
{
  background(0);
  if(hyperdrive.state)
  {
    if(!inHyperspace)
    {
      // hyperdrive is on but we aren't yet in hyperspace
      hyperspeed += 0.5; // increase speed
      inHyperspace = enterHyperspace(hyperspeed);
      println(hyperspeed);
      println(inHyperspace);
    }
    else
    {
      if(theta == 2 * PI)
      {
        theta = 0;
      }
      drawHyperspace(theta);
      theta ++;
    }
  }
  else
  {    
    if(inHyperspace)
    {
      // hyperdrive is off but we are still in hyperspace
      hyperspeed -= 0.5; // reduce speed
      inHyperspace = leaveHyperspace(hyperspeed);
      println(hyperspeed);
      println(inHyperspace);
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
  thermometer.display(hyperspeed * 50);
  
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
  strokeWeight(5);
  
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
  float vStart, vEnd;
  stroke(#FFFFFF);
  strokeWeight(1);

  pushMatrix();
  translate(width/2, height/2);
  PVector v;
  vStart = (pow(1.25, hyperspeed));
  vEnd = (pow(1.3, hyperspeed));
  background(vStart);
  for(PVector s: stars)
  {
    v = PVector.div(s, s.mag());   
    line(s.x + (vStart * v.x), s.y + (vStart * v.y), s.x + (vEnd * v.x), s.y + (vEnd * v.y));    
  }
  popMatrix();
   
  if(vEnd >= width/2)
  {
    // there is at least one star still on screen, so hyperspace entry animination hasn't finished
    return true;
  }
  return false;
 
}

boolean leaveHyperspace(float hyperspeed)
{
  stroke(#FFFFFF);
  strokeWeight(1);

  pushMatrix();
  translate(width/2, height/2);
  PVector v;
  float vStart, vEnd;
  vStart = (pow(1.25, hyperspeed));
  vEnd = (pow(1.3, hyperspeed));
  
  background(vStart);
  
  for(PVector s: stars)
  {
    v = PVector.div(s, s.mag());
    line(s.x + (vEnd * v.x), s.y + (vEnd * v.y), s.x + (vStart * v.x), s.y + (vStart * v.y));
  }
  popMatrix();
  if(hyperspeed <= 0)
  {
    // instead of checking each star's position, just see if we are back to normal speed
    return false;
  }
  return true;
}

void drawHyperspace(float offset)
{
  background(255);
  strokeWeight(2);
  stroke(0);
  float theta = offset, rad = width/2, x1, y1, x2, y2;
  while(rad > 0)
  {
    x1 = (width/2) + (rad * sin(-theta));
    y1 = (height/2) - (rad * cos(-theta));
    x2 = (width/2) + ((rad + 200) * sin(-theta));
    y2 = (height/2) -((rad + 200) * cos(-theta));
    stroke(map(rad, 0, width/2, 255, 0));
    
    line(x1, y1, x2, y2);
    rad -= 1.5;
    theta += 0.125;
  }
}