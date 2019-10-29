class bullet{
  int shooter; //0 - player, 1 - AI
  PVector dir;
  float speed, bulletsize;
  int life, maxbounces, bouncecount;
  color bcol;
  boolean explode;
  
  Vec2 pos, vel;
  float mass = 15;
  Body body;
  
  bullet(int shooter, Vec2 pos, float ang, float speed, int life, color bcol, float bulletsize){
    this.shooter = shooter;
    this.pos = pos;
    this.dir = new PVector(cos(ang), sin(ang));
    this.speed = speed;
    this.vel = new Vec2(1,0);
    vel.set(dir.x,-dir.y).normalize();
    vel.mulLocal(speed*10);
    this.life = life;
    this.bcol = bcol;
    this.maxbounces = 1;
    this.bouncecount = 0;
    this.bulletsize = bulletsize;
    this.explode = false;
    
    float w = bulletsize;
    float h = bulletsize/2;
    
    float box2dposx = (pos.x - width/2)/10;
    float box2dposy = -(pos.y - height/2)/10;
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.angle = ang;
    bd.position.set(box2dposx, box2dposy);
    body = box2d.createBody(bd);
     
    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    sd.setAsBox(box2dW, box2dH);
    
    
    FixtureDef bulletbody = new FixtureDef();
    bulletbody.shape = sd;

    bulletbody.density = mass;
    bulletbody.friction = 0;
    bulletbody.restitution = 0;

    body.createFixture(bulletbody);
    body.setUserData(this);
  }
  
  void killBody() {
    box2d.destroyBody(body);
  }
  
  void boom(){
    explode = true;
  }
  
  boolean hitmine(ArrayList<mine> mines){
    for(mine mien:mines){
      if(dist(pos.x,pos.y,mien.pos.x,mien.pos.y) < minesize/2){
        mien.state = 2;
        mien.timer = mineexplosiontime;
        return true;
      }
    }
    return false;
  }
  
  void move(){
    Vec2 moveForce = new Vec2(vel.x,vel.y);
    body.setLinearVelocity(moveForce);
    pos = box2d.getBodyPixelCoord(body);
  }
  
  void display(){
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(atan2(-vel.y, vel.x));
    noStroke();
    fill(bcol);
    rect(-bulletsize/2,-bulletsize/4,bulletsize,bulletsize/2);
    popMatrix();
  }
  
}
