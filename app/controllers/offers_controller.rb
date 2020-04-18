class OffersController < ApplicationController
  before_action verify_status

  def index
    @offers = Offer.all
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(permitted_params)

    if @offer.save!
      redirect_to offer_path(@offer)
    end
  end

  def show
    @offer = Offer.find(params[:id])
  end

  def edit
    @offer = Offer.find(params[:id])
  end

  def update
    @offer = Offer.find(params[:id])
    @offer.update(permitted_params)

    if @offer.save!
      redirect_to offer_path(@offer)
    end
  end

  def destroy
    @offer = Offer.find(params[:id]).destroy

    redirect_to offers_path
  end

  private

  def permitted_params
    params.require(:offer).permit(
      :advertiser_name,
      :url,
      :description,
      :active_from,
      :active_until,
      :premium
    )
  end

  def verify_status
    Offer.verify_status
  end
end
