class Radar
{
  float xPos, yPos;
  float size;
  color colour;
  color textColour;
  float theta;
  ArrayList<Enemy> enemies;
  
  Radar(String enemyData)
  {
    xPos = 100;
    yPos = 150;
    size = 100;
    colour = #00FF00;
    textColour = #00FF00;
    theta = 0;
    enemies = new ArrayList<Enemy>();
  }
  
  Radar(float xPos, float yPos, float size, color colour, color textColour)
  {
    this.xPos = xPos;
    this.yPos = yPos;
    this.size = size;
    this.colour = colour;
    this.textColour = textColour;
    theta = 0;
  }
  
  Radar(float xPos, float yPos, float size, String enemyData)
  {
    this(enemyData);
    this.xPos = xPos;
    this.yPos = yPos;
    this.size = size;
  }
  
  void display()
  {
    float w = size;
    float h = size;
    float xCentre = xPos + w/2;
    float yCentre = yPos + h/2;
    fill(0);
    stroke(91);
    strokeWeight(3);
    
    // black background
    rect(radar.xPos, radar.yPos, radar.size, radar.size);
    
    float xOuter, yOuter;
    
    noFill();
    strokeWeight(1);
    
    
    // green cross
    stroke(colour, 127);
    line(xCentre, yCentre + size/2.1, xCentre, yCentre - size/2.1);
    line(xCentre - size/2.1, yCentre, xCentre + size/2.1, yCentre);
    
    // outer-most circle
    stroke(colour);
    ellipse(xCentre, yCentre, size * 0.95, size * 0.95);
    
    strokeWeight(2);
    
    // concentric circles and the scan line
    for(float j = 0; j < 16; j += 0.5)
    {
      xOuter = xCentre + ((size/2.1) * sin(theta - radians(j)));
      yOuter = yCentre - ((size/2.1) * cos(theta - radians(j)));
      line(xCentre, yCentre, xOuter, yOuter);
      strokeWeight(1);
      if(j % 4 == 0)
      {
        
        stroke(colour, 127);
        ellipse(xCentre, yCentre, j * size/16, j * size/16);
      }
      stroke(colour, 127 - (8 * j));
    }
    theta += radians(1);
  }
  
  void showEnemies()
  {
    
  }
  
  void loadEnemies(String enemyData)
  {
    Table tfile = loadTable(enemyData, "header");
    for (TableRow row : tfile.rows())
    {
      Enemy e = new Enemy(row.getString("Name"), row.getFloat("Speed"), row.getFloat("Size"));
      enemies.add(e);
    }
  }
  
  String toString()
  {
    return xPos + "\t" + yPos + "\t" + size + "\t" + colour + "\t" + textColour + "\t" + theta;
  }
}