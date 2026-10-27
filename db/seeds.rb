# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
admin = User.find_by(admin: true)

if admin
  Post.destroy_all

  posts = [
    {
      title: "Как я решилась на переезд",
      body: "Переезд в новый город казался мне сложным решением. Я долго готовилась, собирала документы и искала жильё. Теперь хочу поделиться своим опытом с другими."
    },
    {
      title: "Первые дни в новом городе",
      body: "В первые дни после переезда всё кажется непривычным. Мне помогли прогулки по городу, новые знакомства и небольшие ежедневные планы."
    },
    {
      title: "Что взять с собой при переезде",
      body: "Перед переездом я составила список самых важных вещей: документы, лекарства, одежда и техника. Такой список помог мне ничего не забыть."
    }
  ]

  posts.each do |post|
    admin.posts.create!(
      title: post[:title],
      body: post[:body],
      status: "approved"
    )
  end
end
