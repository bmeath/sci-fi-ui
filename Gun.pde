class Gun
{
  color colour;
  Polygon range;
  SawOsc pew = new SawOsc(scifiui.this);
  float expansion; // to make the aimer expand and contract
  float cornerX;
  float cornerY;
  float cornerSize;
  
  Gun(Polygon range, color colour)
  {
    this.range = range;
    this.colour = colour;
    pew.amp(0);
    pew.play();
    expansion = 0;
    cornerSize = height/100;
  }
   
  void display(float xCentre, float yCentre)
  {
    if(range.contains(xCentre, yCentre))
    {
      stroke(#FF0000);
      strokeWeight(2);
      noFill();
      
      expansion += 0.05;
      if(expansion > 2 * PI)
      {
        expansion = 0;
      }
      
      cornerX = (1.5 - sin(expansion)) * (width/50);
      cornerY = (1.5 - sin(expansion)) * (height/50);
      
      /* draw the corners, factoring in the expansion variable to give a pulsing effect */
      
      // top left
      line(xCentre - cornerX, yCentre - cornerY, xCentre - cornerX + cornerSize, yCentre - cornerY);
      line(xCentre - cornerX, yCentre - cornerY, xCentre - cornerX, yCentre - cornerY+ cornerSize);
      
      // top right
      line(xCentre + cornerX, yCentre - cornerY, xCentre + cornerX - cornerSize, yCentre - cornerY);
      line(xCentre + cornerX, yCentre - cornerY, xCentre + cornerX, yCentre - cornerY + cornerSize);
      
      // bottom left
      line(xCentre - cornerX, yCentre + cornerY, xCentre - cornerX + cornerSize, yCentre + cornerY);
      line(xCentre - cornerX, yCentre + cornerY, xCentre - cornerX, yCentre + cornerY - cornerSize);
      
      // bottom right
      line(xCentre + cornerX, yCentre + cornerY, xCentre + cornerX - cornerSize, yCentre + cornerY);
      line(xCentre + cornerX, yCentre + cornerY, xCentre + cornerX, yCentre + cornerY - cornerSize);
      
      // cross
      line(xCentre - cornerSize, yCentre, xCentre + cornerSize, yCentre);
      line(xCentre, yCentre + cornerSize, xCentre, yCentre - cornerSize);
    }
  }
  
  boolean checkFired()
  {
    if(range.contains(mouseX, mouseY))
    {
      
      pew.amp(0.5);
      for(int i = 750; i > 100; i -= 25)
      {
        pew.freq(i);
      }
      pew.amp(0);
      return true;
    }
    return false;
  }
  
  String toString()
  {
    return range.toString() + "\t" + colour;
  }
}