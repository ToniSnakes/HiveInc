class Node {
  PVector location;
  String type;
  float w = 30;
  float progress = 0, upThreshold = 9000;
  
  Node (float x, float y) {
    location = new PVector(x,y);
    type = "Node";
  }
  
  void place (float mat) {
    progress += mat;
  }
  
  boolean upgrade () {
    if (progress >= upThreshold) {
      return true;
    }
    return false;
  }
  
  boolean includes (PVector loc) {
    if (loc.x > location.x - w/2 && loc.x < location.x + w/2 && loc.y > location.y - w/2 && loc.y < location.y + w/2) {
      return true;
    }
    return false;
  }
  
  void display () {
    stroke(0);
    fill(0,128,0);
    rectMode(CENTER);
    rect(location.x,location.y,w,w);
  }
}