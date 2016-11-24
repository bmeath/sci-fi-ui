class Space
{
  PVector stars[];
  float hyperspeed;
  boolean inHyperspace;
  Pulse pulse;
  Polygon area;
  
  
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
    for(int i = 0; i < 1000; i++)
    {
      stars[i] = new PVector(random(-width/2, width/2), random(-height/2,height/2));
    }
  }
  
  void display(boolean hyperdrive)
  {
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
  }
  
  void drawNormal()
  {
    pulse.amp(0);
    stroke(#FFFFFF);
    strokeWeight(1);
    pushMatrix();
    translate(width/2, height/2);
    
    for(PVector s: stars)
    {
      point(s.x, s.y);
    } 
    popMatrix();
  }
  
  void enterHyperspace()
  {
    /* function to animate the transition into hyperspace
     * returns wether or not we are in hyperspace
     */
    hyperspeed += 0.5; // increase speed
    pulse.freq(space.hyperspeed * 2);
    pulse.amp(0.5);
    float lStart, lEnd;
    stroke(#FFFFFF);
    strokeWeight(1);
  
    pushMatrix();
    translate(width/2, height/2);
    PVector v;
    
    
    lStart = (pow(1.25, hyperspeed)); // the 'tail' of the line is slower than the 'head'
    lEnd = (pow(1.3, hyperspeed));
    
    /* extrapolate each star away from the centre
     * motion is exponential
     */
    for(PVector s: stars)
    {
      v = PVector.div(s, s.mag()); // the forward vector
      strokeWeight(map(s.mag(), 0, width/2, 1, 4));
      line(s.x + (lStart * v.x), s.y + (lStart * v.y), s.x + (lEnd * v.x), s.y + (lEnd * v.y));    
    }
    popMatrix();
     
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
  
  void leaveHyperspace()
  {
    /* function to animate the transition out of hyperspace
     * works like enterHyperspace in reverse
     * returns wether or not we are in hyperspace
     */
    hyperspeed -= 0.5; // reduce speed
    pulse.amp(0.5);
    pulse.freq(hyperspeed * 2);
    stroke(#FFFFFF);
    strokeWeight(1);
  
    pushMatrix();
    translate(width/2, height/2);
    PVector v;
    float vStart, vEnd;
    vStart = (pow(1.25, hyperspeed));
    vEnd = (pow(1.3, hyperspeed));
    
    for(PVector s: stars)
    {
      v = PVector.div(s, s.mag());
      line(s.x + (vEnd * v.x), s.y + (vEnd * v.y), s.x + (vStart * v.x), s.y + (vStart * v.y));
    }
    popMatrix();
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
  
  void drawHyperspace()
  {
    /* function to animate hyperspace travel
     */
     pulse.amp(0);
     
     pushMatrix();
     
     translate(width/2, height/2);
     for(int i = 0; i < 1000; i++)
     {
       //if(stars[i].x < -(width/2) || stars[i].x > width/2 || stars[i].y < (-height/2) || stars[i].y > (height/2))
       if(!area.contains(stars[i].x, stars[i].y))
       {
         stars[i] = new PVector( random(-50, 50), random(-50, 50));
       }
       stars[i].add(PVector.mult(PVector.div(stars[i], stars[i].mag()), 15));
       //stars[i].rotate(0.025);
       strokeWeight(map(stars[i].mag(), 0, width/2, 1, 4));
       point(stars[i].x, stars[i].y);
     }
     popMatrix();
     
  }
  
  boolean inHyperspace()
  {
    /* a better to check if in hyperspace
     * than accessing the attribute directly
     */
    return inHyperspace;
  }
}