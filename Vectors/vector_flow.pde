float inc = 0.1;
int scl = 10;
int cols, rows;
float zoff = 0;
Particle[] particles;
PVector[] flowfield;

void setup() {
  size(800, 800);
  pixelDensity(1);
  int sizea = 1000;

  cols = width / scl;
  rows = height / scl;
  particles = new Particle[sizea];
  flowfield = new PVector[cols * rows];

  for (int i = 0; i < sizea; i++) {
    particles[i] = new Particle();
  }
  background(255);
}

void draw() {

  for (int i = 0; i < particles.length; i++) {
    particles[i].follow(flowfield);
    particles[i].update();
    particles[i].show();
    particles[i].edges();
  }

  float yoff = 0;
  for (int x = 0; x < cols; x++) {
    float xoff = 0;
    for (int y = 0; y < rows; y++) {
      int index = x + y * cols;
      float angle = noise(xoff, yoff, zoff) * TWO_PI * 4;
      PVector v = PVector.fromAngle(angle);
      v.setMag(1);
      flowfield[index] = v;
      xoff += inc;
      //stroke(0, 50);
      //strokeWeight(1);
      //push();
      //translate(x*scl, y*scl);
      //rotate(v.heading());
      //line(0, 0, scl, 0);
      //pop();
    }
    yoff += inc;

    zoff += 0.0003;
  }
}
