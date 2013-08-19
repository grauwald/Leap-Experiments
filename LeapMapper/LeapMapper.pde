import com.leapmotion.leap.CircleGesture;
import com.leapmotion.leap.Gesture.State;
import com.leapmotion.leap.Gesture.Type;
import com.leapmotion.leap.Hand;
import com.leapmotion.leap.KeyTapGesture;
import com.leapmotion.leap.ScreenTapGesture;
import com.leapmotion.leap.SwipeGesture;
import com.onformative.leap.LeapMotionP5;
import com.leapmotion.leap.Finger;
import com.leapmotion.leap.Hand;
import peasy.*;
import controlP5.*;
import punktiert.math.Vec;
import punktiert.physics.*;

Spot sp;
Grid gr;
HFV hfv;
GUI gui;

PeasyCam cam;
ControlP5 cp5;
VPhysics physics;
BAttraction attr;
LeapMotionP5 leap;
String lastGesture =
"enabling gestures: \n'c' for CircleGesture\n's' for SwipeGesture\n'k' for KeyTapGesture\n't' for ScreenTapGesture";
int myColor = color(0, 0, 0);

int bgR = 100;
int bgG = 100;
int bgB = 100;
int sliderTicks1 = 100;
int sliderTicks2 = 30;
Slider abc;

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
  cp5.setAutoDraw(false);

  // add a horizontal sliders, the value of this slider will be linked
  // to variable 'sliderValue' 
  cp5.addSlider("bgR")
    .setPosition(100, 50)
      .setRange(0, 255)
        ;
  cp5.addSlider("bgG")
    .setPosition(100, 60)
      .setRange(0, 255)
        ;

  cp5.addSlider("bgB")
    .setPosition(100, 70)
      .setRange(0, 255)
        ;

  gr = new Grid();
  sp = new Spot();
  hfv = new HFV();
  gui = new GUI();
  sp.x = 33;
  sp.y = 50;
  sp.diameter = 30;
  gr.x1 = 0;
  gr.y1 = 0;
  
  cols = width/videoScale;
  rows = height/videoScale;

}

public void draw() {
  background(bgR, bgG, bgB);

  sp.display();
  gr.display();
  hfv.display();
  gui.display();
}


void controlEvent(ControlEvent theEvent) {
  println(theEvent.getController().getId());
}

void slider(float theColor) {
  myColor = color(theColor);
  println("a slider event. setting background to "+theColor);
}

public void circleGestureRecognized(CircleGesture gesture, String clockwiseness) {
  if (gesture.state() == State.STATE_STOP) {
    System.out.println("//////////////////////////////////////");
    System.out.println("Gesture type: " + gesture.type().toString());
    System.out.println("ID: " + gesture.id());
    System.out.println("Radius: " + gesture.radius());
    System.out.println("Normal: " + gesture.normal());
    System.out.println("Clockwiseness: " + clockwiseness);
    System.out.println("Turns: " + gesture.progress());
    System.out.println("Center: " + leap.vectorToPVector(gesture.center()));
    System.out.println("Duration: " + gesture.durationSeconds() + "s");
    System.out.println("//////////////////////////////////////");
    lastGesture = "Gesture type: " + gesture.type().toString() + "\n";
    lastGesture += "ID: " + gesture.id() + "\n";
    lastGesture += "Radius: " + gesture.radius() + "\n";
    lastGesture += "Normal: " + gesture.normal() + "\n";
    lastGesture += "Clockwiseness: " + clockwiseness + "\n";
    lastGesture += "Turns: " + gesture.progress() + "\n";
    lastGesture += "Center: " + leap.vectorToPVector(gesture.center()) + "\n";
    lastGesture += "Duration: " + gesture.durationSeconds() + "s" + "\n";
  } 
  else if (gesture.state() == State.STATE_START) {
  } 
  else if (gesture.state() == State.STATE_UPDATE) {
  }
}

