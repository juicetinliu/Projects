ArrayList<hitblock> blox = new ArrayList<hitblock>();
PVector[] mousetrail = new PVector[5];
float mousespeed;
int blokangle = 0;
boolean visualon = false;
boolean mouseclick = true;

void setup(){
  fullScreen(OPENGL);
  pixelDensity(displayDensity());
  frameRate(60);
  smooth();
  blox.add(new hitblock(width/2,height/2,radians(0),150));
  blox.add(new hitblock(width/2+200,height/2,radians(0),150));
  blox.add(new hitblock(width/2-200,height/2,radians(0),150));
  //blox.add(new hitblock(random(200,width-200),random(200,height-200),radians(int(random(360))),150));
  
  for(int i = 0; i < mousetrail.length; i++){
    mousetrail[i] = new PVector(mouseX, mouseY);
  }
}

void draw(){
  
  background(0);  
  
  for(hitblock blocks:blox){
    blocks.display();
  }
  mousespeed = mouseeffect();
  
  
  for(int b = 0; b < blox.size(); b++){
    hitblock thisblock = blox.get(b);
    if(!thisblock.begindestruction){
      if(thisblock.hitv2()){
        thisblock.destroy();
        blox.add(new hitblock(random(200,width-200),random(200,height-200),radians(int(random(360))),150));
      }
    }else if(thisblock.destroyed){
      blox.remove(b);
    }
  }
  hud();
}
