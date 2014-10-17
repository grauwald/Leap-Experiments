import com.onformative.leap.LeapMotionP5;
import com.leapmotion.leap.Finger;
import com.leapmotion.leap.Hand;
import peasy.*;
import controlP5.*;
import punktiert.math.Vec;
import punktiert.physics.*;

PeasyCam cam;
ControlP5 cp5;
VPhysics physics;
BAttraction attr;
LeapMotionP5 leap;

// number of particles in the scene
int amount = 500;

//grid integers
int x;
int y;
float outerRad;
float innerRad;

PVector f1;
// Size of each cell in the grid, ratio of window size to video size
// 80 * 8 = 640
// 60 * 8 = 480
int videoScale = 100;

// Number of columns and rows in our system
int cols, rows;


public void setup() {
  size(1200, 800, P3D);
  leap = new LeapMotionP5(this);
  cam = new PeasyCam(this, 1000);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(5000);
   cp5 = new ControlP5(this);
  cp5.addButton("button", 10, 100, 60, 80, 20).setId(1);
  cp5.addButton("buttonValue", 4, 100, 90, 80, 20).setId(2);
  cp5.setAutoDraw(false);


  cols = width/videoScale;
  rows = height/videoScale;

  //set up physics
  physics = new VPhysics();
  physics.setfriction(.4f);

  // new AttractionForce: (Vec pos, radius, strength)
  attr = new BAttraction(new Vec(width * .5f, height * .5f), 400, .1f);
  physics.addBehavior(attr);

  for (int i = 0; i < amount; i++) {
    // val for arbitrary radius
    float rad = random(1, 20);
    // vector for position
    Vec pos = new Vec(random(rad, width - rad), random(rad, height - rad));
    // create particle (Vec pos, mass, radius)
    VParticle particle = new VParticle(pos, 4, rad);
    // add Collision Behavior
    particle.addBehavior(new BCollision());
    // add particle to world
    physics.addParticle(particle);
  }
}

