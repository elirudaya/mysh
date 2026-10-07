json.extract! event, :id, :user_id, :title, :description, :date, :city, :capacity, :created_at, :updated_at
json.url event_url(event, format: :json)
