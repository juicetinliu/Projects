class wall{
  PVector pos;
  int type;
  float size;
  color wallc;
  
  wall(PVector pos, int type, float size, color wallc){
    this.pos = pos;
    this.type = type;
    this.size = size;
    this.wallc = wallc;
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
