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
    current_country: "Германия",
    current_city: "Берлин"
  },
  {
    user: User.find_by(email: "user_2@email.com"),
    name: "Иван",
    origin_country: "Россия",
    origin_city: "Казань",
    current_country: "Сербия",
    current_city: "Белград"
  },
  {
    user: User.find_by(email: "user_3@email.com"),
    name: "Мария",
    origin_country: "Россия",
    origin_city: "Санкт-Петербург",
    current_country: "Нидерланды",
    current_city: "Амстердам"
  }
]

profiles.each do |profile|
  p = Profile.create(profile)
  puts "Profile created with id #{p.id}"
end


posts = [
  {
    user: User.find_by(email: "user_1@email.com"),
    title: "Моя поездка в Берлин",
    body: "Рассказываю о своей поездке и интересных местах."
  },
  {
    user: User.find_by(email: "user_2@email.com"),
    title: "Переезд в Белград",
    body: "Небольшой рассказ о переезде в Сербию."
  },
  {
    user: User.find_by(email: "user_3@email.com"),
    title: "Жизнь в Амстердаме",
    body: "Делюсь своим опытом жизни в Нидерландах."
  }
]

posts.each do |post|
  p = Post.create(post)
  puts "Post created with title #{p.title} and id #{p.id}"
end





interests = [
  { name: "Путешествия" },
  { name: "Музыка" },
  { name: "Кино" },
  { name: "Искусство" },
  { name: "Спорт" }
]

interests.each do |interest|
  i = Interest.create(interest)
  puts "Interest created with name #{i.name}"
end


user_interests = [
  {
    user: User.find_by(email: "user_1@email.com"),
    interest: Interest.find_by(name: "Путешествия")
  },
  {
    user: User.find_by(email: "user_1@email.com"),
    interest: Interest.find_by(name: "Музыка")
  },
  {
    user: User.find_by(email: "user_2@email.com"),
    interest: Interest.find_by(name: "Спорт")
  },
  {
    user: User.find_by(email: "user_3@email.com"),
    interest: Interest.find_by(name: "Искусство")
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
    status: "accepted"
  },
  {
    user: User.find_by(email: "user_1@email.com"),
    friend_email: "user_3@email.com",
    status: "pending"
  }
]

friendships.each do |friendship|
  f = Friendship.create(friendship)
  puts "Friendship created with id #{f.id}"
end


subscriptions = [
  {
    user: User.find_by(email: "user_1@email.com"),
    name: "Путешествия"
  },
  {
    user: User.find_by(email: "user_1@email.com"),
    name: "Жизнь в Германии"
  },
  {
    user: User.find_by(email: "user_2@email.com"),
    name: "Мероприятия"
  }
]

subscriptions.each do |subscription|
  s = Subscription.create(subscription)
  puts "Subscription created with id #{s.id}"
end


places = [
  {
    user: User.find_by(email: "user_1@email.com"),
    name: "Community Cafe",
    description: "Место для встреч сообщества",
    city: "Берлин",
    address: "Alexanderplatz",
    category: "Кафе"
  },
  {
    user: User.find_by(email: "user_2@email.com"),
    name: "Культурный центр",
    description: "Место для мероприятий",
    city: "Белград",
    address: "Центр города",
    category: "Культура"
  }
]

places.each do |place|
  p = Place.create(place)
  puts "Place created with name #{p.name}"
end

trips = [
  {
    user: User.find_by(email: "user_1@email.com"),
    origin_city: "Берлин",
    destination_city: "Прага",
    start_date: "2026-11-10",
    end_date: "2026-11-15",
    trip_type: "Поездка",
    transport: "Поезд"
  },
  {
    user: User.find_by(email: "user_2@email.com"),
    origin_city: "Белград",
    destination_city: "Будапешт",
    start_date: "2026-12-01",
    end_date: "2026-12-05",
    trip_type: "Поездка",
    transport: "Автобус"
  }
]

trips.each do |trip|
  t = Trip.create(trip)
  puts "Trip created with id #{t.id}"
end
