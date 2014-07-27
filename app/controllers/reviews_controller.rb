class ReviewsController < ApplicationController
  before_action :signed_in_user
  
  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      flash[:success] = "Review created!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end
  
  def edit
  end
  
  def destroy
  end
  
  private
  
    def review_params
      params.require(:review).permit(:content, :court, :member)
    end
end