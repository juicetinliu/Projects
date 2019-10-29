int glugencost = 20;
int oxgencost = 20;
int barcost = 10;

class oxGen {
  int level;
  int genAmount;
  int health;
  public oxGen(int level, int genAmount, int health) {
    this.level=level;
    this.genAmount = genAmount;
    this.health = health;
  }
}

class gluGen {
  int level;
  int genAmount;
  int health;
  gluGen(int level, int genAmount, int health) {
    this.level=level;
    this.genAmount = genAmount;
    this.health=health;
  }
}

class barracks{
  int health;
  boolean training;
  
  int stat;
  barracks(int health, boolean training){
    this.health= health;
    this.training = training;
  }
  void tuneStat(int changestat){
    this.stat = changestat;
  }
}


void generateCells(Boolean finishTurn, ArrayList<barracks> barrackobama){
  if(finishTurn){
    for(barracks barrack: barrackobama){
      switch(barrack.stat) {
        case 0:
          Celltypes[0]++;
          oxygen-=pcost;
          glucose-=pcost;
          break;
        case 1:
          Celltypes[1]++;
          oxygen-=dcost;
          glucose-=dcost;
          break;
        case 2:
          Celltypes[2]++;
          oxygen-=bcost;
          glucose-=bcost;
          break;
        case 3:
          Celltypes[3]++;
          oxygen-=tcost;
          glucose-=tcost;
          break;
      }
    }
  }
}

public oxGen buyOxgen() {
  oxygen-= oxgencost;
  oxGen generator = new oxGen(1, 10, 50);
  return generator;
}

public gluGen buyGlucose() {
  glucose-= glugencost;
  gluGen generator = new gluGen(1, 10, 50);
  return generator;
}

public barracks buyBarracks(){
  oxygen-= barcost;
  glucose-= barcost;
  barracks barrack = new barracks(75, true);
  barrack.stat = 0;
  return barrack;
}

public void afterTurn(boolean finishTurn, ArrayList<oxGen> genO, ArrayList<gluGen> genG, Heart heartInstance, Lungs lungsInstance, Liver liverInstance) {
  if (finishTurn) {
    for (int i = 0; i < genO.size(); i++) {
      oxygen += genO.get(i).genAmount * (heartInstance.health * 100 / heartInstance.maxHealth) * (lungsInstance.health * 100/ lungsInstance.maxHealth) / 10000;
    }
    for (int i = 0; i < genG.size(); i++) {
      glucose += genG.get(i).genAmount * (heartInstance.health * 100 / heartInstance.maxHealth) * (liverInstance.health * 100 / liverInstance.maxHealth) / 10000;
    }
  }
}

int predoxygen(ArrayList<barracks> barrackobama){
  int predoxy = 0;
  for(barracks barrack: barrackobama){
      switch(barrack.stat) {
        case 0:
          predoxy-=pcost;
          break;
        case 1:
          predoxy-=dcost;
          break;
        case 2:
          predoxy-=bcost;
          break;
        case 3:
          predoxy-=tcost;
          break;
      }
    }
  return predoxy;
}

int predglucose(ArrayList<barracks> barrackobama){
  int predglu = 0;
  for(barracks barrack: barrackobama){
      switch(barrack.stat) {
        case 0:
          predglu-=pcost;
          break;
        case 1:
          predglu-=dcost;
          break;
        case 2:
          predglu-=bcost;
          break;
        case 3:
          predglu-=tcost;
          break;
      }
    }
    return predglu;
}

public void deleteStructure(int type){
  switch (type) {
    case 0:
      if(boi1.size() > 0){
        boi1.remove(selox);
        oxgencoor.remove(selox);
        oxygen+=oxgencost;
      }
      break;
    case 1:
      if(boi2.size() > 0){
        boi2.remove(selglu);
        glucoor.remove(selglu);
        glucose+=glugencost;
      }
      break;
    case 2:
      if(boi3.size() > 0){
        boi3.remove(selbarrack);
        barrackcoor.remove(selbarrack);
        oxygen+=barcost;
        glucose+=barcost;
      }
      break;
    default:
      break;
  }
}

public void levelUpOxy(oxGen gen) {
  oxygen-=gen.genAmount;
  gen.level++;
  gen.genAmount+=20;
  gen.health += 25;
}

public void levelUpGlu(gluGen gen) {
  glucose-=gen.genAmount;
  gen.level++;
  gen.genAmount+=20;
  gen.health += 25;
}
