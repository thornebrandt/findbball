class VideoArticle < ActiveRecord::Base
    validates :vi, presence: true
    validates :title, presence: true

    def list_order
        if self.priority
            self.priority
        else
            self.id
        end
    end

    default_scope -> { order('priority ASC') }
end