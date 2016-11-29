import processing.sound.*;
import java.awt.Polygon;
import java.awt.Rectangle;

CircularGauge speedometer;
CircularGauge fuel;
VerticalGauge thermometer;
VerticalGauge co2Gauge;
Radar radar;
Button radarPower;
Button hyperdrive;
Button lightSwitch;
Gun gun;
SoundFile ambientSound; // source: https://www.freesound.org/people/qubodup/sounds/212025/
SoundFile clickSound; // source: https://www.freesound.org/people/josepharaoh99/sounds/367997/
SoundFile warpSound; // source: https://www.freesound.org/people/Fantozzi/sounds/163077/
SoundFile stopwarpSound; // source: https://www.freesound.org/people/LittleRobotSoundFactory/sounds/270553/
boolean[] keys = new boolean[1000];
float timeDelta = 1/60;
float shipSpeed = 0;
enemyInfo enemyInfoScreen;
String enemyInfoFile = "enemies.csv";
Compass compass;
Polygon window = new Polygon();
Space space;

void setup()
{
  size(1280, 720);
  compass = new Compass(0.48 * width, 0.008 * height, 64, 0);
  co2Gauge = new VerticalGauge(0.12 * width, 0.75 * height, 150, "CO2 Level", "mg/L", 0, 20000, 2000, #FF0000, #FFFFFF, #FFFFFF);
  co2Gauge.measure(500);
  
  ambientSound = new SoundFile(scifiui.this, "ambient.ogg");
  ambientSound.loop();
  clickSound = new SoundFile(scifiui.this, "click.mp3");
  warpSound = new SoundFile(scifiui.this, "warp.wav");
  stopwarpSound = new SoundFile(scifiui.this, "stopwarp.wav");
  
  speedometer = new CircularGauge(0.5 * width - 150/2, 0.63 * height, 150, "Velocity", "x1000\nkm/h", 0, 25, 5, 1, #FF0000, #FFFFFF, #0000FF);
  fuel = new CircularGauge(0.87 * width, 0.75 * height, 125, "Fuel", "Litres", 0, 10000, 2500, 500, #FF0000, #FFFFFF, #FFFF00);
  fuel.measure(9000);
  thermometer = new VerticalGauge(0.04 * width, 0.75 * height, 150, "Temperature", "Deg. C", 0, 1500, 250, #FF0000, #FFFFFF, #FFFFFF);
  radar = new Radar(0.7 * width, 0.63 * height, 150, enemyInfoFile);
  radarPower = new Button(0.7 * width, 0.85 * height, 48, "Radar", #303030, #FEA500, true);
  hyperdrive = new Button(0.47 * width, 0.95 * height, 64, "Warp", #303030, #00FFFF, false); 
  enemyInfoScreen = new enemyInfo(0.2 * width, 0.63 * height, width/6);
  
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
  lightSwitch = new Button(0.7 * width, 0.05 * height, 48, "Light", #303030, #FEA500, true);
}

void draw()
{
  drawInterior();
  space.display(hyperdrive.state);
  gun.display(mouseX, mouseY);
  
  compass.display(space.theta);
  co2Gauge.display();
  speedometer.display(hyperdrive.state ? random(speedometer.min, speedometer.max) : shipSpeed);
  fuel.display();
  radarPower.display();
  hyperdrive.display();
  thermometer.display(space.hyperspeed * 50);
  lightSwitch.display();
  enemyInfoScreen.display();
  
  stroke(91);
  fill(0);
  rect(radar.xPos, radar.yPos, radar.size, radar.size);
  if(radarPower.state)
  {
    radar.display();
  }
  
}

void mouseClicked()
{
  // check which of these objects have been clicked, if any
  
  if(radarPower.checkPressed())
  {
    clickSound.play();
  }
  if(hyperdrive.checkPressed())
  {
    clickSound.play();
    if(hyperdrive.state == true)
    { 
      warpSound.play();
      radar.enemies.clear();
    }
    else
    {
      radar.loadEnemies(enemyInfoFile);
      stopwarpSound.play();
    }
  }
  for(Enemy e : radar.enemies)
  {
    if(e.checkPressed())
    {
      enemyInfoScreen.update(e);
    }  
  }
  gun.checkFired();
  if(lightSwitch.checkPressed())
  {
    clickSound.play();
  }
  
}

void keyPressed()
{ 
  keys[keyCode] = true;
}
 
void keyReleased()
{
  keys[keyCode] = false; 
}
boolean checkKey(int k)
{
  if (keys.length >= k) 
  {
    return keys[k] || keys[Character.toUpperCase(k)];
  }
  return false;
}

void drawInterior()
{
  background(lightSwitch.state ? 56 : 0);
  drawVent(0.015 * width, 0.025 * height, 100, 60);
  drawVent(0.907 * width, 0.025 * height, 100, 60);
}

void drawVent(float x, float y, float w, float h)
{
  noStroke();
  fill(lightSwitch.state ? 127 : 31);
  rect(x, y, w, h);
  strokeWeight(2);
  stroke(91);
  for(float i = 0.2; i < 1; i += 0.2)
  {
    line(x + w/10, y + i * h, x + 0.9 * w, y + i * h);
  }
}