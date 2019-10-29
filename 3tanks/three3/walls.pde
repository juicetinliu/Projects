class wall{
  PVector pos;
  int type;
  float size;
  color wallc;
  
  Body b;
  
  wall(PVector pos, int type, float size, color wallc){
    this.pos = pos;
    this.type = type;
    this.size = size;
    this.wallc = wallc;
    
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(size/2);
    float box2dH = box2d.scalarPixelsToWorld(size/2);
    // We're just a box
    sd.setAsBox(box2dW, box2dH);


    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(pos.x,pos.y));
    b = box2d.createBody(bd);
    
    // Attached the shape to the body using a Fixture
    b.createFixture(sd,1);
    
  }
  
  void killBody() {
    box2d.destroyBody(b);
  }
  
  void display(){
    rectMode(CENTER);
    fill(wallc);
    stroke(0);
    strokeWeight(3);
    
    rect(pos.x, pos.y, size, size);
    rectMode(CORNER);
  }
  
}
