class Event < ActiveRecord::Base
    include ActionView::Helpers::DateHelper

    belongs_to :member, inverse_of: :events
    belongs_to :court, inverse_of: :events

    validates :name,          presence: true, length: { maximum: 150 }
    validates :court_id,      presence: true
    validates :member_id,     presence: true
    validates :start,         presence: true
    validates :end,           presence: true

    def time_in_words
        if self.start > Time.now
            "in about " + distance_of_time_in_words(self.start)
        else
            time_ago_in_words(self.start) + " ago"
        end
    end

end