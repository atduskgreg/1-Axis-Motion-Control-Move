import processing.video.*;
import processing.serial.*;

Movie mov;
XMLElement xml;
ArrayList<Float> zPositions;
Serial myPort;

void setup() {
  size(720, 540);
  XMLElement aexml;
  frameRate(24);

  mov = new Movie(this, "3d_experiment_small.mov");
  mov.play();

  aexml = new XMLElement(this, "ae_camera_output.xml");
  zPositions = new ArrayList(aexml.getChildCount());

  int cameraPositionDataLength = aexml.getChildCount();
  for (int i = 0; i < cameraPositionDataLength; i++) {
    XMLElement position = aexml.getChild(i);
    String time; 
    String x;
    String y; 
    String z;

    for(int j = 0; j < position.getChildCount(); j ++) {
      XMLElement attribute = position.getChild(j);
      if(attribute.getName().equals("z")) {
        zPositions.add(float(attribute.getContent()));
      }
    }
  }

  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
}

int currentFrame = 0;
void draw() {
  image(mov, 0, 0);
  int m = int(map(zPositions.get(currentFrame), -1236, -164, 0, 180));
  myPort.write(m);
  currentFrame++;
}



void movieEvent(Movie m) {
  m.read();
}

