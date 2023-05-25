json.extract! event, :id, :title, :body, :user_id, :created_at, :updated_at
json.url event_url(event, format: :json)
