class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.text :content
      t.datetime :post_date
      t.integer :like_count

      t.timestamps
    end
  end
end
