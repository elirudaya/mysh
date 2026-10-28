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
  Event.destroy_all

  posts = [
    {
      title: "Как я решилась на переезд в Хельсинки",
      body: "Переезд в Хельсинки стал для меня началом новой главы. Сначала было немного страшно: незнакомый язык, другой ритм жизни и город, в котором я никого не знала. Но постепенно я начала привыкать. Гуляла по уютным улицам, открывала для себя маленькие кофейни, любовалась морем и училась наслаждаться спокойствием финской столицы. Теперь Хельсинки понемногу становится для меня домом.",
      image: "helsinki.jpeg"
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

  events = [
    {
      title: "Прогулка по Хельсинки",
      description: "Прогуляемся по центру города, познакомимся и поделимся историями переезда.",
      date: Time.zone.parse("2026-11-14 12:00"),
      city: "Хельсинки",
      address: "Сенатская площадь",
      capacity: 20
    },
    {
      title: "Фотосессия в Минске",
      description: "Приглашаем на совместную фотосессию в Минске! Это отличная возможность познакомиться с новыми людьми, провести время в приятной компании и получить красивые фотографии на память. Количество участников ограничено — всего 15 человек.",
      date: Time.zone.parse("2026-11-21 15:00"),
      city: "Минск",
      address: "Центр города",
      capacity: 15,
      image: "minsk.jpg"
    }
  ]

  posts.each do |post_data|
    post = admin.posts.create!(
      title: post_data[:title],
      body: post_data[:body],
      status: "approved"
    )

    if post_data[:image].present?
      image_path = Rails.root.join("app/assets/images", post_data[:image])

      if File.exist?(image_path)
        post.image.attach(
          io: File.open(image_path),
          filename: post_data[:image]
        )
      end
    end
  end

  events.each do |event_data|
    event = admin.events.create!(
      event_data.except(:image)
    )

    if event_data[:image].present?
      image_path = Rails.root.join("app/assets/images", event_data[:image])

      if File.exist?(image_path)
        event.image.attach(
          io: File.open(image_path),
          filename: event_data[:image]
        )
      end
    end
  end
end
