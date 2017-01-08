class Hive {
  PVector location;
  String type;
  float w = 30;
  Creature[] creatures = new Creature[60];
  float maxFitness, averageFitness;
  Creature best;
  
  float totalFood;
  
  Hive (float x, float y) {
    super();
    location = new PVector(x,y);
    type = "Hive";
    //creatures = new ArrayList<Creature>();
    for (int i = 0; i < creatures.length; ++i) {
      //creatures.add(new Creature(location.x,location.y,i));
      creatures[i] = new Creature(location.x,location.y,i);
    }
    best = creatures[0];
  }
  
  void fitSort (int a, int b) {
    int mid = (a + b) / 2;
    if (a != b) {
      fitSort(a,mid);
      fitSort(mid+1,b);
      int i = a, j = mid + 1;
      Creature[] fits = new Creature[b-a+1];
      int k = 0;
      while (i <= mid && j <= b) {
        if (creatures[i].fitness >= creatures[j].fitness) {
          fits[k] = creatures[i];
          ++i;
        }
        else {
          fits[k] = creatures[j];
          ++j;
        }
        ++k;
      }
      while (i <= mid) {
        fits[k] = creatures[i];
        ++i;
        ++k;
      }
      while (j <= b) {
        fits[k] = creatures[j];
        ++j;
        ++k;
      }
      for (int ii = 0; ii < k; ++ii) {
        creatures[ii+a] = fits[ii];
      }
    }
  }
  
  DNA reproduce () {
    ++deaths;
    float sum = 0;
    float max = 0;
    for (int i = 0; i < creatures.length; ++i) {
      sum += creatures[i].fitness;
      if (creatures[i].fitness > max) {
        max = creatures[i].fitness;
        best = creatures[i];
      }
    }
    averageFitness = sum / creatures.length;
    maxFitness = max;
    
    if (!best.alive) {
      return best.dna;
    }
    
    ArrayList<Creature> matingPool = new ArrayList<Creature>();
    fitSort(0,creatures.length-1);
    float num = creatures.length, dub = num;
    for (int i = 0; i < creatures.length; ++i) {
      int n = int(num/dub * 100);
      for (int j = 1; j <= n; ++j) {
        matingPool.add(creatures[i]);
      }
    }
    int a = int(random(matingPool.size()));
    int b = int(random(matingPool.size()));
    while (b == a) {
      b = int(random(matingPool.size()));
    }
    DNA parentA = matingPool.get(a).dna;
    DNA parentB = matingPool.get(b).dna;
    DNA child = parentA.crossover(parentB);
    return child;
  }
  
  void run () {
    for (int i = 0; i < creatures.length; ++i) {
      if (creatures[i].alive) {
        creatures[i].update();
      }
      else {
        totalFood += creatures[i].foodDelivered;
        DNA next = reproduce(); // keeping the best of the best alive!
        creatures[i] = new Creature(location.x,location.y,i); 
        creatures[i].dna.gets(next);
      }
    }
  }
  void creatureDisplay () {
    for (Creature c: creatures) {
      c.display();
    }
  }
  
  void place (float food, int id) {
    // !fitness!
  }
  
  boolean includes (PVector loc) {
    if (loc.x > location.x - w/2 && loc.x < location.x + w/2 && loc.y > location.y - w/2 && loc.y < location.y + w/2) {
      return true;
    }
    return false;
  }
  
  void display () {
    stroke(0);
    fill(0,0,128);
    rectMode(CENTER);
    rect(location.x,location.y,w,w);
  }
}