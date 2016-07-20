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

    it 'accepts parameter status_ids' do
      expect(client).to receive(:get).with(
        '/profile/1234/loop',
        batchNumber: 1, batchSize: 50, statusIds: [1, 2, 3]
      ).and_return([])
      subject.all(profile_id: '1234', options: { status_ids: [1, 2, 3] })
    end

    it 'accepts parameter compliance_status_ids' do
      expect(client).to receive(:get).with(
        '/profile/1234/loop',
        batchNumber: 1, batchSize: 50, complianceStatusIds: [1, 2, 3]
      ).and_return([])
      subject.all(profile_id: '1234', options: { compliance_status_ids: [1, 2, 3] })
    end

    it 'accepts parameter tag_ids' do
      expect(client).to receive(:get).with(
        '/profile/1234/loop',
        batchNumber: 1, batchSize: 50, tagIds: [1, 2, 3]
      ).and_return([])
      subject.all(profile_id: '1234', options: { tag_ids: [1, 2, 3] })
    end

    it 'accepts parameter sort_by' do
      expect(client).to receive(:get).with(
        '/profile/1234/loop',
        batchNumber: 1, batchSize: 50, sortBy: 'sort me'
      ).and_return([])
      subject.all(profile_id: '1234', options: { sort_by: 'sort me' })
    end

    it 'accepts parameter search_query' do
      expect(client).to receive(:get).with(
        '/profile/1234/loop',
        batchNumber: 1, batchSize: 50, searchQuery: 'search me'
      ).and_return([])
      subject.all(profile_id: '1234', options: { search_query: 'search me' })
    end

    it 'accepts parameter tag_names' do
      expect(client).to receive(:get).with(
        '/profile/1234/loop',
        batchNumber: 1, batchSize: 50, tagNames: 'tags'
      ).and_return([])
      subject.all(profile_id: '1234', options: { tag_names: 'tags' })
    end

    it 'accepts parameter created_by_me' do
      expect(client).to receive(:get).with(
        '/profile/1234/loop',
        batchNumber: 1, batchSize: 50, createdByMe: 123_456
      ).and_return([])
      subject.all(profile_id: '1234', options: { created_by_me: 123_456 })
    end
  end
end
