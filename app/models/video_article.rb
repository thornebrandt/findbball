class VideoArticle < ActiveRecord::Base
    default_scope -> { order('priority DESC') }
end