require_relative '../spec_helper'

RSpec.describe Dotloop::Participant do
  let(:client) { Dotloop::Client.new(api_key: SecureRandom.uuid) }
  subject { Dotloop::Participant.new(client: client) }

  describe '#initialize' do
    it 'should exist' do
      expect(subject).to_not be_nil
    end

    it 'should set the client' do
      expect(subject.client).to eq(client)
    end
  end

  describe '#all' do
    it 'should return a list of participants' do
      dotloop_mock(:participants)
      participants = subject.all(profile_id: 1_234, loop_view_id: 76_046)
      expect(participants).to_not be_empty
      expect(participants).to all(be_a(Dotloop::Models::Participant))
      expect(participants.first).to have_attributes(
        email: 'new2_person@email.com',
        member_of_my_team: 'N',
        name: 'New Person',
        participant_id: 3_600_616,
        role: 'None'
      )
    end
  end
end
