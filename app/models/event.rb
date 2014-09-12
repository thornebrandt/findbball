class Event < ActiveRecord::Base
    include ActionView::Helpers::DateHelper
    belongs_to :member, inverse_of: :events
    belongs_to :court, inverse_of: :events
    has_many :attendees, inverse_of: :event

    validates :name,          presence: true, length: { maximum: 150 }
    validates :court_id,      presence: true
    validates :member_id,     presence: true
    validates :start,         presence: true
    validates :end,           presence: true

    def times_long
        self.get_12hour_time(self.start) + " - " +
        self.get_12hour_time(self.end)
    end

    def hour_number
        self.start.strftime("%l");
    end

    def hour_offset
        # for populating the input
        offset = 0;
        if self.start.strftime("%p") == "PM"
            offset = 12
        end
        offset
    end

    def duration_hours
        # for populating the input
        ( ( self.end - self.start ) / 1.hour ).round
    end

    def date_long
        self.start_day_in_words + ", " +
        self.start_date_in_words
    end

    def get_12hour_time(_time)
        _time.strftime("%l:%M %p");
    end

    def start_day_in_words
        self.start.strftime("%A");
    end

    def start_date_in_words
        self.start.strftime("%B %e")
    end

    def time_in_words
        from_time = Time.now
        if self.start > from_time
            "in about " + distance_of_time_in_words(from_time, self.start)
        else
            distance_of_time_in_words(from_time, self.start) + " ago"
        end
    end

    def mainPhoto
        # if @event.main_photo
        #     img_path = CourtPhoto.find(@event.main_photo).photo
        # elsif @event.court_photos.any?
        #     img_path = @event.court_photos.first().photo
        # else
        if self.main_photo
            img_path = CourtPhoto.find(self.main_photo).photo
        end
        if !img_path
            img_path = ActionController::Base.helpers.asset_path("events/default.jpg")
        end
        img_path
    end

end