class bleh{
  float x,y;
  float dir;
  float speed;
  char state; //0 - wandering || 1 - pursue ||
  int life;
  boolean die = false;
  
  bleh(float x, float y, float dir, float speed){
    this.x = x;
    this.y = y;
    this.dir = dir;
    this.speed = speed;
    this.state = '0';
    this.life = 10+data1*10;
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
        
        life -= 1;
        if(life <= 0){
          die = true;
        }
        break;
        
      case '1':
        //dir = (dir + radians(random(-15,15)))%(2*PI);
        //x = x + speed*cos(dir);
        //y = y + speed*sin(dir);
        //life -= 1;
        //if(life <= 0){
        //  die = true;
        //}
        break;
      
      default:
        state = '0';
        break;
    }
  }
  
  void display(){
    pushMatrix();
    translate(x,y);
    stroke(255,0,0);
    point(0,0);
    popMatrix();
  }
}