public void swipeGestureRecognized(SwipeGesture gesture) {
  if (gesture.state() == State.STATE_STOP) {
    System.out.println("//////////////////////////////////////");
    System.out.println("Gesture type: " + gesture.type());
    System.out.println("ID: " + gesture.id());
    System.out.println("Position: " + leap.vectorToPVector(gesture.position()));
    System.out.println("Direction: " + gesture.direction());
    System.out.println("Duration: " + gesture.durationSeconds() + "s");
    System.out.println("Speed: " + gesture.speed());
    System.out.println("//////////////////////////////////////");
    lastGesture = "Gesture type: " + gesture.type().toString() + "\n";
    lastGesture += "ID: " + gesture.id() + "\n";
    lastGesture += "Position: " + leap.vectorToPVector(gesture.position()) + "\n";
    lastGesture += "Direction: " + gesture.direction() + "\n";
    lastGesture += "Speed: " + gesture.speed() + "\n";
    lastGesture += "Duration: " + gesture.durationSeconds() + "s" + "\n";
  } 
  else if (gesture.state() == State.STATE_START) {
  } 
  else if (gesture.state() == State.STATE_UPDATE) {
  }
}

public void screenTapGestureRecognized(ScreenTapGesture gesture) {
  if (gesture.state() == State.STATE_STOP) {
    System.out.println("//////////////////////////////////////");
    System.out.println("Gesture type: " + gesture.type());
    System.out.println("ID: " + gesture.id());
    System.out.println("Position: " + leap.vectorToPVector(gesture.position()));
    System.out.println("Direction: " + gesture.direction());
    System.out.println("Duration: " + gesture.durationSeconds() + "s");
    System.out.println("//////////////////////////////////////");
    lastGesture = "Gesture type: " + gesture.type().toString() + "\n";
    lastGesture += "ID: " + gesture.id() + "\n";
    lastGesture += "Position: " + leap.vectorToPVector(gesture.position()) + "\n";
    lastGesture += "Direction: " + gesture.direction() + "\n";
    lastGesture += "Duration: " + gesture.durationSeconds() + "s" + "\n";
  } 
  else if (gesture.state() == State.STATE_START) {
  } 
  else if (gesture.state() == State.STATE_UPDATE) {
  }
}

public void KeyTapGestureRecognized(KeyTapGesture gesture) {
  if (gesture.state() == State.STATE_STOP) {
    System.out.println("//////////////////////////////////////");
    System.out.println("Gesture type: " + gesture.type());
    System.out.println("ID: " + gesture.id());
    System.out.println("Position: " + leap.vectorToPVector(gesture.position()));
    System.out.println("Direction: " + gesture.direction());
    System.out.println("Duration: " + gesture.durationSeconds() + "s");
    System.out.println("//////////////////////////////////////");
    lastGesture = "Gesture type: " + gesture.type().toString() + "\n";
    lastGesture += "ID: " + gesture.id() + "\n";
    lastGesture += "Position: " + leap.vectorToPVector(gesture.position()) + "\n";
    lastGesture += "Direction: " + gesture.direction() + "\n";
    lastGesture += "Duration: " + gesture.durationSeconds() + "s" + "\n";
  } 
  else if (gesture.state() == State.STATE_START) {
  } 
  else if (gesture.state() == State.STATE_UPDATE) {
  }
}

public void keyPressed() {
  if (key == 'c') {
    if (leap.isEnabled(Type.TYPE_CIRCLE)) {
      leap.disableGesture(Type.TYPE_CIRCLE);
      lastGesture = "Circle Gesture disabled.";
    } 
    else {
      leap.enableGesture(Type.TYPE_CIRCLE);
      lastGesture = "Circle Gesture enabled.";
    }
  }

  if (key == 's') {
    if (leap.isEnabled(Type.TYPE_SWIPE)) {
      leap.disableGesture(Type.TYPE_SWIPE);
      lastGesture = "Swipe Gesture disabled.";
    } 
    else {
      leap.enableGesture(Type.TYPE_SWIPE);
      lastGesture = "Swipe Gesture enabled.";
    }
  }

  if (key == 'k') {
    if (leap.isEnabled(Type.TYPE_KEY_TAP)) {
      leap.disableGesture(Type.TYPE_KEY_TAP);
      lastGesture = "KeyTap Gesture disabled.";
    } 
    else {
      leap.enableGesture(Type.TYPE_KEY_TAP);
      lastGesture = "KeyTap Gesture enabled.";
    }
  }

  if (key == 't') {
    if (leap.isEnabled(Type.TYPE_SCREEN_TAP)) {
      leap.disableGesture(Type.TYPE_SCREEN_TAP);
      lastGesture = "ScreenTap Gesture disabled. ";
    } 
    else {
      leap.enableGesture(Type.TYPE_SCREEN_TAP);
      lastGesture = "ScreenTap Gesture enabled. "; 
    }
  }
}

public void stop() {
  leap.stop();
}

