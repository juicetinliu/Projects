void hud(){
  fill(255);
  textAlign(LEFT, TOP);
  textSize(12);
  text(frameRate,width-75,10);
  text(infectedcounter,width/2,10);
  databox(databox1x,databox1y, 20, color(255,0,0), "Life", data1);
  databox(databox2x,databox2y, 20, color(255,0,0), "Speed", data2);
}

void databox(float x, float y, int maxdata, color thisc, String dataname, int thisdata){
  //noFill();
  fill(0);
  strokeWeight(1);
  stroke(thisc);
  rect(x,y,400,150);
  
  if(mouseX > x+25 && mouseX < x+75 && mouseY > y+25 && mouseY < y+75){
    fill(thisc);
  }else{
    noFill();
  }
  rect(x+25,y+25,50,50);
  if(mouseX > x+325 && mouseX < x+375 && mouseY > y+25 && mouseY < y+75){
    fill(thisc);
  }else{
    noFill();
  }
  rect(x+325,y+25,50,50);
  
  fill(thisc);
  textAlign(CENTER, CENTER);
  textSize(26);
  text(dataname, x+200, y+50);
  
  for(int i = 0; i < maxdata; i++){
    if(i < thisdata){
      fill(thisc);
    }else{
      noFill();
    }
    rect(x+25+i*360/maxdata, y+110, 10, 20);
  }
}
