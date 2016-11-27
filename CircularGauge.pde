class CircularGauge extends Gauge
{
  
  float minorGrade;
  
  CircularGauge()
  {
    super();
    minorGrade = 2;
  }
  
  CircularGauge(float xPos, float yPos, float size, String title, String unit, float min, float max, float grade, float minorGrade, color pointerColour, color graduationColour, color textColour)
  {
    super(xPos, yPos, size, title, unit, min, max, grade, pointerColour, graduationColour, textColour);
    this.minorGrade = minorGrade;
  }
  
  void display() // allows calling display without any arguments and assumes this.reading as the argument to pass
  {
    display(reading);
  }
  
  void display(float val)
  {
    measure(val);
    
    float w = size;
    float h = size;
    float xCentre = xPos + w/2;
    float yCentre = yPos + h/2;
    fill(0);
    stroke(91);
    strokeWeight(3);
    ellipse(xCentre, yCentre, size, size);

    float thetaStart = radians(210);
    float thetaEnd = radians(510);
    float interval = (thetaEnd - thetaStart) / (max - min);
    float xInner, yInner, xOuter, yOuter;
    
    // draw name of gauge and unit of measurement
    textAlign(CENTER);
    fill(textColour);
    textSize(size/13);
    text(unit, xCentre, yPos + h/3);
    textAlign(CENTER);
    text(title, xCentre, yPos + (0.9 * h));
    
    // draw the graduations and numbers
    stroke(graduationColour);
    textSize(size/12);
    String label;
    float theta = thetaStart;
    for(float i = min; i <= max; i += minorGrade)
    {
      if(i % grade == 0)
      {
        strokeWeight(2);
        xInner = xCentre + ((0.42 * size) * sin(theta));
        yInner = yCentre - ((0.42 * size) * cos(theta));
        label = (i == (float)((int)i)) ? Integer.toString((int)i) : Float.toString(i); // remove trailing zeros
        text(label, xCentre + ((0.3 * size) * sin(theta)), yCentre - ((0.3 * size) * cos(theta)));
      }
      else
      {
        strokeWeight(1);
        xInner = xCentre + ((0.46 * size) * sin(theta));
        yInner = yCentre - ((0.46 * size) * cos(theta));
      }
      
      xOuter = xCentre + ((size/2.1) * sin(theta));
      yOuter = yCentre - ((size/2.1) * cos(theta));
      
      line(xInner, yInner, xOuter, yOuter);
      
      theta += minorGrade * interval; // spacing between graduations
    }
    
    // draw needle
    stroke(pointerColour);
    strokeWeight(2);
    fill(pointerColour);
    
    ellipse(xCentre, yCentre, w/20, h/20);
    
    xInner = xCentre - ((0.05 * size) * sin(thetaStart + (reading * interval)));
    yInner = yCentre + ((0.05 * size) * cos(thetaStart + (reading * interval)));
    xOuter = xCentre + ((0.4 * size) * sin(thetaStart + (reading * interval)));
    yOuter = yCentre - ((0.4 * size) * cos(thetaStart + (reading * interval)));
    line(xInner, yInner, xOuter, yOuter);
    
    fill(textColour);
    
  }
  
  String toString()
  {
    return super.toString() + "\t" + minorGrade;
  }
}