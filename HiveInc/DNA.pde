class DNA {
  int l1 = 19;
  int l2 = l1 + 1;
  int l3 = 4;
  float[][] lay12 = new float[l1][l2];
  float[][] lay23 = new float[l2][l3];
  
  DNA () {
    for (int i = 0; i < l1; ++i) {
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
        if (mut < mutationChance) {
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
  
  void gets (DNA other) {
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