class Lava {
  PVector location;
  String type;
  float R;
  
  Lava (float x, float y, float r) {
    super();
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

/*class Lava {
  ArrayList<PVector> margins;
  
  Lava (float x, float y, float r) {
    margins = new ArrayList<PVector>();
    ArrayList<PVector> next = new ArrayList<PVector>();
    float t = random(100);
    for (float a = 0; a < 180; a += 1) {
      r += map(noise(t),0,1,-1,1);
      float px = cos(radians(a)) * r + x;
      float py = sin(radians(a)) * r + y;
      margins.add(new PVector(px,py));
      //float qx = cos(radians(a+180)) * r * random(0.5,1.5) + x;
      //float qy = sin(radians(a+180)) * r * random(0.5,1.5) + y;
      float qx = cos(radians(a+180)) * r + x;
      float qy = sin(radians(a+180)) * r + y;
      next.add(new PVector(qx,qy));
      t += 1;
    }
    for (PVector p: next) {
      margins.add(p);
    }
    for (int i = next.size() - 1 ; i >= 0; --i) {
      margins.add(next.get(i));
    }
    margins.add(margins.get(0));
  }
  
  void display () {
    stroke(139,0,0);
    fill(255,0,0);
    beginShape();
    for (PVector p: margins) {
      vertex(p.x,p.y);
    }
    endShape();
  }
}*/

//fail

// noised vertexes