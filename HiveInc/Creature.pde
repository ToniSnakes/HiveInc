class Creature {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float angle;
  float r = 9;
  int id; // just in case
  
  DNA dna;
  
  ArrayList<Eye> eyes;
  
  float HP, pHP, maxHP = 150; //hit points
  float E, pE, maxE = 500; // energy, previous energy, max energy
  float Hg, pHg, maxHg = 200; // hunger
  //float carry;
  float food, mat, maxCarry = 300; // amount of food and materials
  float age, lifespan = 3000;
  boolean alive;
  
  float accel = 2, maxspeed = 4; //base acceleration, max speed
  float aSpeed = 90; //base speed of turning
  
  float[] inputs, hidden, outputs;
  
  float foodDelivered, fitness;
  
  String name; // why not?
  
  Creature (float x, float y, int id_) {
    location = new PVector(x,y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    id = id_;
    angle = random(360);
    //angle = -90;
    dna = new DNA();
    eyes = new ArrayList<Eye>();
    eyes.add(new Eye(r * 1.0, -40));
    eyes.add(new Eye(r * 0.8, -15));
    eyes.add(new Eye(r * 0.8, 15));
    eyes.add(new Eye(r * 1.0, 40));
    inputs = new float[dna.l1];
    hidden = new float[dna.l2];
    outputs = new float[dna.l3];
    inputs[dna.l1-1] = 1;
    
    HP = maxHP;
    pHP = HP;
    E = maxE;
    pE = E;
    Hg= maxHg;
    pHg = Hg;
    food = 0;
    mat = 0;
    age = 0;
    alive = true;
    
    foodDelivered = 0;
    
    //?Better name generator?
    //for (int i = 1; i <= 5; ++i) {
      name = "Test-";
      name += id;
    //}
  }
  
  void applyForce (PVector force) {
    acceleration.add(force); // !when calculating acceleration, take the creature's orientation into consideration!
  }
  
  void checkEdges() {
    /*if (location.x < 0 || location.x > width-hudMargin || location.y < 0 || location.y > height) {
      //alive = false; // what we actually need
      location = new PVector(width/2-200,height/2); // for now
    }*/
    if (location.x < 0 || location.x > width-hudMargin) {
      location.x = (location.x + width-hudMargin) % (width-hudMargin);
    }
    if (location.y < 0 || location.y > height) {
      location.y = (location.y + height) % (height);
    }
  }
  
  void fitness () {
    fitness = (foodDelivered + age/lifespan) / 1;
    fitness = pow(fitness,2);
  }
  
  void checkBelow () {
    boolean found = false;
    int i = 0;
    while (i < areaMap.lavas.size() && !found) {
      Lava l = areaMap.lavas.get(i);
      if (l.includes(location)) { 
        HP -= 30;
        found = true;
      }
      ++i;
    }
  }
  
  void update () {
    if (alive) {
      pHP = HP;
      act();
      checkBelow();
      if (E > maxspeed) {
        velocity.add(acceleration);
        velocity.limit(maxspeed);
        location.add(velocity);
        pE = E;
        E -= velocity.mag();
      }
      else {
        HP -= 10;
      }
      if (Hg > 0) {
        pHg = Hg;
        Hg -= 1;
      }
      else {
        HP -= 10;
      }
      checkEdges();
      acceleration.mult(0);
      age += 1;
      if (age > lifespan || HP < 0) {
        alive = false;
      }
      fitness();
    }
  }
  
  void getInputs () {
    int i = 0;
    loadPixels();
    for (Eye e: eyes) { // get the inputs for all the eyes
      color c = e.look(location,angle);
      inputs[i] = red(c);
      ++i;
      inputs[i] = green(c);
      ++i;
      inputs[i] = blue(c);
      ++i;
    }
    inputs[i] = HP - pHP; // hp diff
    ++i;
    inputs[i] = E - pE; // energy difference
    ++i;
    inputs[i] = Hg - pHg; // hunger difference
    ++i;
    inputs[i] = food; // quantity of food carried
    ++i;
    inputs[i] = mat; // quantity of materials carried
    ++i;
    inputs[i] = age; // age
    ++i;
    if (i != dna.l1 - 1) {
      print("Count the inputs!");
      pause = true;
    }
  }
  
  float process (float node) {
    return (1/(1+pow(e,-node)));
  }
  
  float[] clearNodes (float[] layer) {
    for (int i = 0; i < layer.length; ++i) {
      layer[i] = 0;
    }
    return layer;
  }
  
  void think () {
    // !decide whether or not to use a brain!
    getInputs();
    hidden = clearNodes(hidden);
    hidden[hidden.length-1] = 1; // remember to update the bias
    outputs = clearNodes(outputs);
    for (int i = 0; i < dna.l1; ++i) {
      for (int j = 0; j < dna.l2; ++j) {
        hidden[j] += inputs[i] * dna.lay12[i][j]; // sum all of the biases * weigths from all of the inputs
      }
    }
    for (int i = 0; i < dna.l2; ++i) {
      hidden[i] = process(hidden[i]); // no need to do this separately
      for (int j = 0; j < dna.l3; ++j) {
        outputs[j] += hidden[i] * dna.lay23[i][j]; // sum all of the biases * weigths from the hidden layer
      }
    }
    for (int i = 0; i < dna.l3; ++i) {
      outputs[i] = process(outputs[i]);
    }
  }
  
  void act () {
    think(); // think before you act
    int i = 0;
    forward(outputs[i]); // forward/back movement
    ++i;
    left(outputs[i]); // left/right movement
    ++i;
    turnR(outputs[i]); // turn right/left
    ++i;
    interact(outputs[i]); // exchange materials/food
    ++i;
    if (i != dna.l3) {
      print("Count the outputs!");
      pause = true;
    }
  }
  
  void forward (float node) {
    node = map(node,0,1,-1,1); // remap to get the exact modifier
    PVector forwardMove = new PVector(accel * node,0);
    forwardMove.rotate(radians(angle));
    applyForce(forwardMove);
  }
  
  void left (float node) {
    node = map(node,0,1,-1,1); // remap to get the exact modifier
    PVector leftMove = new PVector(0,-accel * node * 0.6); // not as effiecient as going forward/back, for some particular reason
    leftMove.rotate(radians(angle));
    applyForce(leftMove);
  }
  
  void turnR (float node) {
    node = map(node,0,1,-1,1); // remap to get the exact modifier
    angle += aSpeed * node;
  }
  
  void interact (float node) { // for now, handles damage as well
    if (node > 0.95) {
      boolean found = false;
      int i = 0;
      while (i < areaMap.hives.size() && !found) {
        Hive h = areaMap.hives.get(i);
        if (h.includes(location)) { 
          foodDelivered += food;
          food = 0;
          mat = maxCarry;
          HP = maxHP;
          E = maxE;
          Hg = maxHg;
          found = true;
        }
        ++i;
      }
      i = 0;
      while (i < areaMap.nodes.size() && !found) {
        Node n = areaMap.nodes.get(i);
        if (n.includes(location)) { 
          n.place(mat,id);
          mat = 0;
          food = maxCarry;
          found = true;
        }
        ++i;
      }
    }
  }
  
  void display () {
    fill(139,16,19);
    stroke(0);
    pushMatrix();
    translate(location.x,location.y);
    rotate(radians(angle));
    for (Eye e: eyes) {
      PVector p = e.getRelPos();
      line(0,0,p.x,p.y);
      ellipse(p.x,p.y,r/8,r/8);
    }
    ellipse(0,0,r,r);
    popMatrix();
  }
}