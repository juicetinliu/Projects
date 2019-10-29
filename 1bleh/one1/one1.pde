ArrayList<being> beings = new ArrayList<being>();
ArrayList<bleh> blehs = new ArrayList<bleh>();
ArrayList<blessedbeing> blesses = new ArrayList<blessedbeing>();
int infectedcounter = 0;
float lifedata, speeddata, blehsdata, healsdata;
int totalbeings = 0;
IntList infpop = new IntList();
boolean mouseclick = true;
boolean selectedbeing = false, selectedbless = false;

void setup(){
  fullScreen(OPENGL);
  pixelDensity(displayDensity());
  frameRate(60);
  smooth();
  lifedata = 0;
  speeddata = 0;
  blehsdata = 1;
  for(int b = 0; b < 1000; b++){
    beings.add(new being(random(0,width), random(0,height), random(0,2*PI),0.5,5));
    totalbeings += 1;
  }
  for(int s = 0; s < 0; s++){
    blesses.add(new blessedbeing(random(0,width), random(0,height), random(0,2*PI),0.5,5,50));
    totalbeings += 1;
  }
  for(int p = 0; p < maxsamples; p++){
    infpop.append(0);
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
  for(blessedbeing these: blesses){
    these.move();
    these.bless(beings, blehs);
    these.display();
  }
  for(int h = blehs.size() - 1; h >= 0; h--){
    bleh thisbleh = blehs.get(h);
    thisbleh.display();
    thisbleh.move();
    if(thisbleh.die){
      blehs.remove(h);
    }
  }
  
  graph();
  hudbutton(20,15);
  
  if(displayhud){
    hud();
  }else{
    fill(255);
    textAlign(LEFT, CENTER);
    textSize(12);
    text("FPS: " + int(frameRate),40,15);
  }
}

void mousePressed() {
  if(displayhud && mouseX > 200){
    if(displaybeingmenu && !(mouseX > 250 && mouseX < 850 && mouseY < 750 && mouseY > 600)){
      if(selectedbeing){
        //if(!(mouseX > 250 && mouseX < 850 && mouseY < 750 && mouseY > 600)){
          beings.add(new being(mouseX, mouseY, random(0,2*PI),0.5,5));
          totalbeings += 1;
        //}
      }else if(selectedbless){
        //if(!(mouseX > 250 && mouseX < 850 && mouseY < 750 && mouseY > 600)){
          blesses.add(new blessedbeing(mouseX, mouseY, random(0,2*PI),0.5,5,50));
          totalbeings += 1;
        //}
      }else{
        //if(!(mouseX > 250 && mouseX < 850 && mouseY < 750 && mouseY > 600)){
        for(int bl = 0; bl < 20; bl++){
          blehs.add(new bleh(mouseX, mouseY, (float(bl)/5)*PI));
        }
      }
    }else if(!displaybeingmenu){
      for(int bl = 0; bl < 20; bl++){
        blehs.add(new bleh(mouseX, mouseY, (float(bl)/5)*PI));
      }
    }
  }else if(!displayhud && dist(20,15,mouseX,mouseY) > 10){
    for(int bl = 0; bl < 20; bl++){
        blehs.add(new bleh(mouseX, mouseY, (float(bl)/5)*PI));
      }
  }
}
