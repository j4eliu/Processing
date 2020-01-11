void setup() {
  Theatre galaxy = new Theatre("Galaxy Cinemas Waterloo", 5, 0);
  Theatre landmark = new Theatre("Landmark Cinemas Waterloo", 10, 0); 
  
  Movie h = new Movie("Halloween", 5); 
  Movie v = new Movie("Venom", 4);
  Movie asib = new Movie("A Star is Born", 4);
  Movie fm = new Movie("First Man", 2);
  Movie thug = new Movie("The Hate U Give", 4);  
  Movie sf = new Movie("Smallfoot", 2);
  Movie bter = new Movie("Bad Times at the El Royale", 2);
  
  Person john = new Person("John", 3, true);
  Person jane = new Person("Jane", 1, false); 
  Person birthday = new Person("Birthday Boy", 201, true);

  landmark.addToTheatre(h);
  landmark.addToTheatre(v);
  landmark.addToTheatre(asib);
  landmark.addToTheatre(thug); 
  landmark.addToTheatre(fm); 
  landmark.addToTheatre(bter); 

  galaxy.addToTheatre(h); 
  galaxy.addToTheatre(v); 
  galaxy.addToTheatre(asib);
  galaxy.addToTheatre(sf);

  landmark.nowPlaying();
  landmark.removeFromTheatre(fm);
  landmark.nowPlaying();
  
  galaxy.nowPlaying(); 
  galaxy.removeFromTheatre(v); 
  galaxy.nowPlaying(); 
 
  h.displayShowtimes(galaxy);
  thug.displayShowtimes(galaxy); 
  asib.displayShowtimes(landmark);
  
  john.buyTickets(h, galaxy);
  jane.buyTickets(asib, landmark);
  birthday.buyTickets(bter, landmark); 

  exit();
}
