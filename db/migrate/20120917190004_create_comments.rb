class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :post_id
      t.text :content
      t.references :post
      t.text :post_content
      t.string :creator_id

      t.timestamps
    end
  end
end
