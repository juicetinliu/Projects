boolean displaybeingmenu = false;

void beingbutton(float x, float y){
  pushMatrix();
  translate(x,y);
  
  if(dist(mouseX,mouseY,x,y) < 10){
    fill(255,128);
    noStroke();
    ellipse(0,0,20,20);
    if(mousePressed){
      if(mouseclick){
        displaybeingmenu = !displaybeingmenu;
        selectedbeing = false;
        selectedbless = false;
        mouseclick = false;
      }
    }else{
      mouseclick = true;
    }
  }
  
  stroke(255);
  noFill();
  ellipse(0,0,20,20);
  line(0,-5,6,0);
  line(0,5,6,0);
  arc(0,0,10,10,PI/2,3*PI/2,OPEN);
  popMatrix();
}

void displaybeingmenu(){
  rectMode(CORNER);
  fill(255);
  noStroke();
  rect(250,600,600,150);
  fill(0);
  rect(251,601,598,148);
  
  optionbeing(310,675,70,100,0);
  optionbeing(405,675,70,100,1);
  if(selectedbeing){
    pushMatrix();
    translate(mouseX, mouseY);
    noStroke();
    fill(255,200);
    triangle(0,-3,0,3,5,0);
    arc(0,0,6,6,PI/2,3*PI/2);
    popMatrix();
  }else if(selectedbless){
    pushMatrix();
    translate(mouseX, mouseY);
    fill(255,255,0,125);
    noStroke();
    ellipse(0,0,100,100);
    noStroke();
    fill(255,255,0,200);
    triangle(0,-3,0,3,5,0);
    arc(0,0,6,6,PI/2,3*PI/2);
    popMatrix();
  }
}

void optionbeing(float x, float y, float w, float h, int type){
  pushMatrix();
  translate(x,y);
  
  if(mouseX > x - w/2 && mouseX < x + w/2 && mouseY < y + h/2 && mouseY > y - h/2){
    //selectedbeing = false;
    //selectedbless = false;
    fill(255,128);
    noStroke();
    rectMode(CENTER);
    rect(0,0,w,h);
    if(mousePressed){
      if(mouseclick){
        if(type == 0){
          selectedbeing = !selectedbeing;
          selectedbless = false;
        }else if(type == 1){
          selectedbless = !selectedbless;
          selectedbeing = false;
        }
        mouseclick = false;
      }
    }else{
      mouseclick = true;
    }
  }
  
  stroke(255);
  noFill();
  rectMode(CENTER);
  rect(0,0,w,h);
  if(type == 0){
    noStroke();
    fill(255,200);
    triangle(0,-5,0,5,6,0);
    arc(0,0,10,10,PI/2,3*PI/2);
  }else if(type == 1){
    fill(255,255,0,125);
    noStroke();
    ellipse(0,0,50,50);
    noStroke();
    fill(255,255,0,200);
    triangle(0,-5,0,5,6,0);
    arc(0,0,10,10,PI/2,3*PI/2);
  }
  
    stroke(255);
    noFill();
    rectMode(CENTER);
  if(selectedbeing && type == 0){
    rect(0,0,w+5,h+5);
  }else if(selectedbless && type == 1){
    rect(0,0,w+5,h+5);
  }
  
  popMatrix();
}
