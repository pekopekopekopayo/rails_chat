class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats do |t|
      t.text :content, null: false
      t.belongs_to :chat_room, null: false
      t.belongs_to :user, null: false
      t.timestamps
    end
  end
end
