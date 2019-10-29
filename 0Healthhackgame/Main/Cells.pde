import java.util.Random;
int pcost = 5;
int dcost = 5;
int bcost = 5;
int tcost = 10;

class cells {
  int mobilityPoints;
  int attack;
  int costInBlood;
  int costOutOfBlood;
  int targetindex;
  int targettype;
  boolean targetchosen = false;
  boolean targetdead;
  boolean dead;
  cells(int mobilityPoints, int attack, int costInBlood, int costOutOfBlood, boolean dead) {
    this.attack = attack;
    this.mobilityPoints = mobilityPoints;
    this.costInBlood = costInBlood;
    this.costOutOfBlood = costOutOfBlood;
    this.dead = dead;
  }
  void settarget(int tarindex, int tartype){
    this.targetindex = tarindex;
    this.targettype = tartype;
    this.targetchosen = true;
    this.targetdead = false;
  }
  void findnewtarget(){
    this.targetindex = 0;
    this.targettype = 0;
    this.targetchosen = false;
  }
}

class Phagocytes extends cells {
  Phagocytes(int mobilityPoints, int attack, int costInBlood, int costOutOfBlood, boolean dead) {
    super(mobilityPoints, attack, costInBlood, costOutOfBlood, dead);
  }
  public void attackBacteria(bacteria target) {
    if (target.marked) {
      target.health = target.health - attack * 2;
    }
    else {
      target.health = target.health - attack;
    }
    return;
  }
  
  public void attackVirus(virus target) {
    if (target.marked) {
      target.health = target.health - attack * 2;
    }
    else {
      target.health = target.health - attack;
    }
    return;
  }
}

class Dendritic extends cells {
  
  Dendritic(int mobilityPoints, int attack, int costInBlood, int costOutOfBlood, boolean dead) {
    super(mobilityPoints, attack, costInBlood, costOutOfBlood, dead);
  }
  
  public void attackBacteria(bacteria target) {
    target.health = target.health - attack;
    switch (target.name) {
      case "Staphylococcus":
        bacteriaData[0]++;
        break;
      case "Tuberculosis":
        bacteriaData[1]++;
        break;
      case "Streptococcus":
        bacteriaData[2]++;
        break;
      case "EColi":
        bacteriaData[3]++;
        break;
      default:
      return;
    }
  }
  
  public void attackVirus(virus target) {
    target.health = target.health - attack;
    switch(target.name) {
      case "Common Cold": 
        virusData[0]++;
        break;
      case "Hepatitis A":
        virusData[1]++;
        break;
      case "Influenza":
        virusData[2]++;
        break;
      case "Ebola":
        virusData[3]++;
        break;
      default:
      return;    
    }
  }
}

class BCell extends cells {
  BCell(int mobilityPoints, int attack, int costInBlood, int costOutOfBlood, boolean dead) {
    super(mobilityPoints, 0, costInBlood, costOutOfBlood, dead);
  }
  
  public void markBacteria(bacteria target) {
    target.marked = true;
    return;
  }
  
  public void markVirus(virus target) {
    target.marked = true;
    return;
  }
}

class KillerTCell extends cells {
  String specialisation;
  KillerTCell(int mobilityPoints, int attack, int costInBlood, int costOutOfBlood, boolean dead, String specialisation) {
     super(mobilityPoints, attack, costInBlood, costOutOfBlood, dead);
     this.specialisation = specialisation;
  }
  
  public void attackBacteria(bacteria target) {
    switch(target.name) {
      case "Staphylococcus": 
      if (this.specialisation.equals("Staphylococcus")) {
        target.health = target.health - 3 * this.attack;
      }
      else {
        target.health = target.health - this.attack / 2;
      }
      case "Tuberculosis":
      if (this.specialisation.equals("Tuberculosis")) {
        target.health = target.health - 3 * this.attack;
      }
      else {
        target.health = target.health - this.attack / 2;
      }
      case "Streptococcus":
      if (this.specialisation.equals("Streptococcus")) {
        target.health = target.health - 3 * this.attack;
      }
      else {
        target.health = target.health - this.attack / 2;
      }
      case "EColi":
      if (this.specialisation.equals("EColi")) {
        target.health = target.health - 3 * this.attack;
      }
      else {
        target.health = target.health - this.attack / 2;
      }
      default:
      return;
    }
  }
  
  public void attackVirus(virus target) {
    switch(target.name) {
      case "Common Cold": 
      if (this.specialisation.equals("Common Cold")) {
        target.health = target.health - 3 * this.attack;
      }
      else {
        target.health = target.health - this.attack / 2;
      }
      case "Hepatitis A":
      if (this.specialisation.equals("Hepatitis A")) {
        target.health = target.health - 3 * this.attack;
      }
      else {
        target.health = target.health - this.attack / 2;
      }
      case "Influenza":
      if (this.specialisation.equals("Influenza")) {
        target.health = target.health - 3 * this.attack;
      }
      else {
        target.health = target.health - this.attack / 2;
      }
      case "Ebola":
      if (this.specialisation.equals("Ebola")) {
        target.health = target.health - 3 * this.attack;
      }
      else {
        target.health = target.health - this.attack / 2;
      }
      default:
      return;    
    }
  }
}
