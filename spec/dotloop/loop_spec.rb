require_relative '../spec_helper'

RSpec.describe Dotloop::Loop do
  let(:client) { double }
  subject { Dotloop::Loop.new(client: client) }

  describe '#initialize' do
    it 'should exist' do
      expect(subject).to_not be_nil
    end

    it 'should have a client' do
      expect(subject.client).to eq(client)
    end
  end

  describe '#all' do
    it 'should return all loops' do
      expect(client).to receive(:get).with('/profile/1234/loop').and_return(json_fixture('profile/1234/loop.json'))
      loops = subject.all(profile_id: '1234')
      expect(loops.size).to eq(2)
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
  end
end
