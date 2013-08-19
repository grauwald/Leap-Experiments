class Grid {

  //grid integers
  int x1;
  int y1;
  float outerRad;
  float innerRad;

  PVector f2;
  // Size of each cell in the grid, ratio of window size to video size
  // 80 * 8 = 640
  // 60 * 8 = 480
  int videoScale = 700;

  // Number of columns and rows in our system
  int cols, rows;

  void display() {
    // Begin loop for columns


    pushMatrix();
    noFill();
    stroke(170, 170, 170);
    strokeWeight(.7);
    translate(0, 0, 0);
    // For every column and row, a rectangle is drawn at an (x,y) location scaled and sized by videoScale.
    rect(x, y, 700, videoScale);
    popMatrix();


    pushMatrix();    
    noFill();
    stroke(255, 0, 0);
    strokeWeight(.2);
    translate(0, 800, 0);
    rotateX(radians(map(-90, 0, -90, 0, 90)));
    rect(x1, y1, 700, 700);
    popMatrix();


    pushMatrix();
    noFill();
    stroke(0, 255, 0);
    translate(0, 800, 0);
    rotateX(radians(map(90, 0, 90, 0, -90)));
    rect(x1, y1, 700, 700);
    popMatrix();



    pushMatrix();
    noFill();
    stroke(0, 0, 255);
    translate(0, 0, 0);
    rotateX(radians(map(-90, 0, -90, 0, 90)));
    rotateY(radians(map(-90, 0, -90, 0, 90)));
    rect(x, y, videoScale, 700);
    popMatrix();


    pushMatrix();
    noFill();
    stroke(0, 255, 255);
    translate(0, 0, 0);
    rotateX(radians(map(90, 0, 90, 0, -90)));
    rotateY(radians(map(90, 0, 90, 0, -90)));
    rect(x1, y1, videoScale, 700);
    popMatrix();
    noStroke();
    noFill();
  }
}

