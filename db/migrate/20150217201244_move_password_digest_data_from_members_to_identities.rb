class MovePasswordDigestDataFromMembersToIdentities < ActiveRecord::Migration
  class Identity < OmniAuth::Identity::Models::ActiveRecord
  end
  
  class Member < ActiveRecord::Base
    has_many :identities, class_name: "MovePasswordDigestDataFromMembersToIdentities::Identity", order: :id
  end
  
  def up
    Member.all.each do |member|
      Identity.create do |identity|
        # uid is string version of identity id; all members are now assigned one new identity with equal (u)id
        identity.uid = member.id.to_s
        identity.provider = 'identity'
        identity.email = member.email
        identity.password_digest = member.password_digest
        identity.member_id = member.id
        identity.save
        puts member, identity
      end
    end
  end
end
