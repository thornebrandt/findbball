class CreateVideoArticles < ActiveRecord::Migration
  def change
    create_table :video_articles do |t|
        t.string    "vi"
        t.integer   "member_id"
        t.float     "priority"
        t.string    "title"
    end
  end
end
