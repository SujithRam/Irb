json.extract! message, :id, :msg, :user_id, :created_at, :updated_at
json.url message_url(message, format: :json)