class ChatRoom < ApplicationRecord
  belongs_to :user
  has_many :chats, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
end
