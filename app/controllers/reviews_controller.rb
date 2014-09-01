class ReviewsController < ApplicationController
  before_action :signed_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
        flash[:success] = "Review created!"
        redirect_to @review.court
    else
        flash[:error] = "Could not create review";
        redirect_to @court
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @court = @review.court
    @review.destroy
    flash[:info] = "Review deleted."
    redirect_to @court
  end

  private

    def review_params
      params.require(:review).permit(:id, :content, :court_id, :member_id)
    end

    def correct_user
      @review = current_user.reviews.find_by(id: params[:id])
      redirect_to root_url if @review.nil?
    end
end