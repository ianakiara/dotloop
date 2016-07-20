require_relative '../spec_helper'

RSpec.describe Dotloop::Admin do
  let(:client) { Dotloop::Client.new(api_key: SecureRandom.uuid) }
  subject { Dotloop::Admin.new(client: client) }

  describe '#initialize' do
    it 'should exist' do
      expect(subject).to_not be_nil
    end

    it 'should set the client' do
      expect(subject.client).to eq(client)
    end
  end

  describe '#all' do
    it 'should return a list of admins' do
      dotloop_mock(:admins)
      admins = subject.all(profile_id: 1234)
      expect(admins).to_not be_empty
      expect(admins).to all(be_a(Dotloop::Models::Admin))
      expect(admins.first).to have_attributes(
        email_address: 'listingAgent@emailaddress.com',
        first_name: 'TestFirstName1',
        is_admin: true,
        last_name: 'TestLastName1',
        member_id: 2_629_538,
        status: 'ACTIVE'
      )
    end
  end
end
