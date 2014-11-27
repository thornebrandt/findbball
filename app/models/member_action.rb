class MemberAction < ActiveRecord::Base
    belongs_to :member, inverse_of: :member_actions
    validates :member_id, presence: true
    validates :level, presence: true

    accepts_nested_attributes_for :member

end