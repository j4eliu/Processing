int pointSize = 7;
int numPoints = 100;

Point2D[] S = new Point2D[ numPoints ]; //The set S
Point2D[] farthestPair = new Point2D[ 2 ]; //The two points of the farthest pair

ArrayList<Point2D> convexHull = new ArrayList(); //The vertices of the convex hull of S

color convexHullColour = color(255, 0, 0);
color genericColour = color(255, 255, 0);

Point2D currentPoint, minAnglePoint, nextPoint;
Vector currentVector, minAngleVector, nextVector;
float minAngle, angle, dist;
float maxDist = 0; //Sets the initial value for greatest distance
int max, min, maxCHIndex, minCHIndex, nextPointMax, nextPointMin;  

void setup() {
  background(0);
  size(600, 600);

  makeRandomPoints();
  findConvexHull();        
  findFarthestPair_EfficientWay();
  //findFarthestPair_BruteForceWay();
}

//Fills S with random points
void makeRandomPoints() {
  for (int i = 0; i < numPoints; i++) {
    int x = 50 + (int) random(0, 500);
    int y = 50 + (int) random(0, 500);
    S[i] = new Point2D(x, y);
  }
}

void draw() {        
  //Draws the random points in S
  for (int i=0; i<numPoints; i++) { 
    fill(genericColour);
    ellipse(this.S[i].x, this.S[i].y, pointSize, pointSize);
  }

  //Draws the lines connecting the points in the convex hull
  for (int i=0; i<convexHull.size()-1; i++) { 
    stroke(255);
    line(convexHull.get(i).x, convexHull.get(i).y, convexHull.get(i+1).x, convexHull.get(i+1).y);
    noStroke();
  }

  //Draws the points in the convex hull
  for (int i=0; i<convexHull.size(); i++) { 
    fill(convexHullColour);    
    ellipse(convexHull.get(i).x, convexHull.get(i).y, pointSize, pointSize);
  }

  //Draws a line connecting the farthest pair
  stroke(0, 255, 0); 
  line(farthestPair[0].x, farthestPair[0].y, farthestPair[1].x, farthestPair[1].y);
  noStroke();
}

//JARVIS WRAP METHOD
//Finds the points in convex hull by comparing angles of vectors
void findConvexHull() {
  //Creates initial points and vectors to compare to
  currentPoint = new Point2D(0, 0); 
  nextPoint = new Point2D(0, 0);
  currentVector = new Vector(1, 0);

  //Finds the lowest point (which is guaranteed to be in convex hull)
  for (int i=0; i<numPoints; i++) {
    if (S[i].y > currentPoint.y) 
      currentPoint = S[i];
  }
  
  convexHull.add(currentPoint);

  //Loop will stop checking for convex hull points when it returns back to the first (lowest) point
  while (nextPoint != convexHull.get(0)) {
    minAngle = 3.2; //Sets initial angle comparison to slightly greater than pi
    //since all angles measured will be smaller than pi

    for (int i=0; i<numPoints; i++) {      
      minAngleVector = S[i].subtract(currentPoint); //Creates a vector using a point
      angle = currentVector.getAngle(minAngleVector); //Calculates angle formed between the two vectors 
      //Updates angle/potential point if the two points are the same
      //or if the point has a vector that produces a smaller angle 
      if (nextPoint == currentPoint || angle < minAngle) {
        minAngle = angle; 
        nextPoint = S[i];
        nextVector = minAngleVector;
      }
    }
    //Current point & vector is replaced with next point in convex hull (the one that was just found)
    currentPoint = nextPoint; 
    convexHull.add(currentPoint);
    currentVector = nextVector;
  }
}

//ROTATING CALIPERS ALGORITHM
void findFarthestPair_EfficientWay() { 
  float maxCH = convexHull.get(0).y; 
  float minCH = convexHull.get(0).y; 
  Vector a = new Vector(1, 0); //a and b are initial horizontal vectors (X-axis)
  Vector b = new Vector(-1, 0); 

  boolean startingPointMax = false; 
  boolean startingPointMin = false; 
  
  for (int i=0; i<convexHull.size(); i++) {
    //Finds highest point in the convex hull
    if (convexHull.get(i).y < maxCH) {
      maxCH = convexHull.get(i).y;
      maxCHIndex = i; 
    }
    //Finds lowest point in the convex hull    
    if (convexHull.get(i).y > minCH) {
      minCH = convexHull.get(i).y;
      minCHIndex = i;
    }
  }

  //Sets new variables for max and min points in convex hull and the succeeding points
  max = maxCHIndex; 
  min = minCHIndex;
  nextPointMax = max + 1;
  nextPointMin = min + 1;  

  //Loop will keep running until all points in the convex xhull have been tested
  while (!startingPointMax && !startingPointMin) {
    //Determines next points in the convex hull

    //Finds the vector formed from the current point and the next point in the convex hull
    Vector c = ( convexHull.get(max) ).subtract( convexHull.get(nextPointMax) );
    Vector d = ( convexHull.get(min) ).subtract( convexHull.get(nextPointMin) );
 
    //Calculates the angle between the current convex hull vectors to the previous vectors
    //and rotates the vectors using the vectors that form the smaller angle
    if (c.getAngle(a) < d.getAngle(b)) { //Rotates vectors if angle formed from highest points gives smaller angle 
      a = c;
      b = new Vector(-a.xComponent, -a.yComponent);
      max++;
      nextPointMax++;
      
      //Will stop the loop once the next point tested is the original 
      if (max == maxCHIndex) 
        startingPointMax = true;
    } 
    
    else { //Rotates if angle formed from lowest points gives smaller angle 
      b = d; 
      a = new Vector(-b.xComponent, -b.yComponent);
      min++;   
      nextPointMin++;
      
      if (min == minCHIndex) 
        startingPointMin = true;
    }

    //Calculates the distance between the points 
    dist = sqrt( pow(convexHull.get(max).y-convexHull.get(min).y, 2) + pow(convexHull.get(max).x-convexHull.get(min).x, 2) ); 

    //Updates greatest distance and records the pair of points that produces it
    if (dist > maxDist) {
      maxDist = dist; 
      farthestPair[0] = convexHull.get(max);
      farthestPair[1] = convexHull.get(min);
    }

    //Once the end of the convex hull array is reached,
    //the current points being tested will return to the first point in the convex hull
    if (max >= convexHull.size()-1)
      max = 0;
    if (min >= convexHull.size()-1)
      min = 0; 
    if (nextPointMax >= convexHull.size()-1)
      nextPointMax = 0; 
    if (nextPointMin >= convexHull.size()-1)
      nextPointMin = 0;
  }
}

//BRUTE FORCE METHOD
void findFarthestPair_BruteForceWay() {
  //Calculates distance between each pair of points in S
  for (int i=0; i<numPoints; i++) {
    for (int j=0; j<numPoints; j++) {
      dist = sqrt( pow(S[j].y - S[i].y, 2) + pow(S[j].x - S[i].x, 2) ); 

      //Updates greatest distance and records the pair of points that produces it
      if (dist > maxDist) {
        maxDist = dist; 
        farthestPair[0] = S[i];
        farthestPair[1] = S[j];
      }
    }
  }
}
