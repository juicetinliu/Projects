import java.util.Random;

void evilsetup(){
  organSet();
  prepareWave();
}
public int randInt(int min, int max) {
  
  Random rand = new Random();
  int randomNumber = rand.nextInt((max - min) + 1) + min;
  
  return randomNumber;
}
public void prepareWave(){
  int randY, typeOfVirus, typeOfBacteria, numberOfPathogens;
  int mobilityPoints = 3;
  int HP = 30;
  numberOfPathogens = randInt(0,5);
  // creating viruses...
  for (int i=0; i<numberOfPathogens; i++) {
    randY = randInt(80, 580);
    randY = randY - randY % 20 + 10;
    typeOfVirus = randInt(0,3);
    switch (typeOfVirus) {
      case 0:
        mobilityPoints = 4;
        HP = 30;
        break;
      case 1:
        mobilityPoints = 5;
        HP = 40;
        break;
      case 2:
        mobilityPoints = 4;
        HP = 45;
        break;
      case 3:
        mobilityPoints = 3;
        HP = 60;
        break;
      default:
        break;
    }
    Vir.add(createVirus(typeOfVirus, mobilityPoints, HP));
    Vircoor.add(new PVector(1290, randY));
  }
  
  // creating bacterias...
  for (int i=0; i<numberOfPathogens; i++) {
    randY = randInt(80, 580);
    randY = randY - randY % 20 + 10;
    typeOfBacteria = randInt(0,3);
    switch (typeOfBacteria) {
      case 0:
        mobilityPoints = 3;
        HP = 40;
        break;
      case 1:
        mobilityPoints = 2;
        HP = 60;
        break;
      case 2:
        mobilityPoints = 5;
        HP = 30;
        break;
      case 3:
        mobilityPoints = 4;
        HP = 50;
        break;
      default:
        break;
    }
    Bact.add(createBacteria(typeOfBacteria, mobilityPoints, HP));
    Bactcoor.add(new PVector(-30, randY));
  }  
  return;
}
void wave(){
  for(int i = 0; i < Bact.size(); i++){
     Bactcoor.set(i,movementBact(Bact.get(i),Bactcoor.get(i),organs.get(1)));       
  }
  for(int i=0; i < Vir.size();i++){
     Vircoor.set(i,movementVirus(Vir.get(i), Vircoor.get(i),organs.get(0)));
  }
  turn = true;
}
