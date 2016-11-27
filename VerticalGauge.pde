class VerticalGauge extends Gauge
{
  
  VerticalGauge()
  {
    super();
  }
  
  VerticalGauge(float xPos, float yPos, float size, String title, String unit, float min, float max, float grade, color pointerColour, color graduationColour, color textColour)
  {
    super(xPos, yPos, size, title, unit, min, max, grade, pointerColour, graduationColour, textColour);
  }
  
  void display() // allows calling display without any arguments and assumes this.reading as the argument to pass
  {
    display(reading);
  }
  
  void display(float val)
  {
    float w = size/4;
    float h = size;
    measure(val);
    
    fill(0);
    stroke(91);
    strokeWeight(3);
    rect(xPos, yPos, w, h);
    
    stroke(255);
    strokeWeight(1);
    
    float yStart = yPos + (0.05 * h);
    float yEnd = yPos + (0.95 * h);
    float xStart = xPos + (0.2 * w);
    float xEnd = xPos + (0.8 * w);
    float interval = (yEnd - yStart) / (max - min);
    
    float mappedReading = map(reading, min, max, yEnd, yStart);
    fill(#FEA500);
    rect(xStart, mappedReading, xEnd - xStart, yEnd - (mappedReading));
    
    String label;
    fill(textColour);
    textSize(size/14);
    textAlign(RIGHT);
    
    // draw markings and label them
    for( float i = max; i >= min; i -= grade)
    {
      label = (i == (float)((int)i)) ? Integer.toString((int)i) : Float.toString(i); // remove trailing zeros
      text(label, xPos, yEnd - (i * interval));
      line(xStart, yEnd - (i * interval), xEnd, yEnd- (i * interval));
    }
    
    textAlign(CENTER, TOP);
    text(unit, xPos + w/2, yPos + h);
  }

  String toString()
  {
    return super.toString();
  }
}