class Message < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :asc) }
end
