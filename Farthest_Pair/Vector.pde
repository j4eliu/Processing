class Vector {

  float xComponent, yComponent;
    
  Vector(float x, float y) {
    this.xComponent = x;
    this.yComponent = y;
  }
    
  //needed as part of the convex hull algorithm and for finding the farthest pair within the vertices of the convex hull
  Vector subtract( Vector other ) {
    return new Vector( this.xComponent - other.xComponent, this.yComponent - other.yComponent);
  }
    
  //needed as part of the convex hull algorithm and for finding the farthest pair within the vertices of the convex hull
  float getAngle( Vector other ) {  
    float vDotw = this.dotProduct( other );
    float magV = this.magnitude();
    float magW = other.magnitude();
        
    return acos( vDotw / (magV*magW) );
  }
    
  //only used inside getAngle()
  float dotProduct( Vector other ) {
    return this.xComponent*other.xComponent + this.yComponent*other.yComponent;
  }
    
  //only used inside getAngle()
  float magnitude() {
    return sqrt( this.xComponent*this.xComponent + this.yComponent*this.yComponent );
  }
}
