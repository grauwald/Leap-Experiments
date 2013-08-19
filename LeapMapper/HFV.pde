class HFV {

  void display() {
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
      stroke(0, 255, 0);
      strokeWeight(.5);
      float ellipseSizeHand = map(handPos.z, 300, -400, handPos.z/10, handPos.z/5);
      ellipse(handPos.x, handPos.y, ellipseSizeHand, ellipseSizeHand);

      strokeWeight(.5);
      arc(handPos.x, handPos.y, 60, 60, PI, TWO_PI);


      pushMatrix();
      stroke(0);
      translate(handPos.x, handPos.y, handPos.z);
      ellipse(0, 0, 50, 50);
      popMatrix();


      pushMatrix();
      stroke(0);
      translate(handNorm.x, handNorm.y, handNorm.z);
      ellipse(0, 0, 50, 50);
      popMatrix();

      beginShape();
      stroke(50, 20, 120);
      strokeWeight(.7);
      vertex(handVel.x, handVel.y, handVel.z);
      vertex(handDir.x, handDir.y, handDir.z);
      endShape();

      pushMatrix();
      translate(handPos.x, handPos.y, handPos.z);
      rotateZ(radians(map(roll, 0, 90, 0, 180)));

      stroke(0, 200, 0);
      noFill();
      line(0, 0, 100, 100);
      ellipse(0, 0, sphere_radius*2, sphere_radius*2);
      popMatrix();

      pushMatrix();
      translate(handPos.x, handPos.y, handPos.z);
      rotateY(radians(map(yaw, 0, 90, 0, 180)));
      stroke(255, 0, 0);
      strokeWeight(1);

      ellipse(0, 0, sphere_radius*2, sphere_radius*2);
      noStroke();
      popMatrix();

      strokeWeight(1);

      pushMatrix();
      translate(handPos.x, handPos.y, handPos.z);
      rotateX(radians(map(pitch, 0, 90, 0, 180)));

      stroke(0, 0, 255);
      noFill();
      ellipse(0, 0, sphere_radius*2, sphere_radius*2);
      popMatrix();

      pushMatrix();
      translate(sphere_center.x, sphere_center.y, sphere_center.z);
      rotateY(radians(map(yaw, 0, 90, 0, 180)));
      stroke(255, 0, 0);
      strokeWeight(1);

      ellipse(0, 0, sphere_radius/2, sphere_radius/2);
      noStroke();
      popMatrix();

      pushMatrix();
      translate(sphere_center.x, sphere_center.y, sphere_center.z);
      rotateZ(radians(map(roll, 0, 90, 0, 180)));

      stroke(0, 200, 0);
      noFill();
      line(0, 0, 100, 100);
      ellipse(0, 0, sphere_radius/2, sphere_radius/2);
      popMatrix();


      pushMatrix();
      stroke(10, 100, 0);
      translate(sphere_center.x, sphere_center.y, sphere_center.z);
      ellipse(0, 0, 20, 20);
      println("hand" + handPos);
      popMatrix();

      pushMatrix();
      translate(handPos.x, 800, handPos.z);
      fill(handPos.x, handPos.y, handPos.z);
      rotateX(radians(map(-90, 0, -90, 0, 90)));
      rect(0, 0, 50, 50);
      popMatrix();

      stroke(120, 120, 120);
      strokeWeight(.2);

      beginShape();
      vertex(handPos.x, handPos.y, handPos.z);
      vertex(handPos.x, 800, handPos.z);
      endShape();
      for (Finger finger : leap.getFingerList()) {
        PVector fingerPos = leap.getTip(finger);
        PVector fingerOrigin = leap.getOrigin(finger);
        PVector fingerDir = leap.getDirection(finger);

        beginShape();
        stroke(120, 120, 120);
        vertex(fingerOrigin.x, fingerOrigin.y, fingerOrigin.z);
        stroke(fingerPos.x, fingerPos.y, fingerPos.z);
        vertex(fingerPos.x, fingerPos.y, fingerPos.z);
        stroke(0);
        vertex(fingerPos.x, fingerPos.y-10, fingerPos.z+150); 
        fill(handPos.x, handPos.y, handPos.z);
        vertex(fingerOrigin.x, fingerOrigin.y, fingerOrigin.z); 
        endShape(CLOSE);

        stroke(120, 120, 120);
        strokeWeight(.5);
        noFill();
        beginShape();
        vertex(handPos.x, handPos.y, handPos.z);
        vertex(sphere_center.x, sphere_center.y, sphere_center.z);
        endShape();

        beginShape();
        vertex(fingerDir.x, fingerDir.y, fingerDir.z);
        vertex(fingerPos.x, fingerPos.y, fingerPos.z);
        endShape();

        float ellipseSizeHandStable = map(fingerPos.z, 300, -400, fingerPos.z/10, fingerPos.z/5);
        stroke(fingerPos.x, fingerPos.y, fingerPos.z);
        pushMatrix();
        translate(fingerPos.x, fingerPos.y, fingerPos.z);
        ellipse(0, 0, 20, 20);
        println("finger" + fingerPos);
        popMatrix();
        stroke(100);
        noFill();
        pushMatrix();
        translate(fingerOrigin.x, fingerOrigin.y, fingerOrigin.z);
        ellipse(0, 0, 10, 10);
        popMatrix();
/*
        pushMatrix();
        translate(handPos.x, handPos.y, handPos.z);
        rotateY(radians(map(yaw, 0, 90, 0, 180)));
        stroke(255, 120, 0);
        strokeWeight(1);

        ellipse(0, 0, handPos.x - fingerOrigin.x, handPos.z - fingerOrigin.z);
 
        noStroke();
        popMatrix();
        */
      }
    }
  }
}

