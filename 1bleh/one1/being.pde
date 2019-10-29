class being{
  float x,y;
  float dir;
  float speed;
  char state; //0 - wandering || 1 - rest || 2 - infected ||
  int counter;
  int nexttime;
  float size;
  boolean infected, beinghealed;
  int blessed;
  
  being(float x, float y, float dir, float speed, float size){
    this.x = x;
    this.y = y;
    this.dir = dir;
    this.speed = speed;
    this.state = '0';
    this.counter = 0;
    this.nexttime = int(random(50,200));
    this.infected = false;
    this.blessed = 0;
    this.size = size;
    this.beinghealed = false;
  }
  
  void move(){
    blesstimer();
    switch(state){
      case '0':
        dir = dir + ((random(1)>map(size,50,5,0.1,0.9)) ? 0 : radians(random(-15,15))%(2*PI));
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
        
      case '2':
        counter += 1;
        if(counter >= nexttime){
          for(int bl = 0; bl < blehsdata; bl++){
            blehs.add(new bleh(this.x, this.y, dir));
          }
          state = '3';
        }
        break;
        
      case '3':
        //dead
        break;
        
      default:
        state = '0';
        break;
    }
    //fill(255);
    //text(state,500,20);
  }
  
  void blesstimer(){
    if(blessed > 0){
      blessed -= 1;
    }
  }
  
  void infect(ArrayList<bleh> blehs){
    if(!infected && blessed == 0){
      for(int b = blehs.size() - 1; b >= 0; b--){
        bleh thisbleh = blehs.get(b);
        if(dist(thisbleh.x, thisbleh.y, this.x, this.y) < size/2){
          beinghealed = false;
          blehs.remove(b);
          state = '2';
          nexttime = 50;
          counter = 0;
          infected = true;
          break;
        }
      }
    }
  }

  
  void display(){
    pushMatrix();
    translate(x,y);
    rotate(dir);
    
    if(state == '2' || state == '3'){
      noStroke();
      fill(255,128);
      ellipse(0,0,size,size);
      fill(255,0,0,128);
      ellipse(0,0,size-1,size-1);
    }else{
      if(blessed > 0){
        noStroke();
        fill(255,255,0);
        triangle(0,-size*4/5,0,size*4/5,size*6/5,0);
        arc(0,0,size*8/5,size*8/5,PI/2,3*PI/2);
      }
      //stroke(255);
      //line(0,0,5,0);
      noStroke();
      fill(255,200);
      triangle(0,-size*3/5,0,size*3/5,size,0);
      arc(0,0,size*6/5,size*6/5,PI/2,3*PI/2);
    }
    
    popMatrix();
  }
}
