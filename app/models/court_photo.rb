class CourtPhoto < ActiveRecord::Base
    belongs_to :member, inverse_of: :court_photos
    belongs_to :court, inverse_of: :court_photos

    default_scope -> { order('created_at DESC') }

    validates :photo, presence: true
    validates :member_id, presence: true
    validates :court_id, presence: true

    mount_uploader :photo, CourtPhotoUploader

    def court_photo
        if photo.nil?
            ActionController::Base.helpers.asset_path("courts/default.jpg")
        else
            photo
        end
    end
end
