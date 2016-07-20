require_relative '../spec_helper'

RSpec.describe Dotloop::Loop do
  let(:client) { Dotloop::Client.new(api_key: SecureRandom.uuid) }
  subject { Dotloop::Loop.new(client: client) }

  describe '#initialize' do
    it 'should exist' do
      expect(subject).to_not be_nil
    end

    it 'should have a client' do
      expect(subject.client).to eq(client)
    end
  end

  before(:each) { mock_loop_batches }
  describe '#all' do
    it 'should return all loops' do
      loops = subject.all(profile_id: '1234')
      expect(loops.size).to eq(52)
      expect(loops).to all(be_a(Dotloop::Models::Loop))
      expect(loops.first.attributes).to eq(
        Dotloop::Models::Loop.new(
          created_by: 2_097_622,
          last_updated: '2013-12-03T11:38:22-05:00',
          loop_id: 34_242,
          loop_name: 'Atturo Garay 123Main Street, Chicago, IL 60605',
          loop_status: 'Archived',
          loop_tags: [{
            'profile_id': 4_533,
            'tag_id': 2,
            'tag_name': 'Buying'
          }],
          loop_view_id: 76_046,
          transaction_type: 'Listing for Sale'
        ).attributes
      )
    end

    it 'accepts additional parameters' do
      expect(client).to receive(:get).with(
        '/profile/1234/loop',
        batchNumber: 1,
        batchSize: 50,
        statusIds: [1, 2, 3],
        complianceStatusIds: [3, 4, 5],
        tagIds: [6, 7, 8],
        sortBy: 'sort me',
        searchQuery: 'search me',
        tagNames: 'tags',
        createdByMe: 123_456
      ).and_return([])
      subject.all(
        profile_id: '1234',
        status_ids: [1, 2, 3],
        compliance_status_ids: [3, 4, 5],
        tag_ids: [6, 7, 8],
        sort_by: 'sort me',
        search_query: 'search me',
        tag_names: 'tags',
        created_by_me: 123_456
      )
    end
  end
end
