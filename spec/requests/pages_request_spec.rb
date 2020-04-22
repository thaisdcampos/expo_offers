# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  context 'request list of enabled offers' do
    before { create(:offer, advertiser_name: 'My first offer', status: :enabled) }

    it 'redirects to the list of offers' do
      get root_path

      expect(response).to be_successful
      expect(response).to render_template(:home)
      expect(response.body).to include('My first offer')
    end
  end
end
