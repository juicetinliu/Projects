player p1;
int bulletlim = 5, p1bullnum = 0;
int minelim = 2, p1minenum = 0;
boolean isLeft, isRight, isUp, isDown, isMine;
boolean spacePressed = true;
float p1mxspeed = 2, p1accel = 0.2, p1tlen = 30, p1fric = 0.9;

ArrayList<bullet> bullets = new ArrayList<bullet>();
float bulletspeed = 3;
float bulletsize = 10;
ArrayList<AItank> AItanks = new ArrayList<AItank>();
ArrayList<wall> walls = new ArrayList<wall>();
ArrayList<mine> mines = new ArrayList<mine>();
float minesize = 20;


void setup() {
  fullScreen(OPENGL);
  pixelDensity(displayDensity());
  frameRate(60);
  smooth();
  p1 = new player(new PVector(width/2, height/2), new PVector(1,0), p1mxspeed, p1accel, 1, color(255,0,0), p1fric, p1tlen);
  AItanks.add(new AItank(new PVector(100, 100), new PVector(1,0), p1mxspeed, p1accel, 1, color(255,0,0), p1fric, p1tlen));
  createlevel(1);
   }

void draw() {
  background(#E5CA68);
  hud();
  text(binary(p1.collidewalls(walls),4),width/2,height/2);
  
  p1.move(walls, isLeft, isRight, isUp, isDown);
  p1.setMine(isMine, mines);
  p1.display();
  for(AItank AI:AItanks){
    AI.move(walls, isRight, isLeft, isDown, isUp);
    AI.display();
  }
  
  for(int m = 0; m < mines.size(); m++){
    mine thismine = mines.get(m);
    thismine.display();
  }
  
  for(int w = 0; w < walls.size(); w++){
    wall thiswall = walls.get(w);
    thiswall.display();
  }
  
  hitbullets(bullets);
  for(int b = 0; b < bullets.size(); b++){
    bullet thisbullet = bullets.get(b);
    thisbullet.move();
    
    if(thisbullet.hitplayer(p1) || thisbullet.hitAI(AItanks) || thisbullet.hitwall(walls) || thisbullet.hitmine(mines)){
      if(thisbullet.shooter == 0){
        p1bullnum--;
      }
      bullets.remove(b);
    }else{
      thisbullet.display();
    }
  }
}

void mousePressed() {
  if(p1bullnum < bulletlim){
    PVector turrettip = new PVector(p1.pos.x + p1tlen*cos(p1.angtomouse), p1.pos.y + p1tlen*sin(p1.angtomouse));
    bullets.add(new bullet(0, turrettip, p1.angtomouse, bulletspeed, 1, color(#8E8E8E), bulletsize));
    p1bullnum++;
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
