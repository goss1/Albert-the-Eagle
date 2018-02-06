PImage img;

int cols, rows;
int scl = 10;
int w = 1200;
int h = 1000;

float flying = 0;
float starX, starY;

float[][] starField;
float[][] terrain;

void setup(){
  frameRate(30);
  size(600, 600, P3D);
  cols = w/scl;
  rows = h/scl;
  terrain = new float[cols][rows];
  starField = new float[50][2];
  for (int star = 0; star< 50; star++){
    starX = random(1300);
    starY = random(600);
    starField[star][0]=starX;
    starField[star][1]=starY;
  }
  img = loadImage("moon.jpg");
  background(img);
}

void draw(){
  background(img);

  for (int star = 0; star< 50; star++){
    translate(starField[star][0]-350,starField[star][1]-400, -600);
    fill(255);
    stroke(255);
    sphere(random(2,3));
    translate(-starField[star][0]+350,-starField[star][1]+400, 600);
  }
  ambientLight(90, 85, 40);
  directionalLight(150, 150, 150, -1, 1, -.2);
  translate(0,100,-590);
  rotateX(PI/3);
  fill(20,40,100);
  stroke(20, 40, 100);
  ellipse(300, 135, 1200, 80);
  rotateX(-PI/3);
  translate(0,-100,590);
  flying += .02;
  float yoff = 0;
    for (int y = 0; y < rows; y++){
      float xoff = flying;
      for (int x = 0; x < cols; x++){
        terrain[x][y] = map(noise(xoff,yoff), 0, 1, -20, 20);//use frame count to change terrain over time
        xoff += .025;  
      }
      yoff+= .025;
    }
    strokeWeight(0);
    translate(width/2, height/2);
    rotateX(PI/2.4);
    fill(20, 40, 100);
    box(1200, 1000, 1);
    fill(255);
    translate(-w/2, -h/2);
  for (int y = 0; y < rows-1; y++){
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++){
      if(terrain[x][y]<5){
        fill(50);
      }
      else{
        fill(45, 60, 30);
      }
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }
}