import peasy.PeasyCam;
PeasyCam cam;

int cols, rows;
int scl = 15;
int w = 3650;
int h = 1600;

float xoff, yoff;

float flying;
float starX, starY;

float[][] starField;
float[][] terrain;
float[][] cameraWobble;

void setup(){
  size(1440, 900, P3D);
  frameRate(30);
  cam = new PeasyCam(this, 800);
  cols = w/scl;
  rows = h/scl;
  terrain = new float[cols][rows];
  starField = new float[100][2];
  cameraWobble = new float[5][5];
  for (int star = 0; star< 50; star++){
    starX = random(-2400, 2400);
    starY = -random(3000);
    starField[star][0]=starX;
    starField[star][1]=starY;
  }
}

void draw(){
  cameraWork();
  background(0);
  axes();
  stars();
  light();
  generateTerrain();
  renderTerrain();

}

void axes(){
  strokeWeight(3);
  stroke(255, 0, 0);
  line(-1000, 0, 0, 1000, 0, 0);
  stroke(0, 255, 0);
  line(0, -1000, 0, 0, 1000, 0);
  stroke(0, 0, 255);
  line(0, 0, -1000, 0, 0, 1000);
}

void stars(){
  for (int star = 0; star< 50; star++){
    pushMatrix();
    translate(starField[star][0],starField[star][1], -1500);
    fill(255);
    stroke(255);
    sphere(random(2,3));
    popMatrix();
  }
}

void light(){
  //ambientLight(90, 85, 40);
  directionalLight(255, 255, 255, -1, 1, -.2);
}

void generateTerrain(){
  flying += .02;
  float yoff = 0;
  for (int y = 0; y < rows; y++){
    float xoff = flying;
    for (int x = 0; x < cols; x++){
      terrain[x][y] = map(noise(xoff,yoff), 0, 1, -120, 120);//use frame count to change terrain over time
      xoff += .025;  
    }
    yoff+= .025;
  }
}
  
void renderTerrain(){
  pushMatrix();
  translate(0, 150, -300);
  rotateX(PI/2.3);
  strokeWeight(0);
  fill(20, 40, 100);
  box(3600, 1500, 1);
  ellipse(0, -750, 3650, 400);
  fill(200);
  for (int y = 0; y < rows-1; y++){
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++){
      fill(255);
      vertex(x*scl-cols*scl/2, y*scl-rows*scl/2, terrain[x][y]);
      vertex(x*scl-cols*scl/2, (y+1)*scl-rows*scl/2, terrain[x][y+1]);
    }
    endShape();
  }  
  popMatrix();
}

//Perlin noise used to generate fluid camera wobble. Could be used for rotation as well but I think the desired affect is acheived here. No use wasting processing power.
void cameraWork(){
  float yoff = 0;
  for (int y = 0; y < 5; y++){
    float xoff = flying;
    for (int x = 0; x < 5; x++){
      cameraWobble[x][y] = map(noise(xoff,yoff), 0, 1, -50, 50);
      cam.lookAt(cameraWobble[x][0], cameraWobble[0][y], 900D, 0D);
      xoff += .1;  
    }
    yoff+= .1;
  }
}
