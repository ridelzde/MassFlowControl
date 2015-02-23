import processing.serial.*;
import controlP5.*;  

PImage bg;
ControlP5 cp5;

Textlabel myTextlabelA;
Textlabel myTextlabelB;


int prevValue = 1000;
int prutok = 0;
int lastprutok;
boolean dalkove = false;
Serial myPort;
int myColor = color(0,0,0);

void setup(){
  bg = loadImage("lcd3.jpg");
  smooth();
  size(658 ,320);
  println(Serial.list());
  background(0);
  myPort = new Serial(this, Serial.list()[0], 9600);
  
  myPort.bufferUntil('\n');

  cp5 = new ControlP5(this);
  
  cp5.addSlider("flow")
     .setPosition(100,175)
     .setRange(0,100)
     .setSize(200,20)    
     .setNumberOfTickMarks(101)
     //.setSliderMode(Slider.FLEXIBLE)
     ;
     
  PImage[] imgsd = {loadImage("button_ad.png"),loadImage("button_bd.png"),loadImage("button_cd.png")};
  PImage[] imgsu = {loadImage("button_a.png"),loadImage("button_b.png"),loadImage("button_c.png")};
  cp5.addButton("UP")
     .setValue(128)
     .setPosition(597,65)
     .setImages(imgsu)
     .updateSize()
     ;
     
  cp5.addButton("DOWN")
     .setValue(128)
     .setPosition(597,130)
     .setImages(imgsd)
     .updateSize()
     ;
     
      
  PFont font;
  font = loadFont("TrebuchetMS-Bold-48.vlw");
  textFont(font, 44);
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
  
}

void draw(){
  ;
  myTextlabelB.draw(this);
  myTextlabelA.draw(this);
       

}

void serialEvent(Serial myPort){
  String inString = myPort.readStringUntil('\n');
  if (inString != null) {
    inString = trim(inString);
    char firstChar = inString.charAt(0); //separuje prvni pismeno

    if (firstChar == 'd'){ //pokud je rizeno dalkove, prvni pismeno bude d
      prutok = int(inString.substring(1));
      //prutok2 = inString.substring(1);
      //background(50);
       background(bg);
      /*textSize(12);
      text("DÁLKOVĚ", 10, 20);*/
      cp5.getController("flow").setLock(false);
      textSize(44);
      /*text(prutok, 155, 100);
      if(prutok == 100){
      text("slm", 230, 100);
      }else{
      text("slm", 220, 100);
      }*/
      //println(prutok);println("");
      dalkove = true;
      cp5.getController("flow").setVisible(true);
        
  }else{       //lokalne
      prutok = int(inString);
      //prutok2 = inString;
       background(bg);
      //background(0);
      /*text(prutok, 155, 100);
      if(prutok == 100){
      text("slm", 230, 100);
      }else{
      text("slm", 220, 100);
      }*/
      myTextlabelA.setText(inString);
      cp5.getController("flow").lock();
      cp5.getController("flow").setValue(prutok);
  }
  
  }
}

void flow(float flowValue) {
  int f = int(flowValue);
  //println(flowValue);
  if(f!=prevValue){ //posle hodnoty jen kdyz se lisi, nezahlcuje seriovy port
  myPort.write(int(flowValue));
  println(int(flowValue));
  }
  prevValue = f;
}

