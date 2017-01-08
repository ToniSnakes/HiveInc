class Map {
  ArrayList<Hive> hives;
  ArrayList<Node> nodes;
  ArrayList<Lava> lavas;
  float W, H;
  
  Map () {
    W = width - hudMargin;
    H = height;
    hives = new ArrayList<Hive>();
    nodes = new ArrayList<Node>();
    lavas = new ArrayList<Lava>();
    hives.add(new Hive(W/2,H/2));
    for (int i = 0; i <= W/100; ++i) {
      for (int j = 0; j <= H/100; ++j) {
        float x = i * 100;
        float y = j * 100;
        if (x != W/2 || y != H/2) { //holy shit this needs improvement
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
    for (Hive h: hives) {
      h.run();
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