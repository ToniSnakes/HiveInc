class HUD {
  float W = hudMargin;
  
  HUD () {
    
  }
  
  void display () {
    stroke(0);
    fill(255,128,0);
    pushMatrix();
    translate(width-W,0);
    rect(W/2,height/2,W,height);
    PFont font = createFont("Arial",16,true);
    textFont(font, 14);
    fill(0);
    text("<<STILL IN DEVELOPMENT>>",30,40);
    Hive hTest = areaMap.hives.get(0);
    text("Average Fitness: " + hTest.averageFitness,30,60);
    text("Max Fitness: " + hTest.maxFitness,30,80);
    text("Name of Best Creature: " + hTest.best.name,30,100);
    text("Lifespan: " + hTest.best.lifespan,30,120);
    //text("Random Fitness: " + hTest.creatures[int(random(hTest.creatures.length))].fitness,30,120);
    text("Total Number of Deaths: " + deaths,30,140);
    text("Total Food Brought: " + hTest.totalFood,30,160);
    boolean found = false;
    int foundAt = 0;
    if (hTest.totalFood > 0 && !found) {
      found = true;
      foundAt = deaths;
    }
    if (hTest.totalFood > 0) {
      text("Deaths Necessary to Bring in Food: " + foundAt,30,180);
    }
    else {
      text("No Food as of Yet",30,180);
    }
    if (pause && !train) {
      fill(128,0,0);
    }
    else
    if (train) {
      fill(0,0,128);
    }
    else {
      fill(0,200,0);
    }
    rect(W-5,height-5,10,10);
    popMatrix();
  }
}