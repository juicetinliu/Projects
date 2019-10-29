import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;    

player p1;
int bulletlim = 5, p1bullnum = 0;
int minelim = 2, p1minenum = 0;
boolean isLeft, isRight, isUp, isDown, isMine;
boolean spacePressed = true;
float p1mxspeed = 10, p1accel = 0.03, p1tlen = 30, p1fric = 0.9;

ArrayList<bullet> bullets = new ArrayList<bullet>();
float bulletspeed = 2;
float bulletsize = 10;
ArrayList<AItank> AItanks = new ArrayList<AItank>();
ArrayList<wall> walls = new ArrayList<wall>();
ArrayList<mine> mines = new ArrayList<mine>();
float minesize = 20;

int randomtimer = int(random(50,400));

void setup() {
  fullScreen(OPENGL);
  pixelDensity(displayDensity());
  frameRate(60);
  smooth();
  box2d = new Box2DProcessing(this);  
  box2d.createWorld();
  box2d.listenForCollisions();
  box2d.setGravity(0, 0);
  
  p1 = new player(new Vec2(200, height/2), new PVector(1,0), p1mxspeed, p1accel, 1, color(255,0,0), p1fric, p1tlen);
  AItanks.add(new AItank(new Vec2(1050, height/2), new PVector(1,0), p1mxspeed, p1accel, 1, color(255,0,0), p1fric, p1tlen));
  createlevel(1);
}

void draw() {
  background(#E5CA68);
  hud();
  box2d.step();
  
  p1.movev2(isLeft, isRight, isUp, isDown);
  p1.setMine(isMine, mines);
  p1.display();
  
  for(int m = 0; m < mines.size(); m++){
    mine thismine = mines.get(m);
    thismine.display();
    thismine.action();
    if(thismine.exploded){
      mines.remove(m);
      p1minenum--;
    }
  }
  
  for(int b = 0; b < bullets.size(); b++){
    bullet thisbullet = bullets.get(b);
    thisbullet.move();
    if(thisbullet.hitmine(mines)){
      thisbullet.boom();
    }
    if(thisbullet.explode){
      removebullet(thisbullet);
    }else{
      thisbullet.display();
    }
  }
  
  for(int a = 0; a < AItanks.size(); a++){
    AItank AI = AItanks.get(a);
    AI.move(false, false, false, false);
    if(AI.explode){
      removeAItank(AI);
    }else{
      AI.display();
    }
    if(randomtimer <= 0){
      Vec2 turrettip = new Vec2(AI.pos.x + (p1tlen+bulletsize)*cos(AI.angtoaim), AI.pos.y + (p1tlen+bulletsize)*sin(AI.angtoaim));
      bullets.add(new bullet(1, turrettip, AI.angtoaim, bulletspeed, 1, color(#8E8E8E), bulletsize));
      randomtimer = int(random(50,400));
    }else{
      randomtimer--;
    }
  }
  
  
  for(int w = 0; w < walls.size(); w++){
    wall thiswall = walls.get(w);
    thiswall.display();
  }
}


void keyPressed() {
  setMove(keyCode, true);
}
 
void keyReleased() {
  setMove(keyCode, false);
}

boolean setMove(int k, boolean b) {
  switch (k) {
  case UP:
    return isUp = b;
 
  case DOWN:
    return isDown = b;
 
  case LEFT:
    return isLeft = b;
 
  case RIGHT:
    return isRight = b;

  case 87:
    return isUp = b;
 
  case 83:
    return isDown = b;
 
  case 65:
    return isLeft = b;
 
  case 68:
    return isRight = b;
  
  case 32:
    return isMine = b;
    
  default:
    return b;
  }
}
