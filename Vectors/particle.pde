class Particle {

  PVector pos;
  PVector vel;
  PVector acc;
  float maxspeed;

  Particle() {
    this.pos = new PVector(random(width), random(height));
    this.vel = PVector.random2D();
    this.acc = new PVector(0, 0);
    this.maxspeed = 4;
  }

  void update() {
    vel.add(this.acc);
    vel.limit(maxspeed);
    pos.add(this.vel);
    acc.mult(0);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void show() {
    stroke(0, 5);
    strokeWeight(1);
    point(this.pos.x, this.pos.y);
  }

  void follow(PVector arr[]) {
    int x = floor(this.pos.x / scl);
    int y = floor(this.pos.y / scl);
    int index = x + y * cols;
    if (index > 1599) index = 1599;
    PVector force = arr[index];
    if (force != null) applyForce(force);
  }

  void edges() {
    if (this.pos.x > width) this.pos.x = 0;
    if (this.pos.x < 0) this.pos.x = width;
    if (this.pos.y > height) this.pos.y = 0;
    if (this.pos.y < 0) this.pos.y = height;
  }
}
