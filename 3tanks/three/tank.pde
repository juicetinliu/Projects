class player{
  PVector pos, vel, dir, turretdir;
  float speed, maxspeed, acl, friction, angtomouse, p1tlen;
  int life;
  int maxlife;
  color pcol;
  
  player(PVector pos, PVector dir, float maxspeed, float acl, int life, color pcol, float friction, float p1tlen){
    this.pos = pos;
    this.dir = dir;
    this.maxspeed = maxspeed;
    this.acl = acl;
    this.life = life;
    this.maxlife = life;
    this.pcol = pcol;
    this.vel = new PVector(0,0);
    this.friction = friction;
    this.p1tlen = p1tlen;
  }
  
  void move(ArrayList<wall> walls, boolean isLeft, boolean isRight, boolean isUp, boolean isDown){
    if(isLeft){
      vel.x = max(vel.x - acl, -maxspeed);
    }
    if(isRight){
      vel.x = min(vel.x + acl, maxspeed);
    }
    if(isDown){
      vel.y = min(vel.y + acl, maxspeed);
    }
    if(isUp){
      vel.y = max(vel.y - acl, -maxspeed);
    }
    vel.limit(maxspeed);
    if(vel.mag() < 0.01){
      vel = vel.setMag(0);
    }else{
      vel.mult(friction);
      dir.set(vel);
    }
    pos.x = pos.x + vel.x; 
    pos.y = pos.y + vel.y;
    angtomouse = atan2(mouseY - pos.y, mouseX - pos.x);
  }
  
  void setMine(boolean isMine, ArrayList<mine> mines){
    if(p1minenum < minelim){
      if(isMine){
        if(spacePressed){
          spacePressed = false;
          mines.add(new mine(0, pos,minesize,color(#FFFF00)));
          p1minenum++;
        }
      }else{
        spacePressed = true;
      }
    }
  }
  
  int collidewalls(ArrayList<wall> walls){
    for(wall thiswall:walls){
      if(rectrectsect(pos.x,pos.y,dir.heading(),50,30,thiswall.pos.x,thiswall.pos.y,0,thiswall.size,thiswall.size)){
        return tankwallsect(pos.x,pos.y,dir.heading(),50,30,thiswall.pos.x,thiswall.pos.y,0,thiswall.size,thiswall.size);
      }
    }
    return 0; 
  }
  
  void display(){
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(atan2(dir.y, dir.x));
    
    fill(pcol);
    stroke(0);
    strokeWeight(3);    
    
    rect(-25,-15,50,30);
    popMatrix();
    ellipse(pos.x,pos.y,20,20);
    line(pos.x+10*cos(angtomouse),pos.y+10*sin(angtomouse),pos.x+p1tlen*cos(angtomouse),pos.y+p1tlen*sin(angtomouse));
  }
  
}
