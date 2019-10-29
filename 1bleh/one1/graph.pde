
//int[] pop = new int[500];

int maxsamples = 200;
int samplingperiod = 10;
int samplingtimer = 0;
boolean displaygraph = false;

void graph(){
  samplingtimer += 1;
  if(samplingtimer > 20){
    samplingtimer = 0;
    infpop.remove(0);
    infpop.append(infectedcounter);
  }
}

void displaygraph(){
  fill(255);
  noStroke();
  rect(250,50,400,300);
  fill(0);
  rect(251,51,398,298);
  
  noFill();
  stroke(255,0,0);
  beginShape();
  for(int p = 0; p < maxsamples; p++){
    int datap = infpop.get(p);
    //point(275+(p*350/maxsamples),map(datap,0,totalbeings,325,75));
    curveVertex(275+(p*350/maxsamples),map(datap,0,totalbeings,325,75));
  }
  endShape();
  
  stroke(255);
  line(275,75,275,325);
  line(275,325,625,325);
}

void graphbutton(float x, float y){
  pushMatrix();
  translate(x,y);
  
  if(dist(mouseX,mouseY,x,y) < 10){
    fill(255,128);
    noStroke();
    ellipse(0,0,20,20);
    if(mousePressed){
      if(mouseclick){
        displaygraph = !displaygraph;
        mouseclick = false;
      }
    }else{
      mouseclick = true;
    }
  }
  
  stroke(255);
  noFill();
  ellipse(0,0,20,20);
  line(-5,-5,-5,5);
  line(-5,5,5,5);
  line(-5,5,3,-3);
  popMatrix();
}
