json.extract! trip, :id, :user_id, :origin_city, :destination_city, :start_date, :end_date, :trip_type, :transport, :created_at, :updated_at
json.url trip_url(trip, format: :json)
