class mine{
  int placer; //0 - player, 1 - AI
  boolean exploded;
  PVector pos;
  float size;
  color mcol;
  int timer;
  int state; //0 - just placed(standby), 1 - beeping, 2 - explode
  
  mine(int placer, PVector pos, float size, color mcol){
    this.placer = placer;
    this.pos = new PVector(pos.x,pos.y);
    this.size = size;
    this.mcol = mcol;
    this.timer = 500;
    this.state = 0;
    this.exploded = false;
  }
  
  void action(){
    fill(0);
    text(state + " " + timer, pos.x+size/2, pos.y);
    switch(state){
      case 0:
        if(timer <= 0){
          state = 1;
          timer = 200;
        }else if(triggered(players, AItanks)){
          timer -= 5;
        }else{
          timer--;
        }
      break;
      
      case 1:
        if(triggered(players, AItanks)){
          timer -= 2;
        }else if(timer <= 0){
          state = 2;
          timer = mineexplosiontime;
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
          explode(mines, walls, bullets, AItanks, players);
        }else{
          stroke(0);
          strokeWeight(2);
          float timervalue = map(timer,mineexplosiontime,0,1,0);
          float timervalueinv = map(timer,mineexplosiontime,0,0,1);
          fill(255,255*(1-timervalueinv*timervalueinv*timervalueinv),0);
          ellipse(pos.x,pos.y,250*(1-timervalue*timervalue*timervalue*timervalue),250*(1-timervalue*timervalue*timervalue*timervalue));
          timer--;
        }
      break;
      
      default:
        state = 0;
      break;
    }
  }
  
  boolean triggered(ArrayList<player> players, ArrayList<AItank> AItanks){
    for(int A = AItanks.size()-1; A >= 0; A--){
      AItank AI = AItanks.get(A);
      if(dist(AI.pos.x, AI.pos.y, pos.x,pos.y) <= size){
        return true;
      }
    }
    for(int P = players.size()-1; P >= 0; P--){
      player play = players.get(P);
      if(dist(play.pos.x, play.pos.y, pos.x,pos.y) <= size){
        return true;
      }
    }
    return false;
  }
  
  void explode(ArrayList<mine> mines, ArrayList<wall> walls, ArrayList<bullet> bullets, ArrayList<AItank> AItanks, ArrayList<player> players){
    for(int m = mines.size()-1; m >= 0; m--){
      mine thismine = mines.get(m);
      if(dist(thismine.pos.x, thismine.pos.y, pos.x,pos.y) <= 125){
        thismine.state = 2;
        thismine.timer = mineexplosiontime;
      }
    }
    for(int w = walls.size()-1; w >= 0; w--){
      wall thiswall = walls.get(w);
      if(thiswall.type == 1){
        if(dist(thiswall.pos.x, thiswall.pos.y, pos.x,pos.y) <= 125){
          removewall(thiswall);
        }
      }
    }
    for(int b = bullets.size()-1; b >= 0; b--){
      bullet thisbullet = bullets.get(b);
      if(dist(thisbullet.pos.x, thisbullet.pos.y, pos.x,pos.y) <= 125){
        thisbullet.boom();
      }
    }
    for(int A = AItanks.size()-1; A >= 0; A--){
      AItank AI = AItanks.get(A);
      if(dist(AI.pos.x, AI.pos.y, pos.x,pos.y) <= 125){
        removeAItank(AI);
      }
    }
    for(int P = players.size()-1; P >= 0; P--){
      player play = players.get(P);
      if(dist(play.pos.x, play.pos.y, pos.x,pos.y) <= 125){
        gameover();
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
