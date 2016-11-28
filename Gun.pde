class Gun
{
  PVector pos;
  color colour;
  Polygon range;
  SoundFile pew; 
  float expansion; // to make the aimer expand and contract
  float cornerX;
  float cornerY;
  float cornerSize;
  ArrayList<Laser> laserShots;
  
  
  Gun(float xPos, float yPos, Polygon range, color colour)
  {
    this.pos = new PVector(xPos, yPos);
    this.range = range;
    this.colour = colour;
    expansion = 0;
    cornerSize = height/100;
    laserShots = new ArrayList<Laser>();
    pew = new SoundFile(scifiui.this, "pew.wav"); // source https://www.freesound.org/people/TheGeekRanger/sounds/273497/
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
    for(int i = 0; i < laserShots.size(); i++)
    {
      if(range.contains(laserShots.get(i).pos.x, laserShots.get(i).pos.y))
      {
        if(laserShots.get(i).size > 1)
        {
          laserShots.get(i).display();
        }
      }
      else
      {
        laserShots.remove(i);
      }
    }
  }
  
  boolean checkFired()
  {
    if(range.contains(mouseX, mouseY))
    {
        pew.play();
        Laser l = new Laser(pos, mouseX, mouseY, #00FF00);
        laserShots.add(l);
        return true;
    }
    return false;
  }
  
  String toString()
  {
    return range.toString() + "\t" + colour;
  }
}