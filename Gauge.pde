class Gauge
{
  float xPos, yPos;
  float size;
  String title; // name of thing being measured
  String unit; // unit of measurement
  float min, max; // needle cannot point beyond these values
  /* Note:
   * majorGrade should be a multiple of minorGrade,
   * otherwise gauge will look a bit odd
   */
  float majorGrade, minorGrade; // show larger markings for multiples of majorGrade
  color needleColour;
  color graduationColour; // colour of the markings
  color textColour; // colour of unit name and numbers beside markings
  float reading; // value which needle will point to
  
  Gauge()
  {
    xPos = 100;
    yPos = 150;
    size = 100;
    title = "";
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
    textAlign(CENTER,BOTTOM);
    fill(textColour);
    textSize(size/12);
    text(title, xPos, yPos - size/2);
    textAlign(CENTER);
    text(unit, xPos, yPos + (0.4 * size));
    
    // draw the graduations and numbers
    stroke(graduationColour);
    textSize(size/12);
    String label;
    float theta = thetaStart;
    for(float i = min; i <= max; i += minorGrade)
    {
      if(i % majorGrade == 0)
      {
        strokeWeight(2);
        xInner = xPos + ((0.43 * size) * sin(theta));
        yInner = yPos - ((0.43 * size) * cos(theta));
        label = (i == (float)((int)i)) ? Integer.toString((int)i) : Float.toString(i);
        text(label, xPos + ((0.3 * size) * sin(theta)), yPos - ((0.3 * size) * cos(theta)));
      }
      else
      {
        strokeWeight(1);
        xInner = xPos + ((0.47 * size) * sin(theta));
        yInner = yPos - ((0.47 * size) * cos(theta));
      }
      
      xOuter = xPos + ((size/2) * sin(theta));
      yOuter = yPos - ((size/2) * cos(theta));
      
      line(xInner, yInner, xOuter, yOuter);
      
      theta += minorGrade * interval; // spacing between graduations
    }
    
    // draw needle
    stroke(needleColour);
    strokeWeight(2);
    fill(needleColour);
    
    ellipse(xPos, yPos, size/20, size/20);
    
    xInner = xPos - ((0.05 * size) * sin(thetaStart + (reading * interval)));
    yInner = yPos + ((0.05 * size) * cos(thetaStart + (reading * interval)));
    xOuter = xPos + ((0.4 * size) * sin(thetaStart + (reading * interval)));
    yOuter = yPos - ((0.4 * size) * cos(thetaStart + (reading * interval)));
    line(xInner, yInner, xOuter, yOuter);
    
    
    fill(textColour);
    
  }
  
  String toString()
  {
    return xPos + "\t" + yPos + "\t" + size + "\t" + title + "\t" + unit + "\t" + min + "\t" + max + "\t" + majorGrade + "\t" + minorGrade + "\t" + needleColour + "\t" + graduationColour + "\t" + textColour + "\t" + reading;
  }
}