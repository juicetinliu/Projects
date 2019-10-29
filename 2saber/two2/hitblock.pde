class hitblock{
  float x, y;
  float angle;
  float size;
  int boundingcircle = 2000;
  color blockcolor = color(255,0,0);
  float impactangle, impactspeed, impactpointx, impactpointy;
  boolean begindestruction = false, destroyed = false;
  int destroytimer = 0;
  float minspeed = 5;
  
  hitblock(float x, float y, float angle, float size){
    this.x = x;
    this.y = y;
    this.angle = angle;
    this.size = size;
  }
  
  void display(){
    if(begindestruction){
      destroytimer += 1;
      fill(255,map(destroytimer,0,100,255,0));
      textAlign(CENTER, CENTER);
      textSize(map(impactspeed,10,250,12,40));
      text(int(impactspeed),x,y);
      
      if(visualon){
        noFill();
        stroke(255,0,0);
        strokeWeight(3);
        ellipse(impactpointx, impactpointy, 10,10);
        ellipse(x,y,sqrt(2*size*size),sqrt(2*size*size));
        
        strokeWeight(2);
        stroke(255,50);
        fill(blockcolor,50);
        pushMatrix();
        translate(x,y);
        rotate(angle);
        rectMode(CENTER);
        rect(0,0,size,size,size/10,size/10,size/10,size/10);
        fill(255,50);
        triangle((5*size-size)/10,(5*size-size)/10,size/10,0,(5*size-size)/10,(size-5*size)/10);
        popMatrix();
      }
      
      strokeWeight(map(impactspeed,10,250,2,20));
      stroke(255,map(destroytimer,0,100,255,0));
      noFill();
      //ellipse(x,y,destroytimer*destroytimer/10,destroytimer*destroytimer/10);
      float spreed = 1000;
      float sprad = map(spreed - spreed/destroytimer, 0,spreed,0,map(impactspeed,10,250,100,1000));
      ellipse(x,y,sprad,sprad);
      if(destroytimer >= 100){
        destroyed = true;
      }
    }else{
      strokeWeight(2);
      stroke(255);
      fill(blockcolor,150);
      pushMatrix();
      translate(x,y);
      rotate(angle);
      rectMode(CENTER);
      rect(0,0,size,size,size/10,size/10,size/10,size/10);
      fill(255,158);
      triangle((5*size-size)/10,(5*size-size)/10,size/10,0,(5*size-size)/10,(size-5*size)/10);
      popMatrix();
      if(visualon){
        ellipse(x-boundingcircle*cos(angle),y-boundingcircle*sin(angle),boundingcircle*2+size,boundingcircle*2+size);
      }    
    }
  }
  
  void destroy(){
    begindestruction = true;
  }
    
  boolean hitv2(){
    impactangle = atan2(mouseY-pmouseY,mouseX-pmouseX) + PI;
    
    //impactpoint
    if(mouseX == pmouseX && mouseY == pmouseY){
      return false;
    }else{
      if(dist(mouseX,mouseY,x-boundingcircle*cos(angle),y-boundingcircle*sin(angle)) < boundingcircle+size/2 && mousespeed > minspeed && dist(pmouseX,pmouseY,x-boundingcircle*cos(angle),y-boundingcircle*sin(angle)) > boundingcircle+size/2){
        if(angle >= radians(330)){
          if(impactangle > angle - radians(30) || impactangle < angle - radians(300)){
            if(cutvalid(mouseX,mouseY,pmouseX,pmouseY)){
              impactspeed = mousespeed;
              return true;
            }else{
              return false;
            }
          }else{
            return false;
          }
        }else if(angle <= radians(30)){
          if(impactangle > angle + radians(300) || impactangle < angle + radians(30)){
            if(cutvalid(mouseX,mouseY,pmouseX,pmouseY)){
              impactspeed = mousespeed;
              return true;
            }else{
              return false;
            }
          }else{
            return false;
          }
        }else{
          if(impactangle > angle - radians(30) && impactangle < angle + radians(30)){
            if(cutvalid(mouseX,mouseY,pmouseX,pmouseY)){
              impactspeed = mousespeed;
              return true;
            }else{
              return false;
            }
          }else{
            return false;
          }
        }
      }else{
        return false;
      }
    }
  }
  
  boolean cutvalid(float x1, float y1, float x2, float y2){
    float x3 = x + size*(sin(angle) + cos(angle))/2;
    float y3 = y + size*(sin(angle) - cos(angle))/2;
    float x4 = x - size*(sin(angle) - cos(angle))/2;
    float y4 = y + size*(sin(angle) + cos(angle))/2;
    if(visualon){
      noStroke();
      fill(255,0,0);
      ellipse(x3, y3, 10,10);
      ellipse(x4, y4, 10,10);
    }
    float d = ((x1-x2)*(y3-y4)-(y1-y2)*(x3-x4));
    float t = ((x1-x3)*(y3-y4)-(y1-y3)*(x3-x4))/d;
    //float u = -((x1-x2)*(y1-y3)-(y1-y2)*(x1-x3))/d;
    if(t >= 0 && t <= 1){
      impactpointx = x1 + t*(x2-x1);
      impactpointy = y1 + t*(y2-y1);
      if(visualon){
        noFill();
        stroke(255,0,0);
        strokeWeight(3);
        ellipse(impactpointx, impactpointy, 10,10);
        ellipse(x,y,sqrt(2*size*size),sqrt(2*size*size));
      }
      if(dist(impactpointx,impactpointy,x,y) <= sqrt(2*size*size)/2){
        return true;
      }else{
        return false;
      }
    }else{
      return false;
    }
  }
  
  //boolean hit(){
  //  impactangle = atan2(mouseY-pmouseY,mouseX-pmouseX) + PI;
    
  //  //impactpoint
  //  if(mouseX == pmouseX && mouseY == pmouseY){
  //    return false;
  //  }else{
  //    if(dist(mouseX,mouseY,x,y) < size/2 && mousespeed > 10 && dist(pmouseX,pmouseY,x,y) > size/2){
  //      if(angle >= radians(330)){
  //        if(impactangle > angle - radians(30) || impactangle < angle - radians(300)){
  //          impactspeed = mousespeed;
  //          return true;
  //        }else{
  //          return false;
  //        }
  //      }else if(angle <= radians(30)){
  //        if(impactangle > angle + radians(300) || impactangle < angle + radians(30)){
  //          impactspeed = mousespeed;
  //          return true;
  //        }else{
  //          return false;
  //        }
  //      }else{
  //        if(impactangle > angle - radians(30) && impactangle < angle + radians(30)){
  //          impactspeed = mousespeed;
  //          return true;
  //        }else{
  //          return false;
  //        }
  //      }
  //    }else{
  //      return false;
  //    }
  //  }
  //}
  
}




  
//  boolean hitno(){
//    //if(mouseX < x + size/2 && mouseX > x - size/2 && mouseY < y + size/2 && mouseY > y - size/2){
//    //  float mouseang = atan2(mouseY-pmouseY,mouseX-pmouseX);
//    //  if(mouseY != pmouseY && mouseX != pmouseX && mouseang < PI + radians(30) && mouseang > PI - radians(30)){
//    //    stroke(255);
//    //    strokeWeight(3);
//    //    fill(255,128);
//    //    ellipse(mouseX,mouseY,50,50);
//    //    return true;
//    //  }else{
//    //    return false;
//    //  }
//    //}else{
//    //  return false;
//    //}
    
    
//    //if(mouseX == pmouseX && mouseY == pmouseY){
//    //  return false;
//    //}else{
      
      
//      float mouseang = atan2(mouseY-pmouseY,mouseX-pmouseX);
//      //text(mouseang, mouseX+10, mouseY+10);
//      if(hitangle == 0 || hitangle == PI/2 || hitangle == PI || hitangle == PI*3/2 ){
//        if(mouseX < x + size/2 && mouseX > x - size/2 && mouseY > y - size/2 && mouseY < y + size/2){
//        //  if(hitangle == 0){
//        //    if(pmouseX > x + size/2){
//        //      if(mouseang <= PI && mouseang > PI - radians(30) || mouseang >= -PI && mouseang < -PI + radians(30)){
//        //        return true;
//        //      }else{
//        //        return false;
//        //      }
//        //    }else{
//        //      return false;
//        //    }
//        //  }else if(hitangle == PI/2){
//        //    if(pmouseY > y + size/2){
//        //      if(mouseang <= -PI/2 + radians(30) && mouseang >= -PI/2 - radians(30)){
//        //        return true;
//        //      }else{
//        //        return false;
//        //      }
//        //    }else{
//        //      return false;
//        //    }
//        //  }else if(hitangle == PI){
//        //    if(pmouseX < x - size/2){
//        //      if(mouseang <= radians(30) && mouseang >= -radians(30)){
//        //        return true;
//        //      }else{
//        //        return false;
//        //      }
//        //    }else{
//        //      return false;
//        //    }
//        //  }else if(hitangle == PI*3/2){
//        //    if(pmouseY < y - size/2){
//        //      if(mouseang <= PI/2 + radians(30) && mouseang >= PI/2 - radians(30)){
//        //        return true;
//        //      }else{
//        //        return false;
//        //      }
//        //    }else{
//        //      return false;
//        //    }
//        //  }else{
//        //    return false;
//        //  }
//          return true;
//        }else{
//          return false;
//        }
//      }else{
//        hitangle = hitangle % PI;
//        if(mouseY < y-x*tan(hitangle)+mouseX*tan(hitangle) + size/(2*cos(hitangle)) && mouseY > y-x*tan(hitangle)+mouseX*tan(hitangle) - size/(2*cos(hitangle))){
//          //if(mouseY > x/tan(hitangle) + y - mouseX/tan(hitangle) - size/(2*sin(hitangle)) && mouseY < x/tan(hitangle) + y - mouseX/tan(hitangle) + size/(2*sin(hitangle))){
//          //if(pmouseX > x + size/2){
//          //  if(mouseang < PI && mouseang > PI - radians(30) || mouseang > -PI && mouseang < -PI + radians(30)){
//              return true;
//          //  }else{
//          //    return false;
//          //  }
//          //}else{
//          //  return false;
//          //}
//          //}else{
//          //  return false;
//          //}
//        }else{
//          return false;
//        }
//      }
//    //}
//  }
    
//}
