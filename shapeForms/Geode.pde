class Geode {

  PShape mesh;

  float radiusMax, radius, pRadius;

  int totalVertex, totalSegments;

  float[][] currCircle, prevCircle;

  color vertexColor;
  color[] currColor, prevColor;

  float x, y, z;
  PVector norm;
  float percent;
  float angle, angleOuter;

  float noiseAmp, noiseAvg, noiseMin, noiseMax;

  color strokeColor;
  color fillColorLower;
  color fillColorUpper;

  Geode(float _radiusMax, int _totalVertex, int _totalSegments, float _noiseAmp, color _strokeColor, color _fillColorLower, color _fillColorUpper ) {
    radiusMax = _radiusMax;
    totalVertex = _totalVertex;
    totalSegments = _totalSegments;
    noiseAmp = _noiseAmp;
    strokeColor = _strokeColor;
    fillColorLower = _fillColorLower;
    fillColorUpper = _fillColorUpper;

    generateMesh();
  }

  void generateMesh() {
    currCircle = new float[totalVertex][3];
    prevCircle = new float[totalVertex][3];

    currColor = new color[totalVertex];
    prevColor = new color[totalVertex];

    mesh = createShape();
    mesh.colorMode(HSB);
    mesh.beginShape(TRIANGLE_STRIP);
    mesh.specular(77);
    //mesh.ambient(255, 255, 255);
    mesh.shininess(100);
    mesh.stroke(strokeColor);

    noiseAvg = ((1.0/totalSegments)+(1.0/totalVertex))*noiseAmp;
    noiseMin = 1.0-noiseAvg;
    noiseMax = 1.0+noiseAvg; 

    radius = radiusMax;
    for (float j=0; j<totalSegments; j++) {
      float percentOuter = j/(totalSegments-1);
      pRadius = radius;
      radius = sin(PI*percentOuter)*radiusMax;

      angleOuter = percentOuter*PI;
      prevCircle = currCircle;
      prevColor = currColor;


      for (int i=0; i<totalVertex; i++) {
        percent = float(i)/(totalVertex-1);
        angle = TWO_PI*percent;

        float _noise = random(noiseMin, noiseMax);
        float _radius = radius*_noise;
        vertexColor = calculateFill(_noise);

        if (j>0) {
          x = prevCircle[i][0];
          y = prevCircle[i][1];
          z = prevCircle[i][2];
          mesh.fill(prevColor[i]);

          norm = new PVector(x, y, z);
          norm.normalize();
          mesh.normal(norm.x, norm.y, norm.z);
          //mesh.normal(cos(angle), 0, sin(angle));
          mesh.vertex(x, y, z);
        }

        if (i==totalVertex-1) {
          x = currCircle[0][0];
          y = currCircle[0][1];
          z = currCircle[0][2];
          vertexColor = currColor[0];
        } else {
          x = cos(angle)*_radius;
          y = sin(angle)*_radius;
          if (j==totalSegments-1 || j==0) z = (cos(angleOuter)*radiusMax)*(noiseMin+noiseAvg);
          else z = cos(angleOuter)*radiusMax*_noise;
        }


        norm = new PVector(x, y, z);
        norm.normalize();
        mesh.normal(norm.x, norm.y, norm.z);
        //mesh.normal(cos(angle), 0, sin(angle));
        mesh.fill(vertexColor);
        mesh.vertex(x, y, z);

        currCircle[i][0] = x;
        currCircle[i][1] = y;
        currCircle[i][2] = z;

        currColor[i] = vertexColor;
      }
    }
    mesh.endShape(CLOSE);
  }

  color calculateFill(float _noise) {

    float _hue = map(_noise, noiseMin, noiseMax, hue(fillColorLower), hue(fillColorUpper));
    float _sat = map(_noise, noiseMin, noiseMax, saturation(fillColorLower), saturation(fillColorUpper));
    float _bright = map(_noise, noiseMin, noiseMax, brightness(fillColorLower), brightness(fillColorUpper));
    float _alpha = map(_noise, noiseMin, noiseMax, alpha(fillColorLower), alpha(fillColorUpper)); 

    color _fill = color(_hue, _sat, _bright, _alpha);
    println(_fill );
    return _fill;

    // return fillColor;
  }
} 
