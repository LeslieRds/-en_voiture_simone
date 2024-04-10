require 'faker'
require 'open-uri'
require 'date'

User.destroy_all

ADDRESSES = [
    '33 Rue des Deux Ponts, 75004, Paris',
    'Route de Sevres a Neuilly, 75004, Paris',
    '33 Rue des Deux Ponts, 75016, Paris',
    '12 Rue Saint-Bernard, 75004, Paris',
    '34 Bis Rue de Dunkerque, 75010, Paris',
]

IMAGES_URL = [
    "https://unsplash.com/fr/photos/photographie-a-mise-au-point-peu-profonde-de-volkswagen-coccinelle-orange-N7RiDzfF2iw",
    "https://unsplash.com/fr/photos/ford-mustang-gt-noire-N9Pf2J656aQ",
    "https://unsplash.com/fr/photos/berline-3-portes-sarcelle-sur-route-fwYZ3B_QQco",
    "https://unsplash.com/fr/photos/vehicule-bmw-bleu-4WBvCqeMaDE",
    "https://unsplash.com/fr/photos/vehicule-blanc-esvWH-owWug",
]

# CREATION OF 5 USERS
puts "----- CREATION OF 5 USERS -----"

User.create({email: "test@test.com", password: "password"})
User.create({email: "test2@test.com", password: "password"})
User.create({email: "test3@test.com", password: "password"})
User.create({email: "test4@test.com", password: "password"})
User.create({email: "test5@test.com", password: "password"})

# END OF CREATION OF 5 USERS
puts "----- END OF CREATION OF 5 USERS -----"




# CREATION OF 15 CARS
puts "----- CREATION OF 5 CARS -----"

i = 0

5.times do
    car = Car.new({brand: Faker::Vehicle.make, model: Faker::Vehicle.model, year_of_production: Faker::Vehicle.year, address: ADDRESSES.sample, price_per_day: rand(50..350)})
    car.user = User.all.reject { |user| user.cars.count > 5 }.sample
    if ENV["CLOUDINARY_URL"]
        file = URI.open(IMAGES_URL.shuffle.pop)
        car.photo.attach(io: file, filename: "#{i}.png", content_type: "image/png")
    end

    car.save!
end

# END OF CREATION OF 15 CARS
puts "----- END OF CREATION OF 15 CARS -----"
