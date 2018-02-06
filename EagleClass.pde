import peasy.PeasyCam;
PeasyCam cam;
MyEagle Eagle;

void setup(){
  cam = new PeasyCam(this, 800);
  Eagle = new MyEagle();
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
  Eagle.body();
  Eagle.wing();  
}

class MyEagle {
PImage feather;
/*float bodyLength = 100;
float bodyHeight = 50;
float bodyDepth = 40;*/
float tipHeight = 40;
float wingDirection = 10;
float[][] body = {  {0, 0, 0},
                    {150, 0, 40},
                    {150, 0, -40},
                    {200, -50, 0},
                    {50, -50, 25},
                    {50, -50, -25}
                                    };
                                    
MyEagle(){
    feather = loadImage("feathers.jpg");
  }
  
  void body(){
     translate(0, tipHeight/10,0);
  for (int i = 0; i < 6; i++){
    for (int j = 0; j < 6; j++){
      for (int k = 0; k < 6; k++){
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
  /*
  beginShape();
    texture(feather);
    vertex(0, 0, bodyDepth/2, 0, 0);
    vertex(bodyLength, 0, 0, 1, 0);
    vertex(150, -bodyHeight, 0, 1, 1);
    vertex(bodyHeight, -bodyHeight, 0, 0, 1);
    vertex(0, 0, bodyDepth/2, 0, 0);
  endShape();
  beginShape();
    texture(feather);
    vertex(0, 0, bodyDepth/2, 0, 0);
    vertex(bodyLength, 0, bodyDepth, 1, 0);
    vertex(150, -bodyHeight, bodyDepth, 1, 1);
    vertex(bodyHeight, -bodyHeight, bodyDepth, 0, 1);
    vertex(0, 0, bodyDepth/2, 0, 0);
  endShape();
  beginShape();
    texture(feather);
    vertex(0, 0, 0, 0, 0);
    vertex(bodyLength, 0, 0, 1, 0);
    vertex(bodyLength, 0, bodyDepth, 1, 1);
    vertex(0, 0, bodyDepth, 0, 1);
    vertex(0, 0, 0, 0, 0);
  endShape();
  beginShape();
    texture(feather);
    vertex(bodyLength, 0, 0, 0, 0);
    vertex(bodyLength, 0, bodyDepth, 1, 0);
    vertex(150, -bodyHeight, bodyDepth, 1, 1);
    vertex(150, -bodyHeight, 0, 0, 1);
    vertex(bodyLength, 0, 0, 0, 0);
  endShape();
  beginShape();
    texture(feather);
    vertex(150, -bodyHeight, 0, 0, 0);
    vertex(150, -bodyHeight, bodyDepth, 1, 0);
    vertex(bodyHeight, -bodyHeight, bodyDepth, 1, 1);
    vertex(bodyHeight, -bodyHeight, 0, 0, 1);
    vertex(150, -bodyHeight, 0, 0, 0);
  endShape();
  beginShape();
    texture(feather);
    vertex(0, 0, 0, 0, 0);
    vertex(0, 0, bodyDepth, 1, 0);
    vertex(bodyHeight, -bodyHeight, bodyDepth, 1, 1);
    vertex(bodyHeight, -bodyHeight, 0, 0, 1);
    vertex(0, 0, 0, 0, 0);
  endShape();*/
 
  }
  
  void wing(){
     beginShape();
    texture(feather);
    vertex(40, -40, 0, 0, 0);
    vertex(120, -40, 0, 1, 0);
    vertex(120, -tipHeight, 250, 1, 1);
    vertex(80, -2*tipHeight/3, 150, 0, 1);
    vertex(40, -40, 0, 0, 0);
  endShape();
  beginShape();
    texture(feather);
    vertex(40, -40, 0, 0, 0);
    vertex(120, -40, 0, 1, 0);
    vertex(120, -tipHeight, -250, 1, 1);
    vertex(80, -2*tipHeight/3, -150, 0, 1);
    vertex(40, -40, 0, 0, 0);
  endShape();
  if ((tipHeight > 30) || (tipHeight < -120)){
    wingDirection = wingDirection*-1;
  }
  tipHeight += wingDirection; 
  }
}