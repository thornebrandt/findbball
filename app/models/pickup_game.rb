class PickupGame < ActiveRecord::Base
    belongs_to :court, inverse_of: :pickup_games
    belongs_to :member, inverse_of: :pickup_games
    has_many :pickup_attendees, inverse_of: :pickup_game, dependent: :destroy

    validates   :day,       presence: true
    validates   :time,      presence: true
    validates   :member_id, presence: true

    accepts_nested_attributes_for :pickup_attendees


    def pickup_attendees_count
        if self.pickup_attendees.count
            self.pickup_attendees.count
        end
    end

    def verbose_day
        case day
            when 0 then "Sundays"
            when 1 then "Mondays"
            when 2 then "Tuesdays"
            when 3 then "Wednesdays"
            when 4 then "Thursdays"
            when 5 then "Fridays"
            when 6 then "Saturdays"
            when 7 then "Daily"
        end
    end

    def verbose_time
        #no minutes right now
        hour = Integer(time)
        military = "#{hour}:00"
        read_time = Time.parse(military).strftime("%l%P")
        read_time
    end



    # function minTommss(minutes){
    #  var sign = minutes < 0 ? "-" : "";
    #  var min = Math.floor(Math.abs(minutes))
    #  var sec = Math.floor((Math.abs(minutes) * 60) % 60);
    #  return sign + (min < 10 ? "0" : "") + min + ":" + (sec < 10 ? "0" : "") + sec;
    # }

end
