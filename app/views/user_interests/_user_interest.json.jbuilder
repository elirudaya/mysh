json.extract! user_interest, :id, :user_id, :interest_id, :created_at, :updated_at
json.url user_interest_url(user_interest, format: :json)
