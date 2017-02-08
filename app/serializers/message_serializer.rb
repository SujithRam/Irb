class MessageSerializer < ActiveModel::Serializer
  attributes :id, :msg
  has_one :user
end
