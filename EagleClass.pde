import peasy.PeasyCam;
PeasyCam cam;
MyEagle Eagle;

float tipHeight = 40;
float wingDirection = 5;

void setup(){
  cam = new PeasyCam(this, 800);
  Eagle = new MyEagle();
  frameRate(60);
  size(1440, 900, P3D); 
}

void draw(){
  //print(tipHeight);
  background(127);
  axes();
  pushMatrix();
  translate(width/2, height/2);
  popMatrix();
  stroke(0);
  strokeWeight(0);
  textureMode(NORMAL); 
  bodyPhysics();
  Eagle.body();
  Eagle.upperWings();  
  Eagle.lowerWings();
  Eagle.headPhysics();
  Eagle.head();
  //Eagle.beak();
}

void axes(){
  strokeWeight(3);
  stroke(255, 0, 0);
  line(-100, 0, 0, 100, 0, 0);
  stroke(0, 255, 0);
  line(0, -100, 0, 0, 100, 0);
  stroke(0, 0, 255);
  line(0, 0, -100, 0, 0, 100);
}

void bodyPhysics(){
  if ((tipHeight >120) || (tipHeight < -60)){
    wingDirection = wingDirection*-1;
  }
  tipHeight += wingDirection;
  translate(0, -tipHeight/10,0);
}

class MyEagle {
  PImage feather;
  PImage whiteFeather;
  float[][] body = {  {0, -25, 0},
                      {140, -20, 25},
                      {140, -20, -25},
                      {190, -50, 0},
                      {50, -50, 20},
                      {50, -50, -20},
                      {180, -20, 0},
                      {95, 0, 0}
                                      };
                                      
  float[][] rUpperWing = {  {190, -50, 0},
                           {100, -45, 0},
                           {150, -35, 0},
                           {200, -45, 150},
                           {140, -50, 150},
                           {170, -35, 150}
                                           };
                                           
  float[][] lUpperWing = { {190, -50, 0},
                           {100, -45, 0},
                           {150, -35, 0},
                           {200, -45, -150},
                           {140, -50, -150},
                           {170, -35, -150}
                                             };  
                                           
  float[][] rLowerWing = { 
                           {200, -45, 150},
                           {140, -50, 150},
                           {170, -35, 150},
                           {140, -50, 250}
                                            };
                                            
  float[][] lLowerWing = { 
                           {200, -45, -150},
                           {140, -50, -150},
                           {170, -35, -150} ,
                           {140, -50, -250}
                                             }; 
                                             
  float[][] head = { 
                       {180, -20, 0},
                       {190, -50, 0},
                       {170, -35, 15},
                       {170, -35, -15},
                       {215, -50, 10},
                       {215, -50, -10},
                       {225, -38, 0}
                       
                                         };
                                         
  float[][] upperBeak = { 
                       {215, -48, 7},
                       {215, -48, -7},
                       {240, -44, 3},
                       {240, -44, -3},
                                         };                                          
 
  float[][] lowerBeak = { 
                       {180, -20, 0},
                       {190, -50, 0},
                       {170, -35, 15},
                       {170, -35, -15},
                       {215, -52, 10},
                       {215, -52, -10},
                       {220, -35, 0}
                       
                                         }; 
                                         
  float[][] beakTip = { 
                       {180, -20, 0},
                       {190, -50, 0},
                       {170, -35, 15},
                       {170, -35, -15},
                       {215, -52, 10},
                       {215, -52, -10},
                       {220, -35, 0}
                       
                                         };                                          
  MyEagle(){
    feather = loadImage("feathers.jpg");
    whiteFeather = loadImage("whiteFeather.jpg");
  }
    
  void body(){
    for (int i = 0; i < 8; i++){
      for (int j = 0; j < 8; j++){
        for (int k = 0; k < 8; k++){
          beginShape();
            texture(feather);
            vertex(body[i][0], body[i][1], body[i][2], 0, 0);
            vertex(body[j][0], body[j][1], body[j][2], 1, 0);
            vertex(body[k][0], body[k][1], body[k][2], 1, 1);
            vertex(body[i][0], body[i][1], body[i][2], 0, 1);
          endShape();
        }
      }
    }
  }
  
