# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require "json"
require "open-uri"

url = "https://tmdb.lewagon.com/movie/top_rated"
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)

# puts movies["results"]
puts "Destroying database..."
Movie.destroy_all
puts "Database destroyed"

movies["results"].each do |movie|
  Movie.create(title: movie["title"], overview: movie["overview"], poster_url: "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}", rating: movie["vote_average"])
  puts "movie #{movie["title"]} created"
end

puts "Database created!"
