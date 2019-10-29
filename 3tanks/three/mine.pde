class mine{
  int placer; //0 - player, 1 - AI
  PVector pos;
  float size;
  color mcol;
  int timer;
  
  mine(int placer, PVector pos, float size, color mcol){
    this.placer = placer;
    this.pos = new PVector(pos.x,pos.y);
    this.size = size;
    this.mcol = mcol;
    this.timer = 100;
  }
  
  void display(){
    fill(mcol);
    stroke(0);
    strokeWeight(3);
    ellipse(pos.x,pos.y,size,size);
  }
}
