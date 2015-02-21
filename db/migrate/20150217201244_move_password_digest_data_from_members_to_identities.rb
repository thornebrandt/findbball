class MovePasswordDigestDataFromMembersToIdentities < ActiveRecord::Migration
  def up
    # id/uid collision danger?
    # 
    sql = "INSERT INTO identities (id, name, email, password_digest, member_id, provider, uid)
           SELECT id, name, email, password_digest, id, 'identity', id FROM members;"
    ActiveRecord::Base.connection.execute(sql)
   end
end
