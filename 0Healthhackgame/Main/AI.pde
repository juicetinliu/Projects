import java.util.Random;
ArrayList<PVector> organCoor = new ArrayList<PVector>();
ArrayList<organ> organs = new ArrayList<organ>();
ArrayList<PVector> Ptargets = new ArrayList<PVector>();
ArrayList<PVector> Dtargets = new ArrayList<PVector>();
ArrayList<PVector> Btargets = new ArrayList<PVector>();
ArrayList<PVector> Ttargets = new ArrayList<PVector>();
boolean chosentarget = false;

void organSet(){
  PVector heartcoor = new PVector (780,400);
  PVector lungscoor = new PVector (610,210);
  PVector livercoor = new PVector (395,400);
  organs.add(heart);
  organs.add(lungs);
  organs.add(liver);
  organCoor.add(heartcoor);
  
  organCoor.add(lungscoor);
  organCoor.add(livercoor);

}
PVector AIMovementPossibilities(PVector pathogen,organ organAttack){
  int index;
  boolean right = false;
  boolean left = false;
  boolean up = false;
  boolean down = false;
  index = organs.indexOf(organAttack);
  if(organCoor.get(index).x - pathogen.x > 10){
    right = true;
  }
  if(organCoor.get(index).x - pathogen.x < 10){
    left = true;
  }
  if(organCoor.get(index).y - pathogen.y > 10){
    down = true;
  }
  if(organCoor.get(index).y - pathogen.y < 10){
    up = true;
  }
  int direction = probabilityCalculations(pathogen,right, left, up , down);
  if(direction == 1){
    pathogen.y+=gridspacing;
  }
  if(direction == 2){
    pathogen.y-=gridspacing;
  }
  if(direction == 3){
    pathogen.x-=gridspacing;
  }
  if(direction == 4){
    pathogen.x+=gridspacing;
  }
  
  return pathogen;
}

PVector CellMovementPossibilities(cells cell,PVector cellloc){
  boolean right = false;
  boolean left = false;
  boolean up = false;
  boolean down = false;
  float bestdist = 2810;
  int bestindex = 0;
  int index = 0;
  int type = 0;
  if(!cell.targetchosen){
    if(Vir.size()!=0){
      for(PVector virpos: Vircoor){
         if(virpos.dist(cellloc) < bestdist){
           bestdist = virpos.dist(cellloc);
           bestindex = index;
           type = 1;
         }
         index+=1;
      }
    }else{
      index = -1;
    }
    index = 0;
    for(PVector bactpos: Bactcoor){
      if(Vir.size()!=0){
        if(bactpos.dist(cellloc) < bestdist){
           bestdist = bactpos.dist(cellloc);
           bestindex = index;
           type = 2;
         }
         index+=1;
      }else{
        index = -1;
      }
    }
    cell.settarget(bestindex, type);
  }
  if(cell.targettype == 1){
    if(cell.targetindex < Vircoor.size() && Vircoor.size() > 0){
      if(Vircoor.get(cell.targetindex).x - cellloc.x > 10){
        right = true;
      }
      if(Vircoor.get(cell.targetindex).x - cellloc.x < 10){
        left = true;
      }
      if(Vircoor.get(cell.targetindex).y - cellloc.y > 10){
        down = true;
      }
      if(Vircoor.get(cell.targetindex).y - cellloc.y < 10){
        up = true;
      }
    }else{
      cell.findnewtarget();
    }
  }else if(cell.targettype == 2){
    if(cell.targetindex < Bactcoor.size() && Bactcoor.size() > 0){
      if(Bactcoor.get(cell.targetindex).x - cellloc.x > 10){
        right = true;
      }
      if(Bactcoor.get(cell.targetindex).x - cellloc.x < 10){
        left = true;
      }
      if(Bactcoor.get(cell.targetindex).y - cellloc.y > 10){
        down = true;
      }
      if(Bactcoor.get(cell.targetindex).y - cellloc.y < 10){
        up = true;
      }
    }else{
      cell.findnewtarget();
    }
  }else{
    cell.findnewtarget();
  }
  
  int direction = probabilityCalculations(cellloc, right, left, up , down);
  if(direction == 1){
    cellloc.y+=gridspacing;
  }
  if(direction == 2){
    cellloc.y-=gridspacing;
  }
  if(direction == 3){
    cellloc.x-=gridspacing;
  }
  if(direction == 4){
    cellloc.x+=gridspacing;
  }
  
  return cellloc;
}

//boolean inBloodVessel(float x, float y){
//  boolean yeet = true;
//  //if(x<250 && y>500){
//  //  yeet = true;
//  //}
//  return yeet;
  
//}

int probabilityCalculations (PVector pathogen, boolean right, boolean left, boolean up, boolean down){
  int totalNumber = 0;
  int probabilityNumber =0;
  if(right){
      totalNumber += 10;
      probabilityNumber = 10;
  }
  if(left){
    totalNumber += 10;
    probabilityNumber = 10;
  }
  if(up){
      totalNumber += 10;
      probabilityNumber = 10;
  }
  if(down){
      totalNumber += 10;
      probabilityNumber = 10;
  }
  if(probabilityNumber <= random(1,totalNumber)){
    if(down){
      return 1;
    }else if(up){
      return 2;
    }else if(left){
      return 3;
    }else if(right){
      return 4;
    }
  }else{
    if(right){
      return 4;
    }else if(left){
      return 3;
    }else if(up){
      return 2;
    }else if(down){
      return 1;
    }
  }
    return 0;
}

PVector movementVirus(virus movVirus,PVector movingVirus, organ organAttack){
  int counter = 0;
  PVector newpos = movingVirus;
  while(movVirus.mobilityPoints > counter){
    counter++;
    newpos = AIMovementPossibilities(newpos, organAttack);
  }
  return newpos;
}

PVector movementCell(cells movCell,PVector movingCell){
  int counter = 0;
  PVector newpos = movingCell;
  while(movCell.mobilityPoints > counter){
    counter++;
    newpos = CellMovementPossibilities(movCell, newpos);
  }
  println(movCell.targetindex + " _ "  + movCell.targettype);
  return newpos;
}

PVector movementBact(bacteria movBac,PVector movingbac, organ organAttack){
  int counter = 0;
  PVector newpos = movingbac;
  while(movBac.mobilityPoints > counter){
    counter++;
    newpos = AIMovementPossibilities(newpos, organAttack);
  }
  return newpos;
}
