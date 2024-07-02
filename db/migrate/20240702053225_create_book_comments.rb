class CreateBookComments < ActiveRecord::Migration[6.1]
  def change
    create_table :book_comments do |t|
      t.integer :user_id
      t.text :content
      t.integer :book_id

      t.timestamps
    end
  end
end
