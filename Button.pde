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
    title = "button";
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
  
  void display()
  {
    textAlign(LEFT);
    fill(textColour);
    textSize(size/5);
    text(title, xPos + size/10, yPos + size/3);
    
    fill(state ? #00FF00 : #FF0000);
    ellipse(xPos + (0.85 * size), yPos + (0.15 * size), size/15, size/15);
    noFill();
    stroke(buttonColour);
    strokeWeight(3);
    rect(xPos, yPos, size, size/2, 0, size/5, 0, 0);
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