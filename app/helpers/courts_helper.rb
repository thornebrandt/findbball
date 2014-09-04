module CourtsHelper
    def mainPhoto
        if @court.main_photo
            img_path = CourtPhoto.find(@court.main_photo).photo
        elsif @court.court_photos.count
            img_path = @court.court_photos.first().photo
        else
            img_path = ActionController::Base.helpers.asset_path("courts/default.jpg")
        end
        img_path
    end
end
