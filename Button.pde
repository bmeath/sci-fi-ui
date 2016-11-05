class Button
{
  float xPos, yPos;
  float size;
  String title;
  color colour; 
  color textColour;
  boolean state;
  
  Button()
  {
    xPos = 0;
    yPos = 0;
    size = 50;
    title = "button";
    colour = #00FFFF;
    textColour = #00FF00;
    state = false;
  }
  
  Button(float xPos, float yPos, float size, String title, color colour, color textColour, boolean state)
  {
    this.xPos = xPos;
    this.yPos = yPos;
    this.size = size;
    this.title = title;
    this.colour = colour;
    this.textColour = textColour;
    this.state = state;
  }
  
  void display()
  {   
    fill(colour);
    stroke(colour);
    strokeWeight(2);
    rect(xPos, yPos, size, size/2);
    
    textAlign(LEFT);
    fill(textColour);
    textSize(size/5);
    text(title, xPos + size/10, yPos + size/3);
    
    noStroke();
    fill(state ? #00FF00 : #FF0000);
    ellipse(xPos + (0.85 * size), yPos + (0.15 * size), size/15, size/15);
  }
  
  boolean read()
  {
    return this.state;
  }
  
  void toggle()
  {
    state ^= true;
  }
  
  String toString()
  {
    return xPos + "\t" + yPos + "\t" + size + "\t" + title + "\t" + colour + "\t" + textColour + "\t" + state;
  }
}