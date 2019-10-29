boolean displayhud = false;

void hud(){
  fill(0);
  noStroke();
  rectMode(CORNER);
  rect(0,0,199,height);
  
  fill(255);
  textAlign(CENTER, TOP);
  textSize(12);
  text("FPS: " + int(frameRate),100,0);
  
  populationbar();
  
  fill(255);
  textAlign(RIGHT, CENTER);
  textSize(26);
  text(infectedcounter,90,730);
  textAlign(LEFT, CENTER);
  text("/"+totalbeings,90,730);
  
  graphbutton(180,45);
  
  resetbutton(180,15);
  
  beingbutton(180,775);
  
  stroke(255);
  line(200,0,200,height);
  lifedata = datacircle(100, 100, 20, color(0,255,100), "Life", lifedata);
  speeddata = datacircle(100, 275, 20, color(100,0,255), "Speed", speeddata);
  blehsdata = datacircle(100, 450, 20, color(255,0,0), "Blehs", blehsdata);
  healsdata = datacircle(100, 625, 20, color(255,255,0), "Heal", healsdata);
  //databox(databox1x,databox1y, 20, color(255,0,0), "Life", data1);
  //databox(databox2x,databox2y, 20, color(255,0,0), "Speed", data2);
  
  if(displaygraph){
    displaygraph();
  }
  if(displaybeingmenu){
    displaybeingmenu();
  }
}



float datacircle(float x, float y, float maxdata, color thisc, String dataname, float thisdata){
  fill(0);
  strokeWeight(1);
  stroke(thisc);
  ellipse(x,y,150,150);
  
  fill(thisc);
  noStroke();
  arc(x,y,150,150,PI*-0.5,PI*-0.5+(thisdata/maxdata)*2*PI,PIE);
  
  fill(0);
  strokeWeight(1);
  stroke(thisc);
  ellipse(x,y,100,100);
  
  fill(thisc,128);
  noStroke();
  if(mouseX > x-35 && mouseX < x-25 && mouseY > y-5 && mouseY < y+5 && thisdata > 0){
    //rect(x-35,y-5,10,10);
    ellipse(x-30,y,15,15);
    if(mousePressed){
      if(mouseclick){
        thisdata-=1;
        mouseclick = false;
      }
    }else{
      mouseclick = true;
    }
  }else if(mouseX > x+25 && mouseX < x+35 && mouseY > y-5 && mouseY < y+5 && thisdata < maxdata){
    //rect(x+25,y-5,10,10);
    ellipse(x+30,y,15,15);
    if(mousePressed){
      if(mouseclick){
        thisdata+=1;
        mouseclick = false;
      }
    }else{
      mouseclick = true;
    }
  }
  
  strokeWeight(1);
  stroke(thisc);
  line(x-25,y,x-35,y);
  line(x+25,y,x+35,y);
  line(x+30,y+5,x+30,y-5);
  
  fill(thisc);
  textAlign(CENTER, CENTER);
  textSize(26);
  text(int(thisdata), x, y);
  
  textSize(16);
  text(dataname,x,y-30);
  
  return thisdata;
}

void populationbar(){
  rectMode(CORNER);
  stroke(255);
  strokeWeight(1);
  //fill(255);
  noFill();
  rect(25,715,150,30);
  noStroke();
  fill(255,0,0);
  rect(25,715,map(infectedcounter,0,totalbeings,0,150),30);
}

//void databox(float x, float y, int maxdata, color thisc, String dataname, int thisdata){
//  //noFill();
//  fill(0);
//  strokeWeight(1);
//  stroke(thisc);
//  rect(x,y,400,150);
  
//  if(mouseX > x+25 && mouseX < x+75 && mouseY > y+25 && mouseY < y+75){
//    fill(thisc);
//  }else{
//    noFill();
//  }
//  rect(x+25,y+25,50,50);
//  if(mouseX > x+325 && mouseX < x+375 && mouseY > y+25 && mouseY < y+75){
//    fill(thisc);
//  }else{
//    noFill();
//  }
//  rect(x+325,y+25,50,50);
  
//  fill(thisc);
//  textAlign(CENTER, CENTER);
//  textSize(26);
//  text(dataname, x+200, y+50);
  
//  for(int i = 0; i < maxdata; i++){
//    if(i < thisdata){
//      fill(thisc);
//    }else{
//      noFill();
//    }
//    rect(x+25+i*360/maxdata, y+110, 10, 20);
//  }
//}

void hudbutton(float x, float y){
  pushMatrix();
  translate(x,y);
  
  if(dist(mouseX,mouseY,x,y) < 10){
    fill(255,128);
    noStroke();
    ellipse(0,0,20,20);
    if(mousePressed){
      if(mouseclick){
        displayhud = !displayhud;
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
  rect(0,0,8,6);
  popMatrix();
}
