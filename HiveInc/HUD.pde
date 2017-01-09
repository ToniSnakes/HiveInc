class HUD {
  float W = hudMargin;
  boolean found = false;
  int foundAt = 0;
  
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
    Hive origin = areaMap.hives.get(0);
    text("Average Fitness of Origin: " + origin.averageFitness,30,60);
    text("Max Fitness of Origin: " + origin.maxFitness,30,80);
    text("Name of Best Creature of Origin: " + origin.best.name,30,100);
    text("Lifespan: " + origin.best.lifespan,30,120);
    text("Total Number of Deaths: " + deaths,30,140);
    text("Total Food Brought to Origin: " + origin.totalFood,30,160);
    float averageFitness = 0, maxFitness = 0, totalFood = 0;
    Creature best = new Creature(0,0,100,100);
    for (Hive h: areaMap.hives) {
      averageFitness += h.averageFitness;
      if (h.maxFitness > maxFitness) {
        maxFitness = h.maxFitness;
      }
      totalFood += h.totalFood;
      if (h.best.fitness > best.fitness) {
        best = h.best;
      }
    }
    averageFitness /= areaMap.hives.size();
    text("Average Fitness: " + averageFitness,30,200);
    text("Max Fitness: " + maxFitness,30,220);
    text("Name of Best Creature: " + best.name,30,240);
    text("Total Food Brought: " + totalFood,30,260);
    text("Total Nodes Upgraded: " + areaMap.nodesUpgraded,30,280);
    
    if (origin.totalFood > 0 && !found) {
      found = true;
      foundAt = deaths;
    }
    if (origin.totalFood > 0 && found) {
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
    
    fill(0);
    text("Pause: p    Train: t", 30, height-10);
    
    popMatrix();
  }
}