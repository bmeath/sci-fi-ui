import processing.sound.*;
import java.awt.Polygon;

CircularGauge speedometer;
VerticalGauge thermometer;
Radar radar;
Button radarPower;
Button hyperdrive;
float windowBottom, windowTop;
Gun gun;

PVector[] nearby_objects = new PVector[8];

Polygon windowArea = new Polygon();
Space space;

void setup()
{
  size(1280, 720);
  space = new Space(1000);
  speedometer = new CircularGauge(0.5 * width - 150/2, 0.63 * height, 150, "Velocity", "x1000\nkm/h", 0, 25, 5, 1, #FF0000, #FFFFFF, #0000FF);
  thermometer = new VerticalGauge(0.04 * width, 0.75 * height, 150, "Temperature", "Deg. C", 0, 1500, 250, #FF0000, #FFFFFF, #FFFFFF);
  radar = new Radar(0.7 * width, 0.63 * height, 150);
  radarPower = new Button(0.7 * width, 0.85 * height, 48, "Radar", #303030, #FEA500, true);
  hyperdrive = new Button(0.35 * width, 0.93 * height, 48, "Warp", #303030, #00FFFF, false);
  
  // height of space above and below window
  windowBottom = 0.75 * height;
  windowTop = 0.1 * height;
  
  windowArea.addPoint(0, (int)(0.15 * height));
  windowArea.addPoint((int)(0.1 * width), (int)(0.15 * height));
  windowArea.addPoint((int)(0.2 * width), (int)(0.1 * height));
  windowArea.addPoint((int)(0.8 * width), (int)(0.1 * height));
  windowArea.addPoint((int)(0.9 * width), (int)(0.15 * height));
  windowArea.addPoint(width, (int)(0.15 * height));
  windowArea.addPoint(width, (int)(0.75 * height));
  windowArea.addPoint((int)(0.85 * width), (int)(0.6 * height));
  windowArea.addPoint((int)(0.15 * width), (int)(0.6 * height));
  windowArea.addPoint(0, (int)(0.75 * height));
  
  gun = new Gun(windowArea,#FF0000);
  
  
  
  
}

void draw()
{
  background(0);
  space.display(hyperdrive.state);
  
  gun.display(mouseX, mouseY);
  drawCockpit();
  
  speedometer.display(5 + space.hyperspeed);
  if(radarPower.state)
  {
    radar.display();
  }
  else
  {
    stroke(91);
    fill(0);
    rect(radar.xPos, radar.yPos, radar.size, radar.size);
  }
  radarPower.display();
  hyperdrive.display();
  thermometer.display(space.hyperspeed * 50);
}

void mouseClicked()
{
  // check which of these objects have been clicked, if any
  radarPower.checkPressed();
  hyperdrive.checkPressed();
  gun.checkFired();
}

void drawCockpit()
{
  // function to draw the interior of the spaceship
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