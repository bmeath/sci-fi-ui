class Gauge
{
  float xPos, yPos;
  float size; // in pixels
  String unit; // unit of measurement
  float min, max; // needle cannot point beyond these values
  float majorGrade, minorGrade; // show larger markings for multiples of majorGrade
  color needleColour;
  color graduationColour; // colour of the markings
  color textColour; // colour of unit name and numbers beside markings
  float reading; // value which needle will point to
  
  Gauge()
  {
    xPos = width/2;
    yPos = height/2;
    size = height/10;
    unit = "units";
    needleColour = #FF0000;
    graduationColour = #FFFFFF;
    textColour = #0000FF;
    min = 0;
    max = 100;
    majorGrade = 10;
    minorGrade = 1;
    reading = 0;
  }
  
  Gauge(float xPos, float yPos, float size, String unit, float min, float max, float majorGrade, float minorGrade, color needleColour, color graduationColour, color textColour)
  {
    this.xPos = xPos;
    this.yPos = yPos;
    this.size = size;
    this.unit = unit;
    this.min = min;
    this.max = max;
    this.majorGrade = majorGrade;
    this.minorGrade = minorGrade;
    this.needleColour = needleColour;
    this.graduationColour = graduationColour;
    this.textColour = textColour;
  }
  
  void update(float val)
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
  
  void display()
  {
    
    fill(needleColour);
    noStroke();
    
    ellipse(xPos, yPos, size/10, size/10);
    
    fill(textColour);
    textAlign(CENTER);
    textSize(size/10);
    stroke(graduationColour);
    int numMarkings = int((max-min)/minorGrade);
    float thetaStart = 210;
    float theta = thetaStart;
    float interval = (300)/numMarkings;
    float xInner, yInner, xOuter, yOuter;
    for(int i = 0; i <= numMarkings; i++)
    {
      if(i % majorGrade == 0)
      {
        xInner = xPos + ((0.8 * size) * sin(radians(theta)));
        yInner = yPos - ((0.8 * size) * cos(radians(theta)));
        
        text(i, xPos + ((0.65 * size) * sin(radians(theta))), yPos - ((0.65 * size) * cos(radians(theta))));
      }
      else
      {
        xInner = xPos + ((0.9 * size) * sin(radians(theta)));
        yInner = yPos - ((0.9 * size) * cos(radians(theta)));
      }
      
      xOuter = xPos + (size * sin(radians(theta)));
      yOuter = yPos - (size * cos(radians(theta)));
      
      line(xInner, yInner, xOuter, yOuter);
      
      theta += interval; // spacing between markings
    }
    
    stroke(needleColour);
    xInner = xPos;
    yInner = yPos;
    float readingRad = radians(map(reading, min, max, thetaStart, thetaStart + 300));
    xOuter = xPos + ((0.7 * size) * sin(readingRad));
    yOuter = yPos - ((0.7 * size) * cos(readingRad));
    line(xInner, yInner, xOuter, yOuter);
    
    
    textSize(size/5);
    text(unit, xPos, yPos + (0.8 * size));
    
  }
  
  String toString()
  {
    return unit + "\t" + min + "\t" + max + "\t" + majorGrade + "\t" + minorGrade + "\t" + needleColour + "\t" + graduationColour + "\t" + textColour + "\t" + reading;
  }
}