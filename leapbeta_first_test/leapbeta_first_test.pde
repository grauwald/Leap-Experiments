import de.voidplus.leapmotion.Bone;
import de.voidplus.leapmotion.Arm;
import de.voidplus.leapmotion.*;

LeapMotion leap;

void setup(){
  size(displayWidth, displayHeight, P3D);
  background(255);
  
  ellipseMode(CENTER);
  rectMode(CENTER);

  // ...

  leap = new LeapMotion(this);
}

void draw(){
  //background(255);
  lights();
  
  // ...
  int fps = leap.getFrameRate();
  
  


  // ========= HANDS =========
    
  for(Hand hand : leap.getHands()){


    // ----- BASICS -----
        
    int     hand_id          = hand.getId();
    PVector hand_position    = hand.getPosition();
    PVector hand_stabilized  = hand.getStabilizedPosition();
    PVector hand_direction   = hand.getDirection();
    PVector hand_dynamics    = hand.getDynamics();
    float   hand_roll        = radians(hand.getRoll());
    float   hand_pitch       = radians(hand.getPitch());
    float   hand_yaw         = radians(hand.getYaw());
    boolean hand_is_left     = hand.isLeft();
    boolean hand_is_right    = hand.isRight();
    float   hand_grab        = hand.getGrabStrength();
    float   hand_pinch       = hand.getPinchStrength();
    float   hand_time        = hand.getTimeVisible();
    PVector sphere_position  = hand.getSpherePosition();
    float   sphere_radius    = hand.getSphereRadius();
    
//    println("hand_roll: "+hand_roll);
//    println("hand_pitch: "+hand_pitch);
//    println("hand_yaw: "+hand_yaw);


    // ----- SPECIFIC FINGER -----
        
    Finger  finger_thumb     = hand.getThumb();
    // or                      hand.getFinger("thumb");
    // or                      hand.getFinger(0);

    Finger  finger_index     = hand.getIndexFinger();
    // or                      hand.getFinger("index");
    // or                      hand.getFinger(1);

    Finger  finger_middle    = hand.getMiddleFinger();
    // or                      hand.getFinger("middle");
    // or                      hand.getFinger(2);

    Finger  finger_ring      = hand.getRingFinger();
    // or                      hand.getFinger("ring");
    // or                      hand.getFinger(3);

    Finger  finger_pink      = hand.getPinkyFinger();
    // or                      hand.getFinger("pinky");
    // or                      hand.getFinger(4);        


    // ----- DRAWING -----
        
   // hand.draw();
    
    pushMatrix();
    
    translate(hand_stabilized.x, hand_stabilized.y, hand_stabilized.z);
    
    println("hand_stabilized: "+hand_stabilized);
    
    rotateX(hand_roll+HALF_PI);
    rotateY(hand_pitch);
    rotateZ(-hand_yaw);
    
    fill(222,77);
    stroke(255,77);
    box(200,200,10);
    
    
    popMatrix();
    
    
    // hand.drawSphere();


    // ========= ARM =========
        
    if(hand.hasArm()){
      Arm     arm               = hand.getArm();
      float   arm_width         = arm.getWidth();
      PVector arm_wrist_pos     = arm.getWristPosition();
      PVector arm_elbow_pos     = arm.getElbowPosition();
    }


    // ========= FINGERS =========
        
    for(Finger finger : hand.getFingers()){
      
      
      // ----- BASICS -----
            
      int     finger_id         = finger.getId();
      PVector finger_position   = finger.getPosition();
      PVector finger_stabilized = finger.getStabilizedPosition();
      PVector finger_velocity   = finger.getVelocity();
      PVector finger_direction  = finger.getDirection();
      float   finger_time       = finger.getTimeVisible();


      // ----- SPECIFIC FINGER -----
            
      switch(finger.getType()){
        case 0:
          // System.out.println("thumb");
          break;
        case 1:
          // System.out.println("index");
          break;
        case 2:
          // System.out.println("middle");
          break;
        case 3:
          // System.out.println("ring");
          break;
        case 4:
          // System.out.println("pinky");
          break;
      }


      // ----- SPECIFIC BONE -----
            
      Bone    bone_distal       = finger.getDistalBone();
      // or                       finger.get("distal");
      // or                       finger.getBone(0);
            
      Bone    bone_intermediate = finger.getIntermediateBone();
      // or                       finger.get("intermediate");
      // or                       finger.getBone(1);
            
      Bone    bone_proximal     = finger.getProximalBone();
      // or                       finger.get("proximal");
      // or                       finger.getBone(2);

      Bone    bone_metacarpal   = finger.getMetacarpalBone();
      // or                       finger.get("metacarpal");
      // or                       finger.getBone(3);
            
            
      // ----- DRAWING -----
            
      // finger.draw(); // = drawLines()+drawJoints()
      // finger.drawLines();
      // finger.drawJoints();


      // ----- TOUCH EMULATION -----
            
      int     touch_zone        = finger.getTouchZone();
      float   touch_distance    = finger.getTouchDistance();
      
      switch(touch_zone){
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
    
    
      // ========= TOOLS =========
        
      for(Tool tool : hand.getTools()){
      
      
        // ----- BASICS -----
            
        int     tool_id           = tool.getId();
        PVector tool_position     = tool.getPosition();
        PVector tool_stabilized   = tool.getStabilizedPosition();
        PVector tool_velocity     = tool.getVelocity();
        PVector tool_direction    = tool.getDirection();
        float   tool_time         = tool.getTimeVisible();
      
      
        // ----- DRAWING -----
            
        // tool.draw();
      
      
        // ----- TOUCH EMULATION -----
            
        int     touch_zone        = tool.getTouchZone();
        float   touch_distance    = tool.getTouchDistance();
      
        switch(touch_zone){
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
  
  
  // ========= DEVICES =========
    
  for(Device device : leap.getDevices()){
    float device_horizontal_view_angle = device.getHorizontalViewAngle();
    float device_verical_view_angle = device.getVerticalViewAngle();
    float device_range = device.getRange();
  }
    
}

// ========= CALLBACKS =========

void leapOnInit(){
  // println("Leap Motion Init");
}
void leapOnConnect(){
  // println("Leap Motion Connect");
}
void leapOnFrame(){
  // println("Leap Motion Frame");
}
void leapOnDisconnect(){
  // println("Leap Motion Disconnect");
}
void leapOnExit(){
  // println("Leap Motion Exit");
}
