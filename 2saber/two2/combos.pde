void combo(int type){
  switch(type){
    case 0:
      blox.add(new hitblock(width/2,height/2,radians(0),150));
      blox.add(new hitblock(width/2+200,height/2,radians(0),150));
      blox.add(new hitblock(width/2-200,height/2,radians(0),150));
      blox.add(new hitblock(width/2+400,height/2,radians(0),150));
      blox.add(new hitblock(width/2-400,height/2,radians(0),150));
      break;
    
    case 1:
      blox.add(new hitblock(width/2,height/2-200,radians(0),150));
      blox.add(new hitblock(width/2+200,height/2,radians(90),150));
      blox.add(new hitblock(width/2,height/2+200,radians(180),150));
      blox.add(new hitblock(width/2-200,height/2,radians(270),150));
      break;
    
    default:
      blox.add(new hitblock(width/2,height/2,radians(0),150));
      break;
  }
  
}
