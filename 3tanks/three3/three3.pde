import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;    

player p1;
int bulletlim = 5, p1bullnum = 0;
int minelim = 2, p1minenum = 0;
boolean isLeft, isRight, isUp, isDown, isMine;
boolean spacePressed = true;
float p1mxspeed = 10, p1accel = 0.03, p1tlen = 30, p1fric = 0.9;

ArrayList<bullet> bullets = new ArrayList<bullet>();
float bulletspeed = 3;
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
  
  p1 = new player(new Vec2(200, height/2), new PVector(1,0), p1mxspeed, p1accel, 1, color(255,0,0), p1fric, p1tlen);
  AItanks.add(new AItank(new Vec2(1050, height/2), new PVector(1,0), p1mxspeed, p1accel, 1, color(255,0,0), p1fric, p1tlen));
  createlevel(1);
  box2d.setGravity(0, 0);
}

void draw() {
  background(#E5CA68);
  hud();
  
  p1.movev2(isLeft, isRight, isUp, isDown);
  p1.setMine(isMine, mines);
  p1.display();
    
  for(AItank AI:AItanks){
    AI.move(false, false, false, false);
    AI.display();
    if(randomtimer <= 0){
      PVector turrettip = new PVector(AI.pos.x + p1tlen*cos(AI.angtoaim), AI.pos.y + p1tlen*sin(AI.angtoaim));
      bullets.add(new bullet(1, turrettip, AI.angtoaim, bulletspeed, 1, color(#8E8E8E), bulletsize));
      randomtimer = int(random(50,400));
    }else{
      randomtimer--;
    }
  }
  
  for(int m = 0; m < mines.size(); m++){
    mine thismine = mines.get(m);
    thismine.display();
    thismine.action();
    if(thismine.exploded){
      mines.remove(m);
      p1minenum--;
    }
  }
  
  box2d.step();
  
  for(int w = 0; w < walls.size(); w++){
    wall thiswall = walls.get(w);
    thiswall.display();
  }
  
  hitbullets(bullets);
  for(int b = 0; b < bullets.size(); b++){
    bullet thisbullet = bullets.get(b);
    thisbullet.move();
    if(thisbullet.hitplayer(p1)){
      gameover();
      exit();
    }else if(thisbullet.hitAI(AItanks)){
      if(thisbullet.shooter == 0){
        p1bullnum--;
      }
      bullets.remove(b);
    }else if(thisbullet.hitwall(walls)){
      if(thisbullet.shooter == 0){
        p1bullnum--;
      }
      bullets.remove(b);
    }else if(thisbullet.hitmine(mines)){
      if(thisbullet.shooter == 0){
        p1bullnum--;
      }
      bullets.remove(b);
    }else{
      thisbullet.display();
    }
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
