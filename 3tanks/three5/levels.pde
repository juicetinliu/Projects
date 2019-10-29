void createlevel(int level){
  for(int i = 1; i <= 24; i++){
    walls.add(new wall(new PVector(i*50,50), 0, 50, color(#CB941B)));
    walls.add(new wall(new PVector(i*50,750), 0, 50, color(#CB941B))); 
  }
  for(int i = 2; i < 15; i++){
    walls.add(new wall(new PVector(50,i*50), 0, 50, color(#CB941B)));
    walls.add(new wall(new PVector(1200,i*50), 0, 50, color(#CB941B))); 
  }
  switch(level){
    case 1:
      players.add(new player(new Vec2(200, height/2), new PVector(1,0), p1mxspeed, p1accel, 1, color(255,0,0), p1fric, p1tlen));
      AItanks.add(new AItank(new Vec2(1050, height/2), new PVector(1,0), p1mxspeed, p1accel, 1, color(255,0,0), p1fric, p1tlen));
      for(int i = 5; i < 12; i++){
         if(i <= 9 && i >= 7){
           walls.add(new wall(new PVector(800,i*50), 1, 50, color(#FAB08D)));
         }else{
           walls.add(new wall(new PVector(800,i*50), 0, 50, color(#CB941B)));
         }
      }
      for(int i = 5; i < 7; i++){
         walls.add(new wall(new PVector(400,i*50), 0, 50, color(#CB941B)));
         walls.add(new wall(new PVector(400,250+i*50), 0, 50, color(#CB941B)));
      }
      break;
    case 2:
      players.add(new player(new Vec2(200, height/2), new PVector(1,0), p1mxspeed, p1accel, 1, color(255,0,0), p1fric, p1tlen));
      AItanks.add(new AItank(new Vec2(1050, 300), new PVector(1,0), p1mxspeed, p1accel, 1, color(255,0,0), p1fric, p1tlen));
      for(int i = 5; i < 12; i++){
         for(int j = 5; j < 17; j++){ 
           walls.add(new wall(new PVector(j*50,i*50), 1, 50, color(#FAB08D)));
         }
      }
      break;
    case 3:
      break;
    default:
      for(int i = 1; i <= 24; i++){
        walls.add(new wall(new PVector(i*50,50), 0, 50, color(#CB941B)));
        walls.add(new wall(new PVector(i*50,750), 0, 50, color(#CB941B))); 
      }
      for(int i = 2; i < 15; i++){
        walls.add(new wall(new PVector(50,i*50), 0, 50, color(#CB941B)));
        walls.add(new wall(new PVector(1200,i*50), 0, 50, color(#CB941B))); 
      }
      break;
  }
}

boolean checklevel(){
  if(AItanks.size() == 0){
    return true;
  }else{
    return false;
  }
}

int generatenextlevel(int thislevel){
  clearall();
  thislevel++;
  createlevel(thislevel);
  return thislevel;
}

void clearall(){
  for(int p = players.size()-1; p >= 0; p--){
    player play = players.get(p);
    removeplayertank(play);
  }
  for(int m = mines.size()-1; m >= 0; m--){
    mines.remove(m);
  }
  for(int w = walls.size()-1; w >= 0; w--){
    wall wal = walls.get(w);
    removewall(wal);
  }
  for(int b = bullets.size()-1; b >= 0; b--){
    bullet bull = bullets.get(b);
    removebullet(bull);
  }
}


void gameover(){
  exit();
}
