require_relative '../spec_helper'

RSpec.describe Dotloop::LoopActivity do
  let(:client) { Dotloop::Client.new(api_key: SecureRandom.uuid) }
  subject { Dotloop::LoopActivity.new(client: client) }

  describe '#initialize' do
    it 'should exist' do
      expect(subject).to_not be_nil
    end

    it 'should set the client' do
      expect(subject.client).to eq(client)
    end
  end

  # rubocop:disable Metrics/LineLength
  describe '#all' do
    it 'should return a loop_activity' do
      dotloop_mock_batch(:loop_activities)
      loop_activity = subject.all(profile_id: 1_234, loop_view_id: 76_046)
      expect(loop_activity.size).to eq(57)
      expect(loop_activity).to all(be_a(Dotloop::Models::LoopActivity))
      expect(loop_activity.first).to have_attributes(
        activity_date: Time.parse('2014-01-09T13:10:14-05:00'),
        message: 'K Fouts (Admin for DotLoop Final Review) viewed document <activity action="contracteditor" viewId="76046" documentId="129497">Agency Disclosure Statement Seller</activity>'
      )
    end
  end
end
