Creature test;
Hive hTest;
Node nTest;
Lava lTest;
Map areaMap;
HUD hud;
float mutationChance = 0.01;
float hudMargin = 400;
float e = 2.71828;
int deaths = 0;

void setup() {
  size(1200,600);
  test = new Creature(width/2-200,height/2,0);
  hTest = new Hive(width/2-200,height/2);
  nTest = new Node(width/2,height/2);
  lTest = new Lava(random(width),random(height),random(100,120));
  areaMap = new Map();
  hud = new HUD();
}

boolean pause = true, train = false;
void draw() {
  if (!train) {
    background(255);
    
    areaMap.display();
  }
  if (!pause || train) {
    //test.update();
    //hTest.run();
    areaMap.run();
  }
  if (!train) {
    //hTest.creatureDisplay();
    areaMap.creatureDisplay();
  }
  hud.display();
  if (train) {
    for (int i = 0; i < 100; ++i) {
      areaMap.run();
    }
  }
  //test.display();
  //hTest.display();
  //nTest.display();
  //lTest.display(); 
}

void keyPressed () {
  if (key == 'p' && !train) {
    pause = !pause;
  }
  if (key == 't' && pause) {
    train = !train;
  }
}