Map areaMap;
HUD hud;
float mutationChance = 0.01;
float hudMargin = 400;
float e = 2.71828;
int deaths = 0;

void setup() {
  size(1200,600);
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
    areaMap.run();
    areaMap.checkUpgrades();
  }
  if (!train) {
    areaMap.creatureDisplay();
  }
  hud.display(); 
}

void keyPressed () {
  if (key == 'p' && !train) {
    pause = !pause;
  }
  if (key == 't' && pause) {
    train = !train;
  }
  if (key == 'r' && pause && !train) { // reset
    areaMap = new Map();
    hud = new HUD();
  }
}