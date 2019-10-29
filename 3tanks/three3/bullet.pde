class bullet{
  int shooter; //0 - player, 1 - AI
  PVector pos, dir, vel;
  float speed, bulletsize;
  int life, maxbounces, bouncecount;
  color bcol;
  
  bullet(int shooter, PVector pos, float ang, float speed, int life, color bcol, float bulletsize){
    this.shooter = shooter;
    this.pos = pos;
    this.dir = new PVector(cos(ang), sin(ang));
    this.speed = speed;
    this.vel = new PVector(1,0);
    vel.set(dir).setMag(speed);
    this.life = life;
    this.bcol = bcol;
    this.maxbounces = 1;
    this.bouncecount = 0;
    this.bulletsize = bulletsize;
  }
  
  void move(){
    dir.set(vel);
    pos.x = pos.x + vel.x; 
    pos.y = pos.y + vel.y;
  }
  
  boolean hitplayer(player p1){
    float playerang = p1.dir.heading();
    if(segrectsect(pos.x, pos.y, pos.x+vel.x, pos.y+vel.y, p1.pos.x, p1.pos.y, playerang, 50, 30)){
      return true;
    }else{
      if(dist(pos.x,pos.y,p1.pos.x,p1.pos.y) < 15){
        return true;
      }else{
        return false;
      }
    }
  }
  
  boolean hitAI(ArrayList<AItank> AItanks){
    for(int A = 0; A < AItanks.size(); A++){
      AItank AI = AItanks.get(A);
      float AIang = AI.dir.heading();
      if(segrectsect(pos.x, pos.y, pos.x+vel.x, pos.y+vel.y, AI.pos.x, AI.pos.y, AIang, 50, 30)){
        AItanks.remove(A);
        return true;
      }else{
        if(dist(pos.x,pos.y,AI.pos.x,AI.pos.y) < 15){
          AItanks.remove(A);
          return true;
        }
      }
    }
    return false;
  }
  
  boolean hitmine(ArrayList<mine> mines){
    for(mine mien:mines){
      if(dist(pos.x,pos.y,mien.pos.x,mien.pos.y) < minesize/2){
        mien.state = 2;
        mien.timer = 5;
        return true;
      }
    }
    return false;
  }
  
  boolean hitwall(ArrayList<wall> walls){
    for(wall wal:walls){
      if(bouncecount <= maxbounces){
        if(segsegsect(pos.x,pos.y,pos.x+vel.x,pos.y+vel.y,wal.pos.x-wal.size/2,wal.pos.y-wal.size/2,wal.pos.x+wal.size/2,wal.pos.y-wal.size/2)){
            bouncecount++;
            vel.y = vel.y*-1;
            return false;
        }else if(segsegsect(pos.x,pos.y,pos.x+vel.x,pos.y+vel.y,wal.pos.x-wal.size/2,wal.pos.y+wal.size/2,wal.pos.x+wal.size/2,wal.pos.y+wal.size/2)){
            bouncecount++;
            vel.y = vel.y*-1;
            return false;
        }else if(segsegsect(pos.x,pos.y,pos.x+vel.x,pos.y+vel.y,wal.pos.x-wal.size/2,wal.pos.y-wal.size/2,wal.pos.x-wal.size/2,wal.pos.y+wal.size/2)){
            bouncecount++;
            vel.x = vel.x*-1;
            return false;
        }else if(segsegsect(pos.x,pos.y,pos.x+vel.x,pos.y+vel.y,wal.pos.x+wal.size/2,wal.pos.y-wal.size/2,wal.pos.x+wal.size/2,wal.pos.y+wal.size/2)){
            bouncecount++;
            vel.x = vel.x*-1;
            return false;
        }
      }else{
        return true;
      }
    }
    return false;
  }
  
  void display(){
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(atan2(dir.y, dir.x));
    noStroke();
    fill(bcol);
    rect(-bulletsize/2,-bulletsize/4,bulletsize,bulletsize/2);
    popMatrix();
  }
  
}

void hitbullets(ArrayList<bullet> bullets){
  for(int b = 0; b < bullets.size() - 1; b++){
    bullet bullet1 = bullets.get(b);
    for(int bh = b+1; bh < bullets.size(); bh++){
      bullet bullet2 = bullets.get(bh);
      if(dist(bullet1.pos.x,bullet1.pos.y,bullet2.pos.x,bullet2.pos.y) < bulletsize/2){
        if(bullet1.shooter == 0){
          p1bullnum--;
        }
        if(bullet2.shooter == 0){
          p1bullnum--;
        }
        bullets.remove(bh);
        bullets.remove(b);
      }
    }
  }
}
