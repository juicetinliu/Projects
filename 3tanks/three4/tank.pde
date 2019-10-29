class player{
  PVector dir, turretdir;
  float speed, maxspeed, acl, friction, angtomouse, p1tlen;
  int life;
  int maxlife;
  color pcol;
  float w, h;
  
  Vec2 pos, vel;
  float mass = 15;
  Body body;
  float lmpower, rmpower;
  float virtjoyy, virtjoyx;
  
  player(Vec2 pos, PVector dir, float maxspeed, float acl, int life, color pcol, float friction, float p1tlen){
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
    virtjoyy = 0;
    virtjoyx = 0;
    
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
  
  void movev2(boolean isLeft, boolean isRight, boolean isUp, boolean isDown){
    
    vel.normalize();
    
    int joymoveamt = int(acl*100);
    if(!(isLeft || isRight) || (isLeft && isRight)){
      virtjoyx = 0;
    }else{
      if(isLeft){
        virtjoyx = max(virtjoyx - joymoveamt, -100);
      }
      if(isRight){
        virtjoyx = min(virtjoyx + joymoveamt, 100);
      }
    }
    if(!(isUp || isDown) || (isUp && isDown)){
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
    vel.x = map(lmpower + rmpower, 200, -200, maxspeed, -maxspeed)*cos(body.getAngle());
    vel.y = map(lmpower + rmpower, 200, -200, maxspeed, -maxspeed)*sin(body.getAngle());

    body.setLinearVelocity(vel);
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
    angtomouse = atan2(mouseY - pos.y, mouseX - pos.x);
  }
  
  void setMine(boolean isMine, ArrayList<mine> mines){
    if(p1minenum < minelim){
      if(isMine){
        if(spacePressed){
          spacePressed = false;
          mines.add(new mine(0, new PVector(pos.x,pos.y),minesize,color(#FFFF00)));
          p1minenum++;
        }
      }else{
        spacePressed = true;
      }
    }
  }
  
  void display(){
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(atan2(dir.y, dir.x));
    
    fill(pcol);
    stroke(0);
    strokeWeight(3);    
    rect(-25,-15,w,h);
    
    stroke(0);
    strokeWeight(1);
    triangle(20,5,20,-5,23,0);
    
    popMatrix();
    
    stroke(0);
    strokeWeight(3);
    ellipse(pos.x,pos.y,20,20);
    line(pos.x+10*cos(angtomouse),pos.y+10*sin(angtomouse),pos.x+p1tlen*cos(angtomouse),pos.y+p1tlen*sin(angtomouse));
    
    stroke(255,0,0,128);
    strokeWeight(2);
    line(pos.x+p1tlen*cos(angtomouse),pos.y+p1tlen*sin(angtomouse),mouseX,mouseY);
    noFill();
    strokeWeight(3);
    ellipse(mouseX,mouseY,20,20);
  }
  
}

void mousePressed() {
  if(p1bullnum < bulletlim){
    Vec2 turrettip = new Vec2(p1.pos.x + p1tlen*cos(p1.angtomouse), p1.pos.y + p1tlen*sin(p1.angtomouse));
    bullets.add(new bullet(0, turrettip, p1.angtomouse, bulletspeed, 1, color(#8E8E8E), bulletsize));
    p1bullnum++;
  }
}
