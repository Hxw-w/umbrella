# Write your solution below!

require "http"
require "json"
require "dotenv/load"

puts "======================================"
puts "   Will you need an umbrella today?   "
puts "======================================"
puts
puts "Where are you?"

# Get user's location
location = gets.chomp
puts "Chkecking the weather at " + location + "..."

# Get lat/lng from Google Map
gmap_key = ENV.fetch("GMAPS_KEY")
gmap_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=#{gmap_key}"

raw_gmaps_data = HTTP.get(gmap_url)
gmap_data = JSON.parse(raw_gmaps_data)

# pp gmap_data

lat = gmap_data.fetch("results").at(0).fetch("geometry").fetch("location").fetch("lat")
lng = gmap_data.fetch("results").at(0).fetch("geometry").fetch("location").fetch("lng")

puts "Your coordinates are #{lat}, #{lng}."

# Get Weather infomation from Pirate using the coordinate
pirate_weather_key = ENV.fetch("PIRATE_WEATHER_KEY")
pirate_weather_url = "https://api.pirateweather.net/forecast/#{pirate_weather_key}/#{lat},#{lng}"

raw_pirate_weather_data = HTTP.get(pirate_weather_url)
pirate_weather_data = JSON.parse(raw_pirate_weather_data)

current_temp = pirate_weather_data.fetch("currently").fetch("temperature")
puts "It is currently #{current_temp}˚F"


