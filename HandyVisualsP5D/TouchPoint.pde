class TouchPoint extends PVector
{
  public int id;
  TouchPoint lastPoint;
  float speedX, speedY;
  float speed;
  float acc;
  Boolean linked;
  float weight;
  
  String currentState;
  
  PVector reelCoord;
  
  public TouchPoint(float tx, float ty, float tweight, PVector reelCoordVec, boolean isLast)
  {

    x = tx;
    y = ty;
    weight = tweight;
    linked = false;
    reelCoord = reelCoordVec;
    
    if(!isLast)
    {
      setLastPoint(new TouchPoint(tx, ty, 10,  null, true));
    }
  }
  
  public void setLastPoint(TouchPoint lp)
  {
    lastPoint = lp;
    speedX = x - lastPoint.x;
    speedY = y - lastPoint.y;
    
    float lastSpeed = lastPoint.speed;
    speed = PVector.dist(this, lastPoint);
    acc = speed - lastSpeed;
  }
  
  public void setState(String state)
  {
    currentState = state;
    
    if(state.equals("new"))
    {
      globalTouchPointIndex++;
      this.id = globalTouchPointIndex;
    }
  }
  
  public void drawPointReel(color c)
  {
    pushStyle();
     noFill();
     stroke(c);
     ellipse(reelCoord.x, reelCoord.y,weight/5,weight/5);
    popStyle();
  }
}
