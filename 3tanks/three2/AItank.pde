class AItank{
  PVector pos, vel, dir, turretdir, aimpoint;
  float speed, maxspeed, acl, friction, angtoaim, p1tlen;
  int life;
  int maxlife;
  color pcol;
  
  AItank(PVector pos, PVector dir, float maxspeed, float acl, int life, color pcol, float friction, float p1tlen){
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
    this.aimpoint = new PVector(0,0);
  }
  
  void move(ArrayList<wall> walls, boolean isLeft, boolean isRight, boolean isUp, boolean isDown){
    String collided = binary(collidewalls(walls),4);
    //text(collided,width/2,height/2);
    //text(collided.charAt(0),width/2,height/2 + 20);
    //text(collided.charAt(1),width/2,height/2 + 30);
    //text(collided.charAt(2),width/2,height/2 + 40);
    //text(collided.charAt(3),width/2,height/2 + 50);
    
    if(isLeft && collided.charAt(3) == '0'){
      vel.x = max(vel.x - acl, -maxspeed);
    }else if(collided.charAt(3) == '1'){
      vel.x = max(0, vel.x);
    }
    if(isRight && collided.charAt(1) == '0'){
      vel.x = min(vel.x + acl, maxspeed);
    }else if(collided.charAt(1) == '1'){
      vel.x = min(0, vel.x);
    }
    if(isDown && collided.charAt(0) == '0'){
      vel.y = min(vel.y + acl, maxspeed);
    }else if(collided.charAt(0) == '1'){
      vel.y = min(0, vel.y);
    }
    if(isUp && collided.charAt(2) == '0'){
      vel.y = max(vel.y - acl, -maxspeed);
    }else if(collided.charAt(2) == '1'){
      vel.y = max(0, vel.y);
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
    PVector predictedmovement = new PVector(1,0);
    PVector distancetoplayer = new PVector(1,0);
    distancetoplayer.set(pos).sub(p1.pos);
    predictedmovement.set(p1.dir).mult(distancetoplayer.mag()*p1.vel.mag()/5);
    aimpoint.set(predictedmovement.add(p1.pos));
    noFill();
    stroke(0,255,0,150);
    strokeWeight(3);
    ellipse(aimpoint.x,aimpoint.y,30,30);
    angtoaim = atan2(aimpoint.y - pos.y, aimpoint.x - pos.x);
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
    line(pos.x+10*cos(angtoaim),pos.y+10*sin(angtoaim),pos.x+p1tlen*cos(angtoaim),pos.y+p1tlen*sin(angtoaim));
  }
  
}
