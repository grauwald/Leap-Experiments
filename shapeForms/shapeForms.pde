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

void setup() {
  size(displayWidth, displayHeight, P3D);
  background(0);
  noStroke();

  ellipseMode(CENTER);
  rectMode(CENTER);

  // ...

  leap = new LeapMotion(this);
}

void draw() {

 // ambientLight(0, 0, 0);
  lightFalloff(1.0, 0.01, 0.0);

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

    pointLight( 255, 255, 255, hand_stabilized.x, hand_stabilized.y, hand_stabilized.z);


    // ========= FINGERS =========

    fill(196, 196, 196); 
    noStroke();
    beginShape(QUAD_STRIP);
    for (int i=1; i<5; i++) {
      Finger finger_last = hand.getFinger(i-1);
      Finger finger_current = hand.getFinger(i);

      PVector pjoint =  finger_last.getPositionOfJointTip();
      PVector joint = finger_current.getPositionOfJointTip();

      PVector norm;

     
      norm = new PVector(pjoint.x, pjoint.y, pjoint.z);
      norm.normalize();
      normal(norm.x, norm.y, norm.z);
      vertex(pjoint.x, pjoint.y, pjoint.z);
      norm = new PVector(joint.x, joint.y, joint.z);
      norm.normalize();
      normal(norm.x, norm.y, norm.z);
      vertex(joint.x, joint.y, joint.z);

      pjoint =  finger_last.getPositionOfJointDip();
      joint = finger_current.getPositionOfJointDip();

      norm = new PVector(pjoint.x, pjoint.y, pjoint.z);
      norm.normalize();
      normal(norm.x, norm.y, norm.z);
      vertex(pjoint.x, pjoint.y, pjoint.z);
      norm = new PVector(joint.x, joint.y, joint.z);
      norm.normalize();
      normal(norm.x, norm.y, norm.z);
      vertex(joint.x, joint.y, joint.z);

      pjoint =  finger_last.getPositionOfJointPip();
      joint = finger_current.getPositionOfJointPip();

      norm = new PVector(pjoint.x, pjoint.y, pjoint.z);
      norm.normalize();
      normal(norm.x, norm.y, norm.z);
      vertex(pjoint.x, pjoint.y, pjoint.z);
      norm = new PVector(joint.x, joint.y, joint.z);
      norm.normalize();
      normal(norm.x, norm.y, norm.z);
      vertex(joint.x, joint.y, joint.z);

      pjoint =  finger_last.getPositionOfJointMcp();
      joint = finger_current.getPositionOfJointMcp();

      norm = new PVector(pjoint.x, pjoint.y, pjoint.z);
      norm.normalize();
      normal(norm.x, norm.y, norm.z);
      vertex(pjoint.x, pjoint.y, pjoint.z);
      norm = new PVector(joint.x, joint.y, joint.z);
      norm.normalize();
      normal(norm.x, norm.y, norm.z);
      vertex(joint.x, joint.y, joint.z);
      
      
//        pjoint = finger_last.get
//        joint = finger_current.getPosition();
//        
//        norm = new PVector(pjoint.x, pjoint.y, pjoint.z);
//        norm.normalize();
//        normal(norm.x, norm.y, norm.z);
//        vertex(pjoint.x, pjoint.y, pjoint.z);
//        norm = new PVector(joint.x, joint.y, joint.z);
//        norm.normalize();
//        normal(norm.x, norm.y, norm.z);
//        vertex(joint.x, joint.y, joint.z);
      
      
    }
    endShape();
  }
}

// ========= CALLBACKS =========

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
