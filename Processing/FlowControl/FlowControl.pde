import processing.serial.*;
import controlP5.*;  

ControlP5 cp5;

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
Textlabel myTextlabelA;
Textlabel myTextlabelB;


int prevValue = 1000;
=======
>>>>>>> parent of dd00997... Vyreseni problemu s padanim programu.
=======
int prevValue;
>>>>>>> parent of b370816... Zmena GUI
=======
>>>>>>> parent of dd00997... Vyreseni problemu s padanim programu.
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
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
   background(bg);
   
   myTextlabelA = cp5.addTextlabel("litry")
                    //.setText("A single ControlP5 textlabel, in yellow.")
                    .setPosition(100,50)
                    .setColorValue(0xffffff00)
                    .setFont(font)
                    ;
                    
  myTextlabelB = cp5.addTextlabel("jednotka")
                    //.setText("A single ControlP5 textlabel, in yellow.")
                    .setPosition(100,50)
                    .setColorValue(0xffffff00)
                    .setFont(font)
                    ;       
=======
>>>>>>> parent of b370816... Zmena GUI
  
}

void draw(){
  ;
<<<<<<< HEAD
  myTextlabelB.draw(this);
  myTextlabelA.draw(this);
       

=======
  background(0);
}

void draw(){
  smooth();
  noStroke();
>>>>>>> parent of dd00997... Vyreseni problemu s padanim programu.
=======
>>>>>>> parent of b370816... Zmena GUI
=======
  background(0);
}

void draw(){
  smooth();
  noStroke();
>>>>>>> parent of dd00997... Vyreseni problemu s padanim programu.
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
<<<<<<< HEAD
<<<<<<< HEAD
      /*text(prutok, 155, 100);
=======
      text(prutok, 155, 100);
<<<<<<< HEAD
>>>>>>> parent of b370816... Zmena GUI
      if(prutok == 100){
      text("slm", 230, 100);
      }else{
      text("slm", 220, 100);
      }
      //println(prutok);println("");
=======
      text(prutok, 155, 100);
      text("slm", 220, 100);
      println(prutok);println("");
>>>>>>> parent of dd00997... Vyreseni problemu s padanim programu.
=======
      text("slm", 220, 100);
      println(prutok);println("");
>>>>>>> parent of dd00997... Vyreseni problemu s padanim programu.
      dalkove = true;
      //cp5.getController("flow").setVisible(true);
        
  }else{       //lokalne
      prutok = int(inString);
<<<<<<< HEAD
<<<<<<< HEAD
      //prutok2 = inString;
       background(bg);
      //background(0);
      /*text(prutok, 155, 100);
=======
      background(0);
      text(prutok, 155, 100);
<<<<<<< HEAD
>>>>>>> parent of b370816... Zmena GUI
      if(prutok == 100){
      text("slm", 230, 100);
      }else{
      text("slm", 220, 100);
<<<<<<< HEAD
      }*/
      myTextlabelA.setText(inString);
=======
      background(0);
      text(prutok, 155, 100);
      text("slm", 220, 100);
>>>>>>> parent of dd00997... Vyreseni problemu s padanim programu.
=======
      }
>>>>>>> parent of b370816... Zmena GUI
=======
      text("slm", 220, 100);
>>>>>>> parent of dd00997... Vyreseni problemu s padanim programu.
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

