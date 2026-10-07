json.extract! profile, :id, :user_id, :name, :origin_country, :origin_city, :current_country, :current_city, :created_at, :updated_at
json.url profile_url(profile, format: :json)
