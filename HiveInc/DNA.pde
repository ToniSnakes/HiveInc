class DNA {
  int l1 = 19; // number of nodes on the first layer
  int l2 = l1 + 1;
  int l3 = 3; // so sad
  float[][] lay12 = new float[l1][l2]; // weights between layer 1 and 2
  float[][] lay23 = new float[l2][l3];
  
  DNA () {
    for (int i = 0; i < l1; ++i) { // initializing with random weights
      for (int j = 0; j < l2; ++j) {
        lay12[i][j] = random(-1,1);
      }
    }
    for (int i = 0; i < l2; ++i) {
      for (int j = 0; j < l3; ++j) {
        lay23[i][j] = random(-1,1);
      }
    }
  }
  
  DNA crossover (DNA other) {
    DNA child = new DNA();
    for (int i = 0; i < l1; ++i) {
      for (int j = 0; j < l2; ++j) {
        float ran = random(1);
        float mut = random(1);
        if (mut < mutationChance) {
          child.lay12[i][j] = random(-1,1);
        }
        if (ran < 0.5) {
          child.lay12[i][j] = lay12[i][j];
        }
        else {
          child.lay12[i][j] = other.lay12[i][j];
        }
      }
    }
    for (int i = 0; i < l2; ++i) {
      for (int j = 0; j < l3; ++j) {
        float ran = random(1);
        float mut = random(1);
        if (mut < mutationChance) { // always important to mutate in order to evolve
          child.lay23[i][j] = random(-1,1);
        }
        if (ran < 0.5) {
          child.lay23[i][j] = lay23[i][j];
        }
        else {
          child.lay23[i][j] = other.lay23[i][j];
        }
      }
    }
    return child;
  }
  
  void gets (DNA other) { // safer transfer
    for (int i = 0; i < l1; ++i) {
      for (int j = 0; j < l2; ++j) {
        lay12[i][j] = other.lay12[i][j];
      }
    }
    for (int i = 0; i < l2; ++i) {
      for (int j = 0; j < l3; ++j) {
        lay23[i][j] = other.lay23[i][j];
      }
    }
  }
}