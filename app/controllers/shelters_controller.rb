class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def create
    Shelter.create(shelter_params)
    redirect_to '/shelters'
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    shelter = Shelter.update(params[:id], shelter_params)
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    shelter = Shelter.find(params[:id])
    if shelter.pets.any? {|pet| pet.status == "Pending" }
      flash[:notice] = "Cannot delete a shelter with pets pending adoption"
      redirect_to "/shelters/#{shelter.id}"
    else
      shelter.destroy
      redirect_to "/shelters"
    end
  end

  private

  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
