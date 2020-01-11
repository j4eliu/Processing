class Person {
  String name; 
  int numPeople;
  boolean reserveSeats; 
  int movieNum; 
  String movieTime; 
  
  Person (String n, int np, boolean rs) {
    this.name = n;
    this.numPeople = np; 
    this.reserveSeats = rs; 
    this.movieTime = "0"; 
  }
  
  //lets a person buy tickets / reserve seats 
  void buyTickets(Movie m, Theatre t) {
    m.playing = m.checkIfPlaying(t);
        
    if (m.playing == true) {
      println("TICKET PURCHASE INFO for " + this.name);
      
      if (t.numSeats[movieNum] - this.numPeople < 0) //if not enough seats left
        println("  CANNOT PURCHASE: There are not enough seats left in this theatre"); 
      else {
        while (movieTime == "0") //chooses movie time from upcoming showtimes only
          movieTime = m.upcomingShowtimes[int(random(0,m.numShows))];
        
        println("  Movie: " + m.title);
        println("  Showtime: " + movieTime);
        
        if (reserveSeats == true) { //if the person wants to reserve seats 
          t.numSeats[movieNum] -= this.numPeople; //decreases number of available seats for the movie  
          println("  Seats: " + this.numPeople + ", RESERVED");
        }
        else
          println("  Seats: " + this.numPeople + ", NOT RESERVED");
      }
    }
    else //if movie isn't playing in theatre
      println("  CANNOT PURCHASE: " + m.title + " is not playing at " + t.name); 
      
    println("");
  } 
}
