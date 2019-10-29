void hud(){
  fill(0);
  textAlign(LEFT, CENTER);
  textSize(12);
  text("FPS: " + int(frameRate),40,15);
  
  for(int gridx = 0; gridx < 24; gridx++){
    stroke(0,50);
    strokeWeight(1);
    noFill();
    
    int linex = gridx*50 + 25;
    line(linex, 0, linex, height);
  }
  for(int gridy = 0; gridy < 15; gridy++){
    int liney = gridy*50 + 25;
    line(0, liney, width, liney);
  }
}
