require 'rails_helper'

RSpec.describe Offer, type: :model do
  include ActiveSupport::Testing::TimeHelpers

  context 'validation' do
    let(:yesterday) { Time.current.yesterday }

    context 'when active_from is on the past' do
      let(:offer) { build(:offer, advertiser_name: 'Offer Name', active_from: yesterday) }

      it 'returns an error' do
        expect(offer).to_not be_valid
        expect(offer.errors[:active_from]).to include('Can\'t be in the past')
      end
    end

    context 'when active_until is on the past' do
      let(:offer) { build(:offer, advertiser_name: 'Offer Name', active_until: yesterday) }

      it 'returns an error' do
        expect(offer).to_not be_valid
        expect(offer.errors[:active_until]).to include('Can\'t be in the past')
      end
    end
  end

  context 'verify_status' do
    context 'when offer is disable on valid period' do
      let(:offer) { create(:offer, advertiser_name: 'Bleah', active_until: '')}

      it 'change the status offer' do
        offer.verify_status

        expect(offer.enabled?).to be_truthy
      end
    end


    context 'when the active until arrived' do
      let(:tomorrow) { Time.current.tomorrow }
      let(:offer) { create(:offer, advertiser_name: 'blah', active_until: tomorrow, status: :enabled) }

      it 'returns a disable status' do
        offer.verify_status

        travel_to tomorrow do
          expect(offer.disabled?).to be_truthy
        end
      end
    end
  end
end
