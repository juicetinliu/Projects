boolean segsegsect(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4){
  float den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
  if (den != 0){
    float t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / den;
    float u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / den;
    if (u >= 0 && u <= 1 && t >= 0 && t <= 1){
      stroke(255,0,0);
      strokeWeight(4);
      line(x1,y1,x2,y2);
      line(x3,y3,x4,y4);
      return true;
    }else{
      return false;
    }
  }else{
    return false;
  }
}

boolean segrectsect(float segx1, float segy1, float segx2, float segy2, float rectcenterx, float rectcentery, float rectang, float rectw, float recth){
  PVector rectpoint1 = new PVector(rectw/2,recth/2);
  PVector rectpoint2 = new PVector(rectw/2,-recth/2);
  PVector rectpoint3 = new PVector(-rectw/2,recth/2);
  PVector rectpoint4 = new PVector(-rectw/2,-recth/2);
  rectpoint1.rotate(rectang).add(rectcenterx,rectcentery);
  rectpoint2.rotate(rectang).add(rectcenterx,rectcentery);
  rectpoint3.rotate(rectang).add(rectcenterx,rectcentery);
  rectpoint4.rotate(rectang).add(rectcenterx,rectcentery);
  if(segsegsect(segx1,segy1,segx2,segy2,rectpoint1.x,rectpoint1.y,rectpoint2.x,rectpoint2.y)){
      return true;
  }else if(segsegsect(segx1,segy1,segx2,segy2,rectpoint2.x,rectpoint2.y,rectpoint4.x,rectpoint4.y)){
      return true;
  }else if(segsegsect(segx1,segy1,segx2,segy2,rectpoint4.x,rectpoint4.y,rectpoint3.x,rectpoint3.y)){
      return true;
  }else if(segsegsect(segx1,segy1,segx2,segy2,rectpoint3.x,rectpoint3.y,rectpoint1.x,rectpoint1.y)){
      return true;
  }else{
    return false;
  }
}

boolean rectrectsect(float rect1centerx, float rect1centery, float rect1ang, float rect1w, float rect1h, float rect2centerx, float rect2centery, float rect2ang, float rect2w, float rect2h){
  PVector rectpoint1 = new PVector(rect2w/2,rect2h/2);
  PVector rectpoint2 = new PVector(rect2w/2,-rect2h/2);
  PVector rectpoint3 = new PVector(-rect2w/2,rect2h/2);
  PVector rectpoint4 = new PVector(-rect2w/2,-rect2h/2);
  rectpoint1.rotate(rect2ang).add(rect2centerx,rect2centery);
  rectpoint2.rotate(rect2ang).add(rect2centerx,rect2centery);
  rectpoint3.rotate(rect2ang).add(rect2centerx,rect2centery);
  rectpoint4.rotate(rect2ang).add(rect2centerx,rect2centery);
  if(segrectsect(rectpoint1.x,rectpoint1.y,rectpoint2.x,rectpoint2.y,rect1centerx,rect1centery,rect1ang,rect1w,rect1h)){
      return true;
  }else if(segrectsect(rectpoint2.x,rectpoint2.y,rectpoint4.x,rectpoint4.y,rect1centerx,rect1centery,rect1ang,rect1w,rect1h)){
      return true;
  }else if(segrectsect(rectpoint4.x,rectpoint4.y,rectpoint3.x,rectpoint3.y,rect1centerx,rect1centery,rect1ang,rect1w,rect1h)){
      return true;
  }else if(segrectsect(rectpoint3.x,rectpoint3.y,rectpoint1.x,rectpoint1.y,rect1centerx,rect1centery,rect1ang,rect1w,rect1h)){
      return true;
  }else{
    return false;
  }
}

int tankwallsect(float rect1centerx, float rect1centery, float rect1ang, float rect1w, float rect1h, float rect2centerx, float rect2centery, float rect2ang, float rect2w, float rect2h){
  int ret = 0;
  PVector rectpoint1 = new PVector(rect2w/2,rect2h/2);
  PVector rectpoint2 = new PVector(rect2w/2,-rect2h/2);
  PVector rectpoint3 = new PVector(-rect2w/2,rect2h/2);
  PVector rectpoint4 = new PVector(-rect2w/2,-rect2h/2);
  rectpoint1.rotate(rect2ang).add(rect2centerx,rect2centery);
  rectpoint2.rotate(rect2ang).add(rect2centerx,rect2centery);
  rectpoint3.rotate(rect2ang).add(rect2centerx,rect2centery);
  rectpoint4.rotate(rect2ang).add(rect2centerx,rect2centery);
  if(segrectsect(rectpoint1.x,rectpoint1.y,rectpoint2.x,rectpoint2.y,rect1centerx,rect1centery,rect1ang,rect1w,rect1h)){
      ret = ret + 1;
  }
  if(segrectsect(rectpoint2.x,rectpoint2.y,rectpoint4.x,rectpoint4.y,rect1centerx,rect1centery,rect1ang,rect1w,rect1h)){
      ret = ret + 8;
  }
  if(segrectsect(rectpoint4.x,rectpoint4.y,rectpoint3.x,rectpoint3.y,rect1centerx,rect1centery,rect1ang,rect1w,rect1h)){
      ret = ret + 4;
  }
  if(segrectsect(rectpoint3.x,rectpoint3.y,rectpoint1.x,rectpoint1.y,rect1centerx,rect1centery,rect1ang,rect1w,rect1h)){
      ret = ret + 2;
  }
  
  return ret;
}
