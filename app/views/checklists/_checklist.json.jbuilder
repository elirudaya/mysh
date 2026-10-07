json.extract! checklist, :id, :user_id, :title, :country, :category, :content, :created_at, :updated_at
json.url checklist_url(checklist, format: :json)
