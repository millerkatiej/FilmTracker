As a film tracker I want to enter in vital information about a movie and when I viewed it in order to keep track of my film watching habits.

Usage: ./FilmTracker stats "Title"

Acceptance Criteria:
* Stores the title, director, country of origin, release year, language, distributor, date viewed, personal rating, format, and whether it has been previously viewed.

--

As a film tracker I want to see the types of films I view the most in order to see my film preferences.

Usage: ./FilmTracker stats "Director"

Acceptance Criteria:
* Calculates the films I've viewed based on the previously mentioned criteria, and sorts them based on any of the groups.

--

As a film tracker, I want to know which films I have watched multiple times in order to see if my opinions on them have changed.

Usage: ./FilmTracker stats "PreviouslyViewed"

Acceptance Criteria:
* Displays films that I have viewed before, even if I do not remember having done so.
* Looks in the database for duplicates.
* Compares my personal ratings for the films.

