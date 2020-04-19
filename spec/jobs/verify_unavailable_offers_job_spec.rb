require 'rails_helper'

RSpec.describe VerifyUnavailableOffersJob, type: :job do
  include ActiveJob::TestHelper

  context '#perform' do
    let(:offer) { create(:offer) }

    subject(:job) { described_class.perform_later }

    it 'ensures that the job has been scheduled' do
      expect { job }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
    end

    it 'changes status' do
      expect { VerifyUnavailableOffersJob.perform_later }.to have_enqueued_job.on_queue('default')
    end
  end
end
