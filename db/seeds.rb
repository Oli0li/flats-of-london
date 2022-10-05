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

puts "Creating new flats..."

Flat.create!(
  name: 'Stunning flat in a quiet area',
  address: '10 Clifton Gardens, London W9 1DT',
  description: 'A lovely summer feel for this spacious garden flat. Two double bedrooms, open plan living area, large kitchen and a beautiful conservatory',
  price_per_night: 90,
  number_of_guests: 4,
  user: robert
)
puts "Flat 1 created"

Flat.create!(
  name: 'Charming room with a historic flair',
  address: '236 Baker St, London NW1 5RS',
  description: 'A quaint room in the heart of London. One double bedroom with view on the Sherlock Holmes Museum',
  price_per_night: 85,
  number_of_guests: 2,
  user: linda
)
puts "Flat 2 created"

Flat.create!(
  name: 'Spacious flat in the heart of Chiswick',
  address: '214 Chiswick High Road, London W4 1PD',
  description: 'A spacious flat near the Sunday market, close to shops and restaurants.',
  price_per_night: 75,
  number_of_guests: 2,
  user: mel
)
puts "Flat 3 created"

Flat.create!(
  name: 'Beautiful studio near Paddington station and Hyde Park',
  address: '4 Sussex Place, London W2 2TP',
  description: 'Modern studio with all necessary amenities, just an 8-minute walk from Paddington station and Hyde Park.',
  price_per_night: 100,
  number_of_guests: 3,
  user: linda
)
puts "Flat 4 created"

Flat.create!(
  name: 'Cosy flat near Camden Town',
  address: '101 Bayham St, London NW1 0AG',
  description: 'A quiet flat close to the bustling market of Camden. En-suite bathroom and large kitchen with all modern amenities.',
  price_per_night: 65,
  number_of_guests: 2,
  user: robert
)
puts "Flat 5 created"

Flat.create!(
  name: 'Stunning manor house in Richmond',
  address: '135 Petersham road, Richmond TW10 7AA',
  description: '17th century manor house opposite Richmond Park. Huge garden with swimming pool, 5 double bedrooms, en-suite bathrooms and a modern kitchen.',
  price_per_night: 2000,
  number_of_guests: 7,
  user: josh
)
puts "Flat 6 created"
puts "All done!"
