import netP5.*;  //(1)
import oscP5.*;
import ketai.net.*;
import ketai.sensors.*;

PFont font;

OscP5 oscP5;
KetaiSensor sensor;

NetAddress remoteLocation;
int songNumber, whichPoster;
String myIPAddress; 
String remoteAddress = "10.16.159.92";  //(2) Customize!  

void setup() {
  sensor = new KetaiSensor(this);
  orientation(PORTRAIT);
  textSize(36);
  initNetworkConnection();
  sensor.start();
  size(800, 1280);

  //size(480, 800);
  noStroke();
  fill(255);

  font = loadFont("HelveticaNeue-Bold-48.vlw");
}

void draw() {

  //  scale(1.3);
  background(#FF9900);

  rect(20, 225, 50, 50);
  rect(20+width/2, 225, 50, 50);

  pushStyle();
  stroke(1, 50);
  line(width/2, 200, width/2, 310);
  line(20, 180, width-20, 180);
  line(20, height/4, width-20, height/4);
  line(20, height/4+200, width-20, height/4+200);
  line(20, height/4+450, width-20, height/4+450);
  line(20, height/4+700, width-20, height/4+700);
  popStyle();

  textFont(font, 80);
  text("PAPER", 20, 80);
  text("PLAYLIST", 20, 160);

  textFont(font, 32);
  text("BOOMBOX", 80, 265);
  text("WALKMAN", 80+width/2, 265);

  //translate(10, 170);
  //scale(0.8);

  textFont(font, 32);
  text("The Best We Got", 240, height/4+100);
  textFont(font, 24);
  text("The Rubens", 240, height/4+125);

  textFont(font, 32);
  text("My Gun", 240, height/4+325);
  textFont(font, 24);
  text("The Rubens", 240, height/4+350);

  textFont(font, 32);
  text("Never be the Same", 240, height/4+550);
  textFont(font, 24);
  text("The Rubens", 240, height/4+575);

  //  textFont(font, 32);
  //  text("Lay It Down", 190, 635);
  //  textFont(font, 24);
  //  text("The Rubens", 190, 660);

  pushMatrix();
  //scale(0.8);
  translate(20, 350);
  triangle(0, 150, 0, 0, 150, 75);
  translate(0, 225);
  triangle(0, 150, 0, 0, 150, 75);
  translate(0, 225);
  triangle(0, 150, 0, 0, 150, 75);
  popMatrix();

  check();
  OSC();
}

void check() {
  if (mousePressed && mouseY > height/4 && mouseY < height/4+200) {
    songNumber = 1;
    pushStyle();
    fill(111);
    textFont(font, 32);
    text("The Best We Got", 240, height/4+100);
    textFont(font, 24);
    text("The Rubens", 240, height/4+125);
    popStyle();
  }
  if (mousePressed && mouseY > height/4+200 && mouseY < height/4+450) {
    songNumber = 2;
    pushStyle();
    fill(111);
    textFont(font, 32);
    text("My Gun", 240, height/4+325);
    textFont(font, 24);
    text("The Rubens", 240, height/4+350);
    popStyle();
  }
  if (mousePressed && mouseY > height/4+450 && mouseY < height/4+700) {
    songNumber = 3;
    pushStyle();
    fill(111);
    textFont(font, 32);
    text("Never be the Same", 240, height/4+550);
    textFont(font, 24);
    text("The Rubens", 240, height/4+575);
    popStyle();
  }
  //  if (mousePressed && mouseY > height/4+700 && mouseY < height) {
  //    songNumber = 4;
  //  }
  if (mousePressed && mouseY > 180 && mouseY < height/4 && mouseX < width/2) {
    whichPoster = 1;
  }
  if (mousePressed && mouseY > 180 && mouseY < height/4 && mouseX > width/2) {
    whichPoster = 2;
  }

  if (      songNumber == 1) {
    pushStyle();
    fill(111);
    textFont(font, 32);
    text("The Best We Got", 240, height/4+100);
    textFont(font, 24);
    text("The Rubens", 240, height/4+125);
    popStyle();
  }
  if (      songNumber == 2) {
    pushStyle();
    fill(111);
    textFont(font, 32);
    text("My Gun", 240, height/4+325);
    textFont(font, 24);
    text("The Rubens", 240, height/4+350);
    popStyle();
  }
  if (      songNumber == 3) {
    pushStyle();
    fill(111);
    textFont(font, 32);
    text("Never be the Same", 240, height/4+550);
    textFont(font, 24);
    text("The Rubens", 240, height/4+575);
    popStyle();
  }
}

void OSC() {
  OscMessage myMessage = new OscMessage("accelerometerData"); //(6)
  myMessage.add(songNumber); //(7)
  myMessage.add(whichPoster);
  oscP5.send(myMessage, remoteLocation);  //(8)
}

void initNetworkConnection()
{
  oscP5 = new OscP5(this, 12000);  //(9)
  remoteLocation = new NetAddress(remoteAddress, 12000);  //(10)
  myIPAddress = KetaiNet.getIP();    //(11)
}

