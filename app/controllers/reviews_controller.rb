class ReviewsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  
  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      flash[:success] = "Review created!"
      redirect_to @review.court
    else
      render @review.court
    end
  end
  
  def destroy
  end
  
  private
  
    def review_params
      params.require(:review).permit(:id, :content, :court_id, :member_id)
    end
end