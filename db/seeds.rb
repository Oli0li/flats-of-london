# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Destroying all users and flats..."
User.destroy_all
puts "Destroying all flats..."
Flat.destroy_all

puts "Creating new users..."

robert = User.create!(
  name: "Robert",
  email: "robert@mail.com",
  password: "ilikeflats"
)

puts "User 1 created"

linda = User.create!(
  name: "Linda",
  email: "linda@mail.com",
  password: "ilikeflats2"
)
puts "User 2 created"

mel = User.create!(
  name: "Mel",
  email: "mel@mail.com",
  password: "ilikeflats3"
)
puts "User 3 created"

josh = User.create!(
  name: "Josh",
  email: "josh@mail.com",
  password: "ilikeflats4"
)
puts "User 4 created"

puts "adding user pictures"

users = User.all

4.times do |x|
  url = Cloudinary::Uploader.upload("app/assets/images/user_picture_#{x + 1}.jpg")["secure_url"]
  picture = URI.open(url)
  users[x].photo.attach(io: picture, filename: "user_#{x + 1}.jpg", content_type: "image/jpg")
end

puts "user pictures added"

puts "Creating new flats..."

Flat.create!(
  name: 'Charming flat in a quiet area',
  address: '10 Clifton Gardens, London W9 1DT',
  description: 'A lovely summer feel for this spacious garden flat. Two double bedrooms, open plan living area, large kitchen and a beautiful conservatory',
  price_per_night: 90,
  number_of_guests: 4,
  user: robert
)
puts "Flat 1 created"

Flat.create!(
  name: 'Modern penthouse in Waterloo',
  address: "200 Westminster Bridge Rd, London SE1 7UT",
  description: 'This modern penthouse has everything you could ask for, including a view on the Houses of Parliament and London Eye.',
  price_per_night: 100,
  number_of_guests: 2,
  user: linda
)
puts "Flat 2 created"

Flat.create!(
  name: 'Spacious flat in the heart of London',
  address: '36 Bloomsbury Way, London WC1A 2SD',
  description: 'A spacious flat in a very central location, close to the British Museum, shops and restaurants.',
  price_per_night: 150,
  number_of_guests: 3,
  user: mel
)
puts "Flat 3 created"

Flat.create!(
  name: 'Beautiful studio in Spitafields',
  address: '40 Fashion St, London E1 6PX',
  description: 'Modern studio with all necessary amenities, close to Spitafields Market and the vibrant district of Shoreditch.',
  price_per_night: 100,
  number_of_guests: 3,
  user: linda
)
puts "Flat 4 created"

Flat.create!(
  name: 'Cosy flat near Camden Town',
  address: '101 Bayham St, London NW1 0AG',
  description: 'A quiet flat close to the bustling market of Camden. En-suite bathroom and large kitchen with all modern amenities.',
  price_per_night: 75,
  number_of_guests: 2,
  user: robert
)
puts "Flat 5 created"

Flat.create!(
  name: 'Stunning flat in a historical house',
  address: "100 Queen's Gate, London SW7 5AG",
  description: '17th century house in South Kensington, near the museums. Very chic district with convenient access to central London.',
  price_per_night: 200,
  number_of_guests: 2,
  user: josh
)
puts "Flat 6 created"

puts "adding flat pictures"

flats = Flat.all

6.times do |x|
  url = Cloudinary::Uploader.upload("app/assets/images/flat_picture_#{x + 1}_a.jpg")["secure_url"]
  picture = URI.open(url)
  flats[x].photos.attach(io: picture, filename: "flat_#{x + 1}_a.jpg", content_type: "image/jpg")
  url = Cloudinary::Uploader.upload("app/assets/images/flat_picture_#{x + 1}_b.jpg")["secure_url"]
  picture = URI.open(url)
  flats[x].photos.attach(io: picture, filename: "flat_#{x + 1}_b.jpg", content_type: "image/jpg")
end

puts "flat pictures added"

puts "All done!"
