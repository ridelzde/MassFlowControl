import processing.serial.*;
import g4p_controls.*; 

GKnob kb;

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

  kb = new GKnob(this, 35, 100, 80 , 80, 0.7);
  kb.setTurnRange(90, 35);
  kb.setTurnMode(G4P.CTRL_HORIZONTAL);
  kb.setValue(0);
  kb.setLocalColorScheme(6);
  kb.setNbrTicks(10); 
  kb.setShowTicks(true); 
  kb.setShowTrack(true);
  kb.setShowTicks(true); 
  kb.setShowTrack(true); 
  kb.setShowArcOnly(false); 
  kb.setStickToTicks(false); 
  kb.setIncludeOverBezel(true); 
  kb.setOverArcOnly(false); 
  kb.setSensitivity(1.45); 
  kb.setEasing(12.78125); 
  kb.setLimits(0, 100);
     
  frameRate(15);
  //noLoop();
  
  PFont font;
  font = loadFont("TrebuchetMS-Bold-48.vlw");
  textFont(font, 44);
  background(0);
}

void draw(){
  ;
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
      //cp5.getController("flow").setLock(false);
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
      //cp5.getController("flow").lock();
      kb.setValue(prutok);
  }
  //redraw();
  }
}

public void handleKnobEvents(GValueControl knob, GEvent event) { 
  if (dalkove) {
    myPort.write(knob.getValueI());
    //redraw();
  }
  
  
}

