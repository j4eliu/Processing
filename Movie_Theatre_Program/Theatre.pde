class Theatre {
  String name;
  int numAud, numMovies; 
  String[] moviesPlaying;
  int[] numSeats;
  int h, m; 

  Theatre(String n, int na, int nm) {
    this.name = n;
    this.numAud = na; 
    this.numMovies = nm;
    this.moviesPlaying = new String[this.numAud];
    this.numSeats = new int[this.numAud]; 
    this.h = hour();
    this.m = minute(); 
  }
  
  //adds movie to play in the theatre
  void addToTheatre(Movie m) {
    if (this.numMovies == this.numAud) //if too many movies playing already in the theatre
      println(m.title + " is not playing at " + this.name); 
    
    for (int i=0; i<this.numAud; i++) { 
      if (i >= this.numMovies) {
        if (this.moviesPlaying[i] == null) { //adds movie to auditorium if currently empty
          this.moviesPlaying[i] = m.title;
          this.numMovies++; 
          this.numSeats[i] = int(random(100,200)); //sets random value for # of available seats for the movie
          println(m.title + " is now playing at " + this.name);
          break;
        }
      }     
    }
    println("");
  }
  
  //removes the movie from the theatre's auditorium
  void removeFromTheatre(Movie m) {  
    for (int i=0; i<this.numAud; i++) {
      if (moviesPlaying[i] == m.title) {
        println(m.title + " is no longer playing at " + this.name);
        moviesPlaying[i] = null;
      }
    }
    println("");
  } 
  
  //displays all of the movies currently playing at the theatre
  void nowPlaying() { 
    println("NOW PLAYING at " + this.name); 
    
    for (int i=0; i<this.numAud; i++) {
      if (this.moviesPlaying[i] != null)
        println("  " + this.moviesPlaying[i]);
    }
    
    println("");
  } 
}
