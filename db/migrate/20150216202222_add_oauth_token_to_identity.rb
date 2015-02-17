class AddOauthTokenToIdentity < ActiveRecord::Migration
  def change
    add_column :identities, :oauth_token,           :string
    add_column :identities, :oauth_expires_at,      :datetime
    remove_column :members, :oauth_token,           :string
    remove_column :members, :oauth_expires_at,      :datetime
    remove_column :members, :provider,              :string
    remove_column :members, :uid,                   :string
    
    drop_table :authentications
  end
end
