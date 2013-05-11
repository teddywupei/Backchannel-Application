class CreatePostVotes < ActiveRecord::Migration
  def change
    create_table :post_votes do |t|
      t.string :voter_id
      t.integer :post_id

      t.timestamps
    end
  end
end
