# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "json"
require "open-uri"

puts 'Destruction in progress, renewal to come...'

Bookmark.destroy_all
Movie.destroy_all
List.destroy_all
url = "https://tmdb.lewagon.com/movie/top_rated"
movies_serialized = URI.open(url).read
movies = JSON.parse(movies_serialized)
movies["results"].each do |movie_json|
  infos = {
    title: movie_json["title"],
    overview: movie_json["overview"],
    poster_url: "https://image.tmdb.org/t/p/original#{movie_json['poster_path']}",
    rating: movie_json["vote_average"]
  }
  movie = Movie.new(infos)
  movie.save!
end
puts '...The cycle is completed'
