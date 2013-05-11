class CreateCommentVotes < ActiveRecord::Migration
  def change
    create_table :comment_votes do |t|
      t.string :voter_id
      t.integer :comment_id

      t.timestamps
    end
  end
end
