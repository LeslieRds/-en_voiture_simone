require 'faker'
require 'open-uri'
require 'date'
require 'json'
require 'geocoder'
puts "destruction des utilisateurs, des véhicules et des réservations"
User.destroy_all
Car.destroy_all
Booking.destroy_all
puts "destruction faites!"

puts "création des véhicules"
cars = [
        { brand: 'Peugeot', model: '508', year_of_production: "2018", address: '50, avenue de Lebon', zipcode: '75938', city: 'Carre', nb_passenger: '5', latitude: '-52.4872775', longitude: '-129.088124', price_per_day: '96', description: 'A Peugeot 508 from 2018, perfect for both urban and long-distance travel. Comfort and efficiency guaranteed.', image_url: "https://unsplash.com/fr/photos/une-voiture-blanche-garee-dans-un-boise-LuIHTPtTo8s"},
        { brand: 'Renault', model: 'Clio', year_of_production: '2023', address: '38, rue Nathalie Legrand', zipcode: '78156', city: 'Bourdon', nb_passenger: '4',latitude: '81.9123475', longitude: '-70.221847', price_per_day: '94', description: 'A Renault Clio from 2023, perfect for both urban and long-distance travel. Comfort and efficiency guaranteed.', image_url: "https://unsplash.com/fr/photos/berline-noire-sur-la-route-pendant-la-nuit-uOhYRAcCYes"},
        { brand: 'Citroën', model: 'C3', year_of_production: '2015', address: '97, rue Susan Lévy', zipcode: '16097', city: 'Berger', nb_passenger: '6', latitude: '-2.7036195', longitude: '-146.185575', price_per_day: '99', description: 'A Citroën C3 from 2015, perfect for both urban and long-distance travel. Comfort and efficiency guaranteed.', image_url: "https://unsplash.com/fr/photos/lembleme-dune-voiture-recouverte-de-neige-QkzrJfe69Mk"},
        { brand: 'Toyota', model: 'Corolla', year_of_production: '2023', address: '333, avenue de Robin', zipcode: '58714', city: 'KleinBourg', nb_passenger: '5', latitude: '56.9525505', longitude: '-1.355929', price_per_day: '59', description: 'A Toyota Corolla from 2023, perfect for both urban and long-distance travel. Comfort and efficiency guaranteed.', image_url: "https://unsplash.com/fr/photos/mercedes-benz-coupe-blanc-sur-route-en-beton-gris-5pLxPUtziIQ"},
        { brand: 'Tesla', model: 'Model 3', year_of_production: '2018', address: '99, chemin de Hebert', zipcode: '96593', city: 'Gonzalez', nb_passenger: '5', latitude: '-39.160654', longitude: '-79.750346', price_per_day: '39', description: 'A Tesla Model 3 from 2018, perfect for both urban and long-distance travel. Comfort and efficiency guaranteed.', image_url: "https://unsplash.com/fr/photos/parking-de-vehicule-gris-sur-lherbe-DiJR_M1Mv_A"},
        { brand: 'BMW', model: 'Series 3', year_of_production: '2017', address: 'chemin de Ollivier', zipcode: '12201', city: 'Normandnec', nb_passenger: '4', latitude: '50.814245', longitude: '-32.020057', price_per_day: '43', description: 'A BMW Series 3 from 2017, perfect for both urban and long-distance travel. Comfort and efficiency guaranteed.', image_url: "https://unsplash.com/fr/photos/voiture-noire-au-coucher-du-soleil-Nz0D8aN5Kw0"},
        { brand: 'Audi', model: 'A4', year_of_production: '2023', address: '73, chemin de Lebreton', zipcode: '51591', city: 'Costeboeuf', nb_passenger: '7', latitude: '-38.8955675', longitude: '-49.521243', price_per_day: '39', description: 'A Audi A4 from 2023, perfect for both urban and long-distance travel. Comfort and efficiency guaranteed.', image_url: "https://unsplash.com/fr/photos/vehicule-noir-sur-la-route-entre-les-arbres-pendant-la-journee-Yp9FdEqaCdk"},
        { brand: 'Mercedes', model: "C-Class", year_of_production: "2020", address: 'chemin de Ferreira', zipcode: '52560', city: 'Saint Dominique-sur-Mer', nb_passenger: "5", latitude: '-77.857573', longitude: '128.091981', price_per_day: "60", description: 'A Mercedes C-Class from 2020, perfect for both urban and long-distance travel. Comfort and efficiency guaranteed.', image_url: "https://unsplash.com/fr/photos/une-voiture-est-garee-dans-un-garage--e6vXuw350s"},
        { brand: 'Volkswagen', model: 'Golf', year_of_production: "2015", address: '191, rue Seguin', zipcode: '61510', city: 'Simon-sur-Leclercq', nb_passenger: "7", latitude: '-40.3469735', longitude: '-113.484289', price_per_day: "89", description: 'A Volkswagen Golf from 2015, perfect for both urban and long-distance travel. Comfort and efficiency guaranteed.', image_url: "https://unsplash.com/fr/photos/berline-5-portes-argentee-garee-au-milieu-de-la-route-pendant-la-journee-nH6uHS1g5Vw"},
        { brand: 'Ford', model: 'Focus', year_of_production: "2022", address: '10, avenue de Legendre', zipcode: '41314', city: 'Nguyen', nb_passenger: "4", latitude: '-41.596282', longitude: '-147.228089', price_per_day: "80", description: 'A Ford Focus from 2022, perfect for both urban and long-distance travel. Comfort and efficiency guaranteed.', image_url: "https://unsplash.com/fr/photos/ford-fiesta-5-portes-a-hayon-bleue-yjZAWYZY2jM"},
        { brand: 'Fiat', model: '500', year_of_production: '2015', address: '20, avenue de Bourgeois', zipcode: '57923', city: 'Saint Camille', nb_passenger: "4", latitude: '-46.5257845', longitude: '3.777646', price_per_day: "60", description: 'A Fiat 500 from 2015, perfect for both urban and long-distance travel. Comfort and efficiency guaranteed.', image_url:"https://unsplash.com/fr/photos/voiture-a-hayon-blanche-a-5-portes-garee-a-cote-dun-batiment-en-beton-brun-pendant-la-journee-fTDYvXNjAKU"},
        { brand: 'Honda', model: 'Civic', year_of_production: '2016', address: '81, rue de Richard', zipcode: '69845', city: 'Descamps-la-Forêt', nb_passenger: '7', latitude: '-48.818574', longitude: '120.969950', price_per_day: "87", description: 'A Honda Civic from 2016, perfect for both urban and long-distance travel. Comfort and efficiency guaranteed.', image_url: "https://unsplash.com/fr/photos/une-voiture-de-sport-rouge-garee-devant-un-navire-ZoIPyC_f1oE"},
        { brand: 'Nissan', model: 'Leaf', year_of_production: '2019', address: '8, rue de Daniel', zipcode: '84237', city: 'Bourdon', nb_passenger: '7', latitude: '-12.7233615', longitude: '12.844672', price_per_day: "42", description: 'A Nissan Leaf from 2019, perfect for both urban and long-distance travel. Comfort and efficiency guaranteed.', image_url: "https://www.google.com/url?sa=i&url=https%3A%2F%2Ffrance.nissannews.com%2Ffr-FR%2Freleases%2Fla-mobilite-electrique-plus-accessible-que-jamais-avec-la-nissan-leaf-a-130-mois-sans-apport&psig=AOvVaw1iwUGumeMDr0dt19hk93GS&ust=1712990595270000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCKCnrbWJvIUDFQAAAAAdAAAAABAE"},
        { brand: 'Hyundai', model: 'i30', year_of_production: '2020', address: '724, avenue de Gilles', zipcode: '09352', city: 'Hubert', nb_passenger: "6", latitude: '81.1005985', longitude: '60.590823', price_per_day: "49", description: 'A Hyundai i30 from 2020, perfect for both urban and long-distance travel. Comfort and efficiency guaranteed.', image_url: "https://unsplash.com/fr/photos/une-voiture-bleue-garee-devant-une-foret-MYkMP45I3Ck"},
        { brand: 'Kia', model: 'Rio', year_of_production: '2023', address: '760, boulevard de Humbert', zipcode: '27142', city: 'Evrarddan', nb_passenger: "5", latitude: '60.7009865', longitude: '144.257890', price_per_day: "45", description: 'A Kia Rio from 2023, perfect for both urban and long-distance travel. Comfort and efficiency guaranteed.', image_url: "https://unsplash.com/fr/photos/mercedes-benz-classe-c-noire-sur-route-pendant-la-journee-BkPTNIP3h8A"}
      ]


# CREATION OF 5 USERS
puts "----- CREATION de 5 utilisateurs -----"

User.create({email: "test@test.com", password: "password"})
User.create({email: "test2@test.com", password: "password"})
User.create({email: "test3@test.com", password: "password"})
User.create({email: "test4@test.com", password: "password"})
User.create({email: "test5@test.com", password: "password"})

# END OF CREATION OF 5 USERS
puts "----- fin de la création   -----"




# CREATION OF 15 CARS
puts "----- CREATION de 15 CARS -----"

cars.each do |car|
  Car.create!(
    brand: car[:brand],
    model: car[:model],
    year_of_production: car[:year_of_production],
    description: car[:description],
    price_per_day: car[:price_per_day],
    address: car[:address],
    zipcode: car[:zipcode],
    city: car[:city],
    nb_passenger: car[:nb_passenger],
    latitude: car[:latitude],
    longitude: car[:longitude],
    image_url: car[:image_url],
    user_id: User.all.sample.id
  )
end

# END OF CREATION OF 15 CARS
puts "----- fin de la création  -----"
