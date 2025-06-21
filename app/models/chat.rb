class Chat < ApplicationRecord
  belongs_to :chat_room
  belongs_to :user

  validates :content, presence: true, length: { maximum: 1000 }

  scope :recent, -> { order(id: :desc).limit(10) }
end
