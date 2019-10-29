class being{
  float x,y;
  float dir;
  float speed;
  char state; //0 - wandering || 1 - rest || 2 - infected ||
  int counter;
  int nexttime;
  boolean infected;
  
  being(float x, float y, float dir, float speed){
    this.x = x;
    this.y = y;
    this.dir = dir;
    this.speed = speed;
    this.state = '0';
    this.counter = 0;
    this.nexttime = int(random(50,200));
    this.infected = false;
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
        
      case '2':
        counter += 1;
        if(counter >= nexttime){
          for(int bl = 0; bl < 10; bl++){
            blehs.add(new bleh(this.x, this.y, dir,1+float(data2)*0.1));
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
  
  void infect(ArrayList<bleh> blehs){
    if(!infected){
      for(int b = blehs.size() - 1; b >= 0; b--){
        bleh thisbleh = blehs.get(b);
        if(dist(thisbleh.x, thisbleh.y, this.x, this.y) < 5){
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
      stroke(255,128);
      fill(255,0,0,128);
    }else{
      stroke(255);
      line(0,0,5,0);
      fill(255);
    }
    ellipse(0,0,5,5);
    popMatrix();
  }
}
