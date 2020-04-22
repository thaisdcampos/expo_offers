require 'rails_helper'

RSpec.describe VerifyOfferAvailabilityJob, type: :job do
  include ActiveJob::TestHelper

  context '#perform' do
    let(:offer) { create(:offer) }

    subject(:offer_job) { described_class.perform_later }

    it 'ensures that the job has been scheduled' do
      expect { offer_job }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
    end

    it 'ensures that the job use the queue default' do
      expect { VerifyOfferAvailabilityJob.perform_later }.to have_enqueued_job.on_queue('default')
    end
  end
end
