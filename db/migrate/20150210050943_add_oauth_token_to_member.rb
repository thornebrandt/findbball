class AddOauthTokenToMember < ActiveRecord::Migration
  def change
    add_column :members, :oauth_token,           :string
    add_column :members, :oauth_expires_at,      :datetime
  end
end
