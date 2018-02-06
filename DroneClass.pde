import peasy.PeasyCam;
PeasyCam cam;
MyDrone Drone;

float proprate = 0.00025;
float propdirection = 0.00005;
void setup(){
  cam = new PeasyCam(this, 800);
  Drone = new MyDrone();
  frameRate(30);
  size(1280, 800, P3D);
}

void draw(){
  background(0, 255, 0);
  pushMatrix();
  translate(width/2, height/2);
  popMatrix();
  stroke(0);
  strokeWeight(1);
  textureMode(NORMAL); 
  Drone.body();
  Drone.strut(propaccel());
  Drone.legs();
}

class MyDrone {
  
PImage fiber;
PImage metal;
PImage blackfiber;
PImage metalstrut;
PShape body;
PShape strut;

float[][] prop = { {6.25, 0, 0},
                   {6.25, 12.5, 0},
                   {18.75, 12.5, 0},
                   {18.75, 0, 0},
                   {9.375, 9.375, -75},
};
float[][] landstrut = { {6.25, 50, 6.25},
                        {18.75, 50, 6.25},
                        {18.75, 50, 18.75},
                        {6.25, 50, 18.75},
                        {12, 200, -37.5}
};
float rY;

MyDrone(){
  //rY = proprate;
  body = createShape(BOX, 200, 50, 200);
  strut = createShape(BOX, 25, 12, -150);
  fiber = loadImage("fiber2.jpg");
  metal = loadImage("metal.jpg");
  blackfiber = loadImage("fiber.jpg");
  body.setTexture(fiber);
  strut.setTexture(metal);
}

void body(){
shape(body); 
}

void strut(float accel){
  translate(145, 0, 145);
  rotateY(PI/4);
  for ( int l = 0; l < 4; l++){
    shape(strut);
    rotateY(-PI/2);
    translate(-205, 0, 205);
     for ( int i = 0; i < 5; i++){
      for ( int j = 0; j < 5; j++){
        for ( int k = 0; k < 5; k++){
          pushMatrix(); //this push and pop allows me to make the props spin around the axis defined by the next translate
            translate(275, -25, -210);
            rY += accel;
            rotateY(-rY); 
              for ( int n = 0; n < 2; n++){
                rotateY(PI);
                 beginShape();
                   texture(blackfiber);
                   vertex(prop[i][0], prop[i][1], prop[i][2], 0, 0);
                   vertex(prop[j][0], prop[j][1], prop[j][2], 1, 0);
                   vertex(prop[k][0], prop[k][1], prop[k][2], 1, 1);
                  endShape();
               }
          popMatrix();  
         }
       }  
     } 
   }
}

void legs(){
  translate(-15, -25, -330);
  for ( int m = 0; m < 4; m++){
    translate(140, 0, 115);
    rotateY(-PI/2);
     for ( int i = 0; i < 5; i++){
       for ( int j = 0; j < 5; j++){
         for ( int k = 0; k < 5; k++){
          beginShape();
          texture(blackfiber);
            vertex(landstrut[i][0], landstrut[i][1], landstrut[i][2], 0, 0);
            vertex(landstrut[j][0], landstrut[j][1], landstrut[j][2], 1, 0);
            vertex(landstrut[k][0], landstrut[k][1], landstrut[k][2], 1, 1);
          endShape();
          }
        }
      }
    } 
  }  
}

  float propaccel(){
    if((proprate > 0.0075) || (proprate < -0.0075)){
      propdirection = propdirection*-1;
    }
    proprate += propdirection;
    return proprate;
  }
