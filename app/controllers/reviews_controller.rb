class ReviewsController < ApplicationController
  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update_attributes(review_params)
      redirect_to "/shelters/#{@review.shelter.id}"
    else
      flash.now[:notice] = "Review not updated: Required information missing."
      render :edit
    end
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    @shelter = Shelter.find(params[:shelter_id])
    review = @shelter.reviews.new(review_params)
    if review.save
      redirect_to "/shelters/#{params[:shelter_id]}"
    else
      flash[:notice] = "Review not created: Required information missing."
      render :new
    end
  end

  def destroy
    @shelter = Shelter.find(params[:shelter_id])
    Review.destroy(params[:id])
    redirect_to "/shelters/#{@shelter.id}"
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :photo)
  end
end
