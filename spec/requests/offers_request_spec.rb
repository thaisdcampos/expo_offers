require 'rails_helper'

RSpec.describe "Offers", type: :request do
  context 'request list of all offers' do
    before { create(:offer, advertiser_name: 'My first offer', status: :enabled) }

    it 'redirects to the list of offers' do
      get offers_path

      expect(response).to be_successful
      expect(response).to render_template(:index)
      expect(response.body).to include('My first offer')
    end
  end

  context 'create a new offer' do
    let(:params) do
      {
        advertiser_name: 'Offer criation',
        url: 'www.test.com',
        description: 'description',
        active_from: Date.current,
        premium: false
      }
    end

    it 'shows a new offer' do
      expect { post '/offers', params: params }.to change(Offer, :count).from(0).to(1)
    end

    it 'show a success message' do
      post '/offers', params: params

      follow_redirect!
      expect(response.body).to include('Offer was successfully created')
    end
  end

  context 'update a offer' do
    let(:offer) { create(:offer, advertiser_name: 'Offer to update', status: :enabled) }
    let(:params) { { advertiser_name: 'Name changed' } }

    before do
      put "/offers/#{offer.id}", params: params
      offer.reload
    end

    it 'changes a updated attribure' do
      expect(offer[:advertiser_name]).to eq params[:advertiser_name]
    end

    it 'show a successfully message' do
      follow_redirect!
      expect(response.body).to include('Offer was successfully updated')
    end
  end

  context 'destroy an offer' do
    let(:offer) { Offer.first }

    before do
      create(:offer, advertiser_name: 'Offer to update', status: :enabled)
    end

    it 'delete a offer' do
      expect { delete "/offers/#{offer.id}" }.to change(Offer, :count).from(1).to(0)
    end

    it 'redirects to a list without a deleted offer' do
      delete "/offers/#{offer.id}"

      follow_redirect!
      expect(response.body).to include('Offer was successfully deleted')
    end
  end
end
