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
    float radiusMax = random(77, 111); 
    int totalVertex = round(random(5, 10));
    int totalSegments = round(random(5, 10)); 
    float noiseAmp = random(4, 17);
    color strokeColor = color(random(255), 128, 255, 11); 
    color fillColorLower = color(random(255), 255, 196, 16); 
    color fillColorUpper  = color(random(255), 16, 128, 0);
    Geode geode = new Geode(radiusMax, totalVertex, totalSegments, noiseAmp, strokeColor, fillColorLower, fillColorUpper );
    geodes[i] = geode;
  }

  // ...

  leap = new LeapMotion(this);
}

void draw() {

  lightFalloff(0.1, 0.0007, 0.0);

  drawBackground();


  // ...
  int fps = leap.getFrameRate();

  // ========= HANDS =========

  for (Hand hand : leap.getHands ()) {

    PVector hand_stabilized  = hand.getStabilizedPosition();
    pointLight( 255, 0, 255, hand_stabilized.x, hand_stabilized.y-200, hand_stabilized.z);


    // ========= FINGERS =========

    noStroke();
    beginShape(QUAD_STRIP);

    Finger finger_current;
    PVector joint_current;

    for (int i=0; i<5; i++) {

      finger_current = hand.getFinger(i);

      int geodeIndex = i*4;
      joint_current = finger_current.getPositionOfJointTip();
      drawGeode(joint_current, geodeIndex);

      geodeIndex++;
      joint_current = finger_current.getPositionOfJointDip();
      drawGeode(joint_current, geodeIndex);

      geodeIndex++;
      joint_current = finger_current.getPositionOfJointPip();
      drawGeode(joint_current, geodeIndex);

      geodeIndex++;
      joint_current = finger_current.getPositionOfJointMcp();
      drawGeode(joint_current, geodeIndex);
    }
    endShape();
  }
}

void drawBackground() {
  pushMatrix();
  translate(width*.5, height*.5, 0);

  rotateY(millis()*.00007);
  pointLight( 255, 0, 255, 0, 0, 999);

  fill(255, 44);
  sphere(1000);

  popMatrix();
}

void drawGeode(PVector joint, int geodeIndex) {
  pushMatrix();
  translate(joint.x, joint.y, joint.z);
  rotateX(joint.x*.007);
  rotateY(joint.y*.007);
  rotateZ(joint.z*.007);

  shape(geodes[geodeIndex].mesh);

  popMatrix();
}
