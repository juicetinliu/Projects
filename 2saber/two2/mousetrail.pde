float mouseeffect(){
  for(int i = 0; i < mousetrail.length-1; i++){
    mousetrail[i] = mousetrail[i+1];
  }
  mousetrail[4] = new PVector(mouseX, mouseY);
  int trailweight = 1;
  
  for(int j = 0; j < mousetrail.length-1; j++){
    strokeWeight(trailweight);
    stroke(255);
    line(mousetrail[j].x, mousetrail[j].y, mousetrail[j+1].x, mousetrail[j+1].y);
    trailweight += 1;
  }
  noFill();
  strokeWeight(1);
  ellipse(mouseX,mouseY,50,50);
  return dist(pmouseX, pmouseY, mouseX, mouseY);
  
}
