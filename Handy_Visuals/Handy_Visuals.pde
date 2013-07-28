import de.voidplus.leapmotion.*;
import peasy.*;

PeasyCam cam;

LeapMotion leap;

int x;
int y;
float outerRad;
float innerRad;

PVector f1;
// Size of each cell in the grid, ratio of window size to video size
// 80 * 8 = 640
// 60 * 8 = 480
int videoScale = 50;

// Number of columns and rows in our system
int cols, rows, depth;

void setup() {
  size(800, 500, P3D);  
  cam = new PeasyCam(this, 1000);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(2000);




  cols = width/videoScale;
  rows = height/videoScale;
  depth = 500/videoScale;


  background(255);

  f1 = new PVector(width/2, height/2, 0);

  x = width/2;
  y = height/2;
  outerRad = min(width, height) * 0.5;
  innerRad = outerRad * .4;

  leap = new LeapMotion(this);
}

void draw() {
  background(255);
  stroke(0, 120, 120);
  strokeWeight(2);
  ellipse(f1.x, f1.y, 12, 12);

  // Begin loop for columns
  for (int i = 0; i < cols; i++) {
    // Begin loop for rows
    for (int j = 0; j < rows; j++) {
      //
      for (int k = 0; k < depth; k++) {

        // Scaling up to draw a rectangle at (x,y)
        int x = i*videoScale;
        int y = j*videoScale;
        int z = k*videoScale;

        noFill();
        stroke(170, 170, 170);
        // For every column and row, a rectangle is drawn at an (x,y) location scaled and sized by videoScale.
        rect(x, y, videoScale, videoScale);
      }
    }
  }

  // ...
  int fps = leap.getFrameRate();

  // HANDS
  for (Hand hand : leap.getHands()) {

    hand.draw();
    int     hand_id          = hand.getId();
    PVector hand_position    = hand.getPosition();
    PVector hand_stabilized  = hand.getStabilizedPosition();
    PVector hand_direction   = hand.getDirection();
    PVector hand_dynamics    = hand.getDynamics();
    float   hand_roll        = hand.getRoll();
    float   hand_pitch       = hand.getPitch();
    float   hand_yaw         = hand.getYaw();
    float   hand_time        = hand.getTimeVisible();
    PVector sphere_position  = hand.getSpherePosition();
    float   sphere_radius    = hand.getSphereRadius();

    stroke(0, 150, 150);
    strokeWeight(1);
    line(sphere_position.x, sphere_position.y, sphere_position.z, 
    hand_direction.x, hand_direction.y, hand_direction.z);




    noFill();

    stroke(255, 150, 0);
    strokeWeight(.2);
    pushMatrix();
    translate(hand_stabilized.x, hand_stabilized.y, hand_stabilized.z);
    sphere(20);
    sphereDetail(10, 10);
    popMatrix();



    stroke(225, 150, 0);
    strokeWeight(2);
    float ellipseSizeHandStable = map(hand_stabilized.z, 0, 300, sphere_radius/2, sphere_radius);
    ellipse(hand_stabilized.x, hand_stabilized.y, ellipseSizeHandStable, ellipseSizeHandStable);


    stroke(225, 225, 0);
    strokeWeight(2);
    float ellipseSize0 = map(sphere_position.z, 0, 300, sphere_radius*2, sphere_radius);
    ellipse(sphere_position.x, sphere_position.y, ellipseSize0, ellipseSize0);

    arc(sphere_position.x, sphere_position.y, 60, 60, PI, TWO_PI);




    stroke(225, 225, 0);
    strokeWeight(.5);
    pushMatrix();
    translate(sphere_position.x, sphere_position.y, sphere_position.z);
    sphere(sphere_radius/2);
    popMatrix();


    /*
    stroke(sphere_position.x, sphere_position.y, sphere_position.z);
     
     int pts = int(map(sphere_position.x, sphere_position.y, width, 6, 60));
     float rot = 180.0/pts;
     float angle = 0;
     
     beginShape(TRIANGLE_STRIP); 
     for (int i = 0; i <= pts; i++) {
     float px = x + cos(radians(angle)) * outerRad;
     float py = y + sin(radians(angle)) * outerRad;
     angle += rot;
     vertex(px, py);
     px = x + cos(radians(angle)) * innerRad;
     py = y + sin(radians(angle)) * innerRad;
     vertex(px, py); 
     angle += rot;
     }
     endShape();
     */



    // FINGERS
    for (Finger finger : hand.getFingers()) {

      // Basics
      finger.draw();
      int     finger_id         = finger.getId();
      PVector finger_position   = finger.getPosition();
      PVector finger_stabilized = finger.getStabilizedPosition();
      PVector finger_velocity   = finger.getVelocity();
      PVector finger_direction  = finger.getDirection();
      float   finger_time       = finger.getTimeVisible();
      println("finger_id: " + finger_position);
      stroke(255, 0, 0);
      strokeWeight(3);

      line(finger_position.x, finger_position.y, finger_position.z, 
      sphere_position.x, sphere_position.y, sphere_position.z);

      stroke(0, 255, 0);
      strokeWeight(1);
      line(finger_position.x, finger_position.y, finger_position.z, 
      hand_position.x, hand_position.y, hand_position.z);

      stroke(0, 0, 255);
      line(sphere_position.x, sphere_position.y, sphere_position.z, 
      hand_position.x, hand_position.y, hand_position.z);

      float ellipseSize = map(finger_position.z, -20, 100, finger_position.z*-1, -20);
      ellipse(finger_position.x, finger_position.y, ellipseSize, ellipseSize);
      ellipseMode(CENTER);

      arc(finger_position.x, finger_position.y, 60, 60, PI, TWO_PI);
      stroke(0, 200, 200);
      strokeWeight(1);
      pushMatrix();
      translate(finger_position.x, finger_position.y, finger_position.z);
      sphereDetail(3, 2);
      sphere(finger_position.z/5);

      popMatrix();

      stroke(0);




      // Touch Emulation
      int     touch_zone        = finger.getTouchZone();
      float   touch_distance    = finger.getTouchDistance();

      switch(touch_zone) {
      case -1: // None
        break;
      case 0: // Hovering
        // println("Hovering (#"+finger_id+"): "+touch_distance);
        break;
      case 1: // Touching
        // println("Touching (#"+finger_id+")");
        break;
      }
    }

    // TOOLS
    for (Tool tool : hand.getTools()) {

      // Basics
      tool.draw();
      int     tool_id           = tool.getId();
      PVector tool_position     = tool.getPosition();
      PVector tool_stabilized   = tool.getStabilizedPosition();
      PVector tool_velocity     = tool.getVelocity();
      PVector tool_direction    = tool.getDirection();
      float   tool_time         = tool.getTimeVisible();

      // Touch Emulation
      int     touch_zone        = tool.getTouchZone();
      float   touch_distance    = tool.getTouchDistance();

      switch(touch_zone) {
      case -1: // None
        break;
      case 0: // Hovering
        // println("Hovering (#"+tool_id+"): "+touch_distance);
        break;
      case 1: // Touching
        // println("Touching (#"+tool_id+")");
        break;
      }
    }
  }

  // DEVICES
  // for(Device device : leap.getDevices()){
  //   float device_horizontal_view_angle = device.getHorizontalViewAngle();
  //   float device_verical_view_angle = device.getVerticalViewAngle();
  //   float device_range = device.getRange();
  // }
}

void leapOnInit() {
  // println("Leap Motion Init");
}
void leapOnConnect() {
  // println("Leap Motion Connect");
}
void leapOnFrame() {
  // println("Leap Motion Frame");
}
void leapOnDisconnect() {
  // println("Leap Motion Disconnect");
}
void leapOnExit() {
  // println("Leap Motion Exit");
}

