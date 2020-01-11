class Point2D {
  float x, y;
  boolean visited; //might need this in the convex hull finding algorithm
  color col;
    
  Point2D(int x, int y) {
    this.x = x;
    this.y = y;
    this.visited = false;
    this.col = color(255,255,0);
  }
    
  //Returns the vector that stretches between this and other.
  Vector subtract( Point2D other ) {
    return new Vector( this.x - other.x, this.y - other.y);
  }
}
