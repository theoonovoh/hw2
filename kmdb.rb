# In this assignment, you'll be using the domain model from hw1 (found in the hw1-solution.sql file)
# to create the database structure for "KMDB" (the Kellogg Movie Database).
# The end product will be a report that prints the movies and the top-billed
# cast for each movie in the database.

# To run this file, run the following command at your terminal prompt:
# `rails runner kmdb.rb`

# Requirements/assumptions
#
# - There will only be three movies in the database – the three films
#   that make up Christopher Nolan's Batman trilogy.
# - Movie data includes the movie title, year released, MPAA rating,
#   and studio.
# - There are many studios, and each studio produces many movies, but
#   a movie belongs to a single studio.
# - An actor can be in multiple movies.
# - Everything you need to do in this assignment is marked with TODO!
# - Note rubric explanation for appropriate use of external resources.

# Rubric
# 
# There are three deliverables for this assignment, all delivered within
# this repository and submitted via GitHub and Canvas:
# - Generate the models and migration files to match the domain model from hw1.
#   Table and columns should match the domain model. Execute the migration
#   files to create the tables in the database. (5 points)
# - Insert the "Batman" sample data using ruby code. Do not use hard-coded ids.
#   Delete any existing data beforehand so that each run of this script does not
#   create duplicate data. (5 points)
# - Query the data and loop through the results to display output similar to the
#   sample "report" below. (10 points)
# - You are welcome to use external resources for help with the assignment (including
#   colleagues, AI, internet search, etc). However, the solution you submit must
#   utilize the skills and strategies covered in class. Alternate solutions which
#   do not demonstrate an understanding of the approaches used in class will receive
#   significant deductions. Any concern should be raised with faculty prior to the due date.

# Submission
# 
# - "Use this template" to create a brand-new "hw2" repository in your
#   personal GitHub account, e.g. https://github.com/<USERNAME>/hw2
# - Do the assignment, committing and syncing often
# - When done, commit and sync a final time before submitting the GitHub
#   URL for the finished "hw2" repository as the "Website URL" for the 
#   Homework 2 assignment in Canvas

# Successful sample output is as shown:

# Movies
# ======

# Batman Begins          2005           PG-13  Warner Bros.
# The Dark Knight        2008           PG-13  Warner Bros.
# The Dark Knight Rises  2012           PG-13  Warner Bros.

# Top Cast
# ========

# Batman Begins          Christian Bale        Bruce Wayne
# Batman Begins          Michael Caine         Alfred
# Batman Begins          Liam Neeson           Ra's Al Ghul
# Batman Begins          Katie Holmes          Rachel Dawes
# Batman Begins          Gary Oldman           Commissioner Gordon
# The Dark Knight        Christian Bale        Bruce Wayne
# The Dark Knight        Heath Ledger          Joker
# The Dark Knight        Aaron Eckhart         Harvey Dent
# The Dark Knight        Michael Caine         Alfred
# The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
# The Dark Knight Rises  Christian Bale        Bruce Wayne
# The Dark Knight Rises  Gary Oldman           Commissioner Gordon
# The Dark Knight Rises  Tom Hardy             Bane
# The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
# The Dark Knight Rises  Anne Hathaway         Selina Kyle

# Delete existing data, so you'll start fresh each time this script is run.
# Use `Model.destroy_all` code.
# TODO!

Studio.destroy_all
Movie.destroy_all
Actor.destroy_all
Role.destroy_all

# Generate models and tables, according to the domain model.
# TODO!

#rails generate model Studio name:string
#rails generate model Movie title:string year_released:integer rating:string studio:references
#rails generate model Actor name:string
#rails generate model Role movie:references actor:references character_name:string


# Insert data into the database that reflects the sample data shown above.
# Do not use hard-coded foreign key IDs.
# TODO!

# Create Studio
warner_bros = Studio.create(name: "Warner Bros.")

# Create Movies
batman_begins = Movie.create(title: "Batman Begins", year_released: 2005, rating: "PG-13", studio: warner_bros)
dark_knight = Movie.create(title: "The Dark Knight", year_released: 2008, rating: "PG-13", studio: warner_bros)
dark_knight_rises = Movie.create(title: "The Dark Knight Rises", year_released: 2012, rating: "PG-13", studio: warner_bros)

# Create Actors
actors = {
  "Christian Bale" => Actor.create(name: "Christian Bale"),
  "Michael Caine" => Actor.create(name: "Michael Caine"),
  "Liam Neeson" => Actor.create(name: "Liam Neeson"),
  "Katie Holmes" => Actor.create(name: "Katie Holmes"),
  "Gary Oldman" => Actor.create(name: "Gary Oldman"),
  "Heath Ledger" => Actor.create(name: "Heath Ledger"),
  "Aaron Eckhart" => Actor.create(name: "Aaron Eckhart"),
  "Maggie Gyllenhaal" => Actor.create(name: "Maggie Gyllenhaal"),
  "Tom Hardy" => Actor.create(name: "Tom Hardy"),
  "Joseph Gordon-Levitt" => Actor.create(name: "Joseph Gordon-Levitt"),
  "Anne Hathaway" => Actor.create(name: "Anne Hathaway")
}

# Assign Roles
roles = [
  [batman_begins, "Christian Bale", "Bruce Wayne"],
  [batman_begins, "Michael Caine", "Alfred"],
  [batman_begins, "Liam Neeson", "Ra's Al Ghul"],
  [batman_begins, "Katie Holmes", "Rachel Dawes"],
  [batman_begins, "Gary Oldman", "Commissioner Gordon"],
  [dark_knight, "Christian Bale", "Bruce Wayne"],
  [dark_knight, "Heath Ledger", "Joker"],
  [dark_knight, "Aaron Eckhart", "Harvey Dent"],
  [dark_knight, "Michael Caine", "Alfred"],
  [dark_knight, "Maggie Gyllenhaal", "Rachel Dawes"],
  [dark_knight_rises, "Christian Bale", "Bruce Wayne"],
  [dark_knight_rises, "Gary Oldman", "Commissioner Gordon"],
  [dark_knight_rises, "Tom Hardy", "Bane"],
  [dark_knight_rises, "Joseph Gordon-Levitt", "John Blake"],
  [dark_knight_rises, "Anne Hathaway", "Selina Kyle"]
]

roles.each do |movie, actor_name, character_name|
  Role.create(movie: movie, actor: actors[actor_name], character_name: character_name)
end

# Prints a header for the movies output
puts "Movies"
puts "======"
puts ""

# Query the movies data and loop through the results to display the movies output.
# TODO!

Movie.all.each do |movie|
    puts "#{movie.title.ljust(22)} #{movie.year_released}    #{movie.rating.ljust(5)}  #{movie.studio.name}"
  end

# Prints a header for the cast output
puts ""
puts "Top Cast"
puts "========"
puts ""

# Query the cast data and loop through the results to display the cast output for each movie.
# TODO!

Role.includes(:movie, :actor).all.each do |role|
    puts "#{role.movie.title.ljust(22)} #{role.actor.name.ljust(20)} #{role.character_name}"
  end