ArrayList<being> beings = new ArrayList<being>();
ArrayList<bleh> blehs = new ArrayList<bleh>();
int infectedcounter = 0;
int data1;
float databox1x, databox1y;
int data2;
float databox2x, databox2y;

void setup(){
  fullScreen(OPENGL);
  pixelDensity(displayDensity());
  frameRate(60);
  smooth();
  databox1x = 10;
  databox1y = 10;
  databox2x = 10;
  databox2y = 210;
  for(int b = 0; b < 1000; b++){
    beings.add(new being(random(0,width), random(0,height), random(0,2*PI),0.5));
  }
}

void draw(){
  background(0);
  infectedcounter = 0;
  for(being them: beings){
    them.move();
    them.infect(blehs);
    them.display();
    if(them.infected){
      infectedcounter += 1;
    }
  }
  for(int h = blehs.size() - 1; h >= 0; h--){
    bleh thisbleh = blehs.get(h);
    thisbleh.display();
    thisbleh.move();
    if(thisbleh.die){
      blehs.remove(h);
    }
  }
  
  hud();
}

void mousePressed() {
  if(mouseX > databox1x+25 && mouseX < databox1x+75 && mouseY > databox1y+25 && mouseY < databox1y+75){
    data1 -=1;
  }else if(mouseX > databox1x+325 && mouseX < databox1x+375 && mouseY > databox1y+25 && mouseY < databox1y+75){
    data1 +=1;
  }else if(mouseX > databox2x+25 && mouseX < databox2x+75 && mouseY > databox2y+25 && mouseY < databox2y+75){
    data2 -=1;
  }else if(mouseX > databox2x+325 && mouseX < databox2x+375 && mouseY > databox2y+25 && mouseY < databox2y+75){
    data2 +=1;
  }else{
    for(int bl = 0; bl < 10; bl++){
      blehs.add(new bleh(mouseX, mouseY, (float(bl)/5)*PI,1));
    }
  }
}
