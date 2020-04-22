class OffersController < ApplicationController
  def index
    @offers = Offer.all
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(permitted_params)

    if @offer.save
      flash[:success] = 'Oferta criada com sucesso'
      redirect_to offer_path(@offer)
    else
      flash[:error] = 'Não foi possível criar a oferta'
      redirect_to new_offer_path
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
    @offer.update(update_permitted_params)

    if @offer.save
      flash[:success] = 'Ofeta atualizada com sucesso'
      redirect_to offer_path(@offer)
    else
      flash[:error] = 'Não foi possível atualizar a ofeta'
      redirect_to edit_offer_path(@offer)
    end
  end

  def destroy
    @offer = Offer.find(params[:id]).destroy

    flash[:notice] = 'Oferta removida com sucesso'
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

  def update_permitted_params
    params.require(:offer).permit(
      :advertiser_name,
      :url,
      :description,
      :active_from,
      :active_until,
      :premium,
      :status
    )
  end
end
