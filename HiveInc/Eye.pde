class Eye {
  float dist, angle;
  
  Eye (float x, float y) {
    dist = x;
    angle = y;
    //offset = new PVector(x,y);
  }
  
  PVector getRelPos () {
    float x = cos(radians(angle)) * dist;
    float y = sin(radians(angle)) * dist;
    return new PVector(x,y);
  }
  
  color look (PVector location, float a) {
    float trueAngle = angle + a;
    int x = round(cos(radians(trueAngle)) * dist + location.x);
    int y = round(sin(radians(trueAngle)) * dist + location.y);
    int pixelPos = y * width + x;
    color c;
    if (pixelPos < 0 || pixelPos > width * height - 1) {
      c = color(0,0,0);
    }
    else {
      c = pixels[pixelPos]; // !loadPixels() before looking!
    }
    return c;
  }
}