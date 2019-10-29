void hud(){
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(12);
  text(int(mousespeed), width/2, 20);
  
  fill(255);
  textAlign(LEFT, CENTER);
  textSize(12);
  text("FPS: " + int(frameRate),40,20);
  
  visualbutton(20,20);
}