public void draw() {
  background(230);
  stroke(255, 0, 0);


  physics.update();
  noFill();

  // Begin loop for columns
  for (int i = 0; i < cols; i++) {
    // Begin loop for rows
    for (int j = 0; j < rows; j++) {
      //


      // Scaling up to draw a rectangle at (x,y)
      int x = i*videoScale;
      int y = j*videoScale;


      noFill();
      stroke(170, 170, 170);
      strokeWeight(.7);
      pushMatrix();
      translate(0, 0, 0);
      // For every column and row, a rectangle is drawn at an (x,y) location scaled and sized by videoScale.
      rect(x, y, 700, videoScale);
      popMatrix();

      noFill();
      stroke(255, 0, 0);
      strokeWeight(.2);
      pushMatrix();
      translate(0, 800, 0);
      rotateX(radians(map(-90, 0, -90, 0, 90)));
      // rotateY(radians(map(-90, 0, -90, 0, 90)));
      //rotateZ(radians(map(-90, 0, -90, 0, 90)));
      // For every column and row, a rectangle is drawn at an (x,y) location scaled and sized by videoScale.
      rect(x, y, 700, 700);
      popMatrix();

      noFill();
      stroke(0, 255, 0);
      pushMatrix();
      translate(0, 800, 0);
      rotateX(radians(map(90, 0, 90, 0, -90)));
      // rotateY(radians(map(-90, 0, -90, 0, 90)));
      //rotateZ(radians(map(-90, 0, -90, 0, 90)));
      // For every column and row, a rectangle is drawn at an (x,y) location scaled and sized by videoScale.
      rect(x, y, 700, 700);
      popMatrix();
      noFill();
      stroke(0, 0, 255);
      pushMatrix();
      translate(0, 0, 0);
      rotateX(radians(map(-90, 0, -90, 0, 90)));
      rotateY(radians(map(-90, 0, -90, 0, 90)));
      //rotateZ(radians(map(-90, 0, -90, 0, 90)));
      // For every column and row, a rectangle is drawn at an (x,y) location scaled and sized by videoScale.
      rect(x, y, videoScale, 700);
      popMatrix();
      
            noFill();
      stroke(0, 255, 255);
      pushMatrix();
      translate(0, 0, 0);
      rotateX(radians(map(90, 0, 90, 0, -90)));
      rotateY(radians(map(90, 0, 90, 0, -90)));
      //rotateZ(radians(map(-90, 0, -90, 0, 90)));
      // For every column and row, a rectangle is drawn at an (x,y) location scaled and sized by videoScale.
      rect(x, y, videoScale, 700);
      popMatrix();
    }
  }


  for (Hand hand : leap.getHandList()) {
    
   // Hand getHand(int handNr);
    ArrayList handList = leap.getHandList();
    PVector handPos = leap.getPosition(hand);
    PVector sphere_center = leap.getSphereCenter(hand);
    PVector handVel = leap.getVelocity(hand);
    PVector handNorm = leap.getNormal(hand);
    PVector handDir = leap.getDirection(hand);
    float sphere_radius = leap.getSphereRadius(hand);
    float pitch = leap.getPitch(hand);
    float handSize = leap.getSphereRadius(hand);
    float roll = leap.getRoll(hand);
    float yaw = leap.getYaw(hand);
    //PVector handStable = leap.getStabilizedPosition(hand);


    for (Finger finger : leap.getFingerList()) {
      PVector fingerPos = leap.getTip(finger);
      PVector fingerOrigin = leap.getOrigin(finger);
      PVector fingerDir = leap.getDirection(finger);



      stroke(0, 255, 0);
      strokeWeight(.5);
      float ellipseSizeHand = map(handPos.z, 300, -400, handPos.z/10, handPos.z/5);
      ellipse(handPos.x, handPos.y, ellipseSizeHand, ellipseSizeHand);



      strokeWeight(.5);
      arc(handPos.x, handPos.y, 60, 60, PI, TWO_PI);

      stroke(0);
      pushMatrix();
      beginShape();
      translate(handPos.x, handPos.y, handPos.z);
      ellipse(0, 0, 50, 50);
      
      
      popMatrix();

      stroke(0);
      pushMatrix();
      translate(handNorm.x, handNorm.y, handNorm.z);
      ellipse(0, 0, 50, 50);
      popMatrix();

      beginShape();
      stroke(50, 20, 120);
      strokeWeight(.7);
      vertex(handVel.x, handVel.y, handVel.z);
      vertex(handDir.x, handDir.y, handDir.z);
      endShape();
     


      stroke(255, 0, 0);
      beginShape();
      vertex(handPos.x, handPos.y, handPos.z);
      stroke(120, 120, 120);
      vertex(fingerOrigin.x, fingerOrigin.y, fingerOrigin.z);
      noStroke();
      stroke(fingerPos.x, fingerPos.y, fingerPos.z);
      vertex(fingerPos.x, fingerPos.y, fingerPos.z);
      noStroke();
      stroke(0);
      vertex(fingerPos.x, fingerPos.y-10, fingerPos.z+250);
      fill(handPos.x, handPos.y, handPos.z);
      vertex(fingerOrigin.x, fingerOrigin.y, fingerOrigin.z);
      vertex(sphere_center.x, sphere_center.y+10, sphere_center.z+150);
      endShape(CLOSE);
      
      pushMatrix();
      translate(handPos.x, 800, handPos.z);
       rotateX(radians(map(-90, 0, -90, 0, 90)));
      //rotateY(radians(map(-90, 0, -90, 0, 90)));
      //rotateZ(radians(map(-90, 0, -90, 0, 90)));
      // For every column and row, a rectangle is drawn at an (x,y) location scaled and sized by videoScale.
      rect(0, 0, 50, 50);
      popMatrix();
      
      
      stroke(120, 120, 120);
      strokeWeight(.2);
      
            beginShape();
      vertex(handPos.x, handPos.y, handPos.z);
      vertex(handPos.x, 800, handPos.z);
      endShape();
      
      beginShape();
      vertex(sphere_center.x, sphere_center.y+10, sphere_center.z+150);
      vertex(sphere_center.x, sphere_center.y, sphere_center.z);
      endShape();

      beginShape();
      vertex(fingerDir.x, fingerDir.y, fingerDir.z);
      vertex(fingerPos.x, fingerPos.y, fingerPos.z);
      endShape();
      
      strokeWeight(1);

      pushMatrix();
      translate(sphere_center.x, sphere_center.y, sphere_center.z);
      rotateX(radians(map(pitch, 0, 90, 0, 180)));
    // rotateY(radians(map(yaw, 1, 90, 90, -90)));
    // rotateZ(radians(map(roll, -40, 40, 45, -45)));

      stroke(0, 0, 255);
      noFill();
      ellipse(0, 0, sphere_radius*2, sphere_radius*2);
      popMatrix();

      pushMatrix();
      translate(sphere_center.x, sphere_center.y, sphere_center.z);
   // rotateX(radians(map(pitch, -180, 180, 180, -180)));
      rotateY(radians(map(yaw, 0, 90, 0, 180)));
   // rotateZ(radians(map(roll, -180, 180, 180, -180)));
      stroke(255, 0, 0);
      strokeWeight(1);
    
      ellipse(0, 0, sphere_radius*2, sphere_radius*2);
      noStroke();
      popMatrix();
      
            pushMatrix();
      translate(sphere_center.x, sphere_center.y, sphere_center.z);
     // rotateX(radians(map(pitch, 0, 90, 0, 180)));
    // rotateY(radians(map(yaw, 1, 90, 90, -90)));
     rotateZ(radians(map(roll, 0, 90, 0, 180)));

      stroke(0, 200, 0);
      noFill();
line(0,0,100,100);
      ellipse(0, 0, sphere_radius*2, sphere_radius*2);
      popMatrix();

      stroke(10, 100, 0);
      pushMatrix();
      translate(sphere_center.x, sphere_center.y, sphere_center.z);
      ellipse(0, 0, 20, 20);
      println("finger" + fingerPos);
      popMatrix();

      float ellipseSizeHandStable = map(fingerPos.z, 300, -400, fingerPos.z/10, fingerPos.z/5);
      stroke(0);
      pushMatrix();
      translate(fingerPos.x, fingerPos.y, fingerPos.z);
      ellipse(0, 0, 20, 20);
      println("finger" + fingerPos);
      popMatrix();
stroke(100);
      pushMatrix();
      translate(fingerOrigin.x, fingerOrigin.y, fingerOrigin.z);
      ellipse(0, 0, 10, 10);
      popMatrix();

      //particle
      noStroke();
      noFill();
      // set pos to fingerPosition
      attr.setAttractor(new Vec(fingerPos.x, fingerPos.y));
      ellipse(attr.getAttractor().x, attr.getAttractor().y, attr.getRadius(), attr.getRadius());

      noStroke();
      noFill();
      fill(0, 255);
      for (VParticle p : physics.particles) {
        ellipse(p.x, p.y, p.getRadius() * -2, p.getRadius() * -2);
      }
      noStroke();
      noFill();

      stroke(0, 0, 255);
      arc(fingerPos.x, fingerPos.y, 60, 60, PI, TWO_PI);
      stroke(0, 200, 200);
      strokeWeight(1);
      
    }
   
  }
   gui();
}
void gui() {
  hint(DISABLE_DEPTH_TEST);
  cam.beginHUD();
  cp5.draw();
  cam.endHUD();
  hint(ENABLE_DEPTH_TEST);
}

void controlEvent(ControlEvent theEvent) {
  println(theEvent.getController().getId());
}

void button(float theValue) {
  //myColor = color(random(255), random(255), random(255));
  println("a button event. "+theValue);
}
public void stop() {
  leap.stop();
}
