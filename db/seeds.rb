# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Comment.destroy_all
Post.destroy_all
UserInterest.destroy_all
Interest.destroy_all
Friendship.destroy_all
Subscription.destroy_all
Place.destroy_all
Trip.destroy_all
Checklist.destroy_all
Event.destroy_all
Profile.destroy_all
User.destroy_all

puts "All data just destroyed"


users = [
  {
    email: "user_1@email.com",
    password: "testtest"
  },
  {
    email: "user_2@email.com",
    password: "testtest"
  },
  {
    email: "user_3@email.com",
    password: "testtest"
  }
]

users.each do |user|
  u = User.create(user)
  puts "User created with email #{u.email} and with id #{u.id}!"
end


profiles = [
  {
    user: User.find_by(email: "user_1@email.com"),
    name: "Анна",
    origin_country: "Россия",
    origin_city: "Москва",
    current_country: "Беларусь",
    current_city: "Минск"
  },
  {
    user: User.find_by(email: "user_2@email.com"),
    name: "Иван",
    origin_country: "Беларусь",
    origin_city: "Гомель",
    current_country: "Россия",
    current_city: "Санкт-Петербург"
  },
  {
    user: User.find_by(email: "user_3@email.com"),
    name: "Соня",
    origin_country: "Россия",
    origin_city: "Казань",
    current_country: "Беларусь",
    current_city: "Гродно"
  }
]

profiles.each do |profile|
  p = Profile.create(profile)
  puts "Profile created with id #{p.id}"
end


posts = [
  {
    user: User.find_by(email: "user_1@email.com"),
    title: "выходные в Минске",
    body: "лааллалала"
  },
  {
    user: User.find_by(email: "user_2@email.com"),
    title: "поездка в СПБ",
    body: "круто классно"
  },
  {
    user: User.find_by(email: "user_3@email.com"),
    title: "поездка в Казань",
    body: "оч красиво"
  }
]

posts.each do |post|
  p = Post.create(post)
  puts "Post created with title #{p.title} and id #{p.id}"
end





interests = [
  { name: "путешествия" },
  { name: "музыка" },
  { name: "кино" },
  { name: "искусство" },
  { name: "спорт" }
]

interests.each do |interest|
  i = Interest.create(interest)
  puts "Interest created with name #{i.name}"
end


user_interests = [
  {
    user: User.find_by(email: "user_1@email.com"),
    interest: Interest.find_by(name: "путешествия")
  },
  {
    user: User.find_by(email: "user_1@email.com"),
    interest: Interest.find_by(name: "музыка")
  },
  {
    user: User.find_by(email: "user_2@email.com"),
    interest: Interest.find_by(name: "спорт")
  },
  {
    user: User.find_by(email: "user_3@email.com"),
    interest: Interest.find_by(name: "искусство")
  }
]

user_interests.each do |user_interest|
  ui = UserInterest.create(user_interest)
  puts "UserInterest created with id #{ui.id}"
end


friendships = [
  {
    user: User.find_by(email: "user_1@email.com"),
    friend_email: "user_2@email.com",
    status: "в друзьях"
  },
  {
    user: User.find_by(email: "user_1@email.com"),
    friend_email: "user_3@email.com",
    status: "на обрбаотке"
  }
]

friendships.each do |friendship|
  f = Friendship.create(friendship)
  puts "Friendship created with id #{f.id}"
end


subscriptions = [
  {
    user: User.find_by(email: "user_1@email.com"),
    name: "путешествия"
  },
  {
    user: User.find_by(email: "user_1@email.com"),
    name: "жизнь в Минске"
  },
  {
    user: User.find_by(email: "user_2@email.com"),
    name: "ивенты малиновка"
  }
]

subscriptions.each do |subscription|
  s = Subscription.create(subscription)
  puts "Subscription created with id #{s.id}"
end


places = [
  {
    user: User.find_by(email: "user_1@email.com"),
    name: "парк Горького",
    description: "близко к центру",
    city: "Москва",
    address: "Крымский Вал, 9",
    category: "парк"
  },
  {
    user: User.find_by(email: "user_2@email.com"),
    name: "верхний город",
    description: "история Минска",
    city: "Минск",
    address: "площадь Свободы",
    category: "достопримечательность"
  },
  {
    user: User.find_by(email: "user_3@email.com"),
    name: "Кремль",
    description: "история Казани",
    city: "Казань",
    address: "Кремлевская улица",
    category: "Достопримечательность"
  }
]

places.each do |place|
  p = Place.create(place)
  puts "Place created with name #{p.name}"
end

trips = [
  {
    user: User.find_by(email: "user_1@email.com"),
    origin_city: "Москва",
    destination_city: "Минск",
    start_date: "2026-11-10",
    end_date: "2026-11-15",
    trip_type: "отдых",
    transport: "поезд"
  },
  {
    user: User.find_by(email: "user_2@email.com"),
    origin_city: "Минск",
    destination_city: "СПБ",
    start_date: "2026-12-01",
    end_date: "2026-12-05",
    trip_type: "отдых",
    transport: "поезд"
  },
  {
    user: User.find_by(email: "user_3@email.com"),
    origin_city: "Гродно",
    destination_city: "Москва",
    start_date: "2026-12-15",
    end_date: "2026-12-20",
    trip_type: "командировка",
    transport: "автобус"
  }
]

trips.each do |trip|
  t = Trip.create(trip)
  puts "Trip created with id #{t.id}"
end
