class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :comments
      t.string :creator_id
      t.text :message
      t.date :modified_date
      t.time :modified_time
      t.integer :category_id

      t.references :category
      t.timestamps
    end
  end
end
