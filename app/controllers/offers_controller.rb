class OffersController < ApplicationController
  def index
    @offers = Offer.all
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(permitted_params)

    if @offer.save!
      flash[:notice] = 'Offer was successfully created'
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
      flash[:notice] = 'Offer was successfully updated'
      redirect_to offer_path(@offer)
    end
  end

  def destroy
    @offer = Offer.find(params[:id]).destroy

    flash[:notice] = 'Offer was successfully deleted'
    redirect_to offers_path
  end

  private

  def permitted_params
    params.permit(
      :advertiser_name,
      :url,
      :description,
      :active_from,
      :active_until,
      :premium
    )
  end
end
