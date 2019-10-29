void drawgrid(){
  strokeWeight(1);
  stroke(#C94747,128);
  for(int i = gridspacing; i < width; i += gridspacing){
    line(i, 0, i, height);
  }
  for(int i = gridspacing; i < height; i += gridspacing){
    line(0, i, width, i);
  }
}

void highlightsquare(){
  noStroke();
  fill(255,0,0,100);
  if(mouseY < 580 && mouseY > 80){
    float highlightx = mouseX - mouseX % gridspacing;
    float highlighty = mouseY - mouseY % gridspacing;
    rect(highlightx,highlighty,gridspacing,gridspacing);
  }
}

void man1(int value, int maxval){
  strokeWeight(1);
  stroke(0);
  fill(255);
  rect(400,30,80,20,10,10,10,10);
  //fill(#C1EEFF,128);
  //rect(540,20,value*58/maxval+22,40,10,10,10,10);
  fill(#C1EEFF);
  rect(400,29,22,22);
  image(picon,400,29,22,22);
  fill(0);
  text(value + "/" + maxval, 430,45);
  //text("P",405,45);
}
void man2(int value, int maxval){
  strokeWeight(1);
  stroke(0);
  fill(255);
  rect(500,30,80,20,10,10,10,10);
  //fill(#C1EEFF,128);
  //rect(640,10,value*58/maxval+22,20,10,10,10,10);
  fill(#C1EEFF);
  rect(500,29,22,22);
  image(dicon,500,29,22,22);
  fill(0);
  text(value + "/" + maxval, 530,45);
  //text("D",505,45);
}
void man3(int value, int maxval){
  strokeWeight(1);
  stroke(0);
  fill(255);
  rect(600,30,80,20,10,10,10,10);
  //fill(#C1EEFF,128);
  //rect(740,10,value*58/maxval+22,20,10,10,10,10);
  fill(#C1EEFF);
  rect(600,29,22,22);
  image(bicon, 600,29,22,22);
  fill(0);
  text(value + "/" + maxval, 630,45);
  //text("B",605,45);
}
void man4(int value, int maxval){
  strokeWeight(1);
  stroke(0);
  fill(255);
  rect(700,30,80,20,10,10,10,10);
  //fill(#C1EEFF,128);
  //rect(840,10,value*58/maxval+22,20,10,10,10,10);
  fill(#C1EEFF);
  rect(700,29,22,22);
  image(ticon,700,29,22,22);
  fill(0);
  text(value + "/" + maxval, 730,45);
  //text("T",705,45);
}
void man5(int value, int maxval){
  strokeWeight(1);
  stroke(0);
  fill(255);
  rect(800,30,80,20,10,10,10,10);
  //fill(#C1EEFF,128);
  //rect(940,10,value*58/maxval+22,20,10,10,10,10);
  fill(#C1EEFF);
  rect(800,29,22,22);
  fill(0);
  text(value + "/" + maxval, 830,45);
  text("M",805,45);
}

void heartbar(){
}

void lungbar(){
}

void oxybar(int value, int predvalue, int maxval){
  strokeWeight(1);
  stroke(0);
  fill(255);
  rect(10,10,200,20,10,10,10,10);
  fill(255,0,0);
  rect(10,10,(value+predvalue)*180/maxval+20,20,10,10,10,10);
  fill(#C1EEFF,200);
  rect(10,10,value*180/maxval+20,20,10,10,10,10);
  fill(0);
  text(value + "(" + (value + predoxygen(boi3)) + ")" + "/" + maxval, 40,25);
  fill(#C1EEFF);
  ellipse(20,20,30,30);
  image(Iconoxy, 5, 5, 31, 31); 
}

void glubar(int value, int predvalue, int maxval){
  strokeWeight(1);
  stroke(0);
  fill(255);
  rect(10,50,200,20,10,10,10,10);
  fill(255,0,0);
  rect(10,50,(value+predvalue)*180/maxval+20,20,10,10,10,10);
  fill(#FAE05D,128);
  rect(10,50,value*180/maxval+20,20,10,10,10,10);
  fill(0);
  text(value + "(" + (value + predglucose(boi3)) + ")" + "/" + maxval, 40,65);
  fill(#FAE05D);
  ellipse(20,60,30,30);
  image(Iconglu, 5, 45, 30, 30); 
}

void deletebox(){
  noFill();
  strokeWeight(1);
  stroke(0);
  rect(1200, 600,60,80,10,10,10,10);
  image(Toiletimg, 1200,600,60,80);
}

void displayboi1(float x, float y){
  fill(#C1EEFF);
  strokeWeight(1);
  stroke(0);
  rect(x-5,y-5,10,10);
}

void displayboi2(float x, float y){
  fill(#FAE05D);
  strokeWeight(1);
  stroke(0);
  ellipse(x,y,10,10);
}

void displayboi3(float x, float y){
  fill(#674207);
  strokeWeight(1);
  stroke(0);
  rect(x-7,y-7,14,14);
}

void displaycell0(float x, float y){
  textAlign(CENTER, CENTER);
  fill(0);
  image(picon, x-10, y-10, 20,20);
  textAlign(BASELINE);
  
}

void displaycell1(float x, float y){
  textAlign(CENTER, CENTER);
  fill(0);
  image(dicon, x-10, y-10, 20,20);
  textAlign(BASELINE);
}

void displaycell2(float x, float y){
  textAlign(CENTER, CENTER);
  fill(0);
  image(bicon, x-10, y-10, 20,20);
  textAlign(BASELINE);
}

void displaycell3(float x, float y){
  textAlign(CENTER, CENTER);
  fill(0);
  image(ticon, x-10, y-10, 20,20);
  textAlign(BASELINE);
}

void displaybact(float x, float y, String type){
  switch(type){
    case "Staphylococcus":
      image(sta,x-10,y-10,20,20);
      break;
    case "Tuberculosis":
      image(tb,x-10,y-10,20,20);
      break;
    case "Streptococcus":
      image(str,x-10,y-10,20,20);
      break;
    case "EColi":
      image(ec,x-10,y-10,20,20);
      break;
  }
}

void displayvirus(float x, float y, String type){
  fill(0);
  switch(type){
    case "Common Cold":
      image(cc,x-10,y-10,20,20);
      break;
    case "Hepatitis A":
      image(ha,x-10,y-10,20,20);
      break;
    case "Influenza":
      image(flu,x-10,y-10,20,20);
      break;
    case "Ebola":
      image(eb,x-10,y-10,20,20);
      break;
  }
}

void showorgans(){
  fill(#EA3434,120);
  noStroke();
  for(PVector position: heartcoor){
    rect(position.x-gridspacing/2,position.y-gridspacing/2,gridspacing,gridspacing);
  }
  for(PVector position: lungcoor){
    rect(position.x-gridspacing/2,position.y-gridspacing/2,gridspacing,gridspacing);
  }
  for(PVector position: livercoor){
    rect(position.x-gridspacing/2,position.y-gridspacing/2,gridspacing,gridspacing);
  }
  fill(#A7E1FF,120);
  for(PVector position: oxfield){
    rect(position.x-gridspacing/2,position.y-gridspacing/2,gridspacing,gridspacing);
  }
  fill(#FFE693 ,120);
  for(PVector position: glufield){
    rect(position.x-gridspacing/2,position.y-gridspacing/2,gridspacing,gridspacing);
  }
  image(Heartimg, 730, 350,100,100); 
  image(Liverimg, 345, 350,100,100); 
  image(Lungsimg, 560, 160,100,100); 
}

void lunggrid(){
  lungcoor.add(new PVector(590,170));
  lungcoor.add(new PVector(610,170));
  lungcoor.add(new PVector(630,170));
  lungcoor.add(new PVector(570,190));
  lungcoor.add(new PVector(590,190));
  lungcoor.add(new PVector(610,190));
  lungcoor.add(new PVector(630,190));
  lungcoor.add(new PVector(650,190));
  lungcoor.add(new PVector(570,210));
  lungcoor.add(new PVector(590,210));
  lungcoor.add(new PVector(610,210));
  lungcoor.add(new PVector(630,210));
  lungcoor.add(new PVector(650,210));
  lungcoor.add(new PVector(570,230));
  lungcoor.add(new PVector(590,230));
  lungcoor.add(new PVector(610,230));
  lungcoor.add(new PVector(630,230));
  lungcoor.add(new PVector(650,230));
  lungcoor.add(new PVector(570,250));
  lungcoor.add(new PVector(590,250));
  lungcoor.add(new PVector(630,250));
  lungcoor.add(new PVector(650,250));
  
}
void heartgrid(){
  heartcoor.add(new PVector(770,350));
  heartcoor.add(new PVector(790,350));
  heartcoor.add(new PVector(750,370));
  heartcoor.add(new PVector(770,370));
  heartcoor.add(new PVector(790,370));
  heartcoor.add(new PVector(810,370));
  heartcoor.add(new PVector(750,390));
  heartcoor.add(new PVector(770,390));
  heartcoor.add(new PVector(790,390));
  heartcoor.add(new PVector(810,390));
  heartcoor.add(new PVector(750,410));
  heartcoor.add(new PVector(770,410));
  heartcoor.add(new PVector(790,410));
  heartcoor.add(new PVector(810,410));
  heartcoor.add(new PVector(750,430));
  heartcoor.add(new PVector(770,430));
  heartcoor.add(new PVector(790,430));
  heartcoor.add(new PVector(810,430));
  heartcoor.add(new PVector(770,450));
  heartcoor.add(new PVector(790,450));
  
}
void livergrid(){
  livercoor.add(new PVector(350,370));
  livercoor.add(new PVector(370,370));
  livercoor.add(new PVector(390,370));
  livercoor.add(new PVector(410,370));
  livercoor.add(new PVector(430,370));
  livercoor.add(new PVector(450,370));
  livercoor.add(new PVector(350,390));
  livercoor.add(new PVector(370,390));
  livercoor.add(new PVector(390,390));
  livercoor.add(new PVector(410,390));
  livercoor.add(new PVector(430,390));
  livercoor.add(new PVector(350,410));
  livercoor.add(new PVector(370,410));
  livercoor.add(new PVector(390,410));
  livercoor.add(new PVector(410,410));
  livercoor.add(new PVector(350,430));
  livercoor.add(new PVector(370,430));
  livercoor.add(new PVector(390,430));
  
}

void oxfieldgrid(){
  oxfield.add(new PVector(550,150));
  oxfield.add(new PVector(530,170));
  oxfield.add(new PVector(530,190));
  oxfield.add(new PVector(510,190));
  oxfield.add(new PVector(530,210));
  oxfield.add(new PVector(510,210));
  oxfield.add(new PVector(510,230));
  oxfield.add(new PVector(490,230));
  oxfield.add(new PVector(490,210));
  oxfield.add(new PVector(710,290));
  oxfield.add(new PVector(710,270));
  oxfield.add(new PVector(730,270));
  oxfield.add(new PVector(730,250));
  oxfield.add(new PVector(710,250));
  oxfield.add(new PVector(730,230));
  oxfield.add(new PVector(750,210));
  
}

void glufieldgrid(){
  glufield.add(new PVector(530,370));
  glufield.add(new PVector(510,390));
  glufield.add(new PVector(530,390));
  glufield.add(new PVector(510,410));
  glufield.add(new PVector(530,410));
  glufield.add(new PVector(530,430));
  glufield.add(new PVector(550,430));
  glufield.add(new PVector(550,450));
  glufield.add(new PVector(550,390));
  glufield.add(new PVector(570,370));
  glufield.add(new PVector(590,370));
  glufield.add(new PVector(570,390));
  glufield.add(new PVector(530,450));
  glufield.add(new PVector(510,450));
  glufield.add(new PVector(510,470));
  glufield.add(new PVector(490,410));
}
