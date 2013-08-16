import com.onformative.leap.LeapMotionP5;
import com.leapmotion.leap.Finger;
import com.leapmotion.leap.Hand;
import peasy.*;
import punktiert.math.Vec;
import punktiert.physics.*;

PeasyCam cam;
VPhysics physics;
BAttraction attr;
LeapMotionP5 leap;

// number of particles in the scene
int amount = 200;


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
int cols, rows;


public void setup() {
  size(800, 800, P3D);
  leap = new LeapMotionP5(this);
  cam = new PeasyCam(this, 1000);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(2000);


  cols = width/videoScale;
  rows = height/videoScale;

 physics = new VPhysics();

  for (int i = 0; i < 1000; i++) {

    Vec pos = new Vec(0, 0, 0).jitter(10);
    Vec vel = new Vec(random(-1, 1), random(-1, 1), random(-1, 1));
    VBoid p = new VBoid(pos, vel);

    p.swarm.setSeperationScale(3.0f);
    p.swarm.setSeperationRadius(50);
    p.trail.setInPast(1);
    physics.addParticle(p);

    VSpring anchor = new VSpring(new VParticle(p.x(), p.y(), p.z()), p, 400, .05f);
    physics.addSpring(anchor);
  }
}

public void draw() {
  background(255);


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
      // For every column and row, a rectangle is drawn at an (x,y) location scaled and sized by videoScale.
      rect(x, y, videoScale, videoScale);
    }
  }


  for (Hand hand : leap.getHandList()) {


    PVector handPos = leap.getPosition(hand);
    PVector sphere_center = leap.getSphereCenter(hand);
    float sphere_radius = leap.getSphereRadius(hand);
    //PVector handStable = leap.getStabilizedPosition(hand);

    stroke(0, 255, 0);
    strokeWeight(1);
    float ellipseSizeHand = map(handPos.z, 300, -400, handPos.z/10, handPos.z/5);
    ellipse(handPos.x, handPos.y, ellipseSizeHand, ellipseSizeHand);

    arc(handPos.x, handPos.y, 60, 60, PI, TWO_PI);

    stroke(0);
    pushMatrix();
    translate(handPos.x, handPos.y, handPos.z);
    scale(10);
    beginShape();
    vertex(-1, -1, -1);
    vertex( 1, -1, -1);
    vertex( 0, 0, 1);

    vertex( 1, -1, -1);
    vertex( 1, 1, -1);
    vertex( 0, 0, 1);

    vertex( 1, 1, -1);
    vertex(-1, 1, -1);
    vertex( 0, 0, 1);

    vertex(-1, 1, -1);
    vertex(-1, -1, -1);
    vertex( 0, 0, 1);
    endShape();
    popMatrix();


    for (Finger finger : leap.getFingerList()) {
      PVector fingerPos = leap.getTip(finger);
      stroke(255, 0, 0);

      line(handPos.x, handPos.y, handPos.z, 
      fingerPos.x, fingerPos.y, fingerPos.z);
      float ellipseSizeHandStable = map(fingerPos.z, 300, -400, fingerPos.z/10, fingerPos.z/5);
      ellipse(fingerPos.x, fingerPos.y, ellipseSizeHandStable, ellipseSizeHandStable);
      println("finger" + fingerPos);
      
      rect(width/2, height/2, 200, 50, 50);
      //particle
      noStroke();
      noFill();
     for (int i = 0; i < physics.particles.size(); i++) {
    VBoid boid = (VBoid) physics.particles.get(i);

    strokeWeight(5);
    stroke(0);
    point(fingerPos.x, fingerPos.y*3, boid.z);
    
    if (frameCount > 50) {
        boid.trail.setInPast(100);
      }

    strokeWeight(1);
    stroke(200, 0, 0);
    noFill();
    beginShape();
    for (int j=0;j<boid.trail.particles.size();j++) {
      VParticle t = boid.trail.particles.get(j);
      vertex(fingerPos.x, t.y, t.z);
    }
    endShape();
     }
      noStroke();
      noFill();

      stroke(0, 0, 255);
      arc(fingerPos.x, fingerPos.y, 60, 60, PI, TWO_PI);
      stroke(0, 200, 200);
      strokeWeight(1);
      pushMatrix();
      translate(fingerPos.x, fingerPos.y, fingerPos.z);
      sphereDetail(10, 10);
      sphere(5);

      popMatrix();
    }
  }
}
public void stop() {
  leap.stop();
}

