class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
        t.string :name
        t.integer :court_id
        t.integer :member_id
        t.timestamps
        t.string :details, limit: 800
        t.datetime :start
        t.datetime :end
    end
    add_index :events, [:court_id, :member_id, :created_at]
  end
end
