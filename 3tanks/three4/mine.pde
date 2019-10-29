class mine{
  int placer; //0 - player, 1 - AI
  boolean exploded;
  PVector pos;
  float size;
  color mcol;
  int timer;
  int state; //0 - just placed(standby), 1 - beeping, 2, explode
  
  mine(int placer, PVector pos, float size, color mcol){
    this.placer = placer;
    this.pos = new PVector(pos.x,pos.y);
    this.size = size;
    this.mcol = mcol;
    this.timer = 300;
    this.state = 0;
    this.exploded = false;
  }
  
  void action(){
    switch(state){
      case 0:
        if(timer <= 0){
          state = 1;
          timer = 100;
        }else{
          timer--;
        }
      break;
      
      case 1:
        if(timer <= 0){
          state = 2;
          timer = 5;
        }else{
          if(int(timer/10) % 2 == 0){
            fill(255,0,0);
            noStroke();
            ellipse(pos.x,pos.y,size-3,size-3);
          }
          timer--;
        }
      break;
        
      case 2:
        if(timer <= 0){
          exploded = true;
          explode(walls, AItanks);
        }else{
          stroke(0);
          strokeWeight(2);
          fill(255);
          ellipse(pos.x,pos.y,50*(5-timer),50*(5-timer));
          timer--;
        }
      break;
      
      default:
        state = 0;
      break;
    }
  }
  
  void explode(ArrayList<wall> walls, ArrayList<AItank> AItanks){
    for(int w = walls.size()-1; w >= 0; w--){
      wall thiswall = walls.get(w);
      if(thiswall.type == 1){
        if(dist(thiswall.pos.x, thiswall.pos.y, pos.x,pos.y) <= 125){
          thiswall.killBody();
          walls.remove(w);
        }
      }
    }
    for(int A = AItanks.size()-1; A >= 0; A--){
      AItank AI = AItanks.get(A);
      if(dist(AI.pos.x, AI.pos.y, pos.x,pos.y) <= 125){
        AItanks.remove(A);
      }
    }
  }
  
  void display(){
    fill(mcol);
    stroke(0);
    strokeWeight(3);
    ellipse(pos.x,pos.y,size,size);
  }
}
