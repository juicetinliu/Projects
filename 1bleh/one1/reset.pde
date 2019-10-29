void reset(){
  for(being them: beings){
    them.state = 0;
    them.infected = false;
  }
  for(int h = blehs.size() - 1; h >= 0; h--){
      blehs.remove(h);
  }
  infpop.clear();
  for(int p = 0; p < maxsamples; p++){
    infpop.append(0);
  }
}

void resetbutton(float x, float y){
  pushMatrix();
  translate(x,y);
  rotate(-PI/4);
  
  if(dist(mouseX,mouseY,x,y) < 10){
    fill(255,128);
    noStroke();
    ellipse(0,0,20,20);
    if(mousePressed){
      if(mouseclick){
        reset();
        mouseclick = false;
      }
    }else{
      mouseclick = true;
    }
  }
  
  stroke(255);
  noFill();
  ellipse(0,0,20,20);
  arc(0,0,10,10,0,PI*3/2);
  triangle(5,-3,3,0,7,0);
  popMatrix();
}
