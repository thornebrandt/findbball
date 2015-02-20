class MovePasswordDigestDataFromMembersToIdentities < ActiveRecord::Migration
  def up
    """Member.all.each do |member|
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
  end"""
  
    # "no such function: VARCHAR"
    # will the password digest work in the same way in these two different models??
    sql = "INSERT INTO identities (name, email, password_digest, member_id, provider, uid)
           SELECT name, email, password_digest, id, 'identity', CONVERT(VARCHAR(10), id) FROM members;"
    ActiveRecord::Base.connection.execute(sql)
   end
end
