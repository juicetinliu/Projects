class organ {
  int health;
  //boolean destroyed;
  organ(int health) {
    this.health= health;
    //this.destroyed = destroyed;
  }
}

class Heart extends organ{
  int maxHealth;
  Heart(int health, int maxHealth) {
    super(health);
    this.maxHealth = maxHealth;
  }
}

class Liver extends organ {
  int maxHealth;
  Liver(int health, int maxHealth) {
    super(health);
    this.maxHealth = maxHealth;
  }
}

class Lungs extends organ {
  int maxHealth;
  Lungs(int health, int maxHealth) {
    super(health);
    this.maxHealth = maxHealth;
  }
}
