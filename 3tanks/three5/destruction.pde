void removebullet(bullet bull){
  bull.killBody();
  if(bull.shooter == 0){
    p1bullnum--;
  }
  for(int B = bullets.size()-1; B >= 0; B--){
    if(bullets.get(B) == bull){
      bullets.remove(B);
    }
  }
}

void removeAItank(AItank AI){
  AI.killBody();
  for(int A = AItanks.size()-1; A >= 0; A--){
    if(AItanks.get(A) == AI){
      AItanks.remove(A);
    }
  }
}

void removeplayertank(player play){
  play.killBody();
  for(int P = players.size()-1; P >= 0; P--){
    if(players.get(P) == play){
      players.remove(P);
    }
  }
}

void removewall(wall wal){
  wal.killBody();
  for(int W = walls.size()-1; W >= 0; W--){
    if(walls.get(W) == wal){
      walls.remove(W);
    }
  }
}
