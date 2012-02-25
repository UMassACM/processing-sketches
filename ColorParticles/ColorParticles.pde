int numParticles = 3000;
Particle[] particles = new Particle[numParticles];

void setup() {
  size(1000, 800);
  stroke(255);
  smooth();
  
  for (int i=0; i< numParticles; i++) {
    particles[i] = new Particle(480.0+random(40),380.0+random(40),random(20)-10,random(20)-10);
  }
}

void draw() {
  background(0);
  
  ellipseMode(CENTER);
  
  noStroke();
  for (int i=0; i<numParticles; i++) {
    particles[i].accelerate(0.006*(mouseX-500),0.006*(mouseY-400));
    particles[i].move();
    if (particles[i].trans < 0 || particles[i].xPos < 0 || particles[i].yPos < 0 || particles[i].xPos > 1000 || particles[i].yPos > 800) {
      particles[i] = new Particle(500,400,random(20)-10,random(20)-10);
    }
    particles[i].draw();
  }
}

class Particle {
  float xPos, yPos;
  float xVel, yVel;
  float trans;
  color col;
  
  Particle(float xp, float yp, float xv, float yv) {
    xPos = xp;
    yPos = yp;
    xVel = xv;
    yVel = yv;
    trans = random(0.75);
    col = color(random(255),random(255),random(255));
  }
  
  void accelerate(float xAccel, float yAccel) {
    xVel += xAccel;
    yVel += yAccel;
  }
  
  void move() {
    xPos += xVel;
    yPos += yVel;
    trans -= 0.01;
  }
  
  void draw() {
    fill(col,255*trans);
    ellipse(xPos,yPos,10,10);
  }
}
