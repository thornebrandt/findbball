class AddTimestampsToVideoArticles < ActiveRecord::Migration
  def change
    add_column :video_articles, :created_at, :datetime
    add_column :video_articles, :updated_at, :datetime
  end
end
