void createlevel(int level){
  switch(level){
    case 1:
      walls.add(new wall(new PVector(600,400), 0, 50, color(#CB941B)));
      for(int i = 1; i <= 24; i++){
        walls.add(new wall(new PVector(i*50,50), 0, 50, color(#CB941B)));
        walls.add(new wall(new PVector(i*50,750), 0, 50, color(#CB941B))); 
      }
      for(int i = 2; i < 15; i++){
        walls.add(new wall(new PVector(50,i*50), 0, 50, color(#CB941B)));
        walls.add(new wall(new PVector(1200,i*50), 0, 50, color(#CB941B))); 
      }
      break;
    case 2:
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
