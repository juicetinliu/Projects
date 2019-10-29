import java.util.Random;

class virus {
  String name;
  int health;
  int mobilityPoints;
  int costInBlood;
  int costOutOfBlood;
  boolean marked;
  virus(String name, int health, int mobilityPoints, int costInBlood, int costOutOfBlood, boolean marked) {
    this.name = name;
    this.health = health;
    this.mobilityPoints = mobilityPoints;
    this.costInBlood = costInBlood;
    this.costOutOfBlood = costOutOfBlood;
    this.marked = marked;
  }
  
  void turndamage(boolean inBlood){
    if(inBlood){
      this.health = this.health - this.costInBlood;
    }else{
      this.health = this.health - this.costOutOfBlood;
    }
  }
  
  public void attackCell(Phagocytes target) {
    if (getRandomBoolean()) {
      target.dead = true;
    }
    return;
  }
  
  public void attackCell(Dendritic target) {
    if (getRandomBoolean()) {
      target.dead = true;
    }
    return;
  }
  
  public void attackCell(BCell target) {
    if (getRandomBoolean()) {
      target.dead = true;
    }
    return;
  }
  
  public void attackCell(KillerTCell target) {
    if (getRandomBoolean()) {
      target.dead = true;
    }
    return;
  }
  
  private boolean getRandomBoolean() {
    Random random = new Random();
    return random.nextBoolean();
  }
}

public void attackOrganVirus(virus v, int index, ArrayList<PVector> heartcoor, PVector coorVirus, Heart heart) {
  for(PVector position: heartcoor){
    if (position.x == coorVirus.x && position.y == coorVirus.y) {
      switch (v.name) {
        case "Common Cold":
          // lungs & heart
          heart.health -= 3;
          virus copyvir = Vir.get(index);
          copyvir.health = 0;
          Vir.set(index, copyvir);
          break;
        case "Hepatitis A":
          // liver
          heart.health -= 4;
          break;
        case "Influenza":
          // lungs
          heart.health -= 4;
          virus copyvir2 = Vir.get(index);
          copyvir2.health = 0;
          Vir.set(index, copyvir2);
          break;
        case "Ebola":
          // heart & lungs & liver
          heart.health -= 10;
          virus copyvir3 = Vir.get(index);
          copyvir3.health = 0;
          Vir.set(index, copyvir3);
          break;
        default:
          break;
      }
    }
  }
  return;
}

public void attackOrganVirus(virus v, int index, ArrayList<PVector> lungcoor, PVector coorVirus, Lungs lungs) {
  for(PVector position: lungcoor){
    if (position.x == coorVirus.x && position.y == coorVirus.y) {
      switch (v.name) {
        case "Common Cold":
          lungs.health -= 5;
          virus copyvir = Vir.get(index);
          copyvir.health = 0;
          Vir.set(index, copyvir);
          break;
        case "Hepatitis A":
          lungs.health -= 4;
          break;
        case "Influenza":
          lungs.health -= 10;
          virus copyvir2 = Vir.get(index);
          copyvir2.health = 0;
          Vir.set(index, copyvir2);
          break;
        case "Ebola":
          lungs.health -= 10;
          virus copyvir3 = Vir.get(index);
          copyvir3.health = 0;
          Vir.set(index, copyvir3);
          break;
        default:
          break;
      }
    }
  }
  return;
}

public void attackOrganVirus(virus v, int index, ArrayList<PVector> livercoor, PVector coorVirus, Liver liver) {
  for(PVector position: livercoor){
    if (position.x == coorVirus.x && position.y == coorVirus.y) {
      switch (v.name) {
        case "Common Cold":
          liver.health -= 2;
          virus copyvir = Vir.get(index);
          copyvir.health = 0;
          Vir.set(index, copyvir);
          break;
        case "Hepatitis A":
          liver.health -= 7;
          break;
        case "Influenza":
          liver.health -= 2;
          virus copyvir2 = Vir.get(index);
          copyvir2.health = 0;
          Vir.set(index, copyvir2);
          break;
        case "Ebola":
          liver.health -= 10;
          virus copyvir3 = Vir.get(index);
          copyvir3.health = 0;
          Vir.set(index, copyvir3);
          break;
        default:
          break;
      }
    }
  }
  return;
}

public virus createVirus(int index, int mobilityPoints, int HP) {
  switch(index) {
    case 0:
      virus v0 = new virus("Common Cold", HP, mobilityPoints, 1, 1, false);
      return v0;
    case 1:
      virus v1 = new virus("Hepatitis A", HP, mobilityPoints, 1, 1, false);
      return v1;
    case 2:
      virus v2 = new virus("Influenza", HP, mobilityPoints, 1, 1, false);
      return v2;
    case 3:
      virus v3 = new virus("Ebola", HP, mobilityPoints, 1, 1, false);
      return v3;
    default:
      return null;
  }
}
