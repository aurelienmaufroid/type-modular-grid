//Light value per pixel variables
float lumiere = 0;

//Typeface variables
int n = 0, maxDistance;
int size = 200;

//PGraphics object variables
PGraphics g;
String txt = "hotdogs";
PFont f;
String[] s;

//Patterns variables
PImage pattern, pattern2;
float mouseXposition = 10;
float patternPos = 1+mouseXposition;

PShape patternShape; //specifical variable for svg file

//Loup pointer effect variables
int distancePointer = 500;
int nbAlt, nbTab = 0, nbEnter = 0;
float diameter;

//Variable file selection
String patternselection;

//Single storage file name variables
int sec = second();
int min = minute();
int hour = hour();
int randomName;


void setup(){
  selectInput("Select a png or jpg file to process:", "fileSelected");
  //fullScreen();
  size(1080, 1080);
  frameRate(30); //FPS 
  background(255);
  noStroke();
  
  maxDistance = 100;
  
  g = createGraphics(width, height);
  f = createFont("Arial", size);
  
  pattern = loadImage("circleblur.png");
  pattern2 = loadImage("circle.png");
  
  patternShape = loadShape("D_01.svg");
  
  
}


void draw(){
  background(255);
  
  g.beginDraw();
  g.fill(0);
  g.background(255);
  g.textFont(f);
  g.textSize(1+mouseY);
  g.textAlign(CENTER, CENTER);
  g.text(txt, width/2, height/2);
  g.endDraw();
  
  //Double-loop
  //the resolution of the final image: x+=10 and y+=10 the higher it is the less precise it is
  for(int x=0 ; x < g.width ; x+=10){

    for(int y=0 ; y < g.height ; y+=10){
      //Recovery of the pixel color information
      color couleurLocale = g.get(x,y);
        
      //Recovery of red, green and blue values
      float r1 = red(couleurLocale); //value between 0 and 255
      float v1 = green(couleurLocale); //value between 0 and 255
      float b1 = blue(couleurLocale); //value between 0 and 255
        
      //Calculation of the amount of white on this pixel
      lumiere = r1 + v1 + b1; //results between 0 and 765       
        
      diameter = dist(mouseX, mouseY, x, y);
      diameter = diameter / distancePointer * 100;
      mouseXposition = map(mouseX, 0, width, 0, 50);
        
      if(nbTab == 1){
        patternPos = diameter;
      } else {
        patternPos = 1+mouseXposition;
      }
        
      if(lumiere <= 150){ //150
                   
         image(pattern, x, y, patternPos, patternPos);
         //patternShape.disableStyle();
         fill(9, 12, 155);
         //shape(patternShape, x, y, patternPos, patternPos);
          
      }else {
        fill(255);//light 255, 255, 0
      }
    }
  }//end for loop 2
    
  if (nbEnter == 1){
    saveFrame("output"+ hour+min+sec+randomName +"/image####.png");
  }//end for loop 1
  
 //print(nbTab + " ");
    
}//end draw

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    //println("User selected " + selection.getAbsolutePath());
    pattern = loadImage(selection.getAbsolutePath());
  }
}

void keyPressed(){  
  if (keyCode == BACKSPACE) {
    if (txt.length() > 0) {
      txt = txt.substring(0, txt.length()-1);
    }
  } else if (keyCode == DELETE) {
    txt = "";
  } else if (keyCode != ENTER && key != '-' && keyCode != ALT && keyCode != RIGHT && keyCode != LEFT) {
    fill(255);
    txt = txt + key;
  }
  
  if (key == '-') {
    int secfile = second();
    int minfile = minute();
    int rfile = int(random(200));
    saveFrame("sreenshots/" + txt + "_" + minfile+secfile+rfile +".png");
  }
  
  if(keyCode == ALT){
    nbAlt = 1;
    print("Alt activée ");
  }  
}

void keyReleased(){
  if(keyCode == ALT){
    nbAlt = 0;
    print("Alt relachée ");
  }
  
  if(keyCode == TAB){
    if (nbTab == 0){
      print("Effect enabled ");
      nbTab = 1;
    } else {
      print("effect disabled ");
      nbTab = 0;
    }
    
  }
  
  if(keyCode == ENTER){
    if (nbEnter == 0){
      randomName = int(random(200));
      print("record enabled ");
      nbEnter = 1;
    } else {
      print("record disabled ");
      nbEnter = 0;
    }
    
  }
  
}

void mouseDragged(){
  if (nbAlt == 1){
    if(distancePointer >= 0){
      distancePointer -= 5;
    }else{
      distancePointer = 0;
    }
    
    //print(distancePointer + " ");
  }else{
    if(distancePointer >= 0){
      distancePointer += 5;
    }else{
      distancePointer = 0;
    }
  }
  
}
