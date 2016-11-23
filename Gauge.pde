abstract class Gauge
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
  float grade; // show larger markings for multiples of majorGrade
  color pointerColour;
  color graduationColour; // colour of the graduations/markings
  color textColour; // colour of unit name and numbers beside markings
  float reading; // value which the pointer will indicate
  
  Gauge()
  {
    xPos = 100;
    yPos = 150;
    size = 100;
    title = "";
    unit = "units";
    pointerColour = #FF0000;
    graduationColour = #FFFFFF;
    textColour = #0000FF;
    min = 0;
    max = 100;
    grade = 10;
    reading = 0;
  }
  
  Gauge(float xPos, float yPos, float size, String title, String unit, float min, float max, float grade, color pointerColour, color graduationColour, color textColour)
  {
    this.xPos = xPos;
    this.yPos = yPos;
    this.size = size;
    this.title = title;
    this.unit = unit;
    this.min = min;
    this.max = max;
    this.grade = grade;
    this.pointerColour = pointerColour;
    this.graduationColour = graduationColour;
    this.textColour = textColour;
  }
  
  abstract void display(); // contains a call to display passing this.reading
  
  abstract void display(float val);
  
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
  
  float read() // get the value that the gauge reads
  {
    return this.reading;
  }
  
  String toString()
  {
    return xPos + "\t" + yPos + "\t" + size + "\t" + title + "\t" + unit + "\t" + min + "\t" + max + "\t" + grade + "\t" + pointerColour + "\t" + graduationColour + "\t" + textColour + "\t" + reading;
  }
}