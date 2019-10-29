int data1;
float databox1x, databox1y;
int data2;
float databox2x, databox2y;
float datalife = 0,dataspeed = 0, datapower = 0;
float datacircle1x, datacircle1y;
boolean mouseclick = true;

void setup(){
  fullScreen(OPENGL);
  pixelDensity(displayDensity());
  frameRate(60);
  smooth();
  databox1x = 10;
  databox1y = 10;
  databox2x = 10;
  databox2y = 210;
  datacircle1x = 500;
  datacircle1y = 500;
}

void draw(){
  background(0);
  if (mousePressed) {
    clip(mouseX, mouseY, 100, 100);
  } else {
    noClip();
  }
  //databox(databox1x,databox1y, 20, color(255,0,0), "Life", data1);
  //databox(databox2x,databox2y, 20, color(255,0,0), "Speed", data2);
  datalife = datacircle(datacircle1x, datacircle1y, 20, color(255,0,0), "Life", datalife);
  dataspeed = datacircle(300, 300, 40, color(0,255,255), "Speed", dataspeed);
  datapower = datacircle(700, 300, 30, color(255,0,255), "Power", datapower);
  
  float x = 300;
  float y = 400;
  pushMatrix();
  translate(x,y);
  rotate(-PI/4);
  stroke(255);
  noFill();
  ellipse(0,0,20,20);
  arc(0,0,10,10,0,PI*3/2);
  triangle(5,-3,3,0,7,0);
  popMatrix();
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

//void mousePressed() {
//  //if(mouseX > databox1x+25 && mouseX < databox1x+75 && mouseY > databox1y+25 && mouseY < databox1y+75){
//  //  datacircle -=1;
//  //}else if(mouseX > databox1x+325 && mouseX < databox1x+375 && mouseY > databox1y+25 && mouseY < databox1y+75){
//  //  datacircle +=1;
//  //}else if(mouseX > databox2x+25 && mouseX < databox2x+75 && mouseY > databox2y+25 && mouseY < databox2y+75){
//  //  data2 -=1;
//  //}else if(mouseX > databox2x+325 && mouseX < databox2x+375 && mouseY > databox2y+25 && mouseY < databox2y+75){
//  //  data2 +=1;
//  //}
//  //if(mouseX > datacircle1x-35 && mouseX < datacircle1x-25 && mouseY > datacircle1y-5 && mouseY < datacircle1y+5 && datacircle > 0){
//  //  datacircle -=1;
//  //}else if(mouseX > datacircle1x+25 && mouseX < datacircle1x+35 && mouseY > datacircle1y-5 && mouseY < datacircle1y+5 && datacircle < 20){
//  //  datacircle +=1;
//  //}
//}
