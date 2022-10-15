//ATARI 2
//WRITTEN BY
//SHIRISH SARKAR

import ddf.minim.*;
import java.util.Random;

boolean recording = false;

Minim minim;
AudioInput in;
Random generator = new Random();

int col, row;
int w = 2000;
int h = 1600;
float sensitivity = 120;
float[][] audio;

int scl = 6;

//Gaussian

float[] distribution = new float [360];

void setup() {
  size(1600, 1200, P3D);

  minim = new Minim(this);
  in = minim.getLineIn(minim.STEREO, 144);

  col = w/scl;
  row = h/scl;

  audio = new float[col][row];
  //casting gaussian distribution into array
  for (int i = 0; i < distribution.length; i++) {
    distribution[i] = (int) generator.nextGaussian() * 25;
  }
}

void draw() {
  background(#FFFFFF);

 float audioIn = abs((in.mix.get(0)) +
    (in.mix.get(1)) +
    (in.mix.get(2)) / 3)
    * sensitivity;

  fill(0);
  stroke(0);
  strokeWeight(1 * audioIn);
  //line(random(width), random(height), random(width), random(height));
  
  //static
  noFill();
  //ellipse(random(width), random(height), random(20), random(20));
  //noFill();
  //noStroke();

 
  //fill(#ABCDEF);
  fill(#FFFFFF);
  strokeWeight(25 + audioIn);
  //rotate(.01 / audioIn);
  
  line( width/2, height/2, width/2, height/2);
  line( width/6, height/2, width/2, height/2);
  line( width/2 + width/3, height/2, width/2, height/2);
  line( width/2, height/3, width/2, height/2);
  line( width/2, height/4, width/2, height/2);
  line( width/2, height/8, width/2, height/2);
  line( width/2, height/2 + height/8, width/2, height/2);
  

  if (audioIn > 5) {
    textSize(150 + audioIn);
    stroke(255);
    fill(0);
    //text("ATTENTION UNITS", width/2, height/2); 
    //text("NO NO NO NO NO", width/6, height/2 + height/6);
    
    //text("PROSECUTION CODE 00-3234//3F42EE", width/2, height/2);
    //text("ALERT!", width/2, height/4);
    //text("EVIDENCE OF DISTURBING ACTIVITY", random(width/2), height/2 + 100);
    //text("DATA MALIGNANT", random(width/6), height/2 + 250);
    //text("YOU WILL BE PROSECUTED", width/4, height/2 + 120);
    //text("UNIDENTIFIED DISTURBANCE", width/2, height/2 + height/4);
    //text("YOU MUST STAY IN LINE", width/2, height/2 + height/6);
    text("DATA", random(width/2), random(height/2));
    //ellipse(width/2, height/2, 500, 500);
    translate(0, audioIn);
  }
  if(audioIn == 3) {
    text("DATA IS.....", width/2, height/2);
    
  }

  if (mousePressed) {
    rotateZ(mouseX / mouseY);
    //text("THAT IS ENOUGH", width/2, height/2);
  }

  noFill();
  strokeWeight(.09);
  stroke(audioIn * 10);

  for (int y = 0; y < row; y++) {
    beginShape(TRIANGLE_FAN);
    for (int x = 0; x < col; x++) {
      vertex(x*scl, y*scl);
      vertex(x*scl, (y+1.2)*scl);


      //vertex(x*scl, y*scl, audio[x][y] += audioIn);
      //vertex(x*scl, (y+1)*scl, audio[x][y+1] += audioIn);
    }
    endShape();
  }
  
  if(recording) {
   saveFrame("dataIS/atari_####.png");
  }
  
}

void keyPressed() {
 if (key == 'r' || key == 'R') {
  recording = !recording; 
 }
}
