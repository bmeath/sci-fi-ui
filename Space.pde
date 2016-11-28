class Space
{
  PVector stars[];
  float hyperspeed;
  boolean inHyperspace;
  Pulse pulse;
  Polygon area;
  Rectangle bounds;
  
  
  Space(int numStars, Polygon area)
  {
    this.area = new Polygon(area.xpoints, area.ypoints, area.npoints);
    this.area.translate(-width/2, -height/2);
    stars = new PVector[numStars];
    hyperspeed = 0;
    inHyperspace = false;
    pulse = new Pulse(scifiui.this);
    pulse.amp(0);
    pulse.play();
    
    bounds = this.area.getBounds();
    
    for(int i = 0; i < 1000; i++)
    {
      stars[i] = new PVector(random(bounds.x, bounds.width), random(bounds.y, bounds.height));
      if(!this.area.contains(stars[i].x, stars[i].y))
      {
        // there is small chance of this condition occuring
        i--;
      }
    }
  }
  
  void display(boolean hyperdrive)
  {
    pushMatrix();
    translate(width/2, height/2);
    
    beginShape();
    fill(0);
    noStroke();
    strokeWeight(5);
    // convert Polygon points to PShape vertices
    for(int i = 0; i < area.npoints; i++)
    {
      vertex(area.xpoints[i], area.ypoints[i]);
    }
    endShape();
    
    stroke(255);
    
    if(hyperdrive)
    {
      
      if(!inHyperspace)
      {
        // hyperdrive is on but we aren't yet in hyperspace
        enterHyperspace();
      }
      else
      {
        drawHyperspace();
      }
    }
    else
    {
      if(inHyperspace || hyperspeed > 0)
      {
        
        // hyperdrive is off but we are still in hyperspace
        space.leaveHyperspace();
        
      }
      else
      {
        // back to normal
        space.drawNormal();
      }
    }
    popMatrix();
  }
  
  private void drawNormal()
  {
    pulse.amp(0);
    
   for(int i = 0; i < 1000; i++)
   {
     if(!bounds.contains(stars[i].x, stars[i].y))
     {
       stars[i] = new PVector( random(-100, 100), random(-100, 100));
       
     }
     stars[i].add(PVector.mult(PVector.div(stars[i], stars[i].mag()), 5));
     if(area.contains(stars[i].x, stars[i].y))
     {
       strokeWeight(map(stars[i].mag(), 0, width/2, 1, 4));
       point(stars[i].x, stars[i].y);
     }
     
   }
  }
  
  private void enterHyperspace()
  {
    /* function to animate the transition into hyperspace
     * returns wether or not we are in hyperspace
     */
    hyperspeed += 0.5; // increase speed
    pulse.freq(space.hyperspeed * 2);
    pulse.amp(0.5);
    
    PVector v;
    
    float lStart = (pow(1.25, hyperspeed)); // the 'tail' of the line is slower than the 'head'
    float lEnd = (pow(1.3, hyperspeed));
    float xOuter, yOuter;
    
    /* extrapolate each star away from the centre
     * motion is exponential
     */
    for(PVector s: stars)
    {
      v = PVector.div(s, s.mag()); // the forward vector
      strokeWeight(map(s.mag(), 0, width/2, 1, 4));
      xOuter = s.x + (lEnd * v.x);
      yOuter = s.y + (lEnd * v.y);
      
      if(area.contains(xOuter, yOuter))
      {
        line(s.x + (lStart * v.x), s.y + (lStart * v.y), xOuter, yOuter);
      }
      
    }
     
    if(lEnd >= width/2)
    {
      // there is at least one star still on screen, so hyperspace entry animination hasn't finished
      inHyperspace = true;
    }
    else
    {
      inHyperspace = false;
    }
  }
  
  private void leaveHyperspace()
  {
    /* function to animate the transition out of hyperspace
     * works like enterHyperspace in reverse
     * returns wether or not we are in hyperspace
     */
    hyperspeed -= 0.5; // reduce speed
    pulse.amp(0.5);
    pulse.freq(hyperspeed * 2);
  
    PVector v;
    float lStart = (pow(1.25, hyperspeed));
    float lEnd = (pow(1.3, hyperspeed));
    float xOuter, yOuter;
    
    for(PVector s: stars)
    {
      v = PVector.div(s, s.mag()); // the forward vector
      strokeWeight(map(s.mag(), 0, width/2, 1, 4));
      xOuter = s.x + (lEnd * v.x);
      yOuter = s.y + (lEnd * v.y);
      if(area.contains(xOuter, yOuter))
      {
        line(s.x + (lStart * v.x), s.y + (lStart * v.y), xOuter, yOuter);
      }
      
    }
    if(hyperspeed <= 0)
    {
      // instead of checking every single star's position, just check hyperspeed
      inHyperspace = false;
    }
    else
    {
      inHyperspace = true;
    }
  }
  
  private void drawHyperspace()
  {
    /* function to animate hyperspace travel
     */
     
     pulse.amp(0);
     
     for(int i = 0; i < 1000; i++)
     {
       if(!bounds.contains(stars[i].x, stars[i].y))
       {
         stars[i] = new PVector( random(-100, 100), random(-100, 100));
         
       }
       stars[i].add(PVector.mult(PVector.div(stars[i], stars[i].mag()), 5));
       if(area.contains(stars[i].x, stars[i].y))
       {
         strokeWeight(map(stars[i].mag(), 0, width/2, 1, 4));
         point(stars[i].x, stars[i].y);
       }
       
     }
     
     
  }
  
  boolean inHyperspace()
  {
    /* a better to check if in hyperspace
     * than accessing the attribute directly
     */
    return inHyperspace;
  }
  
  String toString()
  {
    return stars + "\t" + hyperspeed + "\t" + inHyperspace + "\t" + pulse + "\t" + area + "\t" + bounds;
  }
}