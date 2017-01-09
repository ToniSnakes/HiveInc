class Map {
  ArrayList<Hive> hives;
  ArrayList<Node> nodes;
  ArrayList<Lava> lavas;
  float W, H;
  int nodesUpgraded = 0;
  
  Map () {
    W = width - hudMargin;
    H = height;
    hives = new ArrayList<Hive>();
    nodes = new ArrayList<Node>();
    lavas = new ArrayList<Lava>();
    hives.add(new Hive(W/2,H/2,1));
    for (int i = 0; i <= W/100; ++i) {
      for (int j = 0; j <= H/100; ++j) {
        float x = i * 100;
        float y = j * 100;
        if (x != W/2 || y != H/2) { //holy shit this needs improvement (cheating by using a good sketch size)
          float ran = random(1);
          if (ran < 0.4) {
            lavas.add(new Lava(x, y, random(40,80)));
          }
          else 
          if (ran < 0.7) {
            nodes.add(new Node(x, y));
          }
        }
      }
    }
  }
  
  void run () {
    Creature best = new Creature(0,0,0,1); // transmitting the best creature throughout all of the hives
    for (Hive h: hives) {
      h.run();
      if (h.best.fitness > best.fitness) {
        best = h.best;
      }
    }
    for (Hive h: hives) {
      h.best = best;
    }
  }
  
  void checkUpgrades () {
    for (int i = 0; i < nodes.size(); ++i) {
      Node n = nodes.get(i);
      if (n.upgrade()) {
        ++nodesUpgraded;
        hives.add(new Hive(n.location.x,n.location.y,hives.size()));
        for (int j = i; j < nodes.size() - 1; ++j) { // !Could be optimized!
          nodes.set(j,nodes.get(j+1));
        }
      }
    }
  }
  
  void creatureDisplay () {
    for (Hive h: hives) {
      h.creatureDisplay();
    }
  }
  
  void display () {
    for (Hive h: hives) {
      h.display();
    }
    for (Node n: nodes) {
      n.display();
    }
    for (Lava l: lavas) {
      l.display();
    }
  }
}