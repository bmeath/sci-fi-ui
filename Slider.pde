class Slider
{
  PVector pos;
  float h; // height in pixels
  float w;
  float yMin;
  float yMax;
  String title;
  float reading;
  Rectangle knob;
  float setting;
  
  Slider(float xPos, float yPos, float size, String title)
  {
    this.pos = new PVector(xPos, yPos);
    this.h = size;
    this.title = title;
    w = width/60;
    reading = 0;
    yMax = pos.y + 0.1 * h;
    yMin = pos.y + 0.9 * h;
    knob = new Rectangle((int)(pos.x + w/10), (int)(pos.y + 0.9 * h), (int)(0.8 * w), (int)(0.1 * h));
    setting = knob.y;
  }
  
  void checkPressed()
  {
    if(knob.contains(mouseX, mouseY))
    {
      
      setting = mouseY;
      knob = new Rectangle((int)(pos.x + w/10), (int)setting, (int)(0.8 * w), (int)(0.1 * h));
      /*if(setting < yMin)
      {
        println("less");
        setting = yMin;
      }
      else if(setting > yMax)
      {
        println("greater");
        setting = yMax;
      }*/
    }
  }
  
  void display()
  {
    stroke(191);
    strokeWeight(w);
    rect(pos.x, pos.y, w, h);
    stroke(0);
    strokeWeight(2);
    line(pos.x + w/2, pos.y + 0.1 * h, pos.x + w/2, pos.y + 0.9 * h);
    fill(#00FF00);
    rect(pos.x, setting, w, h/10);    
  }
}