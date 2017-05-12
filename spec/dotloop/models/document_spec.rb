require_relative '../../spec_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Dotloop::Models::Loop do
  let(:profile_id) { 1234 }
  let(:loop_view_id) { 76_046 }
  let(:document_id) { 561_622 }
  let(:document_name) { 'AgencyDisclosureStatementSeller' }

  let(:activities_) { double }
  let(:document_) { double }

  let(:client) do
    double(
      DocumentActivity: activities_,
      Document: document_
    )
  end

  subject do
    doc = Dotloop::Models::Document.new(document_id: document_id, document_name: document_name)
    doc.loop_view_id = loop_view_id
    doc.profile_id = profile_id
    doc.client = client
    doc
  end

  describe '#activies' do
    it 'should return activities' do
      expect(activities_).to receive(:all).with(profile_id: profile_id, document_id: document_id).and_return(:act)
      expect(subject.activities).to eq(:act)
    end
  end

  describe '#get' do
    it 'should return a document' do
      expect(document_).to receive(:get).with(
        profile_id: profile_id,
        loop_view_id: loop_view_id,
        document_id: document_id,
        document_name: document_name
      ).and_return(:document)
      expect(subject.get).to eq(:document)
    end
  end
end
