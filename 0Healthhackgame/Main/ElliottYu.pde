//int oxygen;
//int glucose;
//int ap;

//class oxGen {
//  int level;
//  int genAmount;
//  int health;
//  oxGen(int level, int genAmount, int health){
//    this.level=level;
//    this.genAmount = genAmount;
//    this.health = health;
//  }
//}
//class types{
//  int movement;
//  int attack;
//  int o2cost;
//  int glcost;
//  int ap;
//  types(int o2cost, int glcost,int movement ,int attack, int ap){
//    this.o2cost = o2cost;
//    this.glcost = glcost;
//    this.attack = attack;
//    this.ap = ap;
//    this.movement = movement;
//  }
//}

//class bacteria{
//  int movement;
//  int health;

//  bacteria(int health,int movement){
//    this.health = health;
//    this.movement = movement;
//  }
//}
  
//class virus{
//  int health;
//  int movement;
//  virus(int health, int movement ){
//    this.health = health;
//    this.movement = movement;
//  }
//}

//types monocyte;
//types blymph;
//types tlymph;
//types cell4;
//bacteria bacteria1;
//bacteria bacteria2;
//bacteria bacteria3;
//bacteria bacteria4;
//virus coldflu;
//virus virus2;
//virus virus3;
//virus virus4;
//public types troop(int i){
//  if(i == 1){
//  return monocyte;
//  }
//  else if(i == 2){
//  return blymph;
//  }
//  else if(i == 3){
//  return tlymph;
//  }
//  else if(i == 4){
//  return cell4;
//  }
//  else return null;
//}
//public bacteria bacterias(int i){
//  if(i == 1){
//  return bacteria1;
//  }
//  else if(i == 2){
//  return bacteria2;
//  }
//  else if(i == 3){
//  return bacteria3;
//  }
//  else if(i == 4){
//  return bacteria4;
//  }
//  else return null;
//}

//public virus viruses(int i){
//  if(i == 1){
//  return coldflu;
//  }
//  else if(i == 2){
//  return virus2;
//  }
//  else if(i == 3){
//  return virus3;
//  }
//  else if(i == 4){
//  return virus4;
//  }
//  else return null;
//}

//class barracks{
//  int health;
//  boolean training;
//  types trainType;
//  int stat;
//  barracks(int health, boolean training, types trainType){
//    this.health= health;
//    this.training = training;
//    this.trainType = trainType;
//  }
  
//  void tuneBarrack(types cell, boolean train){
//    this.trainType = cell;
//    this.training = train;
//  }
//  void tuneStat(int changestat){
//    this.stat = changestat;
//  }
  
//}
//class gluGen {
//  int level;
//  int genAmount;
//  int health;
//  gluGen(int level, int genAmount, int health){
//    this.level=level;
//    this.genAmount = genAmount;
//    this.health=health;
//  }
//}

//public barracks buyBarracks(){
//  oxygen-= 10;
//  glucose-= 10;
//  barracks barrack = new barracks(75, true, monocyte);
//  barrack.stat = 2;
//  return barrack;
//}

//public void afterTurn(boolean finishTurn, ArrayList<oxGen> genO, ArrayList<gluGen> genG ){
//  if(finishTurn){
//    for(int i = 0; i < genO.size() ;i++){
//      oxygen+= genO.get(i).genAmount;
//    }
//    for(int i = 0; i < genG.size() ;i++){
//      glucose+= genG.get(i).genAmount;
//    }
//  }
//}
