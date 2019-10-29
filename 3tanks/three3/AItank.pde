class AItank{
  PVector dir, turretdir, aimpoint;
  float speed, maxspeed, acl, friction, angtoaim, p1tlen;
  int life;
  int maxlife;
  color pcol;
  float w, h;
  
  Vec2 pos, vel;
  float mass = 15;
  Body body;
  float lmpower, rmpower;
  float virtjoyy = 0;
  float virtjoyx = 0;
  
  AItank(Vec2 pos, PVector dir, float maxspeed, float acl, int life, color pcol, float friction, float p1tlen){
    this.pos = pos;
    this.dir = dir;
    this.maxspeed = maxspeed;
    this.acl = acl;
    this.life = life;
    this.maxlife = life;
    this.pcol = pcol;
    this.vel = new Vec2(0,0);
    this.friction = friction;
    this.p1tlen = p1tlen;
    
    w = 50;
    h = 30;
    lmpower = 0;
    rmpower = 0;
    
    float box2dposx = (pos.x - width/2)/10;
    float box2dposy = (pos.y - height/2)/10;
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2dposx, box2dposy);
    body = box2d.createBody(bd);
     
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    sd.setAsBox(box2dW, box2dH);
    
    
    FixtureDef sumobody = new FixtureDef();
    sumobody.shape = sd;

    sumobody.density = mass;
    sumobody.friction = 0;
    sumobody.restitution = 0;

    body.createFixture(sumobody);
    
  }
  
  void killBody() {
    box2d.destroyBody(body);
  }
  
  void move(boolean isLeft, boolean isRight, boolean isUp, boolean isDown){
    Vec2 moveForce = new Vec2(0,0);
    moveForce.normalize();
    
    int joymoveamt = int(acl*100);
    if(!(isLeft || isRight)){
      virtjoyx = 0;
    }else{
      if(isLeft){
        virtjoyx = max(virtjoyx - joymoveamt, -100);
      }
      if(isRight){
        virtjoyx = min(virtjoyx + joymoveamt, 100);
      }
    }
    if(!(isUp || isDown)){
      virtjoyy = 0;
    }else{
      if(isUp){
        virtjoyy = min(virtjoyy + joymoveamt, 100);
      }
      if(isDown){
        virtjoyy = max(virtjoyy - joymoveamt, -100);
      }
    }
    
    rmpower = virtjoyy - virtjoyx;
    lmpower = virtjoyy + virtjoyx;
    
    float rotateamount = map(lmpower - rmpower, 200, -200, radians(180), radians(-180));
    moveForce.x = map(lmpower + rmpower, 200, -200, maxspeed, -maxspeed)*cos(body.getAngle());
    moveForce.y = map(lmpower + rmpower, 200, -200, maxspeed, -maxspeed)*sin(body.getAngle());

    body.setLinearVelocity(moveForce);
    body.setAngularVelocity(-rotateamount);
    
    Vec2 currentVelocity;
    currentVelocity = body.getLinearVelocity();
    if(!(isLeft || isRight || isUp || isDown)){
      body.setLinearVelocity(currentVelocity.mulLocal(friction));
      currentVelocity = body.getLinearVelocity();
      body.setAngularVelocity(body.getAngularVelocity() * friction);
    }
    pos = box2d.getBodyPixelCoord(body);
    dir.set(cos(-body.getAngle()), sin(-body.getAngle()));
    
    //PVector predictedmovement = new PVector(1,0);
    //PVector distancetoplayer = new PVector(1,0);
    
    //distancetoplayer.set(pos.x,pos.y).sub(p1.pos.x, p1.pos.y);
    //predictedmovement.set(p1.dir).mult(distancetoplayer.mag()*p1.vel.length()/5);
    //aimpoint.set(predictedmovement.add(p1.pos.x, p1.pos.y));
    //noFill();
    //stroke(0,255,0,150);
    //strokeWeight(3);
    //ellipse(aimpoint.x,aimpoint.y,30,30);
    angtoaim = atan2(mouseY - pos.y, mouseX - pos.x);
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
