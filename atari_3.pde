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
float sensitivity = 5;
float[][] audio;

float flying = 0;

int scl = 50;

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
  //static
  fill(0);
  ellipse(random(width), random(height), random(10), random(10));

  float audioIn = abs((in.mix.get(0)) +
    (in.mix.get(1)) +
    (in.mix.get(2)) / 3)
    * sensitivity;


  noFill();
  strokeWeight(.8 + audioIn);
  stroke(audioIn * 10, audioIn, audioIn);

  flying -= 0.015;

  float yoffset = (flying - (audioIn/1000));
  for ( int y = 0; y < row; y++) {
    float xoffset = 0;
    for ( int x = 0; x < col; x++) {
      audio[x][y] = map(noise(xoffset, yoffset), 0, 1, -400, 405);

      xoffset += .0022;
    }
    yoffset += .0202;
  }

  for (int y = 0; y < row; y++) {
    beginShape(TRIANGLE_FAN);
    for (int x = 0; x < col; x++) {
      vertex(x*scl, y*scl);
      vertex(x*scl, (y+1)*scl);
      if (mousePressed) {
        rotateZ(PI/2 + (mouseX/mouseY));
        /*
        ellipse(width/2, height/2, 100, 100);
        ellipse(width/2 - 100, height/2, 100, 100);
        ellipse(width/2 + width/6, height/2, 100, 100);
        ellipse(width/2 + width/6 - 100, height/2, 100, 100);
        ellipse(width/2 - width/6, height/2, 100, 100);
        ellipse(width/2 - width/6 - 100, height/2, 100, 100);
        ellipse(width/2 - width/3, height/2, 100, 100);
        ellipse(width/2 - width/3 - 100, height/2, 100, 100);
        ellipse(width/2 + width/3, height/2, 100, 100);
        ellipse(width/2 - 100, height/2, 100, 100);
        textSize(200);
        text("* * ** * *", width/2, height/2);
        */
        if(key == '1'){
         rotateY(mouseX); 
        }
      }


      //vertex(x*scl, y*scl, audio[x][y] += audioIn);
      //vertex(x*scl, (y+1)*scl, audio[x][y+1] += audioIn);
    }
    endShape();
  }



  if (recording) {
    saveFrame("amnesiac2/atari_####.png");
  }
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    recording = !recording;
  }
}
