class Lava {
  PVector location;
  String type;
  float R;
  
  Lava (float x, float y, float r) {
    location = new PVector(x,y);
    R = r;
    type = "Lava";
  }
  
  boolean includes (PVector loc) {
    if (PVector.dist(location,loc) < R/2) {
      return true;
    }
    return false;
  }
  
  void display () {
    stroke(128,0,0);
    fill(255,0,0);
    ellipse(location.x,location.y,R,R);
  }
}