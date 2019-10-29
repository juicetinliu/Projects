class blessedbeing{
  float x,y;
  float dir;
  float speed;
  char state; //0 - wandering || 1 - rest || 2 - infected ||
  int counter;
  int nexttime;
  float size;
  float blessrad;
  boolean infected, blessed, healavailable;
  float healtargetx, healtargety;
  being healedbeing;
  
  blessedbeing(float x, float y, float dir, float speed, float size, float blessrad){
    this.x = x;
    this.y = y;
    this.dir = dir;
    this.speed = speed;
    this.state = '0';
    this.counter = 0;
    this.nexttime = int(random(50,200));
    //this.infected = false;
    this.size = size;
    this.blessrad = blessrad;
    this.healavailable = true;
  }
  
  void move(){
    switch(state){
      case '0':
        dir = (dir + radians(random(-15,15)))%(2*PI);
        x = x + speed*cos(dir);
        y = y + speed*sin(dir);
        
        if(x < 0){
          x = width;
        }else if(x > width){
          x = 0;
        }
        if(y > height){
          y = 0;
        }else if(y < 0){
          y = height;
        }
        
        counter += 1;
        if(counter >= nexttime){
          state = '1';
          nexttime = int(random(0,50));
          counter = 0;
        }
        break;
        
      case '1':
        counter += 1;
        if(counter >= nexttime){
          state = '0';
          nexttime = int(random(50,200));
          counter = 0;
        }
        break;
        
      //case '2':
      //  counter += 1;
      //  if(counter >= nexttime){
      //    for(int bl = 0; bl < 5+blehsdata; bl++){
      //      blehs.add(new bleh(this.x, this.y, dir));
      //    }
      //    state = '3';
      //  }
      //  break;
        
      //case '3':
      //  //dead
      //  break;
        
      case '4':
        counter += 1;
        fill(255,255,0,50);
        noStroke();
        ellipse(healtargetx, healtargety, 10,10);
        stroke(255,255,0,200);
        line(x,y,healtargetx,healtargety);
        dir = atan2(healtargety-y,healtargetx-x);
        if(counter >= nexttime){
          healedbeing.infected = false;
          healedbeing.state = '0';
          healedbeing.beinghealed = false;
          state = '0';
          nexttime = int(random(50,200));
          healavailable = true;
          counter = 0;
        }
        break;
      
      default:
        state = '0';
        break;
    }
    //fill(255);
    //text(state,500,20);
  }
  
  void bless(ArrayList<being> beings, ArrayList<bleh> blehs){
    for(int b = 0; b < beings.size(); b++){
      being thisbeing = beings.get(b);
      if(dist(x, y, thisbeing.x, thisbeing.y) < blessrad && thisbeing.state != '2' && thisbeing.state != '3'){
        thisbeing.blessed = 2;
      }else if(healavailable && !thisbeing.beinghealed && dist(x, y, thisbeing.x, thisbeing.y) < blessrad && (thisbeing.state == '2' || thisbeing.state == '3')){
        healedbeing = thisbeing;
        healtargetx = thisbeing.x;
        healtargety = thisbeing.y;
        thisbeing.beinghealed = true;
        healavailable = false;
        nexttime = int(random(190-(9.5*healsdata),200-(10*healsdata)));
        counter = 0;
        state = '4';
      }
    }
    for(int b = blehs.size() - 1; b >= 0; b--){
      bleh thisbleh = blehs.get(b);
      if(dist(x, y, thisbleh.x, thisbleh.y) < blessrad){
        blehs.remove(b);
        stroke(255,255,0);
        point(thisbleh.x, thisbleh.y);
        point(thisbleh.x+1, thisbleh.y);
        point(thisbleh.x-1, thisbleh.y);
        point(thisbleh.x, thisbleh.y+1);
        point(thisbleh.x, thisbleh.y-1);
      }
    }
  }
  
  //void resurrect(ArrayList<being> beings){
  //  for(int b = 0; b < beings.size(); b++){
  //    being thisbeing = beings.get(b);
  //    if(dist(x, y, thisbeing.x, thisbeing.y) < blessrad){
  //      thisbeing.blessed = 2;
  //    }
  //  }
  //}
  
  void display(){
    pushMatrix();
    translate(x,y);
    rotate(dir);
    
    fill(255,255,0,25);
    noStroke();
    
    //noFill();
    //stroke(255,255,0,50);
    //strokeWeight(1);
    ellipse(0,0,blessrad*2,blessrad*2);
  
    noStroke();
    fill(255,255,0);
    triangle(0,size*-3/5,0,size*3/5,size,0);
    arc(0,0,size*6/5,size*6/5,PI/2,3*PI/2);
    
    popMatrix();
  }
}
