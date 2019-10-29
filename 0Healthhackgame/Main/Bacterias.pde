import java.util.Random;

class bacteria {
  String name;
  int mobilityPoints;
  int health;
  int costInBlood;
  int costOutOfBlood;
  boolean marked;
  bacteria(String name, int health, int mobilityPoints, int costInBlood, int costOutOfBlood, boolean marked) {
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
}


public void attackOrganBacteria(bacteria b, ArrayList<PVector> heartcoor, PVector coorVirus, Heart heart) {
  for(PVector position: heartcoor){
    if (position.x == coorVirus.x && position.y == coorVirus.y) {
      switch (b.name) {
        case "Staphylococcus":
          heart.health -= 7;
          // heart
          break;
        case "Tuberculosis":
          heart.health -= 3;
          // lungs
          break;
        case "Streptococcus":
          heart.health -= 3;
          // lungs
          break;
        case "EColi":
          heart.health -= 3;
          // liver
          break;
        default:
          break;
      }
    }
  }
  return;
}

public void attackOrganBacteria(bacteria b, ArrayList<PVector> heartcoor, PVector coorVirus, Lungs lungs) {
  for(PVector position: lungcoor){
    if (position.x == coorVirus.x && position.y == coorVirus.y) {
      switch (b.name) {
        case "Staphylococcus":
          lungs.health -= 3;
          // heart
          break;
        case "Tuberculosis":
          lungs.health -= 7;
          // lungs
          break;
        case "Streptococcus":
          lungs.health -= 7;
          // lungs & liver
          break;
        case "EColi":
          lungs.health -= 3;
          // liver
          break;
        default:
          break;
      }
    }
  }
  return;
}

public void attackOrganBacteria(bacteria b, ArrayList<PVector> heartcoor, PVector coorVirus, Liver liver) {
  for(PVector position: livercoor){
    if (position.x == coorVirus.x && position.y == coorVirus.y) {
      switch (b.name) {
        case "Staphylococcus":
          liver.health -= 3;
          // heart
          break;
        case "Tuberculosis":
          liver.health -= 3;
          // lungs
          break;
        case "Streptococcus":
          liver.health -= 5;
          // lungs & liver
          break;
        case "EColi":
          liver.health -= 7;
          // liver
          break;
        default:
          break;
      }
    }
  }
  return;
}
public bacteria createBacteria(int index, int mobilityPoints, int HP) {
  switch(index) {
    case 0:
      bacteria b0 = new bacteria("Staphylococcus", HP, mobilityPoints, 1, 1, false);
      return b0;
    case 1:
      bacteria b1 = new bacteria("Tuberculosis", HP, mobilityPoints, 1, 1, false);
      return b1;
    case 2:
      bacteria b2 = new bacteria("Streptococcus", HP, mobilityPoints, 1, 1, false);
      return b2;
    case 3:
      bacteria b3 = new bacteria("EColi", HP, mobilityPoints, 1, 1, false);
      return b3;
    default:
    return null;
  }
}
