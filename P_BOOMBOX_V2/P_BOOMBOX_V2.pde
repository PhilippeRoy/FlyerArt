//************** Libraries *************************************

import ddf.minim.*;
import oscP5.*;
import netP5.*;
import processing.serial.*;


//************** OSC *************************************
OscP5 oscP5;
/* a NetAddress contains the ip address and port number of a remote location in the network. */
NetAddress remoteLocation;

Minim minim;
AudioPlayer song1;
AudioPlayer song2;
AudioPlayer song3;
AudioPlayer song4;

int songNumber, whichPoster;

Serial myPort;



void setup()
{
  size(512, 200, P3D);
  oscP5 = new OscP5(this, 12000);
  remoteLocation = new NetAddress("192.168.0.17", 12000); //(1) Customize!
  myPort = new Serial(this, Serial.list()[0], 9600);

  // we pass this to Minim so that it can load files from the data directory
  minim = new Minim(this);

  // loadFile will look in all the same places as loadImage does.
  // this means you can find files that are in the data folder and the 
  // sketch folder. you can also pass an absolute path, or a URL.
  song1 = minim.loadFile("01-the_rubens-the_best_we_got.mp3");
  song2 = minim.loadFile("02-the_rubens-my_gun.mp3");
  song3 = minim.loadFile("03-the_rubens-never_be_the_same.mp3");
  song4 = minim.loadFile("04-the_rubens-lay_it_down.mp3");


  /* create a new instance of oscP5. 
   * 12000 is the port number you are listening for incoming osc messages.
   */
  oscP5 = new OscP5(this, 32000);  
  /* create a new NetAddress. a NetAddress is used when sending osc messages
   * with the oscP5.send method.
  /* the address of the osc broadcast server */
  remoteLocation = new NetAddress("192.168.0.17", 12000);
}

void draw()
{
  background(0);
  text("ON", width/2, height/2);
  player();
  sendMessage();
}

void player() 
{
  if ( songNumber == 1 ) {

    song1.play();

    song2.pause();
    song3.pause();
    song4.pause();

    song2.rewind();
    song3.rewind();
    song4.rewind();
  }
  if ( songNumber == 2 ) {

    song2.play();

    song1.pause();
    song3.pause();
    song4.pause();

    song1.rewind();
    song3.rewind();
    song4.rewind();
  }
  if ( songNumber == 3 ) {

    song3.play();

    song1.pause();
    song2.pause();
    song4.pause();

    song1.rewind();
    song2.rewind();
    song4.rewind();
  }
   if ( songNumber == 4 ) {

    song4.play();

    song1.pause();
    song2.pause();
    song3.pause();

    song1.rewind();
    song2.rewind();
    song3.rewind();
  }
}

void stop()
{
  // always close Minim audio classes when you are done with them
  song1.close();
  song2.close();
  song3.close();
  song4.close();  // always stop Minim before exiting.

  minim.stop();

  super.stop();
}


void sendMessage() {    

  String myPackage = ( "*"  + songNumber + "," + whichPoster + ",#");
  myPort.write(myPackage);
  println(myPackage);
}


void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkTypetag("ii"))  //(6)
  {
    songNumber =  theOscMessage.get(0).intValue(); //(7)
    whichPoster =  theOscMessage.get(1).intValue();
  }
}