  void upperWings(){
    for (int i = 3; i < 6; i++){
      lUpperWing[i][1] += wingDirection;
      rUpperWing[i][1] += wingDirection;
    }
    for (int i = 0; i < 6; i++){
      for (int j = 0; j < 6; j++){
        for (int k = 0; k < 6; k++){
          beginShape();
            texture(feather);
            vertex(rUpperWing[i][0], rUpperWing[i][1], rUpperWing[i][2], 0, 0);
            vertex(rUpperWing[j][0], rUpperWing[j][1], rUpperWing[j][2], 1, 0);
            vertex(rUpperWing[k][0], rUpperWing[k][1], rUpperWing[k][2], 1, 1);
            vertex(rUpperWing[i][0], rUpperWing[i][1], rUpperWing[i][2], 0, 1);
          endShape();
        }
      }
    }
    for (int i = 0; i < 6; i++){
      for (int j = 0; j < 6; j++){
        for (int k = 0; k < 6; k++){
          beginShape();
            texture(feather);
            vertex(lUpperWing[i][0], lUpperWing[i][1], lUpperWing[i][2], 0, 0);
            vertex(lUpperWing[j][0], lUpperWing[j][1], lUpperWing[j][2], 1, 0);
            vertex(lUpperWing[k][0], lUpperWing[k][1], lUpperWing[k][2], 1, 1);
            vertex(lUpperWing[i][0], lUpperWing[i][1], lUpperWing[i][2], 0, 1);
          endShape();
        }
      }
    }
  }
  
  void lowerWings(){
    for (int i = 0; i <3 ; i++){
      lLowerWing[i][1] += wingDirection;
      rLowerWing[i][1] += wingDirection;
    }
      lLowerWing[3][1] += 2*wingDirection;
      rLowerWing[3][1] += 2*wingDirection; 
    for (int i = 0; i < 4; i++){
      for (int j = 0; j < 4; j++){
        for (int k = 0; k < 4; k++){
          beginShape();
            texture(feather);
            vertex(rLowerWing[i][0], rLowerWing[i][1], rLowerWing[i][2], 0, 0);
            vertex(rLowerWing[j][0], rLowerWing[j][1], rLowerWing[j][2], 1, 0);
            vertex(rLowerWing[k][0], rLowerWing[k][1], rLowerWing[k][2], 1, 1);
            vertex(rLowerWing[i][0], rLowerWing[i][1], rLowerWing[i][2], 0, 1);
          endShape();
        }
      }
    }
    for (int i = 0; i < 4; i++){
      for (int j = 0; j < 4; j++){
        for (int k = 0; k < 4; k++){
          beginShape();
            texture(feather);
            vertex(lLowerWing[i][0], lLowerWing[i][1], lLowerWing[i][2], 0, 0);
            vertex(lLowerWing[j][0], lLowerWing[j][1], lLowerWing[j][2], 1, 0);
            vertex(lLowerWing[k][0], lLowerWing[k][1], lLowerWing[k][2], 1, 1);
            vertex(lLowerWing[i][0], lLowerWing[i][1], lLowerWing[i][2], 0, 1);
          endShape();
        }
      }
    }
  }
  
  void headPhysics(){
    for (int i = 4; i < 7; i++){
      head[i][1] += wingDirection/25;
    }
  }
  
  void head(){
    for (int i = 0; i < 7; i++){
      for (int j = 0; j < 7; j++){
        for (int k = 0; k < 7; k++){
          beginShape();
            texture(whiteFeather);
            vertex(head[i][0], head[i][1], head[i][2], 0, 0);
            vertex(head[j][0], head[j][1], head[j][2], 1, 0);
            vertex(head[k][0], head[k][1], head[k][2], 1, 1);
            vertex(head[i][0], head[i][1], head[i][2], 0, 1);
          endShape();
        }
      }
    }
  }
  
  void beak(){
    for (int i = 0; i < 4; i++){
      for (int j = 0; j < 4; j++){
        for (int k = 0; k < 4; k++){
          fill(255, 255, 0);
          beginShape();
            texture(whiteFeather);
            vertex(upperBeak[i][0], upperBeak[i][1], upperBeak[i][2], 0, 0);
            vertex(upperBeak[j][0], upperBeak[j][1], upperBeak[j][2], 1, 0);
            vertex(upperBeak[k][0], upperBeak[k][1], upperBeak[k][2], 1, 1);
            vertex(upperBeak[i][0], upperBeak[i][1], upperBeak[i][2], 0, 1);
          endShape();
        }
      }
    }
  }  
}
