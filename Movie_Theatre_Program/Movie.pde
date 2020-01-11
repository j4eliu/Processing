class Movie {
  String title;
  int numShows;
  String[] showtimes, upcomingShowtimes; 
  boolean playing; 

  Movie (String t, int ns) {
    this.title = t; 
    this.numShows = ns;
    this.showtimes = new String[numShows];
    this.upcomingShowtimes = new String[numShows];
    this.playing = false; 
  }

  //displays all the showtimes throughout the day for the movie / theatre
  void displayShowtimes(Theatre t) {
    int hour, twelveHour; 
    String min, ampm; 
    
    this.playing = checkIfPlaying( t );
    
    if (this.playing == true) { 
      println("SHOWTIMES for " + this.title + " at " + t.name);
  
      //sets various starting times based on # of times it will be played  
      if (this.numShows == 6)
        hour = 10;
      else if (this.numShows == 4)
        hour = 14;
      else
        hour = 18;
  
      for (int i=0; i<this.numShows; i++) {
        min = str(round(random(0, 60)));
  
        //changes 24-hour to 12-hour time 
        if (int(min) < 10) 
          min = 0 + min;
          
        if (hour == 24) { 
          twelveHour = hour - 12; 
          ampm = "am";
        }
        else if (hour == 12) {
          twelveHour = hour; 
          ampm = "pm";
        }
        else if (hour > 24) { 
          twelveHour = hour - 24; 
          ampm = "am";    
        }
        else if (hour > 12) {
          twelveHour = hour - 12; 
          ampm = "pm";
        } 
        else {
          twelveHour = hour; 
          ampm = "am";
        }
        
        //indicates if the showtime has already passed 
        if (t.h > hour || (t.h == hour && t.m >= int(min))) {
          this.showtimes[i] = "X " + twelveHour + ":" + min + ampm + " X"; 
          this.upcomingShowtimes[i] = "0"; 
        }

        else {
          this.showtimes[i] = twelveHour + ":" + min + ampm;
          this.upcomingShowtimes[i] = this.showtimes[i]; //keeps track of upcoming showtimes only 
        }
          
        hour += round(random(1, 4)); 
        println("  " + this.showtimes[i]);
      }
    }
    
    //if movie is not playing in the theatre 
    else 
      println("There are no showtimes for " + this.title + " at " + t.name);  
      
  println("");
  }
   
  //checks if movie has been already added to theatre
  boolean checkIfPlaying(Theatre t) {
    for (int i=0; i<t.numAud; i++) {
      if (t.moviesPlaying[i] == this.title) {
        this.playing = true; 
        break;
      }
    }  
    return this.playing; 
  }
}
