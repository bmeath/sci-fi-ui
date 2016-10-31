class Gauge
{
  float xPos, yPos;
  float size; // in pixels
  String title; // name of thing being measured
  String unit; // unit of measurement
  float min, max; // needle cannot point beyond these values
  float majorGrade, minorGrade; // show larger markings for multiples of majorGrade
  color needleColour;
  color graduationColour; // colour of the markings
  color textColour; // colour of unit name and numbers beside markings
  float reading; // value which needle will point to
  
  Gauge()
  {
    xPos = 125;
    yPos = 125;
    size = 100;
    title = "measurement";
    unit = "units";
    needleColour = #FF0000;
    graduationColour = #FFFFFF;
    textColour = #0000FF;
    min = 0;
    max = 100;
    majorGrade = 10;
    minorGrade = 2;
    reading = 0;
  }
  
  Gauge(float xPos, float yPos, float size, String title, String unit, float min, float max, float majorGrade, float minorGrade, color needleColour, color graduationColour, color textColour)
  {
    this.xPos = xPos;
    this.yPos = yPos;
    this.size = size;
    this.title = title;
    this.unit = unit;
    this.min = min;
    this.max = max;
    this.majorGrade = majorGrade;
    this.minorGrade = minorGrade;
    this.needleColour = needleColour;
    this.graduationColour = graduationColour;
    this.textColour = textColour;
  }
  
  void measure(float val)
  {
    // if value is off the gauge, adjust accordingly
    if(val < min)
    {
      val = min;
    }
    if(val > max)
    {
      val = max;
    }
    this.reading = val;
  }
  
  float read()
  {
    return this.reading;
  }
  
  void display() // allows calling display without any arguments
  {
    display(reading);
  }
  
  void display(float val)
  {
    measure(val);

    float thetaStart = radians(210);
    float thetaEnd = radians(510);
    float interval = (thetaEnd - thetaStart) / (max - min);
    float xInner, yInner, xOuter, yOuter;
    
    // draw name of gauge and unit of measurement
    textAlign(CENTER);
    fill(textColour);
    textSize(size/6);
    text(title, xPos, yPos - size);
    text(unit, xPos, yPos + (0.8 * size));
    
    // draw the graduations and numbers
    stroke(graduationColour);
    textSize(size/10);
    float theta = thetaStart;
    for(float i = min; i <= max; i += minorGrade)
    {
      if(i % majorGrade == 0)
      {
        strokeWeight(2);
        xInner = xPos + ((0.7 * size) * sin(theta));
        yInner = yPos - ((0.7 * size) * cos(theta));
        text(Float.toString(i), xPos + ((0.58 * size) * sin(theta)), yPos - ((0.58 * size) * cos(theta)));
      }
      else
      {
        strokeWeight(1);
        xInner = xPos + ((0.8 * size) * sin(theta));
        yInner = yPos - ((0.8 * size) * cos(theta));
      }
      
      xOuter = xPos + ((0.9 * size) * sin(theta));
      yOuter = yPos - ((0.9 * size) * cos(theta));
      
      line(xInner, yInner, xOuter, yOuter);
      
      theta += minorGrade * interval; // spacing between graduations
    }
    
    // draw needle
    stroke(needleColour);
    strokeWeight(2);
    fill(needleColour);
    
    ellipse(xPos, yPos, size/10, size/10);
    
    xInner = xPos - ((0.1 * size) * sin(thetaStart + (reading * interval)));
    yInner = yPos + ((0.1 * size) * cos(thetaStart + (reading * interval)));
    xOuter = xPos + ((0.7 * size) * sin(thetaStart + (reading * interval)));
    yOuter = yPos - ((0.7 * size) * cos(thetaStart + (reading * interval)));
    line(xInner, yInner, xOuter, yOuter);
    
    
    fill(textColour);
    
  }
  
  String toString()
  {
    return unit + "\t" + min + "\t" + max + "\t" + majorGrade + "\t" + minorGrade + "\t" + needleColour + "\t" + graduationColour + "\t" + textColour + "\t" + reading;
  }
}