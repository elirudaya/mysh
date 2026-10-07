json.extract! subscription, :id, :user_id, :name, :created_at, :updated_at
json.url subscription_url(subscription, format: :json)
