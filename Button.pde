class Button
{
  float xPos, yPos;
  float size;
  String title;
  color buttonColour; 
  color textColour;
  boolean state;
  
  Button()
  {
    xPos = 0;
    yPos = 0;
    size = 50;
    buttonColour = #00FFFF;
    textColour = #00FF00;
    state = false;
  }
  
  Button(float xPos, float yPos, float size, String title, color buttonColour, color textColour, boolean state)
  {
    this.xPos = xPos;
    this.yPos = yPos;
    this.size = size;
    this.title = title;
    this.buttonColour = buttonColour;
    this.textColour = textColour;
    this.state = state;
  }
  
  boolean read()
  {
    return this.state;
  }
  
  void turnOn()
  {
    state = true;
  }
  
  void turnOff()
  {
    state = false;
  }
  
  void toggle()
  {
    state ^= true;
  }
  
  String toString()
  {
    return xPos + "\t" + yPos + "\t" + size + "\t" + title + "\t" + buttonColour + "\t" + textColour;
  }
}