/*  
**  shapeForms
**  Experiment with Leap Motion for Processing Beta 
**  https://github.com/voidplus/leap-motion-processing/tree/beta
**  Beware, there are many libs with the same class LeapMotion
**
**  ©2014 Joseph Gray
*/

import de.voidplus.leapmotion.*;

LeapMotion leap;

int totalGeodes = 40; // 2*5*4 joints
Geode[] geodes; 

void setup() {
  size(displayWidth, displayHeight, P3D);
  background(0);
  noStroke();

  ellipseMode(CENTER);
  rectMode(CENTER);
  colorMode(HSB);
  
  
  geodes = new Geode[totalGeodes]; // 5*2*4 joints
  
  for (int i=0; i<totalGeodes; i++) {
    float radiusMax = random(555,777); 
    int totalVertex = round(random(5,10));
    int totalSegments = round(random(5,10)); 
    float noiseAmp = random(4,17);
    color strokeColor = color(128,128,255,11); 
    color fillColorLower = color(64,255,196,16); 
    color fillColorUpper  = color(96,16,128,0);
    Geode geode = new Geode(radiusMax, totalVertex, totalSegments, noiseAmp, strokeColor, fillColorLower, fillColorUpper );
  }

  // ...

  leap = new LeapMotion(this);
}

void draw() {

 // ambientLight(0, 0, 0);

  pushMatrix();
  translate(width*.5, height*.5, 0);

  rotateY(millis()*.00007);
  pointLight( 196, 196, 255, 0, 0, 999);

  fill(255, 77);


  sphere(1000);

  popMatrix();


  // ...
  int fps = leap.getFrameRate();

  // ========= HANDS =========

  for (Hand hand : leap.getHands ()) {


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

    pointLight( 255, 255, 255, hand_stabilized.x, hand_stabilized.y-200, hand_stabilized.z);


    // ========= FINGERS =========

    fill(196, 196, 196); 
    noStroke();
    beginShape(QUAD_STRIP);
    for (int i=1; i<5; i++) {
      Finger finger_last = hand.getFinger(i-1);
      Finger finger_current = hand.getFinger(i);

      PVector pjoint =  finger_last.getPositionOfJointTip();
      PVector joint = finger_current.getPositionOfJointTip();

      drawBoneWeb(pjoint, joint);

      pjoint =  finger_last.getPositionOfJointDip();
      joint = finger_current.getPositionOfJointDip();

      drawBoneWeb(pjoint, joint);

      pjoint =  finger_last.getPositionOfJointPip();
      joint = finger_current.getPositionOfJointPip();

      drawBoneWeb(pjoint, joint);

      pjoint =  finger_last.getPositionOfJointMcp();
      joint = finger_current.getPositionOfJointMcp();

      drawBoneWeb(pjoint, joint);
      

      
    }
    endShape();
  }
}

void drawBoneWeb(PVector pjoint, PVector joint){
      PVector norm;

      norm = new PVector(pjoint.x, pjoint.y, pjoint.z);
      norm.normalize();
      normal(norm.x, norm.y, norm.z);
      vertex(pjoint.x, pjoint.y, pjoint.z);
      
      norm = new PVector(joint.x, joint.y, joint.z);
      norm.normalize();
      normal(norm.x, norm.y, norm.z);
      vertex(joint.x, joint.y, joint.z);
}
