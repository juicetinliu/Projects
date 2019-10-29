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

void gameover(){
  
}
