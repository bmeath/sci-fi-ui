import processing.sound.*;
import java.awt.Polygon;
import java.awt.Rectangle;

CircularGauge speedometer;
VerticalGauge thermometer;
Radar radar;
Button radarPower;
Button hyperdrive;
Button lightSwitch;
Gun gun;
float timeDelta = 1/60;

PVector[] nearby_objects = new PVector[8];

Polygon window = new Polygon();
Space space;

void setup()
{
  size(1280, 720);
  
  speedometer = new CircularGauge(0.5 * width - 150/2, 0.63 * height, 150, "Velocity", "x1000\nkm/h", 0, 25, 5, 1, #FF0000, #FFFFFF, #0000FF);
  thermometer = new VerticalGauge(0.04 * width, 0.75 * height, 150, "Temperature", "Deg. C", 0, 1500, 250, #FF0000, #FFFFFF, #FFFFFF);
  radar = new Radar(0.7 * width, 0.63 * height, 150, "enemies.csv");
  radarPower = new Button(0.7 * width, 0.85 * height, 48, "Radar", #303030, #FEA500, true);
  hyperdrive = new Button(0.35 * width, 0.93 * height, 48, "Warp", #303030, #00FFFF, false); 
  
  window.addPoint(0, (int)(0.15 * height));
  window.addPoint((int)(0.1 * width), (int)(0.15 * height));
  window.addPoint((int)(0.2 * width), (int)(0.1 * height));
  window.addPoint((int)(0.8 * width), (int)(0.1 * height));
  window.addPoint((int)(0.9 * width), (int)(0.15 * height));
  window.addPoint(width, (int)(0.15 * height));
  window.addPoint(width, (int)(0.75 * height));
  window.addPoint((int)(0.85 * width), (int)(0.6 * height));
  window.addPoint((int)(0.15 * width), (int)(0.6 * height));
  window.addPoint(0, (int)(0.75 * height));
  
  space = new Space(1000, window);
  gun = new Gun(0.5 * width, 0.59 * height, window,#FF0000);
  lightSwitch = new Button(0.95 * width, 0.05 * height, 48, "Light", #303030, #FEA500, true);
}

void draw()
{
  background(lightSwitch.state ? 91 : 31);
  space.display(hyperdrive.state);
  gun.display(mouseX, mouseY);
  
  
  speedometer.display(space.hyperspeed);
  radarPower.display();
  hyperdrive.display();
  thermometer.display(space.hyperspeed * 50);
  lightSwitch.display();
  
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
}

void mouseClicked()
{
  // check which of these objects have been clicked, if any
  radarPower.checkPressed();
  hyperdrive.checkPressed();
  gun.checkFired();
  lightSwitch.checkPressed();
}