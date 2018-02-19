import peasy.PeasyCam;
PeasyCam cam;
MyEagle Eagle;

float tipHeight = 40;
float wingDirection = 15;

float xoff, yoff;
float flying;

float[][] cameraWobble;

void setup(){
  size(1440, 900, P3D); 
  frameRate(30);
  cam = new PeasyCam(this, 800);
  cameraWobble = new float[5][5];  
  Eagle = new MyEagle(); 
}

void draw(){
  //print(tipHeight);
  background(127);
  axes();
  stroke(0);
  strokeWeight(0);
  textureMode(NORMAL);      
  cameraWork();
  bodyPhysics();
  Eagle.body();
  Eagle.upperWings();  
  Eagle.lowerWings();
  Eagle.headPhysics();
  Eagle.head();
  Eagle.beak();
  Eagle.tail();

}

//Perlin noise used to generate fluid camera wobble. Could be used for rotation as well but I think the desired affect is acheived here. No use wasting processing power.
void cameraWork(){
  float yoff = 0;
  for (int y = 0; y < 5; y++){
    float xoff = flying;
    for (int x = 0; x < 5; x++){
      cameraWobble[x][y] = map(noise(xoff,yoff), 0, 1, -50, 50);
      print(cameraWobble[x][y]);
      cam.lookAt(cameraWobble[x][0], cameraWobble[0][y], 900D, 0D);
      xoff += .1; 
    }
    yoff+= .1;
  }
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
  PImage beak;
  
  float[][] body = {  {60, -35, 0},
                      {140, -20, 20},
                      {140, -20, -20},
                      {190, -50, 0},
                      {50, -50, 15},
                      {50, -50, -15},
                      {180, -20, 0},
                      {160, -55, 0},
                      {95, -20, 0}
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
                       {215, -48, 10},
                       {215, -48, -10},
                       {225, -36, 0}
                       
                                         };
                                         
  float[][] upperBeak = { 
                       {215, -48, 5},
                       {215, -48, -5},
                       {215, -44, 7},
                       {215, -44, -7},
                       {240, -40, 3},
                       {240, -40, -3},
                       {245, -45, 0}
                                         };      
                                         
  float[][] beakTip = { 
                       {240, -40, 3},
                       {240, -40, -3},
                       {245, -45, 0},
                       {245, -30, 0}
                                         };                                          
 
  float[][] lowerBeak = { 
                           {225, -38, 0},
                           {215, -48, -5},
                           {215, -48, 5},
                           {245, -38, 0}
                       
                                         }; 
                                         
  float[][] tail = { 
                           {60, -35, 0},
                           {70, -52, 15},
                           {70, -52, -15},
                           {10, -50, -40},
                           {10, -50, 40},
                           {0, -50, 0}
                                         }; 
                                         
  MyEagle(){
    feather = loadImage("feathers.jpg");
    whiteFeather = loadImage("whiteFeather.jpg");
    beak = loadImage("beak.jpg");
  }
    
  void body(){
    for (int i = 0; i < 9; i++){
      for (int j = 0; j < 9; j++){
        for (int k = 0; k < 9; k++){
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
      head[i][1] += wingDirection/20;
    }
    for (int i = 0; i < 7; i++){
      upperBeak[i][1] += wingDirection/20;
    }
    for (int i = 0; i < 4; i++){
      beakTip[i][1] += wingDirection/20;
      lowerBeak[i][1] += wingDirection/20;
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
    for (int i = 0; i < 7; i++){
      for (int j = 0; j < 7; j++){
        for (int k = 0; k < 7; k++){
          beginShape();
            texture(beak);
            vertex(upperBeak[i][0], upperBeak[i][1], upperBeak[i][2], 0, 0);
            vertex(upperBeak[j][0], upperBeak[j][1], upperBeak[j][2], 1, 0);
            vertex(upperBeak[k][0], upperBeak[k][1], upperBeak[k][2], 1, 1);
            vertex(upperBeak[i][0], upperBeak[i][1], upperBeak[i][2], 0, 1);
          endShape();
        }
      }
    }
    for (int i = 0; i < 4; i++){
      for (int j = 0; j < 4; j++){
        for (int k = 0; k < 4; k++){
          beginShape();
            texture(beak);
            vertex(beakTip[i][0], beakTip[i][1], beakTip[i][2], 0, 0);
            vertex(beakTip[j][0], beakTip[j][1], beakTip[j][2], 1, 0);
            vertex(beakTip[k][0], beakTip[k][1], beakTip[k][2], 1, 1);
            vertex(beakTip[i][0], beakTip[i][1], beakTip[i][2], 0, 1);
          endShape();
        }
      }
    }
    for (int i = 0; i < 4; i++){
      for (int j = 0; j < 4; j++){
        for (int k = 0; k < 4; k++){
          beginShape();
            texture(beak);
            vertex(lowerBeak[i][0], lowerBeak[i][1], lowerBeak[i][2], 0, 0);
            vertex(lowerBeak[j][0], lowerBeak[j][1], lowerBeak[j][2], 1, 0);
            vertex(lowerBeak[k][0], lowerBeak[k][1], lowerBeak[k][2], 1, 1);
            vertex(lowerBeak[i][0], lowerBeak[i][1], lowerBeak[i][2], 0, 1);
          endShape();
        }
      }
    }
  }
  void tail(){
    for (int i = 0; i < 6; i++){
      for (int j = 0; j < 6; j++){
        for (int k = 0; k < 6; k++){
          beginShape();
            texture(whiteFeather);
            vertex(tail[i][0], tail[i][1], tail[i][2], 0, 0);
            vertex(tail[j][0], tail[j][1], tail[j][2], 1, 0);
            vertex(tail[k][0], tail[k][1], tail[k][2], 1, 1);
            vertex(tail[i][0], tail[i][1], tail[i][2], 0, 1);
          endShape();
        }
      }
    }
  }
}
