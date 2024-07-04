class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    # 高速化のため
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    # 一意性のため
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
