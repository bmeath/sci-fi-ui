class enemyInfo
{
  float xPos;
  float yPos;
  float size;
  String enemyName;
  String enemySize;
  String enemySpeed;
  
  enemyInfo(float xPos, float yPos, float size)
  {
    this.xPos = xPos;
    this.yPos = yPos;
    this.size = size;
    this.enemyName = "";
    this.enemySize = "";
    this.enemySpeed = "";
  }
  
  void display()
  {
    stroke(91);
    fill(0);
    rect(xPos, yPos, size, size);
    fill(#00FF00);
    textSize(size/12);
    text("Nearby Spacecraft\nStatistics", xPos + size/20, yPos + 0.1 * size);
    textSize(size/16);
    if(enemyName != "")
    {
      text("Name: " + enemyName, xPos + size/20, yPos + 0.35 * size);
      text("Length: " + enemySize + "m", xPos + size/20, yPos + 0.55* size);
      text("Speed: " + enemySpeed + "x1000 km/h", xPos + size/20, yPos + 0.75 * size);
    }
    else
    {
       text("Select a ship\non the radar display\nto view information about it." + enemyName, xPos + size/20, yPos + 0.35 * size);
    }
  }
 
  void update(Enemy e)
  {
    enemyName = e.name;
    enemySize =  Float.toString(e.size);
    enemySpeed =  Float.toString(e.speed);
  }
}