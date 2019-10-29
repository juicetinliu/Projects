void visualbutton(float x, float y){
  pushMatrix();
  translate(x,y);
  
  if(dist(mouseX,mouseY,x,y) < 10){
    fill(255,128);
    noStroke();
    ellipse(0,0,20,20);
    if(mousePressed){
      if(mouseclick){
        visualon = !visualon;
        mouseclick = false;
      }
    }else{
      mouseclick = true;
    }
  }
  
  rectMode(CENTER);
  stroke(255);
  noFill();
  ellipse(0,0,20,20);
  rect(0,0,10,10);
  popMatrix();
}
