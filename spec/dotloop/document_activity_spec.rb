require_relative '../spec_helper'

RSpec.describe Dotloop::DocumentActivity do
  let(:client) { Dotloop::Client.new(api_key: SecureRandom.uuid) }
  subject { Dotloop::DocumentActivity.new(client: client) }

  describe '#initialize' do
    it 'should exist' do
      expect(subject).to_not be_nil
    end

    it 'should set the client' do
      expect(subject.client).to eq(client)
    end
  end

  describe '#all' do
    it 'should return a document_activity' do
      dotloop_mock(:document_activities)
      document_activity = subject.all(profile_id: 1_234, document_id: 561_622)
      expect(document_activity).to_not be_empty
      expect(document_activity).to all(be_a(Dotloop::Models::DocumentActivity))
      expect(document_activity.first).to have_attributes(
        activity_date: DateTime.parse('2014-08-19T18:44:52-04:00'),
        message: 'Meyyalagan Chandrasekaran (Admin for DotLoop Final Review) viewed document <activity action="contracteditor" viewId="404271" documentId="560621">Buyers Sign here</activity>'
      )
    end
  end
end
