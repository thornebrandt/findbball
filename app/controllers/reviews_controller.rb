class ReviewsController < ApplicationController
  before_action :signed_in_user
  
  def create
    @review = @court.reviews.build(review_params)
    @review.member_id = current_user.id
    if @review.save
      flash[:success] = "Review created!"
      redirect_to @court
    else
      render @court
    end
  end
  
  def edit
  end
  
  def destroy
  end
  
  private
  
    def review_params
      params.require(:review).permit(:id, :content, :court_id, :member_id)
    end
end