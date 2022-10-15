int cx, cy;
float secondsRadius;
float minutesRadius;
float hoursRadius;
float clockDiameter;

int c = 10;

void setup() {
  surface.setSize(1200, 1200);
  //size(1200, 1200, P3D);
  //fullScreen(P3D);
  stroke(255);

  int radius = min(width, height) / 2;
  secondsRadius = radius * 0.72;
  minutesRadius = radius * 0.60;
  hoursRadius = radius * 0.50;
  clockDiameter = radius * 1.8;

  cx = width / 2;
  cy = height / 2;

  for (int i = 0; i<10; i++) {
    fill(#CAAA30);
    ellipse( random(cx), random(cy), 20, 20);
    //sphere(50);
  }
}

void draw() {
  //background(#CCAA34);
  background(#000000);
  fill(250);
  ellipse(random(width), random(height), random(5), random(5));
  stroke(250);
  line(random(width), random(height), random(width), random(height));
  // Draw the clock background
  fill(180, 0, 20);
  noStroke();
  //ellipse(cx, cy, clockDiameter, clockDiameter);

  // Angles for sin() and cos() start at 3 o'clock;
  // subtract HALF_PI to make them start at the top
  float s = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;
  float m = map(minute() + norm(second(), 0, 10), 0, 60, 0, TWO_PI) - HALF_PI; 
  float h = map(hour() + norm(minute(), 0, 1), 0, 24, 0, TWO_PI * 2) - HALF_PI;


  // Draw the hands of the clock
  //stroke(255);
  strokeWeight(2);
  //noStroke();

  //fill(c, c, c);
  //ellipse( random(cx + cos(s) * secondsRadius), random(cy + sin(s) * secondsRadius / 2), 50, 50);
  stroke(5);

  //translate(cx, cy);
  //fill(100, 45, 50);
  //box(10);



  for (int i = 0; i<360; i+=10) {
    //strokeWeight(i/10);
    line( cx, cy, cx + cos(s) * secondsRadius, cy + sin(s) * secondsRadius);
    line( cx, cy, cx + cos(s) * secondsRadius, cy + sin(s) * secondsRadius);
    line(cx, cy, sin(i) + cx, cos(i) + cy);
    rotateY(sin(i));

    //ellipse( cx + cos(s) * secondsRadius + 30 * 2, cy + sin(s) * secondsRadius * 2, 10, 10);
    noFill();

    noStroke();
    rect( random(width), random(height), 100, 100);

    rotateY(sin(i));
  }

  fill(120, 40, 40);
  //strokeWeight(0);
  //rect( random(cx + cos(m) * minutesRadius), random(cy + sin(m) * minutesRadius), 50, 50);

  fill(100, 100, 50);
  //ellipse( random(cx + cos(h) * hoursRadius), random(cy + sin(h) * hoursRadius), 50, 50);


  // Draw the minute ticks

  beginShape(POINTS);
  //stroke(20);
  for (int a = 0; a < 480; a+=1) {
    stroke( random(a,50), random(a,50), random(a,50));
    stroke(0, 0, 0);
    fill(a);
    strokeWeight(1);
    float angle = radians(a);
    float x = cx + cos(angle) * secondsRadius / 2;
    float y = cy + sin(angle) * secondsRadius / 2;
    vertex(x, y);
    translate(cx, cy);
    line(cx, cy, x, y);
    line(cx + 280, cy, x + 100, y);
    line(cx/2, cy/2, x/2, y/2);
    if (mousePressed) {
      rotateX(second() + sin(angle));

      rotateZ(second()/2);
      strokeWeight(0);
      noStroke();
      fill(255, 200, random(50), 0.1);
      ellipse(width/2, height/2, 20, 20);
      ellipse( width/2 - 100, height/2 + 100, 20, 20);
      ellipse( width/2 - 100, height/2 + 180, 10, 10);

      pushMatrix();
      translate(500, 800);
      ellipse(width/2, height/2, 50, 50);
      ellipse( width/2 - 100, height/2 + 100, 10, 10);
      ellipse( width/2 - 100, height/2 + 180, 20, 20);
      fill(10);
      //sphere(30);
      noFill();
      rotate(sin(mouseX*mouseY));

      popMatrix();

      strokeWeight(1.8);
    }
    //line(cx*2, cy+100, x/2, y/2);
    noStroke();
  }
  endShape();
  if (second()%5 == 0) {
    rotate(sin(width/2));
  }
}
