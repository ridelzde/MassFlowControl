import processing.serial.*;
import controlP5.*;  

ControlP5 cp5;

int prutok = 0;
int lastprutok;
boolean dalkove = false;
Serial myPort;
int myColor = color(0,0,0);

void setup(){
  smooth();
  size(400,200);
  println(Serial.list());
  
  myPort = new Serial(this, Serial.list()[0],9600);
  myPort.bufferUntil('\n');

  cp5 = new ControlP5(this);
  
  cp5.addSlider("flow")
     .setPosition(100,175)
     .setRange(0,100)
     .setSize(200,20)    
     .setNumberOfTickMarks(101)
     //.setSliderMode(Slider.FLEXIBLE)
     ;
     
  PFont font;
  font = loadFont("TrebuchetMS-Bold-48.vlw");
  textFont(font, 44);
  background(0);
}

void draw(){
  smooth();
  noStroke();
}

void serialEvent(Serial myPort){
  String inString = myPort.readStringUntil('\n');
  if (inString != null) {
    inString = trim(inString);
    char firstChar = inString.charAt(0); //separuje prvni pismeno

    if (firstChar == 'd'){ //pokud je rizeno dalkove, prvni pismeno bude d
      prutok = int(inString.substring(1));
      background(50);
      textSize(12);
      text("DÁLKOVĚ", 10, 20);
      cp5.getController("flow").setLock(false);
      textSize(44);
      text(prutok, 155, 100);
      text("slm", 220, 100);
      println(prutok);println("");
      dalkove = true;
      //cp5.getController("flow").setVisible(true);
        
  }else{       //lokalne
      prutok = int(inString);
      background(0);
      text(prutok, 155, 100);
      text("slm", 220, 100);
      cp5.getController("flow").lock();
      cp5.getController("flow").setValue(prutok);
  }
  
  }
}

void flow(float flowValue) {
  if (dalkove){
  myPort.write(int(flowValue));
  }
}

