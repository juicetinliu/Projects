class bleh{
  float x,y;
  float dir;
  float speed;
  char state; //0 - wandering || 1 - pursue ||
  int life, maxlife;
  boolean die = false;
  
  bleh(float x, float y, float dir){
    this.x = x;
    this.y = y;
    this.dir = dir;
    this.speed = 0.5+speeddata*0.1;
    this.state = '0';
    maxlife = 40+int(lifedata)*10;
    this.life = maxlife;
  }
  
  void move(){
    switch(state){
      case '0':
        dir = (dir + radians(random(-10,10)))%(2*PI);
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
    stroke(255,0,0,map(life,0,maxlife,100,255));
    point(0,0);
    popMatrix();
  }
}
