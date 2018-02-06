import peasy.PeasyCam;
PeasyCam cam;
MyDrone Drone;

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
  Drone.prop();
}

class MyDrone {

PImage fiber;
PImage metalstrut;
PImage metal;
float[][] dronebody = { {0, 0, 0},
                        {0, 50, 0},
                        {200, 50, 0},
                        {200, 0, 0},
                        {200, 0, 200},
                        {200, 50, 200},
                        {0, 50, 200},
                        {0, 0, 200}                      
};
float[][] strut = {  {0, 18.75, 0},
                     {0, 30.75, 0},
                     {25, 30.75, 0},
                     {25, 18.75, 0},
                     {25, 18.75, -150},
                     {25, 30.75, -150},
                     {0, 30.75, -150},
                     {0, 18.75, -150}
};
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
float rY = PI;

MyDrone(){
  fiber = loadImage("fiber.jpg");
  metalstrut = loadImage("metal.jpg");
  metal = loadImage("fiber2.jpg");
}

void body(){
   for ( int i = 0; i < 8; i++){
    for ( int j = 0; j < 8; j++){
      for ( int k = 0; k < 8; k++){
        beginShape();
        texture(metal); //i dunno how to put texture on box() so i had to keep as beginShape
          vertex(dronebody[i][0], dronebody[i][1], dronebody[i][2], 0, 0);
          vertex(dronebody[j][0], dronebody[j][1], dronebody[j][2], 1, 0);
          vertex(dronebody[k][0], dronebody[k][1], dronebody[k][2], 1, 1);
        endShape();
      }
    }
  }
  translate(0, 0, 18);
  rotateY(PI/4);
  for ( int l = 0; l < 4; l++){
    rotateY(-PI/4);
    translate(182, 0, -18);
    rotateY(-PI/4);
    for ( int i = 0; i < 8; i++){
      for ( int j = 0; j < 8; j++){
        for ( int k = 0; k < 8; k++){
          beginShape();
          texture(metalstrut);
            vertex(strut[i][0], strut[i][1], strut[i][2], 0, 0);
            vertex(strut[j][0], strut[j][1], strut[j][2], 1, 0);
            vertex(strut[k][0], strut[k][1], strut[k][2], 1, 1);
          endShape();         
        }
      }
    }
  }
  translate(0, 0, 0);
  for ( int m = 0; m < 4; m++){
    translate(140, 0, 115);
    rotateY(-PI/2);
     for ( int i = 0; i < 5; i++){
       for ( int j = 0; j < 5; j++){
         for ( int k = 0; k < 5; k++){
          beginShape();
          texture(fiber);
            vertex(landstrut[i][0], landstrut[i][1], landstrut[i][2], 0, 0);
            vertex(landstrut[j][0], landstrut[j][1], landstrut[j][2], 1, 0);
            vertex(landstrut[k][0], landstrut[k][1], landstrut[k][2], 1, 1);
          endShape();
        }
      }
    }
  } 
}

void prop(){
  for ( int l = 0; l < 4; l++){
    rotateY(-PI/4);
    translate(182, 0, -18);
    rotateY(-PI/4);
      for ( int i = 0; i < 5; i++){
        for ( int j = 0; j < 5; j++){
          for ( int k = 0; k < 5; k++){
            pushMatrix(); //this push and pop allows me to make the props spin around the axis defined by the next translate
            translate(12.5, 0, -150);
            rY += 0.00025;
            rotateY(-rY); 
              for ( int n = 0; n < 2; n++){
                rotateY(PI);
                 beginShape();
                   texture(fiber);
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
}