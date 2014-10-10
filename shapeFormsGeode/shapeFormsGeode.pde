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

float hand_roll, hand_pitch, hand_yaw;

int totalJoints = 40; // 2*5*4 joints
PVector[] joints; 


int totalGeodes = 40; // 2*5*4 joints
Geode[] geodes; 

void setup() {
  size(displayWidth, displayHeight, P3D);
  background(0);
  noStroke();

  ellipseMode(CENTER);
  rectMode(CENTER);
  colorMode(HSB);

  noCursor();


  joints = new PVector[totalJoints];

  geodes = new Geode[totalGeodes]; // 5*2*4 joints

  for (int i=0; i<totalGeodes; i++) {
    float radiusMax = random(44, 111); 
    int totalVertex = round(random(5, 10));
    int totalSegments = round(random(5, 10)); 
    float noiseAmp = random(4, 17);
    color strokeColor = color(random(255), 128, 255, 11); 
    color fillColorLower = color(random(255), 255, 196, random(7, 77)); 
    color fillColorUpper  = color(random(255), 255, 255, random(4, 11));
    Geode geode = new Geode(radiusMax, totalVertex, totalSegments, noiseAmp, strokeColor, fillColorLower, fillColorUpper );
    geodes[i] = geode;
  }

  // ...

  leap = new LeapMotion(this);
}

void draw() {

  lightFalloff(0.7, 0.001, 0.0);
  ambientLight(255, 0, 129);
  if (leap.countHands() > 0) drawBackground(44);
  else drawBackground(4);

  // ...
  int fps = leap.getFrameRate();

  // ========= HANDS =========

  for (Hand hand : leap.getHands ()) {

    PVector hand_stabilized  = hand.getStabilizedPosition();
    pointLight( 196, 255, 255, hand_stabilized.x, hand_stabilized.y-1000.0, hand_stabilized.z);
    pointLight( 64, 255, 255, hand_stabilized.x, hand_stabilized.y+1000.0, hand_stabilized.z);


    float scalar = hand.getSphereRadius()/100.0;
    println(scalar);

    hand_roll        = radians(hand.getRoll());
    hand_pitch       = radians(hand.getPitch());
    hand_yaw         = radians(hand.getYaw());


    // ========= FINGERS =========

    noStroke();
    beginShape(QUAD_STRIP);

    Finger finger_current;
    PVector joint_current;

    for (int i=0; i<5; i++) {

      finger_current = hand.getFinger(i);

      PVector[] joints = new PVector[4];
      joints[0] = finger_current.getPositionOfJointTip();
      joints[1] = finger_current.getPositionOfJointDip();
      joints[2] = finger_current.getPositionOfJointPip();
      joints[3] = finger_current.getPositionOfJointMcp();

      int geodeIndex = i*4;
      for (int j = 0; j<4; j++) {
        geodeIndex++;
        drawGeode(joints[j], geodeIndex, scalar);
      }
    }
    endShape();
  }
}

void drawBackground(float strength) {
  pushMatrix();
  translate(width*.5, height*.5, 0);

  rotateY(millis()*.00007);
  pointLight( 128, 0, 255, 0, 0, 999);

  fill(255, strength);
  sphere(1000);

  rotateX(HALF_PI);
  fill(0);
  rect(0, 0, 5000, 5000);

  popMatrix();
}

void drawGeode(PVector joint, int geodeIndex, float scalar) {
  pushMatrix();
  translate(joint.x, joint.y, joint.z);
  
  rotateX(joint.x*scalar*.001);
  rotateY(joint.y*scalar*.001);
  rotateZ(joint.z*scalar*.001);

  rotateX(hand_roll+HALF_PI);
  rotateY(hand_pitch);
  rotateZ(-hand_yaw);
  
  scale(scalar);

  shape(geodes[geodeIndex].mesh);
  popMatrix();
}
