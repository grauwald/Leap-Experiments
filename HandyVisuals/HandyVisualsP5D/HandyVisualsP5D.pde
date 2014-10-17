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

  //set up physics
  physics = new VPhysics();
  physics.setfriction(.4f);

  // new AttractionForce: (Vec pos, radius, strength)
  attr = new BAttraction(new Vec(width * .5f, height * .5f), 400, .1f);
  physics.addBehavior(attr);

  for (int i = 0; i < amount; i++) {
    // val for arbitrary radius
    float rad = random(2, 20);
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
      //particle
      stroke(200, 0, 0);
      // set pos to fingerPosition
      attr.setAttractor(new Vec(fingerPos.x, fingerPos.y, fingerPos.z));
      ellipse(attr.getAttractor().x, attr.getAttractor().y, attr.getRadius(), attr.getRadius());

      noStroke();
      fill(0, 255);
      for (VParticle p : physics.particles) {
        ellipse(p.x, p.y, p.getRadius() * 2, p.getRadius() * 2);
      }

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

