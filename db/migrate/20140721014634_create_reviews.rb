class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :content
      t.integer :member_id
      t.integer :court_id

      t.timestamps
    end
    add_index :reviews, [:member_id, :created_at]
  end
end
